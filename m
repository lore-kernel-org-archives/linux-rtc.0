Return-Path: <rtc-linux+bncBAABB6MF6HDQKGQEXYTX4RI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from m50-132.163.com (m50-132.163.com. [123.125.50.132])
        by gmr-mx.google.com with ESMTP id c195si1471064pfc.0.2017.04.22.23.00.24
        for <rtc-linux@googlegroups.com>;
        Sat, 22 Apr 2017 23:00:25 -0700 (PDT)
From: Pan Bian <bianpan2016@163.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Pan Bian <bianpan2016@163.com>
Subject: [rtc-linux] [PATCH 1/1] rtc: snvs: fix an incorrect check of return value
Date: Sun, 23 Apr 2017 13:43:24 +0800
Message-Id: <1492926204-9535-1-git-send-email-bianpan2016@163.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Function devm_regmap_init_mmio() returns an ERR_PTR on error. However,
in function snvs_rtc_probe() its return value is checked against NULL.
This patch fixes it by checking the return value with IS_ERR().

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/rtc/rtc-snvs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
index d51b07d..d8ef9e0 100644
--- a/drivers/rtc/rtc-snvs.c
+++ b/drivers/rtc/rtc-snvs.c
@@ -258,7 +258,7 @@ static int snvs_rtc_probe(struct platform_device *pdev)
 		of_property_read_u32(pdev->dev.of_node, "offset", &data->offset);
 	}
 
-	if (!data->regmap) {
+	if (IS_ERR(data->regmap)) {
 		dev_err(&pdev->dev, "Can't find snvs syscon\n");
 		return -ENODEV;
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
