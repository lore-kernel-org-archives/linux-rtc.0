Return-Path: <rtc-linux+bncBD35ZY754EARBXURW27AKGQE6CURIMI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com. [2607:f8b0:400e:c00::242])
        by gmr-mx.google.com with ESMTPS id 142si993519pfx.2.2016.09.05.08.01.49
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Sep 2016 08:01:49 -0700 (PDT)
Received: by mail-pf0-x242.google.com with SMTP id h186so9904898pfg.2
        for <rtc-linux@googlegroups.com>; Mon, 05 Sep 2016 08:01:49 -0700 (PDT)
From: Axel Lin <axel.lin@ingics.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Oleksij Rempel <linux@rempel-privat.de>,
	rtc-linux@googlegroups.com,
	Axel Lin <axel.lin@ingics.com>
Subject: [rtc-linux] [PATCH] rtc: asm9260: Fix missing spin_lock_init for priv->lock
Date: Mon,  5 Sep 2016 23:01:11 +0800
Message-Id: <1473087671-8866-1-git-send-email-axel.lin@ingics.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/rtc/rtc-asm9260.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-asm9260.c b/drivers/rtc/rtc-asm9260.c
index 5219916..72a036f 100644
--- a/drivers/rtc/rtc-asm9260.c
+++ b/drivers/rtc/rtc-asm9260.c
@@ -269,6 +269,7 @@ static int asm9260_rtc_probe(struct platform_device *pdev)
 
 	priv->dev = &pdev->dev;
 	platform_set_drvdata(pdev, priv);
+	spin_lock_init(&priv->lock);
 
 	irq_alarm = platform_get_irq(pdev, 0);
 	if (irq_alarm < 0) {
-- 
2.7.4

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
