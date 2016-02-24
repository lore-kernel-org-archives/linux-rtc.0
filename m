Return-Path: <rtc-linux+bncBAABBS6PW63AKGQESAEZ57Y@googlegroups.com>
MIME-Version: 1.0
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id ui7si561093pab.0.2016.02.24.09.26.34
        for <rtc-linux@googlegroups.com>;
        Wed, 24 Feb 2016 09:26:34 -0800 (PST)
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-mediatek@lists.infradead.org,
	Eddie Huang <eddie.huang@mediatek.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] [PATCH] rtc: mt6397: Remove plaform module alias
Date: Wed, 24 Feb 2016 14:26:20 -0300
Message-Id: <1456334780-17380-1-git-send-email-javier@osg.samsung.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The driver uses the MODULE_ALIAS() macro to export a platform module alias
to allow the module to be autoloaded if the device is registered using the
legacy platform registration mechanism but the driver is always used by OF
only machines so the alias is not needed and should just be removed.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---
Hello,

This patch supersedes "rtc: mt6397: Add platform device ID table":
https://lkml.org/lkml/2016/2/9/192.

Best regards,
Javier

 drivers/rtc/rtc-mt6397.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index 06a5c52b292f..44f622c3e048 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -419,4 +419,3 @@ module_platform_driver(mtk_rtc_driver);
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Tianping Fang <tianping.fang@mediatek.com>");
 MODULE_DESCRIPTION("RTC Driver for MediaTek MT6397 PMIC");
-MODULE_ALIAS("platform:mt6397-rtc");
-- 
2.5.0

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
