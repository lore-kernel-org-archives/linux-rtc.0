Return-Path: <rtc-linux+bncBD76TE7NVICBB7PS4TEQKGQEX4SS2GY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com. [2607:f8b0:400e:c00::241])
        by gmr-mx.google.com with ESMTPS id f74si584735pff.11.2017.06.08.04.48.12
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jun 2017 04:48:12 -0700 (PDT)
Received: by mail-pf0-x241.google.com with SMTP id u1so4846893pfg.1
        for <rtc-linux@googlegroups.com>; Thu, 08 Jun 2017 04:48:12 -0700 (PDT)
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH] rtc: omap: Handle return value of clk_prepare_enable.
Date: Thu,  8 Jun 2017 17:17:49 +0530
Message-Id: <7bfcac1de9426c3e512a61922bca4239f8b520b5.1496922334.git.arvind.yadav.cs@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

- clk_prepare_enable() can fail here and we must check its return value.
- Add missing clk_disable_unprepare(), if omap_rtc_probe is not successful.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/rtc/rtc-omap.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 13f7cd1..83b876d 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -705,13 +705,19 @@ static int omap_rtc_probe(struct platform_device *pdev)
 	else
 		rtc->clk = devm_clk_get(&pdev->dev, "int-clk");
 
-	if (!IS_ERR(rtc->clk))
-		clk_prepare_enable(rtc->clk);
+	if (IS_ERR(rtc->clk))
+		return PTR_ERR(rtc->clk);
+
+	ret = clk_prepare_enable(rtc->clk);
+	if (ret)
+		return ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	rtc->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(rtc->base))
-		return PTR_ERR(rtc->base);
+	if (IS_ERR(rtc->base)) {
+		ret = PTR_ERR(rtc->base);
+		goto err_clk;
+	}
 
 	platform_set_drvdata(pdev, rtc);
 
@@ -830,7 +836,8 @@ static int omap_rtc_probe(struct platform_device *pdev)
 	rtc->pctldev = pinctrl_register(&rtc_pinctrl_desc, &pdev->dev, rtc);
 	if (IS_ERR(rtc->pctldev)) {
 		dev_err(&pdev->dev, "Couldn't register pinctrl driver\n");
-		return PTR_ERR(rtc->pctldev);
+		ret = PTR_ERR(rtc->pctldev);
+		goto err;
 	}
 
 	return 0;
@@ -841,6 +848,8 @@ static int omap_rtc_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
+err_clk:
+	clk_disable_unprepare(rtc->clk);
 	return ret;
 }
 
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
