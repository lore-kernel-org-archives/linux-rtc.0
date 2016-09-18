Return-Path: <rtc-linux+bncBCN63E7T2ALBBAW57C7AKGQEBTHLFVY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pf0-x22e.google.com (mail-pf0-x22e.google.com. [2607:f8b0:400e:c00::22e])
        by gmr-mx.google.com with ESMTPS id h124si5474954pfe.0.2016.09.17.23.04.50
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Sep 2016 23:04:50 -0700 (PDT)
Received: by mail-pf0-x22e.google.com with SMTP id q2so20021066pfj.3
        for <rtc-linux@googlegroups.com>; Sat, 17 Sep 2016 23:04:50 -0700 (PDT)
From: Baolin Wang <baolin.wang@linaro.org>
To: a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	rostedt@goodmis.org,
	mingo@redhat.com,
	john.stultz@linaro.org,
	tglx@linutronix.de
Cc: baolin.wang@linaro.org,
	broonie@kernel.org,
	linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] [PATCH 2/2] time: alarmtimer: Add the trcepoints for alarmtimer
Date: Sun, 18 Sep 2016 14:03:55 +0800
Message-Id: <0d5cedb2f4ad46aa7fb07b990072bacb33517102.1474177609.git.baolin.wang@linaro.org>
In-Reply-To: <8c570c152c95087faa75e397c667b6d5b8d98b3b.1474177609.git.baolin.wang@linaro.org>
References: <8c570c152c95087faa75e397c667b6d5b8d98b3b.1474177609.git.baolin.wang@linaro.org>
In-Reply-To: <8c570c152c95087faa75e397c667b6d5b8d98b3b.1474177609.git.baolin.wang@linaro.org>
References: <8c570c152c95087faa75e397c667b6d5b8d98b3b.1474177609.git.baolin.wang@linaro.org>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

For system debugging, we sometimes want to know who sets one
alarm timer, the time of the timer, when the timer started and
fired and so on. Thus adding tracepoints can help us trace the
alarmtimer information.

For example, when we debug the system supend/resume, if the
system is always resumed by RTC alarm, we can find out which
process set the alarm timer to resume system by below trace log:

......
Binder:2976_6-3473  [005] d..2  1076.587732: alarmtimer_start:
process:Binder:2976_6
alarmtimer type:ALARM_BOOTTIME expires:1234154000000 time: 1970-1-1
0:20:35

Binder:2976_7-3480  [002] d..2  1076.592707: alarmtimer_cancel:
process:Binder:2976_7
alarmtimer type:ALARM_BOOTTIME expires:1325463060000000000 time:
2012-1-2 0:11:0

Binder:2976_7-3480  [002] d..2  1076.592731: alarmtimer_start:
process:Binder:2976_7
alarmtimer type:ALARM_BOOTTIME expires:1325378040000000000 time:
2012-1-1 0:34:0

system_server-2976  [003] d..2  1076.605587: alarmtimer_cancel:
process:system_server
alarmtimer type:ALARM_BOOTTIME expires:1234154000000 time: 1970-1-1
0:20:35

system_server-2976  [003] d..2  1076.605608: alarmtimer_start:
process:system_server
alarmtimer type:ALARM_BOOTTIME expires:1234155000000 time: 1970-1-1
0:20:35

system_server-3000  [002] ...1  1087.737565: alarmtimer_suspend:
alarmtimer type:ALARM_BOOTTIME
expires time: 2012-1-1 0:34:0
......

>From the trace log, we can find out the 'Binder:2976_7' process
set one alarm timer which resumes the system.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Acked-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/trace/events/alarmtimer.h |  137 +++++++++++++++++++++++++++++++++++++
 kernel/time/alarmtimer.c          |   23 ++++++-
 2 files changed, 157 insertions(+), 3 deletions(-)
 create mode 100644 include/trace/events/alarmtimer.h

