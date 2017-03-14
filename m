Return-Path: <rtc-linux+bncBDIZTUWNWICRBQ6ET3DAKGQEO7H5J7A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from aserp1040.oracle.com (aserp1040.oracle.com. [141.146.126.69])
        by gmr-mx.google.com with ESMTPS id 2si3430987pfz.1.2017.03.14.00.56.51
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Mar 2017 00:56:51 -0700 (PDT)
Date: Tue, 14 Mar 2017 10:56:30 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Sebastian Reichel <sre@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        rtc-linux@googlegroups.com, kernel-janitors@vger.kernel.org
Subject: [rtc-linux] [PATCH] rtc: cpcap: kfreeing devm allocated memory
Message-ID: <20170314075319.GB6111@mwanda>
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

We shouldn't kfree(rtc) because is devm_ managed memory.  It leads to a
double free.

Fixes: dd3bf50b35e3 ("rtc: cpcap: new rtc driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/rtc/rtc-cpcap.c b/drivers/rtc/rtc-cpcap.c
index 7c6a3c3167bd..5d163be98e9f 100644
--- a/drivers/rtc/rtc-cpcap.c
+++ b/drivers/rtc/rtc-cpcap.c
@@ -266,10 +266,8 @@ static int cpcap_rtc_probe(struct platform_device *pdev)
 	rtc->rtc_dev = devm_rtc_device_register(dev, "cpcap_rtc",
 						&cpcap_rtc_ops, THIS_MODULE);
 
-	if (IS_ERR(rtc->rtc_dev)) {
-		kfree(rtc);
+	if (IS_ERR(rtc->rtc_dev))
 		return PTR_ERR(rtc->rtc_dev);
-	}
 
 	err = cpcap_get_vendor(dev, rtc->regmap, &rtc->vendor);
 	if (err)

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
