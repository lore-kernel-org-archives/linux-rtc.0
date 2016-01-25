Return-Path: <rtc-linux+bncBDEKVJM7XAHRBM4PTG2QKGQES57PPUA@googlegroups.com>
MIME-Version: 1.0
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.126.133])
        by gmr-mx.google.com with ESMTPS id c140si162183wmh.0.2016.01.25.08.05.07
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2016 08:05:07 -0800 (PST)
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Wei-Ning Huang <wnhuang@chromium.org>,
	Eddie Huang <eddie.huang@mediatek.com>,
	Tianping Fang <tianping.fang@mediatek.com>,
	Henry Chen <henryc.chen@mediatek.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH] rtc: mt6397: add IRQ domain dependency
Date: Mon, 25 Jan 2016 17:04:46 +0100
Message-Id: <1453737892-1960479-1-git-send-email-arnd@arndb.de>
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

The mt6397 RTC driver can be built either when the MFD_MT6397 driver
is enabled (which selects IRQ_DOMAIN), or when compile testing.
The latter however fails without IRQ domains:

drivers/rtc/rtc-mt6397.c: In function 'mtk_rtc_probe':
drivers/rtc/rtc-mt6397.c:326:13: error: implicit declaration of function 'irq_create_mapping' [-Werror=implicit-function-declaration]
  rtc->irq = irq_create_mapping(mt6397_chip->irq_domain, res->start);

This adds an explicit dependency for the COMPILE_TEST case.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/rtc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 376322f71fd5..4395608bf7fc 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1603,7 +1603,7 @@ config RTC_DRV_MOXART
 
 config RTC_DRV_MT6397
 	tristate "Mediatek Real Time Clock driver"
-	depends on MFD_MT6397 || COMPILE_TEST
+	depends on MFD_MT6397 || (COMPILE_TEST && IRQ_DOMAIN)
 	help
 	  This selects the Mediatek(R) RTC driver. RTC is part of Mediatek
 	  MT6397 PMIC. You should enable MT6397 PMIC MFD before select
-- 
2.7.0

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
