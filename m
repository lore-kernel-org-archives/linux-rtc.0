Return-Path: <rtc-linux+bncBAABB4FZUTDAKGQEIBETS2Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from root.phytec.de (mail.phytec.de. [217.6.246.34])
        by gmr-mx.google.com with ESMTP id e72si1682wma.0.2017.03.15.03.52.32
        for <rtc-linux@googlegroups.com>;
        Wed, 15 Mar 2017 03:52:32 -0700 (PDT)
From: Daniel Schultz <d.schultz@phytec.de>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com, rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH]  driver: rtc: tps65910: Add parameter check
Date: Wed, 15 Mar 2017 11:52:32 +0100
Message-Id: <1489575152-29931-1-git-send-email-d.schultz@phytec.de>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

If the tps65910 driver has no interrupt, the probe of tps65910-rtc will
fail.

This patch adds a check in the probe of the rtc if an interrupt exist.
The check is similar to the check in the function which creates the
interrupt.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 drivers/rtc/rtc-tps65910.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/rtc/rtc-tps65910.c b/drivers/rtc/rtc-tps65910.c
index d0244d7..8c5ca11 100644
--- a/drivers/rtc/rtc-tps65910.c
+++ b/drivers/rtc/rtc-tps65910.c
@@ -375,6 +375,11 @@ static int tps65910_rtc_probe(struct platform_device *pdev)
 
 	tps65910 = dev_get_drvdata(pdev->dev.parent);
 
+	if (!tps65910->chip_irq) {
+		dev_warn(&pdev->dev, "No interrupt support, not created\n");
+		return -EINVAL;
+	}
+
 	tps_rtc = devm_kzalloc(&pdev->dev, sizeof(struct tps65910_rtc),
 			GFP_KERNEL);
 	if (!tps_rtc)
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
