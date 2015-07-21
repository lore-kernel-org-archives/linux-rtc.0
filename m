Return-Path: <rtc-linux+bncBAABBCXBW6WQKGQEP3SD36Q@googlegroups.com>
Received: from mail.ginzinger.com (mail.ginzinger.com. [31.193.165.229])
        by gmr-mx.google.com with ESMTP id gt9si493263wib.2.2015.07.21.00.11.04
        for <rtc-linux@googlegroups.com>;
        Tue, 21 Jul 2015 00:11:04 -0700 (PDT)
From: Roosen Henri <Henri.Roosen@ginzinger.com>
To: "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	"alexandre.belloni@free-electrons.com"
	<alexandre.belloni@free-electrons.com>, "a.zummo@towertech.it"
	<a.zummo@towertech.it>
Subject: [rtc-linux] [PATCH] rtc: rtc-rx8025: remove obsolete
 local_irq_disable() and  local_irq_enable() for rtc_update_irq()
Date: Tue, 21 Jul 2015 07:11:02 +0000
Message-ID: <FC629F1A536C6F42B960B5E32E20BD35922297@exc2.buero.ginzinger.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

>From b68f4bd992a6bf538edb860662be3178394f8bf5 Mon Sep 17 00:00:00 2001
From: Henri Roosen <henri.roosen@ginzinger.com>
Date: Thu, 16 Jul 2015 10:16:41 +0200
Subject: [PATCH] rtc: rtc-rx8025: remove obsolete local_irq_disable() and
 local_irq_enable() for rtc_update_irq()

Since commit e6229bec25be4ba00f31dd26e25721cc96c22262 rtc_update_irq()
is callable with irqs enabled.

Signed-off-by: Henri Roosen <henri.roosen@ginzinger.com>
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
-               local_irq_disable();
                rtc_update_irq(rx8025->rtc, 1, RTC_PF | RTC_IRQF);
-               local_irq_enable();
        }

        if (status & RX8025_BIT_CTRL2_DAFG) {
@@ -172,9 +170,7 @@ static void rx8025_work(struct work_struct *work)
                if (rx8025_write_reg(client, RX8025_REG_CTRL1,
                                     rx8025->ctrl1 & ~RX8025_BIT_CTRL1_DALE))
                        goto out;
-               local_irq_disable();
                rtc_update_irq(rx8025->rtc, 1, RTC_AF | RTC_IRQF);
-               local_irq_enable();
        }

        /* acknowledge IRQ */
--
2.1.4

________________________________

Ginzinger electronic systems GmbH
Gewerbegebiet Pirath 16
4952 Weng im Innkreis
www.ginzinger.com

Firmenbuchnummer: FN 364958d
Firmenbuchgericht: Ried im Innkreis
UID-Nr.: ATU66521089

________________________________
*** BETRIEBSURLAUB VON MONTAG, DEN 27. JULI 2015 BIS FREITAG, DEN 7. AUGUST 2015 ***
*** COMPANY HOLIDAY FROM MONDAY, THE 27 JULY 2015 TO FRIDAY, 7 AUGUST 2015 ***

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
