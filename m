Return-Path: <rtc-linux+bncBD7YLCN32UNBBTWTW2ZAKGQE47WXFKI@googlegroups.com>
MIME-Version: 1.0
Received: from mail-wm0-x231.google.com (mail-wm0-x231.google.com. [2a00:1450:400c:c09::231])
        by gmr-mx.google.com with ESMTPS id w187si72675wmw.1.2015.11.19.02.51.58
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2015 02:51:58 -0800 (PST)
Received: by mail-wm0-x231.google.com with SMTP id w144so109583055wmw.0
        for <rtc-linux@googlegroups.com>; Thu, 19 Nov 2015 02:51:58 -0800 (PST)
From: LABBE Corentin <clabbe.montjoie@gmail.com>
To: alexandre.belloni@free-electrons.com,
	a.zummo@towertech.it,
	linux-arm-kernel@lists.infradead.org,
	maxime.ripard@free-electrons.com,
	wens@csie.org
Cc: LABBE Corentin <clabbe.montjoie@gmail.com>,
	linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 3/3] rtc: sunxi: use of_device_get_match_data
Date: Thu, 19 Nov 2015 11:50:10 +0100
Message-Id: <1447930210-27008-3-git-send-email-clabbe.montjoie@gmail.com>
In-Reply-To: <1447930210-27008-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1447930210-27008-1-git-send-email-clabbe.montjoie@gmail.com>
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

The usage of of_device_get_match_data reduce the code size a bit.

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 drivers/rtc/rtc-sunxi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-sunxi.c b/drivers/rtc/rtc-sunxi.c
index 0c08a5b..abada60 100644
--- a/drivers/rtc/rtc-sunxi.c
+++ b/drivers/rtc/rtc-sunxi.c
@@ -436,7 +436,6 @@ static int sunxi_rtc_probe(struct platform_device *pdev)
 {
 	struct sunxi_rtc_dev *chip;
 	struct resource *res;
-	const struct of_device_id *of_id;
 	int ret;
 
 	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
@@ -463,12 +462,11 @@ static int sunxi_rtc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	of_id = of_match_device(sunxi_rtc_dt_ids, &pdev->dev);
-	if (!of_id) {
+	chip->data_year = of_device_get_match_data(&pdev->dev);
+	if (!chip->data_year) {
 		dev_err(&pdev->dev, "Unable to setup RTC data\n");
 		return -ENODEV;
 	}
-	chip->data_year = of_id->data;
 
 	/* clear the alarm count value */
 	writel(0, chip->base + SUNXI_ALRM_DHMS);
-- 
2.4.10

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
