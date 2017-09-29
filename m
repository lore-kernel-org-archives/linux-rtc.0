Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:43472 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbdI2KWb (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 29 Sep 2017 06:22:31 -0400
In-Reply-To: <20170929102116.GX20805@n2100.armlinux.org.uk>
References: <20170929102116.GX20805@n2100.armlinux.org.uk>
From: Russell King <rmk+kernel@armlinux.org.uk>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: [PATCH v2 4/4] rtc: pl031: make interrupt optional
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1dxsQx-0006Nw-RL@rmk-PC.armlinux.org.uk>
Date: Fri, 29 Sep 2017 11:22:15 +0100
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On some platforms, the interrupt for the PL031 is optional.  Avoid
trying to claim the interrupt if it's not specified.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/rtc/rtc-pl031.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-pl031.c b/drivers/rtc/rtc-pl031.c
index 64c77ec1b4ea..82eb7da2c478 100644
--- a/drivers/rtc/rtc-pl031.c
+++ b/drivers/rtc/rtc-pl031.c
@@ -308,7 +308,8 @@ static int pl031_remove(struct amba_device *adev)
 
 	dev_pm_clear_wake_irq(&adev->dev);
 	device_init_wakeup(&adev->dev, false);
-	free_irq(adev->irq[0], ldata);
+	if (adev->irq[0])
+		free_irq(adev->irq[0], ldata);
 	rtc_device_unregister(ldata->rtc);
 	amba_release_regions(adev);
 
@@ -389,12 +390,13 @@ static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
 		goto out;
 	}
 
-	if (request_irq(adev->irq[0], pl031_interrupt,
-			vendor->irqflags, "rtc-pl031", ldata)) {
-		ret = -EIO;
-		goto out_no_irq;
+	if (adev->irq[0]) {
+		ret = request_irq(adev->irq[0], pl031_interrupt,
+				  vendor->irqflags, "rtc-pl031", ldata);
+		if (ret)
+			goto out_no_irq;
+		dev_pm_set_wake_irq(&adev->dev, adev->irq[0]);
 	}
-	dev_pm_set_wake_irq(&adev->dev, adev->irq[0]);
 	return 0;
 
 out_no_irq:
-- 
2.7.4
