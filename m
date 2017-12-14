Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:44665 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751048AbdLNFcO (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 14 Dec 2017 00:32:14 -0500
Received: by mail-pg0-f67.google.com with SMTP id j9so2740720pgc.11
        for <linux-rtc@vger.kernel.org>; Wed, 13 Dec 2017 21:32:14 -0800 (PST)
From: Baolin Wang <baolin.wang@linaro.org>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
        rostedt@goodmis.org, mingo@redhat.com
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, broonie@kernel.org, baolin.wang@linaro.org
Subject: [PATCH v3] rtc: Add tracepoints for RTC system
Date: Thu, 14 Dec 2017 13:31:43 +0800
Message-Id: <f819febcf2104918bfda1eadba021f9cc08ed866.1513221837.git.baolin.wang@linaro.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

It will be more helpful to add some tracepoints to track RTC actions when
debugging RTC driver. Below sample is that we set/read the RTC time, then
set 2 alarms, so we can see the trace logs:

set/read RTC time:
kworker/0:1-67 [000] 21.814245: rtc_set_time: UTC (1510301580) (0)
kworker/0:1-67 [000] 21.814312: rtc_read_time: UTC (1510301580) (0)

set the first alarm timer:
kworker/0:1-67 [000] 21.829238: rtc_timer_enqueue: RTC timer:(ffffffc15eb49bc8) expires:1510301700000000000 period:0
kworker/0:1-67 [000] 22.018279: rtc_set_alarm: UTC (1510301700) (0)

set the second alarm timer:
kworker/0:1-67 [000] 22.230284: rtc_timer_enqueue: RTC timer:(ffffff80088e6430) expires:1510301820000000000 period:0

the first alarm timer was expired:
kworker/0:1-67 [000] 145.155584: rtc_timer_dequeue: RTC timer:(ffffffc15eb49bc8) expires:1510301700000000000 period:0
kworker/0:1-67 [000] 145.155593: rtc_timer_fired: RTC timer:(ffffffc15eb49bc8) expires:1510301700000000000 period:0
kworker/0:1-67 [000] 145.172504: rtc_set_alarm: UTC (1510301820) (0)

the second alarm timer was expired:
kworker/0:1-67 [000] 269.102353: rtc_timer_dequeue: RTC timer:(ffffff80088e6430) expires:1510301820000000000 period:0
kworker/0:1-67 [000] 269.102360: rtc_timer_fired: RTC timer:(ffffff80088e6430) expires:1510301820000000000 period:0

disable alarm irq:
kworker/0:1-67 [000] 269.102469: rtc_alarm_irq_enable: disable RTC alarm IRQ (0)

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes since v2:
 - Only keep time64_t in the buffer.

Changes since v1:
 - Use unconditional tracepoints with tracing the failures.
 - Simplify the rtc_timer_class.
---
 drivers/rtc/interface.c    |   30 +++++++
 include/trace/events/rtc.h |  206 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 236 insertions(+)
 create mode 100644 include/trace/events/rtc.h

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 672b192..7e253be 100644
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
 
@@ -53,6 +56,8 @@ int rtc_read_time(struct rtc_device *rtc, struct rtc_time *tm)
 
 	err = __rtc_read_time(rtc, tm);
 	mutex_unlock(&rtc->ops_lock);
+
+	trace_rtc_read_time(rtc_tm_to_time64(tm), err);
 	return err;
 }
 EXPORT_SYMBOL_GPL(rtc_read_time);
@@ -87,6 +92,8 @@ int rtc_set_time(struct rtc_device *rtc, struct rtc_time *tm)
 	mutex_unlock(&rtc->ops_lock);
 	/* A timer might have just expired */
 	schedule_work(&rtc->irqwork);
+
+	trace_rtc_set_time(rtc_tm_to_time64(tm), err);
 	return err;
 }
 EXPORT_SYMBOL_GPL(rtc_set_time);
@@ -119,6 +126,8 @@ static int rtc_read_alarm_internal(struct rtc_device *rtc, struct rtc_wkalrm *al
 	}
 
 	mutex_unlock(&rtc->ops_lock);
+
+	trace_rtc_read_alarm(rtc_tm_to_time64(&alarm->time), err);
 	return err;
 }
 
@@ -316,6 +325,7 @@ int rtc_read_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 	}
 	mutex_unlock(&rtc->ops_lock);
 
+	trace_rtc_read_alarm(rtc_tm_to_time64(&alarm->time), err);
 	return err;
 }
 EXPORT_SYMBOL_GPL(rtc_read_alarm);
@@ -352,6 +362,7 @@ static int __rtc_set_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 	else
 		err = rtc->ops->set_alarm(rtc->dev.parent, alarm);
 
+	trace_rtc_set_alarm(rtc_tm_to_time64(&alarm->time), err);
 	return err;
 }
 
@@ -406,6 +417,7 @@ int rtc_initialize_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 
 		rtc->aie_timer.enabled = 1;
 		timerqueue_add(&rtc->timerqueue, &rtc->aie_timer.node);
+		trace_rtc_timer_enqueue(&rtc->aie_timer);
 	}
 	mutex_unlock(&rtc->ops_lock);
 	return err;
