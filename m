Return-Path: <rtc-linux+bncBD7YLCN32UNBBTGTW2ZAKGQENOGNLGI@googlegroups.com>
MIME-Version: 1.0
Received: from mail-wm0-x236.google.com (mail-wm0-x236.google.com. [2a00:1450:400c:c09::236])
        by gmr-mx.google.com with ESMTPS id r194si121585wmb.0.2015.11.19.02.51.56
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2015 02:51:56 -0800 (PST)
Received: by mail-wm0-x236.google.com with SMTP id v187so17524367wmv.1
        for <rtc-linux@googlegroups.com>; Thu, 19 Nov 2015 02:51:56 -0800 (PST)
From: LABBE Corentin <clabbe.montjoie@gmail.com>
To: alexandre.belloni@free-electrons.com,
	a.zummo@towertech.it,
	linux-arm-kernel@lists.infradead.org,
	maxime.ripard@free-electrons.com,
	wens@csie.org
Cc: LABBE Corentin <clabbe.montjoie@gmail.com>,
	linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 2/3] rtc: sunxi: constify the data_year_param structure
Date: Thu, 19 Nov 2015 11:50:09 +0100
Message-Id: <1447930210-27008-2-git-send-email-clabbe.montjoie@gmail.com>
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

The data_year_param struct is never modified, so lets constify it.
This permit to remove cast since of_device_id is const also.

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 drivers/rtc/rtc-sunxi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-sunxi.c b/drivers/rtc/rtc-sunxi.c
index b4f35ac..0c08a5b 100644
--- a/drivers/rtc/rtc-sunxi.c
+++ b/drivers/rtc/rtc-sunxi.c
@@ -133,7 +133,7 @@ struct sunxi_rtc_data_year {
 	unsigned char leap_shift;	/* bit shift to get the leap year */
 };
 
-static struct sunxi_rtc_data_year data_year_param[] = {
+static const struct sunxi_rtc_data_year data_year_param[] = {
 	[0] = {
 		.min		= 2010,
 		.max		= 2073,
@@ -151,7 +151,7 @@ static struct sunxi_rtc_data_year data_year_param[] = {
 struct sunxi_rtc_dev {
 	struct rtc_device *rtc;
 	struct device *dev;
-	struct sunxi_rtc_data_year *data_year;
+	const struct sunxi_rtc_data_year *data_year;
 	void __iomem *base;
 	int irq;
 };
@@ -468,7 +468,7 @@ static int sunxi_rtc_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Unable to setup RTC data\n");
 		return -ENODEV;
 	}
-	chip->data_year = (struct sunxi_rtc_data_year *) of_id->data;
+	chip->data_year = of_id->data;
 
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
