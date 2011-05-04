Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Subject: [3/3] rtc: mxc: remove UIE signaling
From: Wolfram Sang <w.sang@pengutronix.de>
Message-Id: <1304523088-17039-4-git-send-email-w.sang@pengutronix.de>
To: rtc-linux@googlegroups.com
Cc: linux-kernel@vger.kernel.org, johnstul@us.ibm.com,
 Wolfram Sang <w.sang@pengutronix.de>
Date: Wed,  4 May 2011 17:31:28 +0200
List-ID: <rtc-linux.googlegroups.com>

The RTC core handles it since 6610e08 (RTC: Rework RTC code to use
timerqueue for events).

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/rtc/rtc-mxc.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-mxc.c b/drivers/rtc/rtc-mxc.c
index d814417..c996218 100644
--- a/drivers/rtc/rtc-mxc.c
+++ b/drivers/rtc/rtc-mxc.c
@@ -213,9 +213,6 @@ static irqreturn_t mxc_rtc_interrupt(int irq, void *dev_id)
 	if (status & RTC_ALM_BIT)
 		events |= (RTC_AF | RTC_IRQF);
 
-	if (status & RTC_1HZ_BIT)
-		events |= (RTC_UF | RTC_IRQF);
-
 	if (status & PIT_ALL_ON)
 		events |= (RTC_PF | RTC_IRQF);
 
