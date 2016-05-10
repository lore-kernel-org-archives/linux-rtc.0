Return-Path: <rtc-linux+bncBDP5VQPV4IBRB2POY24QKGQEFDQ4HSQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x22f.google.com (mail-wm0-x22f.google.com. [2a00:1450:400c:c09::22f])
        by gmr-mx.google.com with ESMTPS id k143si56830wmg.1.2016.05.10.03.26.48
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 May 2016 03:26:48 -0700 (PDT)
Received: by mail-wm0-x22f.google.com with SMTP id a17so19032683wme.0
        for <rtc-linux@googlegroups.com>; Tue, 10 May 2016 03:26:48 -0700 (PDT)
From: Nicolas Chauvet <kwizart@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Cc: linux-omap@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	Nicolas Chauvet <kwizart@gmail.com>
Subject: [rtc-linux] [PATCH] rtc: rename so the tps6586x-rtc module can be
 autoloaded at boot
Date: Tue, 10 May 2016 12:26:42 +0200
Message-Id: <1462876002-6462-1-git-send-email-kwizart@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This module is loaded by the related mfd driver which has
the needed MODULE_DEVICE_TABLE(i2c,...).

This patch fix the modalias when the rtc driver is built
as a module, so the right name is used.
Everything operates correctly when this module is builtin.

Signed-off-by: Nicolas Chauvet <kwizart@gmail.com>
---
 drivers/rtc/rtc-tps6586x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-tps6586x.c b/drivers/rtc/rtc-tps6586x.c
index e404faa..a3418a8 100644
--- a/drivers/rtc/rtc-tps6586x.c
+++ b/drivers/rtc/rtc-tps6586x.c
@@ -344,7 +344,7 @@ static struct platform_driver tps6586x_rtc_driver = {
 };
 module_platform_driver(tps6586x_rtc_driver);
 
-MODULE_ALIAS("platform:rtc-tps6586x");
+MODULE_ALIAS("platform:tps6586x-rtc");
 MODULE_DESCRIPTION("TI TPS6586x RTC driver");
 MODULE_AUTHOR("Laxman dewangan <ldewangan@nvidia.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.4.11

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
