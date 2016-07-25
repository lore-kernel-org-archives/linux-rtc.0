Return-Path: <rtc-linux+bncBCAP3QEPQIDBBP7U226AKGQEQT4SUDQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com. [2607:f8b0:400e:c00::241])
        by gmr-mx.google.com with ESMTPS id z4si3267980pam.0.2016.07.25.00.05.35
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jul 2016 00:05:35 -0700 (PDT)
Received: by mail-pf0-x241.google.com with SMTP id i6so11420863pfe.0
        for <rtc-linux@googlegroups.com>; Mon, 25 Jul 2016 00:05:35 -0700 (PDT)
From: Wei Yongjun <weiyj.lk@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH -next] rtc: asm9260: Fix missing spin_lock_init()
Date: Mon, 25 Jul 2016 07:05:29 +0000
Message-Id: <1469430329-8737-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

The driver allocates the spinlock but not initialize it.
Use spin_lock_init() on it to initialize it correctly.

This is detected by Coccinelle semantic patch.

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 drivers/rtc/rtc-asm9260.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-asm9260.c b/drivers/rtc/rtc-asm9260.c
index 355fdb9..5ddcc91 100644
--- a/drivers/rtc/rtc-asm9260.c
+++ b/drivers/rtc/rtc-asm9260.c
@@ -267,6 +267,7 @@ static int asm9260_rtc_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	spin_lock_init(&priv->lock);
 	priv->dev = &pdev->dev;
 	platform_set_drvdata(pdev, priv);
 



-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
