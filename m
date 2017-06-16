Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752452AbdFPT2Y (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Fri, 16 Jun 2017 15:28:24 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 5/6] rtc: s3c: Handle clock prepare failures in probe
Date: Fri, 16 Jun 2017 21:28:06 +0200
Message-Id: <20170616192807.10347-5-krzk@kernel.org>
In-Reply-To: <20170616192807.10347-1-krzk@kernel.org>
References: <20170616192807.10347-1-krzk@kernel.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

clk_prepare_enable() can fail so handle such case.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/rtc/rtc-s3c.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index c666b95fb8d7..0cb2f27a30b4 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -498,7 +498,9 @@ static int s3c_rtc_probe(struct platform_device *pdev)
 			dev_dbg(&pdev->dev, "probe deferred due to missing rtc clk\n");
 		return ret;
 	}
-	clk_prepare_enable(info->rtc_clk);
+	ret = clk_prepare_enable(info->rtc_clk);
+	if (ret)
+		return ret;
 
 	if (info->data->needs_src_clk) {
 		info->rtc_src_clk = devm_clk_get(&pdev->dev, "rtc_src");
@@ -512,7 +514,9 @@ static int s3c_rtc_probe(struct platform_device *pdev)
 					"probe deferred due to missing rtc src clk\n");
 			goto err_src_clk;
 		}
-		clk_prepare_enable(info->rtc_src_clk);
+		ret = clk_prepare_enable(info->rtc_src_clk);
+		if (ret)
+			goto err_src_clk;
 	}
 
 	/* check to see if everything is setup correctly */
-- 
2.9.3
