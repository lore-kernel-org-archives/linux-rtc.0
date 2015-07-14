Return-Path: <rtc-linux+bncBD4IBNO3YAGRBHOKSGWQKGQEJCHPGFY@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-x236.google.com (mail-pa0-x236.google.com. [2607:f8b0:400e:c03::236])
        by gmr-mx.google.com with ESMTPS id ns6si1915870pbc.2.2015.07.13.18.25.49
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2015 18:25:49 -0700 (PDT)
Received: by mail-pa0-x236.google.com with SMTP id tm7so216368056pac.2
        for <rtc-linux@googlegroups.com>; Mon, 13 Jul 2015 18:25:49 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	a.zummo@towertech.it,
	rtc-linux@googlegroups.com
Cc: workgroup.linux@csr.com,
	Guo Zeng <guo.zeng@csr.com>,
	Barry Song <Baohua.Song@csr.com>
Subject: [rtc-linux] [PATCH] drivers/rtc/rtc-sirfsoc.c: move to regmap APIs
 from platform-specific APIs
Date: Tue, 14 Jul 2015 01:31:38 +0000
Message-Id: <1436837498-6962-1-git-send-email-21cnbao@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

From: Guo Zeng <guo.zeng@csr.com>

The current codes use CSR platform specific API exported by machine
codes to read/write RTC registers. they are:
sirfsoc_rtc_iobrg_readl()
sirfsoc_rtc_iobrg_writel()

commit b1999477("ARM: prima2: move to use REGMAP APIs for rtciobrg")
moves to regmap support, now we can move to use regmap APIs in RTC
driver.

Signed-off-by: Guo Zeng <guo.zeng@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/rtc/rtc-sirfsoc.c | 106 +++++++++++++++++++++++++++-------------------
 1 file changed, 63 insertions(+), 43 deletions(-)

diff --git a/drivers/rtc/rtc-sirfsoc.c b/drivers/rtc/rtc-sirfsoc.c
index edc3b432..a477bc5 100644
--- a/drivers/rtc/rtc-sirfsoc.c
+++ b/drivers/rtc/rtc-sirfsoc.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/regmap.h>
 #include <linux/rtc/sirfsoc_rtciobrg.h>
 
 
@@ -48,11 +49,25 @@ struct sirfsoc_rtc_drv {
 	/* Overflow for every 8 years extra time */
 	u32			overflow_rtc;
 	spinlock_t		lock;
+	struct regmap *regmap;
 #ifdef CONFIG_PM
 	u32		saved_counter;
 	u32		saved_overflow_rtc;
 #endif
 };
+static u32 sirfsoc_rtc_readl(struct sirfsoc_rtc_drv *rtcdrv, u32 offset)
+{
+	u32 val;
+
+	regmap_read(rtcdrv->regmap, rtcdrv->rtc_base + offset, &val);
+	return val;
+}
+
+static void sirfsoc_rtc_writel(struct sirfsoc_rtc_drv *rtcdrv,
+			u32 offset, u32 val)
+{
+	regmap_write(rtcdrv->regmap, rtcdrv->rtc_base + offset, val);
+}
 
 static int sirfsoc_rtc_read_alarm(struct device *dev,
 		struct rtc_wkalrm *alrm)
