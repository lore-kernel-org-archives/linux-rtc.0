Return-Path: <rtc-linux+bncBDU5DXUG4MFRBY7H464QKGQEDJRJJMI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from youngberry.canonical.com (youngberry.canonical.com. [91.189.89.112])
        by gmr-mx.google.com with ESMTPS id e78si541009wmc.3.2016.05.16.09.22.59
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 16 May 2016 09:22:59 -0700 (PDT)
From: Colin King <colin.king@canonical.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Cc: linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH] rtc: interface: ignore exprired timers one
 enqueing new timers
Date: Mon, 16 May 2016 17:22:54 +0100
Message-Id: <1463415774-28014-1-git-send-email-colin.king@canonical.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

From: Colin Ian King <colin.king@canonical.com>

This patch fixes a RTC wakealarm issue, namely, the event fires during
hibernate and is not cleared from the list, causing hwclock to block.

The current enqueuing does not trigger an alarm if any expired timers
already exist on the timerqueue. This can occur when a RTC wake alarm
is used to wake a machine out of hibernate and the resumed state has
old expired timers that have not been removed from the timer queue.
This fix skips over any expired timers and triggers an alarm if there
are no pending timers on the timerqueue. Note that the skipped expired
timer will get repead later on, so there is no need to clean it up
immediately.

The issue can be reproduced by putting a machine into hibernate and
waking it with the RTC wakealarm.  Running the example RTC test program
from tools/testing/selftests/timers/rtctest.c after the hibernate will
block indefinitely.  With the fix, it no longer blocks after the
hibernate resume.

BugLink: http://bugs.launchpad.net/bugs/1333569

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/rtc/interface.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 9ef5f6f..7fa910f 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -748,9 +748,23 @@ EXPORT_SYMBOL_GPL(rtc_irq_set_freq);
  */
 static int rtc_timer_enqueue(struct rtc_device *rtc, struct rtc_timer *timer)
 {
+	struct timerqueue_node *next = timerqueue_getnext(&rtc->timerqueue);
+	struct rtc_time tm;
+	ktime_t now;
+
 	timer->enabled = 1;
+	__rtc_read_time(rtc, &tm);
+	now = rtc_tm_to_ktime(tm);
+
+	/* Skip over expired timers */
+	while (next) {
+		if (next->expires.tv64 >= now.tv64)
+			break;
+		next = timerqueue_iterate_next(next);
+	}
+
 	timerqueue_add(&rtc->timerqueue, &timer->node);
-	if (&timer->node == timerqueue_getnext(&rtc->timerqueue)) {
+	if (!next) {
 		struct rtc_wkalrm alarm;
 		int err;
 		alarm.time = rtc_ktime_to_tm(timer->node.expires);
-- 
2.7.4

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
