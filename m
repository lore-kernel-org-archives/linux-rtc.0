Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBNWHRHAQKGQEJIQSLEY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (up.free-electrons.com. [163.172.77.33])
        by gmr-mx.google.com with ESMTP id 18si1468193wmr.1.2016.11.08.15.45.58
        for <rtc-linux@googlegroups.com>;
        Tue, 08 Nov 2016 15:45:58 -0800 (PST)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] [PATCH] rtc: fix typos in Kconfig
Date: Wed,  9 Nov 2016 00:45:52 +0100
Message-Id: <20161108234552.3038-1-alexandre.belloni@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

s/buillt/built/g

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 24b0778f6e28..ab55f35019fc 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1565,7 +1565,7 @@ config RTC_DRV_LPC24XX
 	  NXP LPC178x/18xx/408x/43xx devices.
 
 	  If you have one of the devices above enable this driver to use
-	  the hardware RTC. This driver can also be buillt as a module. If
+	  the hardware RTC. This driver can also be built as a module. If
 	  so, the module will be called rtc-lpc24xx.
 
 config RTC_DRV_LPC32XX
@@ -1574,7 +1574,7 @@ config RTC_DRV_LPC32XX
 	help
 	  This enables support for the NXP RTC in the LPC32XX
 
-	  This driver can also be buillt as a module. If so, the module
+	  This driver can also be built as a module. If so, the module
 	  will be called rtc-lpc32xx.
 
 config RTC_DRV_PM8XXX
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
