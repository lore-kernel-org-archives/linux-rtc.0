Return-Path: <rtc-linux+bncBAABBVM32SYAKGQEBCRBC2Y@googlegroups.com>
MIME-Version: 1.0
Received: from mail.cosmopool.net (mail.cosmopool.net. [2a01:4f8:160:20c1::10:107])
        by gmr-mx.google.com with ESMTP id hs5si99654wib.1.2015.10.07.05.19.33
        for <rtc-linux@googlegroups.com>;
        Wed, 07 Oct 2015 05:19:33 -0700 (PDT)
From: Harald Geyer <harald@ccbib.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Cc: rtc-linux@googlegroups.com,
	linux-watchdog@vger.kernel.org,
	kernel@pengutronix.de,
	Wolfram Sang <wsa@the-dreams.de>,
	Fabio Estevam <festevam@gmail.com>,
	Harald Geyer <harald@ccbib.org>
Subject: [rtc-linux] [PATCH 2/2] watchdog: stmp3xxx: Implement GETBOOTSTATUS
Date: Wed,  7 Oct 2015 12:19:12 +0000
Message-Id: <1444220352-20548-2-git-send-email-harald@ccbib.org>
In-Reply-To: <1444220352-20548-1-git-send-email-harald@ccbib.org>
References: <1444220352-20548-1-git-send-email-harald@ccbib.org>
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

This device doesn't provide any information about boot status.
As workaround we use a persitent bit to track watchdog activity.

Signed-off-by: Harald Geyer <harald@ccbib.org>
---
Changes since v2:
* make code ordering more consistent
* move part of the commit message to a code comment
* rewrite the commit message

Changes since v1:
* make code formatting more consistent with the rest of the driver
* Cc some people who might have better documentation then I do

Changes since initially posting this patch on 08/04/2015:
* fix a spelling error in the commit message
* rebase to a recent version

 drivers/rtc/rtc-stmp3xxx.c          |   37 +++++++++++++++++++++++++++++++++++
 drivers/watchdog/stmp3xxx_rtc_wdt.c |    6 +++++-
 include/linux/stmp3xxx_rtc_wdt.h    |    2 ++
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
index ca54d03..47947ea 100644
--- a/drivers/rtc/rtc-stmp3xxx.c
+++ b/drivers/rtc/rtc-stmp3xxx.c
@@ -30,6 +30,7 @@
 #include <linux/of.h>
 #include <linux/stmp_device.h>
 #include <linux/stmp3xxx_rtc_wdt.h>
+#include <linux/watchdog.h>
 
 #define STMP3XXX_RTC_CTRL			0x0
 #define STMP3XXX_RTC_CTRL_ALARM_IRQ_EN		0x00000001
@@ -62,6 +63,9 @@
 /* missing bitmask in headers */
 #define STMP3XXX_RTC_PERSISTENT1_FORCE_UPDATER	0x80000000
 
+#define STMP3XXX_RTC_PERSISTENT2		0x80
+#define STMP3XXX_RTC_PERSISTENT2_WDT_ACTIVE	0x00000001
+
 struct stmp3xxx_rtc_data {
 	struct rtc_device *rtc;
 	void __iomem *io;
@@ -81,6 +85,20 @@ struct stmp3xxx_rtc_data {
  * The watchdog driver is passed the below accessor function via platform_data
  * to configure the watchdog. Locking is not needed because accessing SET/CLR
  * registers is atomic.
+ *
+ * Since this device doesn't report the cause of the last reset, we use
+ * a persistent bit to track watchdog activity. The code from the Freescale
+ * BSP uses the STMP3XXX_RTC_PERSISTENT1 register, which is dedicated to
+ * controlling the boot ROM, for this purpose. However it seems the bit
+ * there can't be cleared once it has been set. So we are using
+ * STMP3XXX_RTC_PERSISTENT2 instead, which is the first register available
+ * for "software use" without restriction.
+ *
+ * I (Harald Geyer <harald@ccbib.org>) don't know if the code touching the
+ * STMP3XXX_RTC_PERSISTENT1 register is doing anything useful. Maybe this
+ * is just a leftover from the BSP code, but then maybe there is something
+ * in the boot ROM or in some bootloader that is using this. Hard to tell
+ * without proper documentation about this register.
  */
 
 static void stmp3xxx_wdt_set_timeout(struct device *dev, u32 timeout)
@@ -93,16 +111,30 @@ static void stmp3xxx_wdt_set_timeout(struct device *dev, u32 timeout)
 		       rtc_data->io + STMP3XXX_RTC_CTRL + STMP_OFFSET_REG_SET);
 		writel(STMP3XXX_RTC_PERSISTENT1_FORCE_UPDATER,
 		       rtc_data->io + STMP3XXX_RTC_PERSISTENT1 + STMP_OFFSET_REG_SET);
+		writel(STMP3XXX_RTC_PERSISTENT2_WDT_ACTIVE,
+		       rtc_data->io + STMP3XXX_RTC_PERSISTENT2 + STMP_OFFSET_REG_SET);
 	} else {
 		writel(STMP3XXX_RTC_CTRL_WATCHDOGEN,
 		       rtc_data->io + STMP3XXX_RTC_CTRL + STMP_OFFSET_REG_CLR);
 		writel(STMP3XXX_RTC_PERSISTENT1_FORCE_UPDATER,
 		       rtc_data->io + STMP3XXX_RTC_PERSISTENT1 + STMP_OFFSET_REG_CLR);
+		writel(STMP3XXX_RTC_PERSISTENT2_WDT_ACTIVE,
+		       rtc_data->io + STMP3XXX_RTC_PERSISTENT2 + STMP_OFFSET_REG_CLR);
 	}
 }
 
