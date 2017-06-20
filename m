Return-Path: <rtc-linux+bncBDKNBMNKRMJRBG62UPFAKGQELGY3O6A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-wm0-x22f.google.com (mail-wm0-x22f.google.com. [2a00:1450:400c:c09::22f])
        by gmr-mx.google.com with ESMTPS id w193si3483598wmf.3.2017.06.20.02.38.35
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 02:38:35 -0700 (PDT)
Received: by mail-wm0-x22f.google.com with SMTP id d73so14472917wma.0
        for <rtc-linux@googlegroups.com>; Tue, 20 Jun 2017 02:38:35 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: benjamin.gaignard@linaro.org
Cc: linaro-kernel@lists.linaro.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH 46/51] rtc: test: stop using rtc deprecated functions
Date: Tue, 20 Jun 2017 11:35:54 +0200
Message-Id: <1497951359-13334-47-git-send-email-benjamin.gaignard@linaro.org>
In-Reply-To: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1497951359-13334-1-git-send-email-benjamin.gaignard@linaro.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

rtc_time_to_tm() and rtc_tm_to_time() are deprecated because they
rely on 32bits variables and that will make rtc break in y2038/2016.
Stop using those two functions to safer 64bits ones.

For the same reasons use set_mmss64 callback instead of set_mmss
Since only set_mmss64 be will used remove module parameter.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
CC: Alessandro Zummo <a.zummo@towertech.it>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: rtc-linux@googlegroups.com
CC: linux-kernel@vger.kernel.org
---
 drivers/rtc/rtc-test.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/rtc/rtc-test.c b/drivers/rtc/rtc-test.c
index 3a2da4c..6a460e3 100644
--- a/drivers/rtc/rtc-test.c
+++ b/drivers/rtc/rtc-test.c
@@ -13,10 +13,6 @@
 #include <linux/rtc.h>
 #include <linux/platform_device.h>
 
-static int test_mmss64;
-module_param(test_mmss64, int, 0644);
-MODULE_PARM_DESC(test_mmss64, "Test struct rtc_class_ops.set_mmss64().");
-
 static struct platform_device *test0 = NULL, *test1 = NULL;
 
 static int test_rtc_read_alarm(struct device *dev,
@@ -44,12 +40,6 @@ static int test_rtc_set_mmss64(struct device *dev, time64_t secs)
 	return 0;
 }
 
-static int test_rtc_set_mmss(struct device *dev, unsigned long secs)
-{
-	dev_info(dev, "%s, secs = %lu\n", __func__, secs);
-	return 0;
-}
-
 static int test_rtc_proc(struct device *dev, struct seq_file *seq)
 {
 	struct platform_device *plat_dev = to_platform_device(dev);
@@ -70,7 +60,7 @@ static int test_rtc_alarm_irq_enable(struct device *dev, unsigned int enable)
 	.read_time = test_rtc_read_time,
 	.read_alarm = test_rtc_read_alarm,
 	.set_alarm = test_rtc_set_alarm,
-	.set_mmss = test_rtc_set_mmss,
+	.set_mmss64 = test_rtc_set_mmss64,
 	.alarm_irq_enable = test_rtc_alarm_irq_enable,
 };
 
@@ -111,11 +101,6 @@ static int test_probe(struct platform_device *plat_dev)
 	int err;
 	struct rtc_device *rtc;
 
-	if (test_mmss64) {
-		test_rtc_ops.set_mmss64 = test_rtc_set_mmss64;
-		test_rtc_ops.set_mmss = NULL;
-	}
-
 	rtc = devm_rtc_device_register(&plat_dev->dev, "test",
 				&test_rtc_ops, THIS_MODULE);
 	if (IS_ERR(rtc)) {
-- 
1.9.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
