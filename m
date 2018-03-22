Return-Path: <linux-rtc-owner@vger.kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH] rtc: ab8500: Drop AB8540 support
Date: Thu, 22 Mar 2018 11:18:30 +0100
Message-Id: <20180322101830.9851-1-linus.walleij@linaro.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <rtc-linux.googlegroups.com>

The AB8540 was an evolved version of the AB8500, but it was never
mass produced or put into products, only reference designs exist.
The upstream support was never completed and it is unlikely that
this will happen so drop the support for now to simplify
maintenance of the AB8500.

Cc: Loic Pallardy <loic.pallardy@st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/rtc/rtc-ab8500.c | 55 ------------------------------------------------
 1 file changed, 55 deletions(-)

diff --git a/drivers/rtc/rtc-ab8500.c b/drivers/rtc/rtc-ab8500.c
index 24a0af650a1b..d9ca704a2df9 100644
--- a/drivers/rtc/rtc-ab8500.c
+++ b/drivers/rtc/rtc-ab8500.c
@@ -36,10 +36,6 @@
 #define AB8500_RTC_FORCE_BKUP_REG	0x0D
 #define AB8500_RTC_CALIB_REG		0x0E
 #define AB8500_RTC_SWITCH_STAT_REG	0x0F
-#define AB8540_RTC_ALRM_SEC		0x22
-#define AB8540_RTC_ALRM_MIN_LOW_REG	0x23
-#define AB8540_RTC_ALRM_MIN_MID_REG	0x24
-#define AB8540_RTC_ALRM_MIN_HI_REG	0x25
 
 /* RtcReadRequest bits */
 #define RTC_READ_REQUEST		0x01
@@ -63,11 +59,6 @@ static const u8 ab8500_rtc_alarm_regs[] = {
 	AB8500_RTC_ALRM_MIN_LOW_REG
 };
 
-static const u8 ab8540_rtc_alarm_regs[] = {
-	AB8540_RTC_ALRM_MIN_HI_REG, AB8540_RTC_ALRM_MIN_MID_REG,
-	AB8540_RTC_ALRM_MIN_LOW_REG, AB8540_RTC_ALRM_SEC
-};
-
 /* Calculate the seconds from 1970 to 01-01-2000 00:00:00 */
 static unsigned long get_elapsed_seconds(int year)
 {
@@ -277,43 +268,6 @@ static int ab8500_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	return ab8500_rtc_irq_enable(dev, alarm->enabled);
 }
 
-static int ab8540_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
-{
-	int retval, i;
-	unsigned char buf[ARRAY_SIZE(ab8540_rtc_alarm_regs)];
-	unsigned long mins, secs = 0;
-
-	if (alarm->time.tm_year < (AB8500_RTC_EPOCH - 1900)) {
-		dev_dbg(dev, "year should be equal to or greater than %d\n",
-				AB8500_RTC_EPOCH);
-		return -EINVAL;
-	}
-
-	/* Get the number of seconds since 1970 */
-	rtc_tm_to_time(&alarm->time, &secs);
-
-	/*
-	 * Convert it to the number of seconds since 01-01-2000 00:00:00
-	 */
-	secs -= get_elapsed_seconds(AB8500_RTC_EPOCH);
-	mins = secs / 60;
-
-	buf[3] = secs % 60;
-	buf[2] = mins & 0xFF;
-	buf[1] = (mins >> 8) & 0xFF;
-	buf[0] = (mins >> 16) & 0xFF;
-
-	/* Set the alarm time */
-	for (i = 0; i < ARRAY_SIZE(ab8540_rtc_alarm_regs); i++) {
-		retval = abx500_set_register_interruptible(dev, AB8500_RTC,
-			ab8540_rtc_alarm_regs[i], buf[i]);
-		if (retval < 0)
-			return retval;
-	}
-
-	return ab8500_rtc_irq_enable(dev, alarm->enabled);
-}
-
 static int ab8500_rtc_set_calibration(struct device *dev, int calibration)
 {
 	int retval;
@@ -435,17 +389,8 @@ static const struct rtc_class_ops ab8500_rtc_ops = {
 	.alarm_irq_enable	= ab8500_rtc_irq_enable,
 };
 
-static const struct rtc_class_ops ab8540_rtc_ops = {
-	.read_time		= ab8500_rtc_read_time,
-	.set_time		= ab8500_rtc_set_time,
-	.read_alarm		= ab8500_rtc_read_alarm,
-	.set_alarm		= ab8540_rtc_set_alarm,
-	.alarm_irq_enable	= ab8500_rtc_irq_enable,
-};
-
 static const struct platform_device_id ab85xx_rtc_ids[] = {
 	{ "ab8500-rtc", (kernel_ulong_t)&ab8500_rtc_ops, },
-	{ "ab8540-rtc", (kernel_ulong_t)&ab8540_rtc_ops, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(platform, ab85xx_rtc_ids);
-- 
2.14.3
