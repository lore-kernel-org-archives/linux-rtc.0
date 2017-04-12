Return-Path: <rtc-linux+bncBDIZTUWNWICRBR6MW7DQKGQENUDNOJI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from aserp1040.oracle.com (aserp1040.oracle.com. [141.146.126.69])
        by gmr-mx.google.com with ESMTPS id y2si594908itc.0.2017.04.12.01.33.11
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Apr 2017 01:33:11 -0700 (PDT)
Date: Wed, 12 Apr 2017 11:32:53 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        rtc-linux@googlegroups.com, kernel-janitors@vger.kernel.org
Subject: [rtc-linux] [PATCH] rtc: hid-sensor-time: remove some dead code
Message-ID: <20170412083253.GB3250@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

devm_rtc_device_register() doesn't ever return NULL so there is no need
to check.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/rtc/rtc-hid-sensor-time.c b/drivers/rtc/rtc-hid-sensor-time.c
index c398f74234c6..2751dba850c6 100644
--- a/drivers/rtc/rtc-hid-sensor-time.c
+++ b/drivers/rtc/rtc-hid-sensor-time.c
@@ -291,9 +291,9 @@ static int hid_time_probe(struct platform_device *pdev)
 					"hid-sensor-time", &hid_time_rtc_ops,
 					THIS_MODULE);
 
-	if (IS_ERR_OR_NULL(time_state->rtc)) {
+	if (IS_ERR(time_state->rtc)) {
 		hid_device_io_stop(hsdev->hdev);
-		ret = time_state->rtc ? PTR_ERR(time_state->rtc) : -ENODEV;
+		ret = PTR_ERR(time_state->rtc);
 		time_state->rtc = NULL;
 		dev_err(&pdev->dev, "rtc device register failed!\n");
 		goto err_rtc;

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
