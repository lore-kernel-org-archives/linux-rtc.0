Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33608 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751697AbdI0Ulh (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 27 Sep 2017 16:41:37 -0400
Received: by mail-wm0-f67.google.com with SMTP id m127so12099261wmm.0
        for <linux-rtc@vger.kernel.org>; Wed, 27 Sep 2017 13:41:37 -0700 (PDT)
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] rtc: ds1307: simplify hwmon config
Message-ID: <1f2c13e2-8e44-1ff9-0647-24be3eb510d2@gmail.com>
Date: Wed, 27 Sep 2017 22:41:26 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

We don't have to define an extra config symbol, IS_REACHABLE does
what we need. And having this config symbol just to save the few
bytes of hwmon support on non-DS3231 chips isn't worth it IMO
(especially as the symbol is set per default).

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/rtc/Kconfig      | 9 ---------
 drivers/rtc/rtc-ds1307.c | 2 +-
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index e0e58f3b..5572819d 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -244,15 +244,6 @@ config RTC_DRV_DS1307
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-ds1307.
 
-config RTC_DRV_DS1307_HWMON
-	bool "HWMON support for rtc-ds1307"
-	depends on RTC_DRV_DS1307 && HWMON
-	depends on !(RTC_DRV_DS1307=y && HWMON=m)
-	default y
-	help
-	  Say Y here if you want to expose temperature sensor data on
-	  rtc-ds1307 (only DS3231)
-
 config RTC_DRV_DS1307_CENTURY
 	bool "Century bit support for rtc-ds1307"
 	depends on RTC_DRV_DS1307
diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index e7d9215c..699ac68a 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1005,7 +1005,7 @@ static u8 ds1307_trickle_init(struct ds1307 *ds1307,
 
 /*----------------------------------------------------------------------*/
 
-#ifdef CONFIG_RTC_DRV_DS1307_HWMON
+#if IS_REACHABLE(CONFIG_HWMON)
 
 /*
  * Temperature sensor support for ds3231 devices.
-- 
2.14.1
