Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45080 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752358AbdKOHbF (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 15 Nov 2017 02:31:05 -0500
Received: by mail-pg0-f65.google.com with SMTP id l19so14827005pgo.2
        for <linux-rtc@vger.kernel.org>; Tue, 14 Nov 2017 23:31:05 -0800 (PST)
From: Baolin Wang <baolin.wang@linaro.org>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
        rostedt@goodmis.org, mingo@redhat.com
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, broonie@kernel.org, baolin.wang@linaro.org
Subject: [PATCH] rtc: Add tracepoints for RTC system
Date: Wed, 15 Nov 2017 15:30:21 +0800
Message-Id: <354301cc7c61ba39021bb56e7ede5ba959e9dbb2.1510730564.git.baolin.wang@linaro.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

It will be more helpful to add some tracepoints to track RTC actions when
debugging RTC driver. Below sample is that we set/read the RTC time, then
set 2 alarms, so we can see the trace logs:

set/read RTC time:
kworker/1:1-586   [001] .... 21.826112: rtc_set_time: 2017-11-10 08:13:00 UTC (1510301580)
kworker/1:1-586   [001] .... 21.826174: rtc_read_time: 2017-11-10 08:13:00 UTC (1510301580)

set the first alarm timer:
kworker/1:1-586   [001] .... 21.841098: rtc_timer_enqueue: RTC timer:(ffffffc15ad913c8) 2017-11-10 08:15:00 UTC (1510301700)
kworker/1:1-586   [001] .... 22.009424: rtc_set_alarm: 2017-11-10 08:15:00 UTC (1510301700)

set the second alarm timer:
kworker/1:1-586   [001] .... 22.181304: rtc_timer_enqueue: RTC timer:(ffffff80088e6430) 2017-11-10 08:17:00 UTC (1510301820)

the first alarm timer was expired:
kworker/0:1-67    [000] .... 145.156226: rtc_timer_dequeue: RTC timer:(ffffffc15ad913c8) 2017-11-10 08:15:00 UTC (1510301700)
kworker/0:1-67    [000] .... 145.156235: rtc_timer_fired: RTC timer:(ffffffc15ad913c8) 2017-11-10 08:15:00 UTC (1510301700)
kworker/0:1-67    [000] .... 145.173137: rtc_set_alarm: 2017-11-10 08:17:00 UTC (1510301820)

the second alarm timer was expired:
kworker/0:1-67    [000] .... 269.102985: rtc_timer_dequeue: RTC timer:(ffffff80088e6430) 2017-11-10 08:17:00 UTC (1510301820)
kworker/0:1-67    [000] .... 269.102992: rtc_timer_fired: RTC timer:(ffffff80088e6430) 2017-11-10 08:17:00 UTC (1510301820)

disable alarm irq:
kworker/0:1-67    [000] .... 269.103098: rtc_alarm_irq_enable: disable RTC alarm IRQ

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/rtc/interface.c    |   46 ++++++++++
 include/trace/events/rtc.h |  215 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 261 insertions(+)
 create mode 100644 include/trace/events/rtc.h

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 8cec9a0..cdd3ac8 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -17,6 +17,9 @@
 #include <linux/log2.h>
 #include <linux/workqueue.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/rtc.h>
+
 static int rtc_timer_enqueue(struct rtc_device *rtc, struct rtc_timer *timer);
 static void rtc_timer_remove(struct rtc_device *rtc, struct rtc_timer *timer);
 
@@ -53,6 +56,9 @@ int rtc_read_time(struct rtc_device *rtc, struct rtc_time *tm)
 
 	err = __rtc_read_time(rtc, tm);
 	mutex_unlock(&rtc->ops_lock);
+
+	if (!err)
+		trace_rtc_read_time(tm);
 	return err;
 }
 EXPORT_SYMBOL_GPL(rtc_read_time);
@@ -87,6 +93,9 @@ int rtc_set_time(struct rtc_device *rtc, struct rtc_time *tm)
 	mutex_unlock(&rtc->ops_lock);
 	/* A timer might have just expired */
 	schedule_work(&rtc->irqwork);
+
+	if (!err)
+		trace_rtc_set_time(tm);
 	return err;
 }
 EXPORT_SYMBOL_GPL(rtc_set_time);