@@ -435,6 +447,8 @@ int rtc_alarm_irq_enable(struct rtc_device *rtc, unsigned int enabled)
 		err = rtc->ops->alarm_irq_enable(rtc->dev.parent, enabled);
 
 	mutex_unlock(&rtc->ops_lock);
+
+	trace_rtc_alarm_irq_enable(enabled, err);
 	return err;
 }
 EXPORT_SYMBOL_GPL(rtc_alarm_irq_enable);
@@ -709,6 +723,8 @@ int rtc_irq_set_state(struct rtc_device *rtc, struct rtc_task *task, int enabled
 		rtc->pie_enabled = enabled;
 	}
 	spin_unlock_irqrestore(&rtc->irq_task_lock, flags);
+
+	trace_rtc_irq_set_state(enabled, err);
 	return err;
 }
 EXPORT_SYMBOL_GPL(rtc_irq_set_state);
@@ -745,6 +761,8 @@ int rtc_irq_set_freq(struct rtc_device *rtc, struct rtc_task *task, int freq)
 		}
 	}
 	spin_unlock_irqrestore(&rtc->irq_task_lock, flags);
+
+	trace_rtc_irq_set_freq(freq, err);
 	return err;
 }
 EXPORT_SYMBOL_GPL(rtc_irq_set_freq);
@@ -779,6 +797,7 @@ static int rtc_timer_enqueue(struct rtc_device *rtc, struct rtc_timer *timer)
 	}
 
 	timerqueue_add(&rtc->timerqueue, &timer->node);
+	trace_rtc_timer_enqueue(timer);
 	if (!next || ktime_before(timer->node.expires, next->expires)) {
 		struct rtc_wkalrm alarm;
 		int err;
@@ -790,6 +809,7 @@ static int rtc_timer_enqueue(struct rtc_device *rtc, struct rtc_timer *timer)
 			schedule_work(&rtc->irqwork);
 		} else if (err) {
 			timerqueue_del(&rtc->timerqueue, &timer->node);
+			trace_rtc_timer_dequeue(timer);
 			timer->enabled = 0;
 			return err;
 		}
@@ -803,6 +823,7 @@ static void rtc_alarm_disable(struct rtc_device *rtc)
 		return;
 
 	rtc->ops->alarm_irq_enable(rtc->dev.parent, false);
+	trace_rtc_alarm_irq_enable(0, 0);
 }
 
 /**
@@ -821,6 +842,7 @@ static void rtc_timer_remove(struct rtc_device *rtc, struct rtc_timer *timer)
 {
 	struct timerqueue_node *next = timerqueue_getnext(&rtc->timerqueue);
 	timerqueue_del(&rtc->timerqueue, &timer->node);
+	trace_rtc_timer_dequeue(timer);
 	timer->enabled = 0;
 	if (next == &timer->node) {
 		struct rtc_wkalrm alarm;
@@ -871,16 +893,19 @@ void rtc_timer_do_work(struct work_struct *work)
 		/* expire timer */
 		timer = container_of(next, struct rtc_timer, node);
 		timerqueue_del(&rtc->timerqueue, &timer->node);
+		trace_rtc_timer_dequeue(timer);
 		timer->enabled = 0;
 		if (timer->task.func)
 			timer->task.func(timer->task.private_data);
 
+		trace_rtc_timer_fired(timer);
 		/* Re-add/fwd periodic timers */
 		if (ktime_to_ns(timer->period)) {
 			timer->node.expires = ktime_add(timer->node.expires,
 							timer->period);
 			timer->enabled = 1;
 			timerqueue_add(&rtc->timerqueue, &timer->node);
+			trace_rtc_timer_enqueue(timer);
 		}
 	}
 
@@ -902,6 +927,7 @@ void rtc_timer_do_work(struct work_struct *work)
 
 			timer = container_of(next, struct rtc_timer, node);
 			timerqueue_del(&rtc->timerqueue, &timer->node);
+			trace_rtc_timer_dequeue(timer);
 			timer->enabled = 0;
 			dev_err(&rtc->dev, "__rtc_set_alarm: err=%d\n", err);
 			goto again;
@@ -992,6 +1018,8 @@ int rtc_read_offset(struct rtc_device *rtc, long *offset)
 	mutex_lock(&rtc->ops_lock);
 	ret = rtc->ops->read_offset(rtc->dev.parent, offset);
 	mutex_unlock(&rtc->ops_lock);
+
+	trace_rtc_read_offset(*offset, ret);
 	return ret;
 }
 
@@ -1025,5 +1053,7 @@ int rtc_set_offset(struct rtc_device *rtc, long offset)
 	mutex_lock(&rtc->ops_lock);
 	ret = rtc->ops->set_offset(rtc->dev.parent, offset);
 	mutex_unlock(&rtc->ops_lock);
+
+	trace_rtc_set_offset(offset, ret);
 	return ret;
 }
