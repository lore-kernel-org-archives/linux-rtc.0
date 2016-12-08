Return-Path: <rtc-linux+bncBC6YH6VTZQDRBCFIU3BAKGQEUQMJFDQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id d199si1463101wmd.1.2016.12.08.09.10.32
        for <rtc-linux@googlegroups.com>;
        Thu, 08 Dec 2016 09:10:32 -0800 (PST)
From: Gregory CLEMENT <gregory.clement@free-electrons.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Cc: Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory CLEMENT <gregory.clement@free-electrons.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Shaker Daibes <shaker@marvell.com>
Subject: [rtc-linux] [PATCH 1/3] rtc: armada38x: improve RTC errata implementation
Date: Thu,  8 Dec 2016 18:10:08 +0100
Message-Id: <20161208171010.29446-2-gregory.clement@free-electrons.com>
In-Reply-To: <20161208171010.29446-1-gregory.clement@free-electrons.com>
References: <20161208171010.29446-1-gregory.clement@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

From: Shaker Daibes <shaker@marvell.com>

According to FE-3124064:
The device supports CPU write and read access to the RTC time register.
However, due to this errata, read from RTC TIME register may fail.

Workaround:
General configuration:
1. Configure the RTC Mbus Bridge Timing Control register (offset 0x184A0)
   to value 0xFD4D4FFF
   Write RTC WRCLK Period to its maximum value (0x3FF)
   Write RTC WRCLK setup to 0x53 (default value )
   Write RTC WRCLK High Time to 0x53 (default value )
   Write RTC Read Output Delay to its maximum value (0x1F)
   Mbus - Read All Byte Enable to 0x1 (default value )
2. Configure the RTC Test Configuration Register (offset 0xA381C) bit3
   to '1' (Reserved, Marvell internal)

For any RTC register read operation:
1. Read the requested register 100 times.
2. Find the result that appears most frequently and use this result
   as the correct value.

For any RTC register write operation:
1. Issue two dummy writes of 0x0 to the RTC Status register (offset
   0xA3800).
2. Write the time to the RTC Time register (offset 0xA380C).

[gregory.clement@free-electrons.com: cosmetic changes and fix issues for
interrupt in original patch]

Reviewed-by: Lior Amsalem <alior@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/rtc/rtc-armada38x.c | 109 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 85 insertions(+), 24 deletions(-)

diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
index 9a3f2a6f512e..a0859286a4c4 100644
--- a/drivers/rtc/rtc-armada38x.c
+++ b/drivers/rtc/rtc-armada38x.c
@@ -29,12 +29,21 @@
 #define RTC_TIME	    0xC
 #define RTC_ALARM1	    0x10
 
+#define SOC_RTC_BRIDGE_TIMING_CTL   0x0
+#define SOC_RTC_PERIOD_OFFS		0
+#define SOC_RTC_PERIOD_MASK		(0x3FF << SOC_RTC_PERIOD_OFFS)
+#define SOC_RTC_READ_DELAY_OFFS		26
+#define SOC_RTC_READ_DELAY_MASK		(0x1F << SOC_RTC_READ_DELAY_OFFS)
+
 #define SOC_RTC_INTERRUPT   0x8
 #define SOC_RTC_ALARM1		BIT(0)
 #define SOC_RTC_ALARM2		BIT(1)
 #define SOC_RTC_ALARM1_MASK	BIT(2)
 #define SOC_RTC_ALARM2_MASK	BIT(3)
 