@@ -64,9 +79,9 @@ static int sirfsoc_rtc_read_alarm(struct device *dev,
 
 	spin_lock_irq(&rtcdrv->lock);
 
-	rtc_count = sirfsoc_rtc_iobrg_readl(rtcdrv->rtc_base + RTC_CN);
+	rtc_count = sirfsoc_rtc_readl(rtcdrv, RTC_CN);
 
-	rtc_alarm = sirfsoc_rtc_iobrg_readl(rtcdrv->rtc_base + RTC_ALARM0);
+	rtc_alarm = sirfsoc_rtc_readl(rtcdrv, RTC_ALARM0);
 	memset(alrm, 0, sizeof(struct rtc_wkalrm));
 
 	/*
@@ -82,8 +97,7 @@ static int sirfsoc_rtc_read_alarm(struct device *dev,
 		rtc_time_to_tm(rtcdrv->overflow_rtc
 				<< (BITS_PER_LONG - RTC_SHIFT)
 				| rtc_alarm >> RTC_SHIFT, &(alrm->time));
-	if (sirfsoc_rtc_iobrg_readl(
-			rtcdrv->rtc_base + RTC_STATUS) & SIRFSOC_RTC_AL0E)
+	if (sirfsoc_rtc_readl(rtcdrv, RTC_STATUS) & SIRFSOC_RTC_AL0E)
 		alrm->enabled = 1;
 
 	spin_unlock_irq(&rtcdrv->lock);
@@ -103,8 +117,7 @@ static int sirfsoc_rtc_set_alarm(struct device *dev,
 
 		spin_lock_irq(&rtcdrv->lock);
 
-		rtc_status_reg = sirfsoc_rtc_iobrg_readl(
-				rtcdrv->rtc_base + RTC_STATUS);
+		rtc_status_reg = sirfsoc_rtc_readl(rtcdrv, RTC_STATUS);
 		if (rtc_status_reg & SIRFSOC_RTC_AL0E) {
 			/*
 			 * An ongoing alarm in progress - ingore it and not
@@ -113,8 +126,7 @@ static int sirfsoc_rtc_set_alarm(struct device *dev,
 			dev_info(dev, "An old alarm was set, will be replaced by a new one\n");
 		}
 
-		sirfsoc_rtc_iobrg_writel(
-			rtc_alarm << RTC_SHIFT, rtcdrv->rtc_base + RTC_ALARM0);
+		sirfsoc_rtc_writel(rtcdrv, RTC_ALARM0, rtc_alarm << RTC_SHIFT);
 		rtc_status_reg &= ~0x07; /* mask out the lower status bits */
 		/*
 		 * This bit RTC_AL sets it as a wake-up source for Sleep Mode
@@ -123,8 +135,7 @@ static int sirfsoc_rtc_set_alarm(struct device *dev,
 		rtc_status_reg |= SIRFSOC_RTC_AL0;
 		/* enable the RTC alarm interrupt */
 		rtc_status_reg |= SIRFSOC_RTC_AL0E;
-		sirfsoc_rtc_iobrg_writel(
-			rtc_status_reg, rtcdrv->rtc_base + RTC_STATUS);
+		sirfsoc_rtc_writel(rtcdrv, RTC_STATUS, rtc_status_reg);
 
 		spin_unlock_irq(&rtcdrv->lock);
 	} else {
@@ -135,8 +146,7 @@ static int sirfsoc_rtc_set_alarm(struct device *dev,
 		 */
 		spin_lock_irq(&rtcdrv->lock);
 
-		rtc_status_reg = sirfsoc_rtc_iobrg_readl(
-				rtcdrv->rtc_base + RTC_STATUS);
+		rtc_status_reg = sirfsoc_rtc_readl(rtcdrv, RTC_STATUS);
 		if (rtc_status_reg & SIRFSOC_RTC_AL0E) {
 			/* clear the RTC status register's alarm bit */
 			rtc_status_reg &= ~0x07;
@@ -145,8 +155,8 @@ static int sirfsoc_rtc_set_alarm(struct device *dev,
 			/* Clear the Alarm enable bit */
 			rtc_status_reg &= ~(SIRFSOC_RTC_AL0E);
 
-			sirfsoc_rtc_iobrg_writel(rtc_status_reg,
-					rtcdrv->rtc_base + RTC_STATUS);
+			sirfsoc_rtc_writel(rtcdrv, RTC_STATUS,
+				rtc_status_reg);
 		}
 
 		spin_unlock_irq(&rtcdrv->lock);
@@ -167,9 +177,9 @@ static int sirfsoc_rtc_read_time(struct device *dev,
 	 * fail, read several times to make sure get stable value.
 	 */
 	do {
-		tmp_rtc = sirfsoc_rtc_iobrg_readl(rtcdrv->rtc_base + RTC_CN);
+		tmp_rtc = sirfsoc_rtc_readl(rtcdrv, RTC_CN);
 		cpu_relax();
-	} while (tmp_rtc != sirfsoc_rtc_iobrg_readl(rtcdrv->rtc_base + RTC_CN));
+	} while (tmp_rtc != sirfsoc_rtc_readl(rtcdrv, RTC_CN));
 
 	rtc_time_to_tm(rtcdrv->overflow_rtc << (BITS_PER_LONG - RTC_SHIFT) |
 					tmp_rtc >> RTC_SHIFT, tm);
@@ -187,10 +197,8 @@ static int sirfsoc_rtc_set_time(struct device *dev,
 
 	rtcdrv->overflow_rtc = rtc_time >> (BITS_PER_LONG - RTC_SHIFT);
 
-	sirfsoc_rtc_iobrg_writel(rtcdrv->overflow_rtc,
-			rtcdrv->rtc_base + RTC_SW_VALUE);
-	sirfsoc_rtc_iobrg_writel(
-			rtc_time << RTC_SHIFT, rtcdrv->rtc_base + RTC_CN);
+	sirfsoc_rtc_writel(rtcdrv, RTC_SW_VALUE, rtcdrv->overflow_rtc);
+	sirfsoc_rtc_writel(rtcdrv, RTC_CN, rtc_time << RTC_SHIFT);
 
 	return 0;
 }
@@ -222,14 +230,13 @@ static int sirfsoc_rtc_alarm_irq_enable(struct device *dev,
 
 	spin_lock_irq(&rtcdrv->lock);
 
-	rtc_status_reg = sirfsoc_rtc_iobrg_readl(
-				rtcdrv->rtc_base + RTC_STATUS);
+	rtc_status_reg = sirfsoc_rtc_readl(rtcdrv, RTC_STATUS);
 	if (enabled)
 		rtc_status_reg |= SIRFSOC_RTC_AL0E;
 	else
 		rtc_status_reg &= ~SIRFSOC_RTC_AL0E;
 
-	sirfsoc_rtc_iobrg_writel(rtc_status_reg, rtcdrv->rtc_base + RTC_STATUS);
+	sirfsoc_rtc_writel(rtcdrv, RTC_STATUS, rtc_status_reg);
 
 	spin_unlock_irq(&rtcdrv->lock);
 
@@ -254,7 +261,7 @@ static irqreturn_t sirfsoc_rtc_irq_handler(int irq, void *pdata)
 
 	spin_lock(&rtcdrv->lock);
 
-	rtc_status_reg = sirfsoc_rtc_iobrg_readl(rtcdrv->rtc_base + RTC_STATUS);
+	rtc_status_reg = sirfsoc_rtc_readl(rtcdrv, RTC_STATUS);
 	/* this bit will be set ONLY if an alarm was active
 	 * and it expired NOW
 	 * So this is being used as an ASSERT
@@ -270,7 +277,8 @@ static irqreturn_t sirfsoc_rtc_irq_handler(int irq, void *pdata)
 		/* Clear the Alarm enable bit */
 		rtc_status_reg &= ~(SIRFSOC_RTC_AL0E);
 	}
-	sirfsoc_rtc_iobrg_writel(rtc_status_reg, rtcdrv->rtc_base + RTC_STATUS);
+
+	sirfsoc_rtc_writel(rtcdrv, RTC_STATUS, rtc_status_reg);
 
 	spin_unlock(&rtcdrv->lock);
 
@@ -287,6 +295,13 @@ static const struct of_device_id sirfsoc_rtc_of_match[] = {
 	{ .compatible = "sirf,prima2-sysrtc"},
 	{},
 };
+
+const struct regmap_config sysrtc_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.fast_io = true,
+};
+
 MODULE_DEVICE_TABLE(of, sirfsoc_rtc_of_match);
 
 static int sirfsoc_rtc_probe(struct platform_device *pdev)
@@ -314,27 +329,35 @@ static int sirfsoc_rtc_probe(struct platform_device *pdev)
 	/* Register rtc alarm as a wakeup source */
 	device_init_wakeup(&pdev->dev, 1);
 
+	rtcdrv->regmap = devm_regmap_init_iobg(&pdev->dev,
+			&sysrtc_regmap_config);
+	if (IS_ERR(rtcdrv->regmap)) {
+		err = PTR_ERR(rtcdrv->regmap);
+		dev_err(&pdev->dev, "Failed to allocate register map: %d\n",
+			err);
+		return err;
+	}
+
 	/*
 	 * Set SYS_RTC counter in RTC_HZ HZ Units
 	 * We are using 32K RTC crystal (32768 / RTC_HZ / 2) -1
 	 * If 16HZ, therefore RTC_DIV = 1023;
 	 */
 	rtc_div = ((32768 / RTC_HZ) / 2) - 1;
-	sirfsoc_rtc_iobrg_writel(rtc_div, rtcdrv->rtc_base + RTC_DIV);
+	sirfsoc_rtc_writel(rtcdrv, RTC_DIV, rtc_div);
 
 	/* 0x3 -> RTC_CLK */
-	sirfsoc_rtc_iobrg_writel(SIRFSOC_RTC_CLK,
-			rtcdrv->rtc_base + RTC_CLOCK_SWITCH);
+	sirfsoc_rtc_writel(rtcdrv, RTC_CLOCK_SWITCH, SIRFSOC_RTC_CLK);
 
 	/* reset SYS RTC ALARM0 */
-	sirfsoc_rtc_iobrg_writel(0x0, rtcdrv->rtc_base + RTC_ALARM0);
+	sirfsoc_rtc_writel(rtcdrv, RTC_ALARM0, 0x0);
 
 	/* reset SYS RTC ALARM1 */
-	sirfsoc_rtc_iobrg_writel(0x0, rtcdrv->rtc_base + RTC_ALARM1);
+	sirfsoc_rtc_writel(rtcdrv, RTC_ALARM1, 0x0);
 
 	/* Restore RTC Overflow From Register After Command Reboot */
 	rtcdrv->overflow_rtc =
-		sirfsoc_rtc_iobrg_readl(rtcdrv->rtc_base + RTC_SW_VALUE);
+		sirfsoc_rtc_readl(rtcdrv, RTC_SW_VALUE);
 
 	rtcdrv->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
 			&sirfsoc_rtc_ops, THIS_MODULE);
@@ -372,10 +395,10 @@ static int sirfsoc_rtc_suspend(struct device *dev)
 {
 	struct sirfsoc_rtc_drv *rtcdrv = dev_get_drvdata(dev);
 	rtcdrv->overflow_rtc =
-		sirfsoc_rtc_iobrg_readl(rtcdrv->rtc_base + RTC_SW_VALUE);
+		sirfsoc_rtc_readl(rtcdrv, RTC_SW_VALUE);
 
 	rtcdrv->saved_counter =
-		sirfsoc_rtc_iobrg_readl(rtcdrv->rtc_base + RTC_CN);
+		sirfsoc_rtc_readl(rtcdrv, RTC_CN);
 	rtcdrv->saved_overflow_rtc = rtcdrv->overflow_rtc;
 	if (device_may_wakeup(dev) && !enable_irq_wake(rtcdrv->irq))
 		rtcdrv->irq_wake = 1;
@@ -392,12 +415,10 @@ static int sirfsoc_rtc_resume(struct device *dev)
 	 * if resume from snapshot and the rtc power is lost,
 	 * restroe the rtc settings
 	 */
-	if (SIRFSOC_RTC_CLK != sirfsoc_rtc_iobrg_readl(
-			rtcdrv->rtc_base + RTC_CLOCK_SWITCH)) {
+	if (SIRFSOC_RTC_CLK != sirfsoc_rtc_readl(rtcdrv, RTC_CLOCK_SWITCH)) {
 		u32 rtc_div;
 		/* 0x3 -> RTC_CLK */
-		sirfsoc_rtc_iobrg_writel(SIRFSOC_RTC_CLK,
-			rtcdrv->rtc_base + RTC_CLOCK_SWITCH);
+		sirfsoc_rtc_writel(rtcdrv, RTC_CLOCK_SWITCH, SIRFSOC_RTC_CLK);
 		/*
 		 * Set SYS_RTC counter in RTC_HZ HZ Units
 		 * We are using 32K RTC crystal (32768 / RTC_HZ / 2) -1
@@ -405,13 +426,13 @@ static int sirfsoc_rtc_resume(struct device *dev)
 		 */
 		rtc_div = ((32768 / RTC_HZ) / 2) - 1;
 
-		sirfsoc_rtc_iobrg_writel(rtc_div, rtcdrv->rtc_base + RTC_DIV);
+		sirfsoc_rtc_writel(rtcdrv, RTC_DIV, rtc_div);
 
 		/* reset SYS RTC ALARM0 */
-		sirfsoc_rtc_iobrg_writel(0x0, rtcdrv->rtc_base + RTC_ALARM0);
+		sirfsoc_rtc_writel(rtcdrv, RTC_ALARM0, 0x0);
 
 		/* reset SYS RTC ALARM1 */
-		sirfsoc_rtc_iobrg_writel(0x0, rtcdrv->rtc_base + RTC_ALARM1);
+		sirfsoc_rtc_writel(rtcdrv, RTC_ALARM1, 0x0);
 	}
 	rtcdrv->overflow_rtc = rtcdrv->saved_overflow_rtc;
 
@@ -419,15 +440,14 @@ static int sirfsoc_rtc_resume(struct device *dev)
 	 * if current counter is small than previous,
 	 * it means overflow in sleep
 	 */
-	tmp = sirfsoc_rtc_iobrg_readl(rtcdrv->rtc_base + RTC_CN);
+	tmp = sirfsoc_rtc_readl(rtcdrv, RTC_CN);
 	if (tmp <= rtcdrv->saved_counter)
 		rtcdrv->overflow_rtc++;
 	/*
 	 *PWRC Value Be Changed When Suspend, Restore Overflow
 	 * In Memory To Register
 	 */
-	sirfsoc_rtc_iobrg_writel(rtcdrv->overflow_rtc,
-			rtcdrv->rtc_base + RTC_SW_VALUE);
+	sirfsoc_rtc_writel(rtcdrv, RTC_SW_VALUE, rtcdrv->overflow_rtc);
 
 	if (device_may_wakeup(dev) && rtcdrv->irq_wake) {
 		disable_irq_wake(rtcdrv->irq);
-- 
2.3.5

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
