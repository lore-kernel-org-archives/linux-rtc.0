Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750903AbdFPT2N (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Fri, 16 Jun 2017 15:28:13 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/6] rtc: s3c: Jump to central exit point on getting src clock error
Date: Fri, 16 Jun 2017 21:28:02 +0200
Message-Id: <20170616192807.10347-1-krzk@kernel.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

In other error paths in probe, centralized exit point was used so make
this consistent.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/rtc/rtc-s3c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index d44fb34df8fe..c5aa7a35d07f 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -510,8 +510,7 @@ static int s3c_rtc_probe(struct platform_device *pdev)
 			else
 				dev_dbg(&pdev->dev,
 					"probe deferred due to missing rtc src clk\n");
-			clk_disable_unprepare(info->rtc_clk);
-			return ret;
+			goto err_src_clk;
 		}
 		clk_prepare_enable(info->rtc_src_clk);
 	}
@@ -575,6 +574,7 @@ static int s3c_rtc_probe(struct platform_device *pdev)
 
 	if (info->data->needs_src_clk)
 		clk_disable_unprepare(info->rtc_src_clk);
+err_src_clk:
 	clk_disable_unprepare(info->rtc_clk);
 
 	return ret;
-- 
2.9.3
