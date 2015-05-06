Return-Path: <rtc-linux+bncBDD45AWIUUARBPMDU6VAKGQECYGCAGI@googlegroups.com>
Received: from mx2.suse.de (cantor2.suse.de. [195.135.220.15])
        by gmr-mx.google.com with ESMTPS id t6si34752wiz.0.2015.05.06.00.24.44
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 06 May 2015 00:24:44 -0700 (PDT)
Date: Wed, 6 May 2015 09:24:42 +0200
From: Jean Delvare <jdelvare@suse.de>
To: rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni
 <alexandre.belloni@free-electrons.com>, Iyappan Subramanian
 <isubramanian@apm.com>, Keyur Chudgar <kchudgar@apm.com>
Subject: [rtc-linux] [PATCH] rtc-xgene: Set hardware dependency
Message-ID: <20150506092442.00396962@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

The rtc-xgene driver is only useful on X-Gene SoC.
    
Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Iyappan Subramanian <isubramanian@apm.com>
Cc: Keyur Chudgar <kchudgar@apm.com>
---
 drivers/rtc/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-4.1-rc2.orig/drivers/rtc/Kconfig	2015-04-27 02:59:10.000000000 +0200
+++ linux-4.1-rc2/drivers/rtc/Kconfig	2015-05-06 09:16:08.405058425 +0200
@@ -1523,6 +1523,7 @@ config RTC_DRV_MOXART
 config RTC_DRV_XGENE
 	tristate "APM X-Gene RTC"
 	depends on HAS_IOMEM
+	depends on ARCH_XGENE || COMPILE_TEST
 	help
 	  If you say yes here you get support for the APM X-Gene SoC real time
 	  clock.


-- 
Jean Delvare
SUSE L3 Support

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
