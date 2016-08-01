Return-Path: <rtc-linux+bncBCLLTU5HV4PRBUG77W6AKGQETK4KBVI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mta2.parkeon.com (ip83.parkeon.com. [213.152.31.83])
        by gmr-mx.google.com with ESMTPS id i198si779575wmd.2.2016.08.01.08.50.40
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 Aug 2016 08:50:40 -0700 (PDT)
Subject: [rtc-linux] [PATCH 3/3] rtc: pcf85263: Support multiple centuries
To: Alessandro Zummo <a.zummo@towertech.it>, Rob Herring <robh+dt@kernel.org>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
From: Martin Fuzzey <mfuzzey@parkeon.com>
Cc: devicetree@vger.kernel.org, rtc-linux@googlegroups.com
Date: Mon, 01 Aug 2016 17:50:36 +0200
Message-ID: <20160801155036.32232.7242.stgit@localhost>
In-Reply-To: <20160801155029.32232.56063.stgit@localhost>
References: <20160801155029.32232.56063.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The hardware has neither a century register nor a century warp around bit.

However it does have a single byte of non volatile RAM.

Use this to provide full century and wrap around support by storing:
* The current century
* The current half century (lower=00-49, upper=50-99)

If the byte is not set the 21st century is assumed.

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 drivers/rtc/rtc-pcf85263.c |  105 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85263.c b/drivers/rtc/rtc-pcf85263.c
index 997742d..7b55d92 100644
--- a/drivers/rtc/rtc-pcf85263.c
+++ b/drivers/rtc/rtc-pcf85263.c
@@ -83,6 +83,10 @@
 
 #define PCF85263_HR_PM		BIT(5)
 
+/* Our data stored in the RAM byte */
+#define PCF85263_STATE_CENTURY_MASK		0x7f
+#define PCF85263_STATE_UPPER_HALF_CENTURY	BIT(7)
+
 enum pcf85263_irqpin {
 	PCF85263_IRQPIN_NONE,
 	PCF85263_IRQPIN_INTA,
@@ -101,6 +105,8 @@ struct pcf85263 {
 	struct regmap *regmap;
 	enum pcf85263_irqpin irq_pin;
 	int irq;
+	u8 century;		/* 1 = 1900 2 = 2000, ... */
+	bool century_half;	/* false = 0-49, true=50-99 */
 	bool mode_12h;
 };
 
@@ -136,6 +142,85 @@ static int pcf85263_bin24h_to_bcd12h(int hr24)
 	return bin2bcd(hr12) | pm ? 0 : PCF85263_HR_PM;
 }
 
+static inline bool pcf85263_century_half(int year)
+{
+	return (year % 100) >= 50;
+}
+
+/*
+ * Since the hardware only has a year range of 00 to 99 we use
+ * the ram byte to store the century. 1=1900, 2=2000, 3=2100
+ * A value of zero is assumed to be 2000
+ *
+ * Set the ram byte when we set the clock which lets us use any
+ * century supported by linux (tm_year=0 => 1900)
+ *
+ * Unfortunately the hardware has no wrap around flag so fix it
+ * by also storing a flag indicating if the year is in the
+ * upper or lower half of the century.
+ */
+static int pcf85263_update_ram_byte(struct pcf85263 *pcf85263)
+{
+	u8 val = pcf85263->century & PCF85263_STATE_CENTURY_MASK;
+
+	if (pcf85263->century_half)
+		val |= PCF85263_STATE_UPPER_HALF_CENTURY;
+
+	return regmap_write(pcf85263->regmap, PCF85263_REG_RAM_BYTE, val);
+}
+
+static int pcf85263_read_ram_byte(struct pcf85263 *pcf85263)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(pcf85263->regmap, PCF85263_REG_RAM_BYTE, &regval);
+	if (ret)
+		return ret;
+
+	pcf85263->century = regval & PCF85263_STATE_CENTURY_MASK;
+	pcf85263->century_half = !!(regval & PCF85263_STATE_UPPER_HALF_CENTURY);
+
+	if (!pcf85263->century) { /* Not valid => not initialised yet */
+		int year;
+
+		ret = regmap_read(pcf85263->regmap,
+				  PCF85263_REG_RTC_YR, &regval);
+		if (ret)
+			return ret;
+
+		pcf85263->century = 2;
+		year = bcd2bin(regval) + 1900 + (pcf85263->century - 1) * 100;
+		pcf85263->century_half = pcf85263_century_half(year);
+
+		dev_warn(pcf85263->dev, "No century in NVRAM - assume %d\n",
+			 year);
+	}
+
+	return 0;
+}
+
+/*
+ * Detect year overflow by comparing the half (upper, lower) of
+ * the current year with the half the last time we read it
+ */
+static int pcf85263_update_century(struct pcf85263 *pcf85263, int year)
+{
+	bool cur_century_half;
+
+	cur_century_half = pcf85263_century_half(year);
+
+	if (cur_century_half == pcf85263->century_half)
+		return 0;
+
+	if (!cur_century_half) /* Year has wrapped around */
+		pcf85263->century++;
+
+	pcf85263->century_half = cur_century_half;
+
+	return pcf85263_update_ram_byte(pcf85263);
+}
+
 static int pcf85263_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct pcf85263 *pcf85263 = dev_get_drvdata(dev);
@@ -169,7 +254,11 @@ static int pcf85263_read_time(struct device *dev, struct rtc_time *tm)
 	tm->tm_mon  = bcd2bin(regs[PCF85263_REG_RTC_MO - first]) - 1;
 	tm->tm_year = bcd2bin(regs[PCF85263_REG_RTC_YR - first]);
 
-	tm->tm_year += 100;  /* Assume 21st century */
+	ret = pcf85263_update_century(pcf85263, tm->tm_year);
+	if (ret)
+		return ret;
+
+	tm->tm_year += (pcf85263->century - 1) * 100;
 
 	return 0;
 }
@@ -214,7 +303,14 @@ static int pcf85263_set_time(struct device *dev, struct rtc_time *tm)
 	}
 
 	/* Start it again */
-	return regmap_write(pcf85263->regmap, PCF85263_REG_STOPENABLE, 0);
+	ret = regmap_write(pcf85263->regmap, PCF85263_REG_STOPENABLE, 0);
+	if (ret)
+		return ret;
+
+	pcf85263->century = (tm->tm_year / 100) + 1;
+	pcf85263->century_half = pcf85263_century_half(tm->tm_year);
+
+	return pcf85263_update_ram_byte(pcf85263);
 }
 
 static int pcf85263_enable_alarm(struct pcf85263 *pcf85263, bool enable)
@@ -422,6 +518,11 @@ static int pcf85263_init_hw(struct pcf85263 *pcf85263)
 		return ret;
 	}
 
+	/* Get our persistent state from the ram byte */
+	ret = pcf85263_read_ram_byte(pcf85263);
+	if (ret < 0)
+		return ret;
+
 	/* Determine 12/24H mode */
 	ret = regmap_read(pcf85263->regmap, PCF85263_REG_OSC, &regval);
 	if (ret)

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