diff --git a/include/trace/events/alarmtimer.h b/include/trace/events/alarmtimer.h
new file mode 100644
index 0000000..a7eba5a
--- /dev/null
+++ b/include/trace/events/alarmtimer.h
@@ -0,0 +1,137 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM alarmtimer
+
+#if !defined(_TRACE_ALARMTIMER_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_ALARMTIMER_H
+
+#include <linux/alarmtimer.h>
+#include <linux/rtc.h>
+#include <linux/tracepoint.h>
+
+TRACE_DEFINE_ENUM(ALARM_REALTIME);
+TRACE_DEFINE_ENUM(ALARM_BOOTTIME);
+
+#define show_alarm_type(type)	__print_flags(type, " | ",	\
+	{ 1 << ALARM_REALTIME, "ALARM_REALTIME" },		\
+	{ 1 << ALARM_BOOTTIME, "ALARM_BOOTTIME" })
+
+DECLARE_EVENT_CLASS(alarm_setting,
+
+	TP_PROTO(struct rtc_time *rtc_time, int flag),
+
+	TP_ARGS(rtc_time, flag),
+
+	TP_STRUCT__entry(
+		__field(unsigned char, second)
+		__field(unsigned char, minute)
+		__field(unsigned char, hour)
+		__field(unsigned char, day)
+		__field(unsigned char, mon)
+		__field(unsigned short, year)
+		__field(unsigned char, alarm_type)
+	),
+
+	TP_fast_assign(
+		__entry->second = rtc_time->tm_sec;
+		__entry->minute = rtc_time->tm_min;
+		__entry->hour = rtc_time->tm_hour;
+		__entry->day = rtc_time->tm_mday;
+		__entry->mon = rtc_time->tm_mon;
+		__entry->year = rtc_time->tm_year;
+		__entry->alarm_type = flag;
+	),
+
+	TP_printk("alarmtimer type:%s expires time: %hu-%u-%u %u:%u:%u",
+		  show_alarm_type((1 << __entry->alarm_type)),
+		  __entry->year + 1900,
+		  __entry->mon + 1,
+		  __entry->day,
+		  __entry->hour,
+		  __entry->minute,
+		  __entry->second
+	)
+);
+
+DEFINE_EVENT(alarm_setting, alarmtimer_suspend,
+
+	TP_PROTO(struct rtc_time *time, int flag),
+
+	TP_ARGS(time, flag)
+);
+
+DECLARE_EVENT_CLASS(alarm_processing,
+
+	TP_PROTO(struct alarm *alarm, char *process_name),
+
+	TP_ARGS(alarm, process_name),
+
+	TP_STRUCT__entry(
+		__field(unsigned long long, expires)
+		__field(unsigned char, second)
+		__field(unsigned char, minute)
+		__field(unsigned char, hour)
+		__field(unsigned char, day)
+		__field(unsigned char, mon)
+		__field(unsigned short, year)
+		__field(unsigned char, alarm_type)
+		__string(name, process_name)
+	),
+
+	TP_fast_assign(
+		__entry->expires = alarm->node.expires.tv64;
+		__entry->alarm_type = alarm->type;
+		__assign_str(name, process_name);
+		__entry->second = rtc_ktime_to_tm(alarm->node.expires).tm_sec;
+		__entry->minute = rtc_ktime_to_tm(alarm->node.expires).tm_min;
+		__entry->hour = rtc_ktime_to_tm(alarm->node.expires).tm_hour;
+		__entry->day = rtc_ktime_to_tm(alarm->node.expires).tm_mday;
+		__entry->mon = rtc_ktime_to_tm(alarm->node.expires).tm_mon;
+		__entry->year = rtc_ktime_to_tm(alarm->node.expires).tm_year;
+	),
+
+	TP_printk("process:%s alarmtimer type:%s expires:%llu "
+		  "time: %hu-%u-%u %u:%u:%u",
+		  __get_str(name),
+		  show_alarm_type((1 << __entry->alarm_type)),
+		  __entry->expires,
+		  __entry->year + 1900,
+		  __entry->mon + 1,
+		  __entry->day,
+		  __entry->hour,
+		  __entry->minute,
+		  __entry->second
+	)
+);
+
+DEFINE_EVENT(alarm_processing, alarmtimer_fired,
+
+	TP_PROTO(struct alarm *alarm, char *process_name),
+
+	TP_ARGS(alarm, process_name)
+);
+
+DEFINE_EVENT(alarm_processing, alarmtimer_start,
+
+	TP_PROTO(struct alarm *alarm, char *process_name),
+
+	TP_ARGS(alarm, process_name)
+);
+
+DEFINE_EVENT(alarm_processing, alarmtimer_restart,
+
+	TP_PROTO(struct alarm *alarm, char *process_name),
+
+	TP_ARGS(alarm, process_name)
+);
+
+DEFINE_EVENT(alarm_processing, alarmtimer_cancel,
+
+	TP_PROTO(struct alarm *alarm, char *process_name),
+
+	TP_ARGS(alarm, process_name)
+);
+
+#endif /* _TRACE_ALARMTIMER_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index c3aad68..7cd15eb 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -26,6 +26,9 @@
 #include <linux/workqueue.h>
 #include <linux/freezer.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/alarmtimer.h>
