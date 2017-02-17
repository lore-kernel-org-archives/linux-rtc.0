Return-Path: <rtc-linux+bncBCVK5RWD2QBRBJFLTHCQKGQEDFBYO4I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from anchovy.45ru.net.au (anchovy2.45ru.net.au. [203.30.46.146])
        by gmr-mx.google.com with ESMTPS id u12si456384pfd.3.2017.02.16.17.45.06
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 17:45:07 -0800 (PST)
From: Phil Reid <preid@electromag.com.au>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
  akinobu.mita@gmail.com, preid@electromag.com.au, rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 3/3] rtc: ds3232: Call device_init_wakeup before device_register
Date: Fri, 17 Feb 2017 09:44:58 +0800
Message-Id: <1487295898-90177-4-git-send-email-preid@electromag.com.au>
In-Reply-To: <1487295898-90177-1-git-send-email-preid@electromag.com.au>
References: <1487295898-90177-1-git-send-email-preid@electromag.com.au>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The wakealarm attribute is currently not exposed in the sysfs interface
as the device has not been set as doing wakealarm when device_register
is called. Changing the order of the calls fixes that problem. Interrupts
are cleared in check_rtc_status prior to requesting the interrupt.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/rtc/rtc-ds3232.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
index 60de3a0..ce943d0 100644
--- a/drivers/rtc/rtc-ds3232.c
+++ b/drivers/rtc/rtc-ds3232.c
@@ -363,11 +363,6 @@ static int ds3232_probe(struct device *dev, struct regmap *regmap, int irq,
 	if (ret)
 		return ret;
 
-	ds3232->rtc = devm_rtc_device_register(dev, name, &ds3232_rtc_ops,
-						THIS_MODULE);
-	if (IS_ERR(ds3232->rtc))
-		return PTR_ERR(ds3232->rtc);
-
 	if (ds3232->irq > 0) {
 		ret = devm_request_threaded_irq(dev, ds3232->irq, NULL,
 						ds3232_irq,
@@ -380,6 +375,11 @@ static int ds3232_probe(struct device *dev, struct regmap *regmap, int irq,
 			device_init_wakeup(dev, 1);
 	}
 
+	ds3232->rtc = devm_rtc_device_register(dev, name, &ds3232_rtc_ops,
+		THIS_MODULE);
+	if (IS_ERR(ds3232->rtc))
+		return PTR_ERR(ds3232->rtc);
+
 	return 0;
 }
 
-- 
1.8.3.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
