Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Subject: [v2,1/4] rtc: Kconfig capital Description
From: =?utf-8?q?S=C3=B8ren_Andersen?= <san@rosetechnology.dk>
Message-Id: <1426020349.5476.28.camel@sanws1.rosetechnology.dk>
Cc: rtc-linux@googlegroups.com
Date: Tue, 10 Mar 2015 21:45:49 +0100
List-ID: <rtc-linux.googlegroups.com>

Signed-off-by: Soeren Andersen <san at rosetechnology.dk>
---
 drivers/rtc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index b5b5c3d..d9e2a14 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -413,7 +413,7 @@ config RTC_DRV_PCF8563
 	  will be called rtc-pcf8563.
 
 config RTC_DRV_PCF85063
-	tristate "nxp PCF85063"
+	tristate "NXP PCF85063"
 	help
 	  If you say yes here you get support for the PCF85063 RTC chip
 