+static void stmp3xxx_wdt_clear_bootstatus(struct device *dev)
+{
+	struct stmp3xxx_rtc_data *rtc_data = dev_get_drvdata(dev);
+
+	writel(STMP3XXX_RTC_PERSISTENT2_WDT_ACTIVE,
+	       rtc_data->io + STMP3XXX_RTC_PERSISTENT2 + STMP_OFFSET_REG_CLR);
+}
+
 static struct stmp3xxx_wdt_pdata wdt_pdata = {
 	.wdt_set_timeout = stmp3xxx_wdt_set_timeout,
+	.wdt_clear_bootstatus = stmp3xxx_wdt_clear_bootstatus,
+	.bootstatus = 0,
 };
 
 static void stmp3xxx_wdt_register(struct platform_device *rtc_pdev)
@@ -110,6 +142,8 @@ static void stmp3xxx_wdt_register(struct platform_device *rtc_pdev)
 	struct platform_device *wdt_pdev =
 		platform_device_alloc("stmp3xxx_rtc_wdt", rtc_pdev->id);
 
+	stmp3xxx_wdt_clear_bootstatus(&rtc_pdev->dev);
+
 	if (wdt_pdev) {
 		wdt_pdev->dev.parent = &rtc_pdev->dev;
 		wdt_pdev->dev.platform_data = &wdt_pdata;
@@ -357,6 +391,9 @@ static int stmp3xxx_rtc_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	if (readl(STMP3XXX_RTC_PERSISTENT2 + rtc_data->io) &
+			 STMP3XXX_RTC_PERSISTENT2_WDT_ACTIVE)
+		wdt_pdata.bootstatus |= WDIOF_CARDRESET;
 	stmp3xxx_wdt_register(pdev);
 	return 0;
 }
diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c b/drivers/watchdog/stmp3xxx_rtc_wdt.c
index e09a01f..7609f78 100644
--- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
+++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
@@ -52,7 +52,8 @@ static int wdt_set_timeout(struct watchdog_device *wdd, unsigned new_timeout)
 }
 
 static const struct watchdog_info stmp3xxx_wdt_ident = {
-	.options = WDIOF_MAGICCLOSE | WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+	.options = WDIOF_MAGICCLOSE | WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
+		WDIOF_CARDRESET,
 	.identity = "STMP3XXX RTC Watchdog",
 };
 
@@ -79,6 +80,7 @@ static int wdt_notify_sys(struct notifier_block *nb, unsigned long code,
 
 	switch (code) {
 	case SYS_DOWN:	/* keep enabled, system might crash while going down */
+		pdata->wdt_clear_bootstatus(dev->parent);
 		break;
 	case SYS_HALT:  /* allow the system to actually halt */
 	case SYS_POWER_OFF:
@@ -95,12 +97,14 @@ static struct notifier_block wdt_notifier = {
 
 static int stmp3xxx_wdt_probe(struct platform_device *pdev)
 {
+	struct stmp3xxx_wdt_pdata *pdata = dev_get_platdata(&pdev->dev);
 	int ret;
 
 	watchdog_set_drvdata(&stmp3xxx_wdd, &pdev->dev);
 
 	stmp3xxx_wdd.timeout = clamp_t(unsigned, heartbeat, 1, STMP3XXX_MAX_TIMEOUT);
 	stmp3xxx_wdd.parent = &pdev->dev;
+	stmp3xxx_wdd.bootstatus = pdata->bootstatus;
 
 	ret = watchdog_register_device(&stmp3xxx_wdd);
 	if (ret < 0) {
diff --git a/include/linux/stmp3xxx_rtc_wdt.h b/include/linux/stmp3xxx_rtc_wdt.h
index 1dd12c9..62dd9e6 100644
--- a/include/linux/stmp3xxx_rtc_wdt.h
+++ b/include/linux/stmp3xxx_rtc_wdt.h
@@ -10,6 +10,8 @@
 
 struct stmp3xxx_wdt_pdata {
 	void (*wdt_set_timeout)(struct device *dev, u32 timeout);
+	void (*wdt_clear_bootstatus)(struct device *dev);
+	unsigned int bootstatus;
 };
 
 #endif /* __LINUX_STMP3XXX_RTC_WDT_H */
-- 
1.7.10.4

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
