Return-Path: <rtc-linux+bncBAABBVE32SYAKGQETUWAX3Y@googlegroups.com>
MIME-Version: 1.0
Received: from mail.cosmopool.net (mail.cosmopool.net. [2a01:4f8:160:20c1::10:107])
        by gmr-mx.google.com with ESMTP id w4si109165wiz.0.2015.10.07.05.19.31
        for <rtc-linux@googlegroups.com>;
        Wed, 07 Oct 2015 05:19:31 -0700 (PDT)
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
Subject: [rtc-linux] [PATCHv3 1/2] watchdog: stmp3xxx: Stop the watchdog on
 system halt
Date: Wed,  7 Oct 2015 12:19:11 +0000
Message-Id: <1444220352-20548-1-git-send-email-harald@ccbib.org>
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

This allows the system to actually halt even if userspace forgot to
disable the watchdog first. Old behaviour was that the watchdog forced
the system to boot again.

Signed-off-by: Harald Geyer <harald@ccbib.org>
---
Changes since v2:
* split this out as a separate patch

 drivers/watchdog/stmp3xxx_rtc_wdt.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c b/drivers/watchdog/stmp3xxx_rtc_wdt.c
index 3ee6128..e09a01f 100644
--- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
+++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
@@ -14,6 +14,8 @@
 #include <linux/watchdog.h>
 #include <linux/platform_device.h>
 #include <linux/stmp3xxx_rtc_wdt.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
 
 #define WDOG_TICK_RATE 1000 /* 1 kHz clock */
 #define STMP3XXX_DEFAULT_TIMEOUT 19
@@ -69,6 +71,28 @@ static struct watchdog_device stmp3xxx_wdd = {
 	.status = WATCHDOG_NOWAYOUT_INIT_STATUS,
 };
 
+static int wdt_notify_sys(struct notifier_block *nb, unsigned long code,
+			  void *unused)
+{
+	struct device *dev = watchdog_get_drvdata(&stmp3xxx_wdd);
+	struct stmp3xxx_wdt_pdata *pdata = dev_get_platdata(dev);
+
+	switch (code) {
+	case SYS_DOWN:	/* keep enabled, system might crash while going down */
+		break;
+	case SYS_HALT:  /* allow the system to actually halt */
+	case SYS_POWER_OFF:
+		wdt_stop(&stmp3xxx_wdd);
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block wdt_notifier = {
+	.notifier_call  = wdt_notify_sys,
+};
+
 static int stmp3xxx_wdt_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -84,6 +108,9 @@ static int stmp3xxx_wdt_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (register_reboot_notifier(&wdt_notifier))
+		dev_warn(&pdev->dev, "cannot register reboot notifier\n");
+
 	dev_info(&pdev->dev, "initialized watchdog with heartbeat %ds\n",
 			stmp3xxx_wdd.timeout);
 	return 0;
@@ -91,6 +118,7 @@ static int stmp3xxx_wdt_probe(struct platform_device *pdev)
 
 static int stmp3xxx_wdt_remove(struct platform_device *pdev)
 {
+	unregister_reboot_notifier(&wdt_notifier);
 	watchdog_unregister_device(&stmp3xxx_wdd);
 	return 0;
 }
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
