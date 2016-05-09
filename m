Return-Path: <uwe@kleine-koenig.org>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,
	Michael Langer <michael.brainbug.langer@googlemail.com>,
	Byron Bradley <byron.bbradley@gmail.com>,
	Tim Ellis <tim@ngndg.com>
Subject: [PATCH 1/2] rtc: initialize output parameter for read alarm to "uninitialized"
Date: Mon,  9 May 2016 23:37:33 +0200
Message-Id: <1462829854-789-2-git-send-email-uwe@kleine-koenig.org>
In-Reply-To: <1462829854-789-1-git-send-email-uwe@kleine-koenig.org>
References: <1462829854-789-1-git-send-email-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>

rtc drivers are supposed to set values they don't support to -1. To
simplify this for drivers and also make it harder for them to get it
wrong initialize the values to -1.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/rtc/interface.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 9ef5f6f89f98..99475908e556 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -104,7 +104,17 @@ static int rtc_read_alarm_internal(struct rtc_device *rtc, struct rtc_wkalrm *al
 	else if (!rtc->ops->read_alarm)
 		err = -EINVAL;
 	else {
-		memset(alarm, 0, sizeof(struct rtc_wkalrm));
+		alarm->enabled = 0;
+		alarm->pending = 0;
+		alarm->time.tm_sec = -1;
+		alarm->time.tm_min = -1;
+		alarm->time.tm_hour = -1;
+		alarm->time.tm_mday = -1;
+		alarm->time.tm_mon = -1;
+		alarm->time.tm_year = -1;
+		alarm->time.tm_wday = -1;
+		alarm->time.tm_yday = -1;
+		alarm->time.tm_isdst = -1;
 		err = rtc->ops->read_alarm(rtc->dev.parent, alarm);
 	}
 
-- 
2.8.1
