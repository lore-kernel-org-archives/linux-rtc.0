Return-Path: <rtc-linux+bncBDEZ72H55YIBBWNYU6XAKGQEMFJD62A@googlegroups.com>
MIME-Version: 1.0
Received: from mailout2.samsung.com (mailout2.samsung.com. [203.254.224.25])
        by gmr-mx.google.com with ESMTPS id qa1si188205pdb.1.2015.08.11.04.28.24
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 11 Aug 2015 04:28:24 -0700 (PDT)
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NSX006VV17AIN80@mailout2.samsung.com> for
 rtc-linux@googlegroups.com; Tue, 11 Aug 2015 20:28:22 +0900 (KST)
From: Joonyoung Shim <jy0922.shim@samsung.com>
To: rtc-linux@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
 cw00.choi@samsung.com, k.kozlowski@samsung.com, jy0922.shim@samsung.com
Subject: [rtc-linux] [PATCH 3/4] rtc: s3c: use unified functions for
 enable/disable of clk
Date: Tue, 11 Aug 2015 20:28:21 +0900
Message-id: <1439292502-22912-3-git-send-email-jy0922.shim@samsung.com>
In-reply-to: <1439292502-22912-1-git-send-email-jy0922.shim@samsung.com>
References: <1439292502-22912-1-git-send-email-jy0922.shim@samsung.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

The driver uses clk_prepare_enable()/clk_disable_unprepare() only in
probe only, elsewhere, use the unified functions for enable/disable of
clk, e.g. s3c_rtc_enable_clk() / s3c_rtc_disable_clk(), so it's better
to use them for consistency of code.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 drivers/rtc/rtc-s3c.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index 44b2921..abe2a6d 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -476,19 +476,21 @@ static int s3c_rtc_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to find rtc clock\n");
 		return PTR_ERR(info->rtc_clk);
 	}
-	clk_prepare_enable(info->rtc_clk);
+	clk_prepare(info->rtc_clk);
 
 	if (info->data->needs_src_clk) {
 		info->rtc_src_clk = devm_clk_get(&pdev->dev, "rtc_src");
 		if (IS_ERR(info->rtc_src_clk)) {
 			dev_err(&pdev->dev,
 				"failed to find rtc source clock\n");
-			clk_disable_unprepare(info->rtc_clk);
+			clk_unprepare(info->rtc_clk);
 			return PTR_ERR(info->rtc_src_clk);
 		}
-		clk_prepare_enable(info->rtc_src_clk);
+		clk_prepare(info->rtc_src_clk);
 	}
 
+	s3c_rtc_enable_clk(info);
+
 	/* check to see if everything is setup correctly */
 	if (info->data->enable)
 		info->data->enable(info);
@@ -548,9 +550,11 @@ static int s3c_rtc_probe(struct platform_device *pdev)
 	if (info->data->disable)
 		info->data->disable(info);
 
+	s3c_rtc_disable_clk(info);
+
 	if (info->data->needs_src_clk)
-		clk_disable_unprepare(info->rtc_src_clk);
-	clk_disable_unprepare(info->rtc_clk);
+		clk_unprepare(info->rtc_src_clk);
+	clk_unprepare(info->rtc_clk);
 
 	return ret;
 }
-- 
1.9.1

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
