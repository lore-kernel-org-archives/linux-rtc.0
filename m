Return-Path: <rtc-linux+bncBAABBJHF5WYAKGQEXZ76WYQ@googlegroups.com>
Received: from eusmtp01.atmel.com (eusmtp01.atmel.com. [212.144.249.242])
        by gmr-mx.google.com with ESMTPS id m4si420429wib.0.2015.10.12.01.43.15
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 01:43:15 -0700 (PDT)
From: Wenyou Yang <wenyou.yang@atmel.com>
To: Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni
	<alexandre.belloni@free-electrons.com>
CC: Nicolas Ferre <nicolas.ferre@atmel.com>, Ludovic Desroches
	<ludovic.desroches@atmel.com>, <rtc-linux@googlegroups.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Wenyou Yang <wenyou.yang@atmel.com>
Subject: [rtc-linux] [PATCH v2] rtc: at91rm9200: clear RTC alarm status flag
 prior to suspending
Date: Mon, 12 Oct 2015 16:39:23 +0800
Message-ID: <1444639163-14255-1-git-send-email-wenyou.yang@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

As said in the SAMA5D2 datasheet, "Prior to instructing the device
to enter ULP mode 1, ... and the internal sources of wake-up must
be cleared."

This patch is to clear the RTC alarm status flag prior to suspending
to avoid the erroneous wake-up activity, as it is often used as
the wake-up source for the ULP mode 1.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

Changes in v2:
 - Add more detail commit log.

 drivers/rtc/rtc-at91rm9200.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
index cb62e21..b60fd47 100644
--- a/drivers/rtc/rtc-at91rm9200.c
+++ b/drivers/rtc/rtc-at91rm9200.c
@@ -495,6 +495,8 @@ static int at91_rtc_suspend(struct device *dev)
 	/* this IRQ is shared with DBGU and other hardware which isn't
 	 * necessarily doing PM like we are...
 	 */
+	at91_rtc_write(AT91_RTC_SCCR, AT91_RTC_ALARM);
+
 	at91_rtc_imr = at91_rtc_read_imr()
 			& (AT91_RTC_ALARM|AT91_RTC_SECEV);
 	if (at91_rtc_imr) {
-- 
1.7.9.5

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
