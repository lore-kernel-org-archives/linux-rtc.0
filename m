Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:43460 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbdI2KW1 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 29 Sep 2017 06:22:27 -0400
In-Reply-To: <20170929102116.GX20805@n2100.armlinux.org.uk>
References: <20170929102116.GX20805@n2100.armlinux.org.uk>
From: Russell King <rmk+kernel@armlinux.org.uk>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: [PATCH v2 3/4] rtc: pl031: avoid exposing alarm if no interrupt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1dxsQs-0006Nm-Lz@rmk-PC.armlinux.org.uk>
Date: Fri, 29 Sep 2017 11:22:10 +0100
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

If the RTC has no interrupt, there is little point in exposing the RTC
alarm capabilities, as it can't be used as a wakeup source nor can it
deliver an event to userspace.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/rtc/rtc-pl031.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-pl031.c b/drivers/rtc/rtc-pl031.c
index 777da06d53ee..64c77ec1b4ea 100644
--- a/drivers/rtc/rtc-pl031.c
+++ b/drivers/rtc/rtc-pl031.c
@@ -320,7 +320,7 @@ static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
 	int ret;
 	struct pl031_local *ldata;
 	struct pl031_vendor_data *vendor = id->data;
-	struct rtc_class_ops *ops = &vendor->ops;
+	struct rtc_class_ops *ops;
 	unsigned long time, data;
 
 	ret = amba_request_regions(adev, NULL);
@@ -329,12 +329,14 @@ static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
 
 	ldata = devm_kzalloc(&adev->dev, sizeof(struct pl031_local),
 			     GFP_KERNEL);
-	if (!ldata) {
+	ops = devm_kmemdup(&adev->dev, &vendor->ops, sizeof(vendor->ops),
+			   GFP_KERNEL);
+	if (!ldata || !ops) {
 		ret = -ENOMEM;
 		goto out;
 	}
-	ldata->vendor = vendor;
 
+	ldata->vendor = vendor;
 	ldata->base = devm_ioremap(&adev->dev, adev->res.start,
 				   resource_size(&adev->res));
 	if (!ldata->base) {
@@ -372,6 +374,13 @@ static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
 		}
 	}
 
+	if (!adev->irq[0]) {
+		/* When there's no interrupt, no point in exposing the alarm */
+		ops->read_alarm = NULL;
+		ops->set_alarm = NULL;
+		ops->alarm_irq_enable = NULL;
+	}
+
 	device_init_wakeup(&adev->dev, true);
 	ldata->rtc = rtc_device_register("pl031", &adev->dev, ops,
 					THIS_MODULE);
-- 
2.7.4