@@ -119,6 +128,9 @@ static int rtc_read_alarm_internal(struct rtc_device *rtc, struct rtc_wkalrm *al
 	}
 
 	mutex_unlock(&rtc->ops_lock);
+
+	if (!err)
+		trace_rtc_read_alarm(&alarm->time);
 	return err;
 }
 
@@ -316,6 +328,8 @@ int rtc_read_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 	}
 	mutex_unlock(&rtc->ops_lock);
 
+	if (!err)
+		trace_rtc_read_alarm(&alarm->time);
 	return err;
 }
 EXPORT_SYMBOL_GPL(rtc_read_alarm);
@@ -352,6 +366,8 @@ static int __rtc_set_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 	else
 		err = rtc->ops->set_alarm(rtc->dev.parent, alarm);
 
+	if (!err)
+		trace_rtc_set_alarm(&alarm->time);
 	return err;
 }
 
@@ -406,6 +422,8 @@ int rtc_initialize_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 
 		rtc->aie_timer.enabled = 1;
 		timerqueue_add(&rtc->timerqueue, &rtc->aie_timer.node);
+		trace_rtc_timer_enqueue(&rtc->aie_timer,
+				rtc_ktime_to_tm(rtc->aie_timer.node.expires));
 	}
 	mutex_unlock(&rtc->ops_lock);
 	return err;
@@ -435,6 +453,9 @@ int rtc_alarm_irq_enable(struct rtc_device *rtc, unsigned int enabled)
 		err = rtc->ops->alarm_irq_enable(rtc->dev.parent, enabled);
 
 	mutex_unlock(&rtc->ops_lock);
+
+	if (!err)
+		trace_rtc_alarm_irq_enable(enabled);
 	return err;
 }
 EXPORT_SYMBOL_GPL(rtc_alarm_irq_enable);
@@ -709,6 +730,9 @@ int rtc_irq_set_state(struct rtc_device *rtc, struct rtc_task *task, int enabled
 		rtc->pie_enabled = enabled;
 	}
 	spin_unlock_irqrestore(&rtc->irq_task_lock, flags);
+
+	if (!err)
+		trace_rtc_irq_set_state(enabled);
 	return err;
 }
 EXPORT_SYMBOL_GPL(rtc_irq_set_state);
@@ -745,6 +769,9 @@ int rtc_irq_set_freq(struct rtc_device *rtc, struct rtc_task *task, int freq)
 		}
 	}
 	spin_unlock_irqrestore(&rtc->irq_task_lock, flags);
+
+	if (!err)
+		trace_rtc_irq_set_freq(freq);
 	return err;
 }
 EXPORT_SYMBOL_GPL(rtc_irq_set_freq);
@@ -779,6 +806,7 @@ static int rtc_timer_enqueue(struct rtc_device *rtc, struct rtc_timer *timer)
 	}
 
 	timerqueue_add(&rtc->timerqueue, &timer->node);
+	trace_rtc_timer_enqueue(timer, rtc_ktime_to_tm(timer->node.expires));
 	if (!next) {
 		struct rtc_wkalrm alarm;
 		int err;
@@ -790,6 +818,8 @@ static int rtc_timer_enqueue(struct rtc_device *rtc, struct rtc_timer *timer)
 			schedule_work(&rtc->irqwork);
 		} else if (err) {
 			timerqueue_del(&rtc->timerqueue, &timer->node);
+			trace_rtc_timer_dequeue(timer,
+					rtc_ktime_to_tm(timer->node.expires));
 			timer->enabled = 0;
 			return err;
 		}
@@ -803,6 +833,7 @@ static void rtc_alarm_disable(struct rtc_device *rtc)
 		return;
 
 	rtc->ops->alarm_irq_enable(rtc->dev.parent, false);
+	trace_rtc_alarm_irq_enable(0);
 }
 
 /**
@@ -821,6 +852,7 @@ static void rtc_timer_remove(struct rtc_device *rtc, struct rtc_timer *timer)
 {
 	struct timerqueue_node *next = timerqueue_getnext(&rtc->timerqueue);
 	timerqueue_del(&rtc->timerqueue, &timer->node);
+	trace_rtc_timer_dequeue(timer, rtc_ktime_to_tm(timer->node.expires));
 	timer->enabled = 0;
 	if (next == &timer->node) {
 		struct rtc_wkalrm alarm;
@@ -871,16 +903,22 @@ void rtc_timer_do_work(struct work_struct *work)
 		/* expire timer */
 		timer = container_of(next, struct rtc_timer, node);
 		timerqueue_del(&rtc->timerqueue, &timer->node);
