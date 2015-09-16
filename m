Return-Path: <ukl@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	kernel@pengutronix.de
Subject: [PATCH] rtc: rtctest: enabling UIE for a chip that doesn't support it returns EINVAL
Date: Wed, 16 Sep 2015 09:16:51 +0200
Message-Id: <1442387811-5384-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20150916071545.GA28635@pengutronix.de>
References: <20150916071545.GA28635@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>

Calling ioctl(..., RTC_UIE_ON, ...) without CONFIG_RTC_INTF_DEV_UIE_EMUL
either ends in rtc_update_irq_enable if rtc->uie_unsupported is true
or in __rtc_set_alarm in the if (!rtc->ops->set_alarm) branch. In both
cases the return value is -EINVAL. So check for that one instead of
ENOTTY.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 tools/testing/selftests/timers/rtctest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/rtctest.c b/tools/testing/selftests/timers/rtctest.c
index d80ae852334d..624bce51b27d 100644
--- a/tools/testing/selftests/timers/rtctest.c
+++ b/tools/testing/selftests/timers/rtctest.c
@@ -61,7 +61,7 @@ int main(int argc, char **argv)
 	/* Turn on update interrupts (one per second) */
 	retval = ioctl(fd, RTC_UIE_ON, 0);
 	if (retval == -1) {
-		if (errno == ENOTTY) {
+		if (errno == EINVAL) {
 			fprintf(stderr,
 				"\n...Update IRQs not supported.\n");
 			goto test_READ;
-- 
2.5.0
