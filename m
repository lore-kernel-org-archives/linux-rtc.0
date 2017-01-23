Return-Path: <rtc-linux+bncBDSJBYGBRIMBBBV4S7CAKGQEYVQ4K4Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id h198si1077985wmg.1.2017.01.23.02.42.14
        for <rtc-linux@googlegroups.com>;
        Mon, 23 Jan 2017 02:42:14 -0800 (PST)
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Chen-Yu Tsai <wens@csie.org>
Cc: linux-arm-kernel@lists.infradead.org,
	rtc-linux@googlegroups.com,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [rtc-linux] [PATCH v2 5/7] rtc: sun6i: Switch to devm_rtc_device_register
Date: Mon, 23 Jan 2017 11:41:50 +0100
Message-Id: <fa6f39ee82429e1851597202b0706a8bd9871bc7.1485168100.git-series.maxime.ripard@free-electrons.com>
In-Reply-To: <cover.6bd4d4760c24d09845ad09c212fcd487d78da5ad.1485168100.git-series.maxime.ripard@free-electrons.com>
References: <cover.6bd4d4760c24d09845ad09c212fcd487d78da5ad.1485168100.git-series.maxime.ripard@free-electrons.com>
In-Reply-To: <cover.6bd4d4760c24d09845ad09c212fcd487d78da5ad.1485168100.git-series.maxime.ripard@free-electrons.com>
References: <cover.6bd4d4760c24d09845ad09c212fcd487d78da5ad.1485168100.git-series.maxime.ripard@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Now that we have a devm variant of rtc_device_register, switch to it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/rtc/rtc-sun6i.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index 37f65c50ab2d..613f42ade533 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -543,8 +543,8 @@ static int sun6i_rtc_probe(struct platform_device *pdev)
 
 	clk_prepare_enable(chip->losc);
 
-	chip->rtc = rtc_device_register("rtc-sun6i", &pdev->dev,
-					&sun6i_rtc_ops, THIS_MODULE);
+	chip->rtc = devm_rtc_device_register(&pdev->dev, "rtc-sun6i",
+					     &sun6i_rtc_ops, THIS_MODULE);
 	if (IS_ERR(chip->rtc)) {
 		dev_err(&pdev->dev, "unable to register device\n");
 		return PTR_ERR(chip->rtc);
@@ -555,15 +555,6 @@ static int sun6i_rtc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int sun6i_rtc_remove(struct platform_device *pdev)
-{
-	struct sun6i_rtc_dev *chip = platform_get_drvdata(pdev);
-
-	rtc_device_unregister(chip->rtc);
-
-	return 0;
-}
-
 static const struct of_device_id sun6i_rtc_dt_ids[] = {
 	{ .compatible = "allwinner,sun6i-a31-rtc" },
 	{ /* sentinel */ },
@@ -572,7 +563,6 @@ MODULE_DEVICE_TABLE(of, sun6i_rtc_dt_ids);
 
 static struct platform_driver sun6i_rtc_driver = {
 	.probe		= sun6i_rtc_probe,
-	.remove		= sun6i_rtc_remove,
 	.driver		= {
 		.name		= "sun6i-rtc",
 		.of_match_table = sun6i_rtc_dt_ids,
-- 
git-series 0.8.11

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