+
+#define SAMPLE_NR 100
+
 struct armada38x_rtc {
 	struct rtc_device   *rtc_dev;
 	void __iomem	    *regs;
@@ -47,32 +56,85 @@ struct armada38x_rtc {
  * According to the datasheet, the OS should wait 5us after every
  * register write to the RTC hard macro so that the required update
  * can occur without holding off the system bus
+ * According to errata FE-3124064, Write to any RTC register
+ * may fail. As a workaround, before writing to RTC
+ * register, issue a dummy write of 0x0 twice to RTC Status
+ * register.
  */
+
 static void rtc_delayed_write(u32 val, struct armada38x_rtc *rtc, int offset)
 {
+	writel(0, rtc->regs + RTC_STATUS);
+	writel(0, rtc->regs + RTC_STATUS);
 	writel(val, rtc->regs + offset);
 	udelay(5);
 }
 
+/* Update RTC-MBUS bridge timing parameters */
+static void rtc_update_mbus_timing_params(struct armada38x_rtc *rtc)
+{
+	uint32_t reg;
+
+	reg = readl(rtc->regs_soc + SOC_RTC_BRIDGE_TIMING_CTL);
+	reg &= ~SOC_RTC_PERIOD_MASK;
+	reg |= 0x3FF << SOC_RTC_PERIOD_OFFS; /* Maximum value */
+	reg &= ~SOC_RTC_READ_DELAY_MASK;
+	reg |= 0x1F << SOC_RTC_READ_DELAY_OFFS; /* Maximum value */
+	writel(reg, rtc->regs_soc + SOC_RTC_BRIDGE_TIMING_CTL);
+}
+
+struct str_value_to_freq {
+	unsigned long value;
+	u8 freq;
+} __packed;
+
+static unsigned long read_rtc_register_wa(struct armada38x_rtc *rtc, u8 rtc_reg)
+{
+	unsigned long value_array[SAMPLE_NR], i, j, value;
+	unsigned long max = 0, index_max = SAMPLE_NR - 1;
+	struct str_value_to_freq value_to_freq[SAMPLE_NR];
+
+	for (i = 0; i < SAMPLE_NR; i++) {
+		value_to_freq[i].freq = 0;
+		value_array[i] = readl(rtc->regs + rtc_reg);
+	}
+	for (i = 0; i < SAMPLE_NR; i++) {
+		value = value_array[i];
+		/*
+		 * if value appears in value_to_freq array so add the
+		 * counter of value, if didn't appear yet in counters
+		 * array then allocate new member of value_to_freq
+		 * array with counter = 1
+		 */
+		for (j = 0; j < SAMPLE_NR; j++) {
+			if (value_to_freq[j].freq == 0 ||
+					value_to_freq[j].value == value)
+				break;
+			if (j == (SAMPLE_NR - 1))
+				break;
+		}
+		if (value_to_freq[j].freq == 0)
+			value_to_freq[j].value = value;
+		value_to_freq[j].freq++;
+		/* find the most common result */
+		if (max < value_to_freq[j].freq) {
+			index_max = j;
+			max = value_to_freq[j].freq;
+		}
+	}
+	return value_to_freq[index_max].value;
+}
+
 static int armada38x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct armada38x_rtc *rtc = dev_get_drvdata(dev);
-	unsigned long time, time_check, flags;
+	unsigned long time, flags;
 
 	spin_lock_irqsave(&rtc->lock, flags);
-	time = readl(rtc->regs + RTC_TIME);
-	/*
-	 * WA for failing time set attempts. As stated in HW ERRATA if
-	 * more than one second between two time reads is detected
-	 * then read once again.
-	 */
-	time_check = readl(rtc->regs + RTC_TIME);
-	if ((time_check - time) > 1)
-		time_check = readl(rtc->regs + RTC_TIME);
-
+	time = read_rtc_register_wa(rtc, RTC_TIME);
 	spin_unlock_irqrestore(&rtc->lock, flags);
 
-	rtc_time_to_tm(time_check, tm);
+	rtc_time_to_tm(time, tm);
 
 	return 0;
 }
@@ -87,16 +149,9 @@ static int armada38x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 
 	if (ret)
 		goto out;
-	/*
-	 * According to errata FE-3124064, Write to RTC TIME register
-	 * may fail. As a workaround, after writing to RTC TIME
-	 * register, issue a dummy write of 0x0 twice to RTC Status
-	 * register.
-	 */
+
 	spin_lock_irqsave(&rtc->lock, flags);
 	rtc_delayed_write(time, rtc, RTC_TIME);
-	rtc_delayed_write(0, rtc, RTC_STATUS);
-	rtc_delayed_write(0, rtc, RTC_STATUS);
 	spin_unlock_irqrestore(&rtc->lock, flags);
 
 out:
@@ -111,8 +166,8 @@ static int armada38x_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 	spin_lock_irqsave(&rtc->lock, flags);
 
-	time = readl(rtc->regs + RTC_ALARM1);
-	val = readl(rtc->regs + RTC_IRQ1_CONF) & RTC_IRQ1_AL_EN;
+	time = read_rtc_register_wa(rtc, RTC_ALARM1);
+	val = read_rtc_register_wa(rtc, RTC_IRQ1_CONF) & RTC_IRQ1_AL_EN;
 
 	spin_unlock_irqrestore(&rtc->lock, flags);
 
@@ -182,7 +237,7 @@ static irqreturn_t armada38x_rtc_alarm_irq(int irq, void *data)
 	val = readl(rtc->regs_soc + SOC_RTC_INTERRUPT);
 
 	writel(val & ~SOC_RTC_ALARM1, rtc->regs_soc + SOC_RTC_INTERRUPT);
-	val = readl(rtc->regs + RTC_IRQ1_CONF);
+	val = read_rtc_register_wa(rtc, RTC_IRQ1_CONF);
 	/* disable all the interrupts for alarm 1 */
 	rtc_delayed_write(0, rtc, RTC_IRQ1_CONF);
 	/* Ack the event */
@@ -196,7 +251,6 @@ static irqreturn_t armada38x_rtc_alarm_irq(int irq, void *data)
 		else
 			event |= RTC_PF;
 	}
-
 	rtc_update_irq(rtc->rtc_dev, 1, event);
 
 	return IRQ_HANDLED;
@@ -253,6 +307,9 @@ static __init int armada38x_rtc_probe(struct platform_device *pdev)
 	if (rtc->irq != -1)
 		device_init_wakeup(&pdev->dev, 1);
 
+	/* Update RTC-MBUS bridge timing parameters */
+	rtc_update_mbus_timing_params(rtc);
+
 	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, pdev->name,
 					&armada38x_rtc_ops, THIS_MODULE);
 	if (IS_ERR(rtc->rtc_dev)) {
@@ -260,6 +317,7 @@ static __init int armada38x_rtc_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Failed to register RTC device: %d\n", ret);
 		return ret;
 	}
+
 	return 0;
 }
 
@@ -280,6 +338,9 @@ static int armada38x_rtc_resume(struct device *dev)
 	if (device_may_wakeup(dev)) {
 		struct armada38x_rtc *rtc = dev_get_drvdata(dev);
 
+		/* Update RTC-MBUS bridge timing parameters */
+		rtc_update_mbus_timing_params(rtc);
+
 		return disable_irq_wake(rtc->irq);
 	}
 
-- 
2.10.2

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