+		trace_rtc_timer_dequeue(timer,
+				rtc_ktime_to_tm(timer->node.expires));
 		timer->enabled = 0;
 		if (timer->task.func)
 			timer->task.func(timer->task.private_data);
 
+		trace_rtc_timer_fired(timer,
+				rtc_ktime_to_tm(timer->node.expires));
 		/* Re-add/fwd periodic timers */
 		if (ktime_to_ns(timer->period)) {
 			timer->node.expires = ktime_add(timer->node.expires,
 							timer->period);
 			timer->enabled = 1;
 			timerqueue_add(&rtc->timerqueue, &timer->node);
+			trace_rtc_timer_enqueue(timer,
+					rtc_ktime_to_tm(timer->node.expires));
 		}
 	}
 
@@ -902,6 +940,8 @@ void rtc_timer_do_work(struct work_struct *work)
 
 			timer = container_of(next, struct rtc_timer, node);
 			timerqueue_del(&rtc->timerqueue, &timer->node);
+			trace_rtc_timer_dequeue(timer,
+					rtc_ktime_to_tm(timer->node.expires));
 			timer->enabled = 0;
 			dev_err(&rtc->dev, "__rtc_set_alarm: err=%d\n", err);
 			goto again;
@@ -992,6 +1032,9 @@ int rtc_read_offset(struct rtc_device *rtc, long *offset)
 	mutex_lock(&rtc->ops_lock);
 	ret = rtc->ops->read_offset(rtc->dev.parent, offset);
 	mutex_unlock(&rtc->ops_lock);
+
+	if (!ret)
+		trace_rtc_read_offset(*offset);
 	return ret;
 }
 
@@ -1021,5 +1064,8 @@ int rtc_set_offset(struct rtc_device *rtc, long offset)
 	mutex_lock(&rtc->ops_lock);
 	ret = rtc->ops->set_offset(rtc->dev.parent, offset);
 	mutex_unlock(&rtc->ops_lock);
+
+	if (!ret)
+		trace_rtc_set_offset(offset);
 	return ret;
 }
