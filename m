Return-Path: <rtc-linux+bncBCRKFI7J2AJRBBOMUHCAKGQEZBO3OVQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com. [119.145.14.65])
        by gmr-mx.google.com with ESMTPS id a17si1754229itd.1.2017.01.25.00.47.00
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 25 Jan 2017 00:47:01 -0800 (PST)
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
Subject: [rtc-linux] [PATCH 2/4] rtc: st-lpc: using devm_rtc_device_register helper
Date: Wed, 25 Jan 2017 16:41:55 +0800
Message-ID: <1485333717-47536-2-git-send-email-wangkefeng.wang@huawei.com>
In-Reply-To: <1485333717-47536-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1485333717-47536-1-git-send-email-wangkefeng.wang@huawei.com>
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

Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/rtc/rtc-st-lpc.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/rtc/rtc-st-lpc.c b/drivers/rtc/rtc-st-lpc.c
index 74c0a33..4f81124 100644
--- a/drivers/rtc/rtc-st-lpc.c
+++ b/drivers/rtc/rtc-st-lpc.c
@@ -272,8 +272,8 @@ static int st_rtc_probe(struct platform_device *pdev)
 		st_rtc_set_time(&pdev->dev, &tm_check);
 	}
 
-	rtc->rtc_dev = rtc_device_register("st-lpc-rtc", &pdev->dev,
-					   &st_rtc_ops, THIS_MODULE);
+	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, "st-lpc-rtc",
+						&st_rtc_ops, THIS_MODULE);
 	if (IS_ERR(rtc->rtc_dev)) {
 		clk_disable_unprepare(rtc->clk);
 		return PTR_ERR(rtc->rtc_dev);
@@ -282,16 +282,6 @@ static int st_rtc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int st_rtc_remove(struct platform_device *pdev)
-{
-	struct st_rtc *rtc = platform_get_drvdata(pdev);
-
-	if (likely(rtc->rtc_dev))
-		rtc_device_unregister(rtc->rtc_dev);
-
-	return 0;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int st_rtc_suspend(struct device *dev)
 {
@@ -344,7 +334,6 @@ static int st_rtc_resume(struct device *dev)
 		.of_match_table = st_rtc_match,
 	},
 	.probe = st_rtc_probe,
-	.remove = st_rtc_remove,
 };
 
 module_platform_driver(st_rtc_platform_driver);
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
