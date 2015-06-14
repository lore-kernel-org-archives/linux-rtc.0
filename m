Return-Path: <rtc-linux+bncBDS7HNEFSALRBPG366VQKGQER4KYBEA@googlegroups.com>
MIME-Version: 1.0
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id t6si422313wiz.0.2015.06.14.14.10.20
        for <rtc-linux@googlegroups.com>;
        Sun, 14 Jun 2015 14:10:20 -0700 (PDT)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: rtc-linux@googlegroups.com
Cc: linux-kernel@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH] rtc: remove useless I2C dependencies
Date: Sun, 14 Jun 2015 23:08:18 +0200
Message-Id: <1434316098-23568-1-git-send-email-alexandre.belloni@free-electrons.com>
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

Multiple options depend on I2C but are already under under if I2C. Remove
those useless dependencies.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/Kconfig | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 23a5bcdf34ec..c904c0f9ed5f 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -146,7 +146,7 @@ if I2C
 
 config RTC_DRV_88PM860X
 	tristate "Marvell 88PM860x"
-	depends on I2C && MFD_88PM860X
+	depends on MFD_88PM860X
 	help
 	  If you say yes here you get support for RTC function in Marvell
 	  88PM860x chips.
@@ -156,7 +156,7 @@ config RTC_DRV_88PM860X
 
 config RTC_DRV_88PM80X
 	tristate "Marvell 88PM80x"
-	depends on I2C && MFD_88PM800
+	depends on MFD_88PM800
 	help
 	  If you say yes here you get support for RTC function in Marvell
 	  88PM80x chips.
@@ -165,7 +165,6 @@ config RTC_DRV_88PM80X
 	  will be called rtc-88pm80x.
 
 config RTC_DRV_ABB5ZES3
-	depends on I2C
 	select REGMAP_I2C
 	tristate "Abracon AB-RTCMC-32.768kHz-B5ZE-S3"
 	help
@@ -205,7 +204,6 @@ config RTC_DRV_DS1307
 
 config RTC_DRV_DS1374
 	tristate "Dallas/Maxim DS1374"
-	depends on I2C
 	help
 	  If you say yes here you get support for Dallas Semiconductor
 	  DS1374 real-time clock chips. If an interrupt is associated
@@ -233,7 +231,6 @@ config RTC_DRV_DS1672
 
 config RTC_DRV_DS3232
 	tristate "Dallas/Maxim DS3232"
-	depends on I2C
 	help
 	  If you say yes here you get support for Dallas Semiconductor
 	  DS3232 real-time clock chips. If an interrupt is associated
@@ -244,7 +241,7 @@ config RTC_DRV_DS3232
 
 config RTC_DRV_HYM8563
 	tristate "Haoyu Microelectronics HYM8563"
-	depends on I2C && OF
+	depends on OF
 	help
 	  Say Y to enable support for the HYM8563 I2C RTC chip. Apart
 	  from the usual rtc functions it provides a clock output of
@@ -366,7 +363,6 @@ config RTC_DRV_ISL12022
 	  will be called rtc-isl12022.
 
 config RTC_DRV_ISL12057
-	depends on I2C
 	select REGMAP_I2C
 	tristate "Intersil ISL12057"
 	help
-- 
2.1.4

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