diff --git a/include/trace/events/rtc.h b/include/trace/events/rtc.h
new file mode 100644
index 0000000..93d77bc
--- /dev/null
+++ b/include/trace/events/rtc.h
@@ -0,0 +1,215 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM rtc
+
+#if !defined(_TRACE_RTC_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_RTC_H
+
+#include <linux/rtc.h>
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(rtc_time_alarm_class,
+
+	TP_PROTO(struct rtc_time *tm),
+
+	TP_ARGS(tm),
+
+	TP_STRUCT__entry(
+		__field(int, sec)
+		__field(int, min)
+		__field(int, hour)
+		__field(int, mday)
+		__field(int, mon)
+		__field(int, year)
+		__field(time64_t, secs)
+	),
+
+	TP_fast_assign(
+		__entry->sec = tm->tm_sec;
+		__entry->min = tm->tm_min;
+		__entry->hour = tm->tm_hour;
+		__entry->mday = tm->tm_mday;
+		__entry->mon = tm->tm_mon;
+		__entry->year = tm->tm_year;
+		__entry->secs = rtc_tm_to_time64(tm);
+	),
+
+	TP_printk("%d-%02d-%02d %02d:%02d:%02d UTC (%lld)",
+		  __entry->year + 1900, __entry->mon + 1, __entry->mday,
+		  __entry->hour, __entry->min, __entry->sec, __entry->secs
+	)
+);
+
+DEFINE_EVENT(rtc_time_alarm_class, rtc_set_time,
+
+	TP_PROTO(struct rtc_time *tm),
+
+	TP_ARGS(tm)
+);
+
+DEFINE_EVENT(rtc_time_alarm_class, rtc_read_time,
+
+	TP_PROTO(struct rtc_time *tm),
+
+	TP_ARGS(tm)
+);
+
+DEFINE_EVENT(rtc_time_alarm_class, rtc_set_alarm,
+
+	TP_PROTO(struct rtc_time *tm),
+
+	TP_ARGS(tm)
+);
+
+DEFINE_EVENT(rtc_time_alarm_class, rtc_read_alarm,
+
+	TP_PROTO(struct rtc_time *tm),
+
+	TP_ARGS(tm)
+);
+
+TRACE_EVENT(rtc_irq_set_freq,
+
+	TP_PROTO(int freq),
+
+	TP_ARGS(freq),
+
+	TP_STRUCT__entry(
+		__field(int, freq)
+	),
+
+	TP_fast_assign(
+		__entry->freq = freq;
+	),
+
+	TP_printk("set RTC periodic IRQ frequency:%u", __entry->freq)
+);
+
+TRACE_EVENT(rtc_irq_set_state,
+
+	TP_PROTO(int enabled),
+
+	TP_ARGS(enabled),
+
+	TP_STRUCT__entry(
+		__field(int, enabled)
+	),
+
+	TP_fast_assign(
+		__entry->enabled = enabled;
+	),
+
+	TP_printk("%s RTC 2^N Hz periodic IRQs",
+		  __entry->enabled ? "enable" : "disable"
+	)
+);
+
+TRACE_EVENT(rtc_alarm_irq_enable,
+
+	TP_PROTO(unsigned int enabled),
+
+	TP_ARGS(enabled),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, enabled)
+	),
+
+	TP_fast_assign(
+		__entry->enabled = enabled;
+	),
+
+	TP_printk("%s RTC alarm IRQ",
+		  __entry->enabled ? "enable" : "disable"
+	)
+);
+
+DECLARE_EVENT_CLASS(rtc_offset_class,
+
+	TP_PROTO(long offset),
+
+	TP_ARGS(offset),
+
+	TP_STRUCT__entry(
+		__field(long, offset)
+	),
+
+	TP_fast_assign(
+		__entry->offset = offset;
+	),
+
+	TP_printk("RTC offset: %ld", __entry->offset)
+);
+
+DEFINE_EVENT(rtc_offset_class, rtc_set_offset,
+
+	TP_PROTO(long offset),
+
+	TP_ARGS(offset)
+);
+
+DEFINE_EVENT(rtc_offset_class, rtc_read_offset,
+
+	TP_PROTO(long offset),
+
+	TP_ARGS(offset)
+);
+
+DECLARE_EVENT_CLASS(rtc_timer_class,
+
+	TP_PROTO(struct rtc_timer *timer, struct rtc_time tm),
+
+	TP_ARGS(timer, tm),
+
+	TP_STRUCT__entry(
+		__field(struct rtc_timer *, timer)
+		__field(int, sec)
+		__field(int, min)
+		__field(int, hour)
+		__field(int, mday)
+		__field(int, mon)
+		__field(int, year)
+		__field(time64_t, secs)
+	),
+
+	TP_fast_assign(
+		__entry->timer = timer;
+		__entry->sec = tm.tm_sec;
+		__entry->min = tm.tm_min;
+		__entry->hour = tm.tm_hour;
+		__entry->mday = tm.tm_mday;
+		__entry->mon = tm.tm_mon;
+		__entry->year = tm.tm_year;
+		__entry->secs = rtc_tm_to_time64(&tm);
+	),
+
+	TP_printk("RTC timer:(%p) %d-%02d-%02d %02d:%02d:%02d UTC (%lld)",
+		  __entry->timer, __entry->year + 1900, __entry->mon + 1,
+		  __entry->mday, __entry->hour, __entry->min, __entry->sec,
+		  __entry->secs
+	)
+);
+
+DEFINE_EVENT(rtc_timer_class, rtc_timer_enqueue,
+
+	TP_PROTO(struct rtc_timer *timer, struct rtc_time tm),
+
+	TP_ARGS(timer, tm)
+);
+
+DEFINE_EVENT(rtc_timer_class, rtc_timer_dequeue,
+
+	TP_PROTO(struct rtc_timer *timer, struct rtc_time tm),
+
+	TP_ARGS(timer, tm)
+);
+
+DEFINE_EVENT(rtc_timer_class, rtc_timer_fired,
+
+	TP_PROTO(struct rtc_timer *timer, struct rtc_time tm),
+
+	TP_ARGS(timer, tm)
+);
+
+#endif /* _TRACE_RTC_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
1.7.9.5
