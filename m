Return-Path: <rtc-linux+bncBDEYND6N5UDBBVPX26ZAKGQE6DPDA6A@googlegroups.com>
MIME-Version: 1.0
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com. [2607:f8b0:400e:c03::233])
        by gmr-mx.google.com with ESMTPS id fg10si2295646pad.0.2015.11.25.10.20.05
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Nov 2015 10:20:05 -0800 (PST)
Received: by mail-pa0-x233.google.com with SMTP id hx2so64495034pad.1
        for <rtc-linux@googlegroups.com>; Wed, 25 Nov 2015 10:20:05 -0800 (PST)
From: Saurabh Sengar <saurabh.truth@gmail.com>
To: a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Cc: Saurabh Sengar <saurabh.truth@gmail.com>
Subject: [rtc-linux] [PATCH] drivers/rtc/rtc-tps65910.c: Add IRQF_ONESHOT to
 interrupt flags
Date: Wed, 25 Nov 2015 23:49:57 +0530
Message-Id: <1448475597-11228-1-git-send-email-saurabh.truth@gmail.com>
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

If no primary handler is specified for threaded_irq then a
default one is assigned which always returns IRQ_WAKE_THREAD.
This handler requires the IRQF_ONESHOT, because the source of
interrupt is not disabled

Signed-off-by: Saurabh Sengar <saurabh.truth@gmail.com>
---
 drivers/rtc/rtc-tps65910.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-tps65910.c b/drivers/rtc/rtc-tps65910.c
index f42aa2b..9afafde 100644
--- a/drivers/rtc/rtc-tps65910.c
+++ b/drivers/rtc/rtc-tps65910.c
@@ -268,7 +268,8 @@ static int tps65910_rtc_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
-		tps65910_rtc_interrupt, IRQF_TRIGGER_LOW | IRQF_EARLY_RESUME,
+		tps65910_rtc_interrupt,
+		IRQF_TRIGGER_LOW | IRQF_EARLY_RESUME | IRQF_ONESHOT,
 		dev_name(&pdev->dev), &pdev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "IRQ is not free.\n");
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
