Return-Path: <rtc-linux+bncBDZJ3QO3SMHBBNNLYOWQKGQEHZTWFJI@googlegroups.com>
MIME-Version: 1.0
Received: from mail-wi0-x22e.google.com (mail-wi0-x22e.google.com. [2a00:1450:400c:c05::22e])
        by gmr-mx.google.com with ESMTPS id cj6si857021wib.1.2015.07.23.04.53.25
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2015 04:53:25 -0700 (PDT)
Received: by mail-wi0-x22e.google.com with SMTP id gb10so139207719wic.1
        for <rtc-linux@googlegroups.com>; Thu, 23 Jul 2015 04:53:25 -0700 (PDT)
From: Henri Roosen <henriroosen@gmail.com>
To: rtc-linux@googlegroups.com
Cc: alexandre.belloni@free-electrons.com,
	a.zummo@towertech.it,
	Henri Roosen <henriroosen@gmail.com>
Subject: [rtc-linux] [PATCH v2] rtc: rtc-rx8025: remove obsolete
 local_irq_disable() and local_irq_enable() for rtc_update_irq()
Date: Thu, 23 Jul 2015 13:52:38 +0200
Message-Id: <1437652358-7722-1-git-send-email-henriroosen@gmail.com>
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

Since commit e6229bec25be4ba00f31dd26e25721cc96c22262 rtc_update_irq()
is callable with irqs enabled.

Signed-off-by: Henri Roosen <henriroosen@gmail.com>
---
 drivers/rtc/rtc-rx8025.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/rtc/rtc-rx8025.c b/drivers/rtc/rtc-rx8025.c
index e6298e0..9be9c37 100644
--- a/drivers/rtc/rtc-rx8025.c
+++ b/drivers/rtc/rtc-rx8025.c
@@ -161,9 +161,7 @@ static void rx8025_work(struct work_struct *work)
 	if (status & RX8025_BIT_CTRL2_CTFG) {
 		/* periodic */
 		status &= ~RX8025_BIT_CTRL2_CTFG;
-		local_irq_disable();
 		rtc_update_irq(rx8025->rtc, 1, RTC_PF | RTC_IRQF);
-		local_irq_enable();
 	}
 
 	if (status & RX8025_BIT_CTRL2_DAFG) {
@@ -172,9 +170,7 @@ static void rx8025_work(struct work_struct *work)
 		if (rx8025_write_reg(client, RX8025_REG_CTRL1,
 				     rx8025->ctrl1 & ~RX8025_BIT_CTRL1_DALE))
 			goto out;
-		local_irq_disable();
 		rtc_update_irq(rx8025->rtc, 1, RTC_AF | RTC_IRQF);
-		local_irq_enable();
 	}
 
 	/* acknowledge IRQ */
-- 
2.1.4

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