diff --git a/include/trace/events/rtc.h b/include/trace/events/rtc.h
new file mode 100644
index 0000000..621333f
--- /dev/null
+++ b/include/trace/events/rtc.h
@@ -0,0 +1,206 @@
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
+	TP_PROTO(time64_t secs, int err),
+
+	TP_ARGS(secs, err),
+
+	TP_STRUCT__entry(
+		__field(time64_t, secs)
+		__field(int, err)
+	),
+
+	TP_fast_assign(
+		__entry->secs = secs;
+		__entry->err = err;
+	),
+
+	TP_printk("UTC (%lld) (%d)",
+		  __entry->secs, __entry->err
+	)
+);
+
+DEFINE_EVENT(rtc_time_alarm_class, rtc_set_time,
+
+	TP_PROTO(time64_t secs, int err),
+
+	TP_ARGS(secs, err)
+);
+
+DEFINE_EVENT(rtc_time_alarm_class, rtc_read_time,
+
+	TP_PROTO(time64_t secs, int err),
+
+	TP_ARGS(secs, err)
+);
+
+DEFINE_EVENT(rtc_time_alarm_class, rtc_set_alarm,
+
+	TP_PROTO(time64_t secs, int err),
+
+	TP_ARGS(secs, err)
+);
+
+DEFINE_EVENT(rtc_time_alarm_class, rtc_read_alarm,
+
+	TP_PROTO(time64_t secs, int err),
+
+	TP_ARGS(secs, err)
+);
+
+TRACE_EVENT(rtc_irq_set_freq,
+
+	TP_PROTO(int freq, int err),
+
+	TP_ARGS(freq, err),
+
+	TP_STRUCT__entry(
+		__field(int, freq)
+		__field(int, err)
+	),
+
+	TP_fast_assign(
+		__entry->freq = freq;
+		__entry->err = err;
+	),
+
+	TP_printk("set RTC periodic IRQ frequency:%u (%d)",
+		  __entry->freq, __entry->err
+	)
+);
+
+TRACE_EVENT(rtc_irq_set_state,
+
+	TP_PROTO(int enabled, int err),
+
+	TP_ARGS(enabled, err),
+
+	TP_STRUCT__entry(
+		__field(int, enabled)
+		__field(int, err)
+	),
+
+	TP_fast_assign(
+		__entry->enabled = enabled;
+		__entry->err = err;
+	),
+
+	TP_printk("%s RTC 2^N Hz periodic IRQs (%d)",
+		  __entry->enabled ? "enable" : "disable",
+		  __entry->err
+	)
+);
+
+TRACE_EVENT(rtc_alarm_irq_enable,
+
+	TP_PROTO(unsigned int enabled, int err),
+
+	TP_ARGS(enabled, err),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, enabled)
+		__field(int, err)
+	),
+
+	TP_fast_assign(
+		__entry->enabled = enabled;
+		__entry->err = err;
+	),
+
+	TP_printk("%s RTC alarm IRQ (%d)",
+		  __entry->enabled ? "enable" : "disable",
+		  __entry->err
+	)
+);
+
+DECLARE_EVENT_CLASS(rtc_offset_class,
+
+	TP_PROTO(long offset, int err),
+
+	TP_ARGS(offset, err),
+
+	TP_STRUCT__entry(
+		__field(long, offset)
+		__field(int, err)
+	),
+
+	TP_fast_assign(
+		__entry->offset = offset;
+		__entry->err = err;
+	),
+
+	TP_printk("RTC offset: %ld (%d)",
+		  __entry->offset, __entry->err
+	)
+);
+
+DEFINE_EVENT(rtc_offset_class, rtc_set_offset,
+
+	TP_PROTO(long offset, int err),
+
+	TP_ARGS(offset, err)
+);
+
+DEFINE_EVENT(rtc_offset_class, rtc_read_offset,
+
+	TP_PROTO(long offset, int err),
+
+	TP_ARGS(offset, err)
+);
+
+DECLARE_EVENT_CLASS(rtc_timer_class,
+
+	TP_PROTO(struct rtc_timer *timer),
+
+	TP_ARGS(timer),
+
+	TP_STRUCT__entry(
+		__field(struct rtc_timer *, timer)
+		__field(ktime_t, expires)
+		__field(ktime_t, period)
+	),
+
+	TP_fast_assign(
+		__entry->timer = timer;
+		__entry->expires = timer->node.expires;
+		__entry->period = timer->period;
+	),
+
+	TP_printk("RTC timer:(%p) expires:%lld period:%lld",
+		  __entry->timer, __entry->expires, __entry->period
+	)
+);
+
+DEFINE_EVENT(rtc_timer_class, rtc_timer_enqueue,
+
+	TP_PROTO(struct rtc_timer *timer),
+
+	TP_ARGS(timer)
+);
+
+DEFINE_EVENT(rtc_timer_class, rtc_timer_dequeue,
+
+	TP_PROTO(struct rtc_timer *timer),
+
+	TP_ARGS(timer)
+);
+
+DEFINE_EVENT(rtc_timer_class, rtc_timer_fired,
+
+	TP_PROTO(struct rtc_timer *timer),
+
+	TP_ARGS(timer)
+);
+
+#endif /* _TRACE_RTC_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
1.7.9.5
