Return-Path: <rtc-linux+bncBCRKFI7J2AJRBAWMUHCAKGQE3JKIIAI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com. [119.145.14.65])
        by gmr-mx.google.com with ESMTPS id d20si1700186itc.1.2017.01.25.00.46.56
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 25 Jan 2017 00:46:58 -0800 (PST)
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Alessandro Zummo
	<a.zummo@towertech.it>,
        Alexandre Belloni
	<alexandre.belloni@free-electrons.com>,
        Patrice Chotard
	<patrice.chotard@st.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, <linux-arm-kernel@lists.infradead.org>,
        <rtc-linux@googlegroups.com>
CC: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [rtc-linux] [PATCH 1/4] rtc: gemini: using devm_rtc_device_register helper
Date: Wed, 25 Jan 2017 16:41:54 +0800
Message-ID: <1485333717-47536-1-git-send-email-wangkefeng.wang@huawei.com>
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

Using devm_rtc_device_register() helper to simplify code.

Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com> 
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/rtc/rtc-gemini.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-gemini.c b/drivers/rtc/rtc-gemini.c
index 688debc..504b6c1 100644
--- a/drivers/rtc/rtc-gemini.c
+++ b/drivers/rtc/rtc-gemini.c
@@ -145,26 +145,16 @@ static int gemini_rtc_probe(struct platform_device *pdev)
 	if (unlikely(ret))
 		return ret;
 
-	rtc->rtc_dev = rtc_device_register(pdev->name, dev,
-					   &gemini_rtc_ops, THIS_MODULE);
+	rtc->rtc_dev = devm_rtc_device_register(dev, pdev->name, &gemini_rtc_ops,
+						THIS_MODULE);
 	return PTR_ERR_OR_ZERO(rtc->rtc_dev);
 }
 
-static int gemini_rtc_remove(struct platform_device *pdev)
-{
-	struct gemini_rtc *rtc = platform_get_drvdata(pdev);
-
-	rtc_device_unregister(rtc->rtc_dev);
-
-	return 0;
-}
-
 static struct platform_driver gemini_rtc_driver = {
 	.driver		= {
 		.name	= DRV_NAME,
 	},
 	.probe		= gemini_rtc_probe,
-	.remove		= gemini_rtc_remove,
 };
 
 module_platform_driver_probe(gemini_rtc_driver, gemini_rtc_probe);
-- 
1.7.12.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