+
 /**
  * struct alarm_base - Alarm timer bases
  * @lock:		Lock for syncrhonized access to the base
@@ -194,6 +197,7 @@ static enum hrtimer_restart alarmtimer_fired(struct hrtimer *timer)
 	}
 	spin_unlock_irqrestore(&base->lock, flags);
 
+	trace_alarmtimer_fired(alarm, NULL);
 	return ret;
 
 }
@@ -218,11 +222,11 @@ EXPORT_SYMBOL_GPL(alarm_expires_remaining);
  */
 static int alarmtimer_suspend(struct device *dev)
 {
-	struct rtc_time tm;
+	struct rtc_time tm, tm_set;
 	ktime_t min, now;
 	unsigned long flags;
 	struct rtc_device *rtc;
-	int i;
+	int i, type = 0;
 	int ret;
 
 	spin_lock_irqsave(&freezer_delta_lock, flags);
@@ -247,8 +251,10 @@ static int alarmtimer_suspend(struct device *dev)
 		if (!next)
 			continue;
 		delta = ktime_sub(next->expires, base->gettime());
-		if (!min.tv64 || (delta.tv64 < min.tv64))
+		if (!min.tv64 || (delta.tv64 < min.tv64)) {
 			min = delta;
+			type = i;
+		}
 	}
 	if (min.tv64 == 0)
 		return 0;
@@ -264,6 +270,11 @@ static int alarmtimer_suspend(struct device *dev)
 	now = rtc_tm_to_ktime(tm);
 	now = ktime_add(now, min);
 
+	if (trace_alarmtimer_suspend_enabled()) {
+		tm_set = rtc_ktime_to_tm(now);
+		trace_alarmtimer_suspend(&tm_set, type);
+	}
+
 	/* Set alarm, if in the past reject suspend briefly to handle */
 	ret = rtc_timer_start(rtc, &rtctimer, now, ktime_set(0, 0));
 	if (ret < 0)
@@ -342,6 +353,8 @@ void alarm_start(struct alarm *alarm, ktime_t start)
 	alarmtimer_enqueue(base, alarm);
 	hrtimer_start(&alarm->timer, alarm->node.expires, HRTIMER_MODE_ABS);
 	spin_unlock_irqrestore(&base->lock, flags);
+
+	trace_alarmtimer_start(alarm, current->comm);
 }
 EXPORT_SYMBOL_GPL(alarm_start);
 
@@ -369,6 +382,8 @@ void alarm_restart(struct alarm *alarm)
 	hrtimer_restart(&alarm->timer);
 	alarmtimer_enqueue(base, alarm);
 	spin_unlock_irqrestore(&base->lock, flags);
+
+	trace_alarmtimer_restart(alarm, current->comm);
 }
 EXPORT_SYMBOL_GPL(alarm_restart);
 
@@ -390,6 +405,8 @@ int alarm_try_to_cancel(struct alarm *alarm)
 	if (ret >= 0)
 		alarmtimer_dequeue(base, alarm);
 	spin_unlock_irqrestore(&base->lock, flags);
+
+	trace_alarmtimer_cancel(alarm, current->comm);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(alarm_try_to_cancel);
-- 
1.7.9.5

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
