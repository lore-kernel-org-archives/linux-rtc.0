Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:45539 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757205AbdKOIfJ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 15 Nov 2017 03:35:09 -0500
Date: Wed, 15 Nov 2017 09:35:05 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
        rostedt@goodmis.org, mingo@redhat.com, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de, broonie@kernel.org
Subject: Re: [PATCH] rtc: Add tracepoints for RTC system
Message-ID: <20171115083505.kderwwdigcq7e674@gmail.com>
References: <354301cc7c61ba39021bb56e7ede5ba959e9dbb2.1510730564.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <354301cc7c61ba39021bb56e7ede5ba959e9dbb2.1510730564.git.baolin.wang@linaro.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>


* Baolin Wang <baolin.wang@linaro.org> wrote:

> It will be more helpful to add some tracepoints to track RTC actions when
> debugging RTC driver. Below sample is that we set/read the RTC time, then
> set 2 alarms, so we can see the trace logs:
> 
> set/read RTC time:
> kworker/1:1-586   [001] .... 21.826112: rtc_set_time: 2017-11-10 08:13:00 UTC (1510301580)
> kworker/1:1-586   [001] .... 21.826174: rtc_read_time: 2017-11-10 08:13:00 UTC (1510301580)
> 
> set the first alarm timer:
> kworker/1:1-586   [001] .... 21.841098: rtc_timer_enqueue: RTC timer:(ffffffc15ad913c8) 2017-11-10 08:15:00 UTC (1510301700)
> kworker/1:1-586   [001] .... 22.009424: rtc_set_alarm: 2017-11-10 08:15:00 UTC (1510301700)
> 
> set the second alarm timer:
> kworker/1:1-586   [001] .... 22.181304: rtc_timer_enqueue: RTC timer:(ffffff80088e6430) 2017-11-10 08:17:00 UTC (1510301820)
> 
> the first alarm timer was expired:
> kworker/0:1-67    [000] .... 145.156226: rtc_timer_dequeue: RTC timer:(ffffffc15ad913c8) 2017-11-10 08:15:00 UTC (1510301700)
> kworker/0:1-67    [000] .... 145.156235: rtc_timer_fired: RTC timer:(ffffffc15ad913c8) 2017-11-10 08:15:00 UTC (1510301700)
> kworker/0:1-67    [000] .... 145.173137: rtc_set_alarm: 2017-11-10 08:17:00 UTC (1510301820)
> 
> the second alarm timer was expired:
> kworker/0:1-67    [000] .... 269.102985: rtc_timer_dequeue: RTC timer:(ffffff80088e6430) 2017-11-10 08:17:00 UTC (1510301820)
> kworker/0:1-67    [000] .... 269.102992: rtc_timer_fired: RTC timer:(ffffff80088e6430) 2017-11-10 08:17:00 UTC (1510301820)
> 
> disable alarm irq:
> kworker/0:1-67    [000] .... 269.103098: rtc_alarm_irq_enable: disable RTC alarm IRQ
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/rtc/interface.c    |   46 ++++++++++
>  include/trace/events/rtc.h |  215 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 261 insertions(+)
>  create mode 100644 include/trace/events/rtc.h
> 
> diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
> index 8cec9a0..cdd3ac8 100644
> --- a/drivers/rtc/interface.c
> +++ b/drivers/rtc/interface.c
> @@ -17,6 +17,9 @@
>  #include <linux/log2.h>
>  #include <linux/workqueue.h>
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/rtc.h>
> +
>  static int rtc_timer_enqueue(struct rtc_device *rtc, struct rtc_timer *timer);
>  static void rtc_timer_remove(struct rtc_device *rtc, struct rtc_timer *timer);
>  
> @@ -53,6 +56,9 @@ int rtc_read_time(struct rtc_device *rtc, struct rtc_time *tm)
>  
>  	err = __rtc_read_time(rtc, tm);
>  	mutex_unlock(&rtc->ops_lock);
> +
> +	if (!err)
> +		trace_rtc_read_time(tm);

It's better to just add unconditional tracepoints and trace the failures as well - 
this makes things faster for the non-traced case, plus it's much easier to read as 
well.

I.e. something like:

	trace_rtc_read_time(tm, err);

etc.

> @@ -790,6 +818,8 @@ static int rtc_timer_enqueue(struct rtc_device *rtc, struct rtc_timer *timer)
>  			schedule_work(&rtc->irqwork);
>  		} else if (err) {
>  			timerqueue_del(&rtc->timerqueue, &timer->node);
> +			trace_rtc_timer_dequeue(timer,
> +					rtc_ktime_to_tm(timer->node.expires));

Please don't break the line in such an ugly fashion.

> @@ -803,6 +833,7 @@ static void rtc_alarm_disable(struct rtc_device *rtc)
>  		return;
>  
>  	rtc->ops->alarm_irq_enable(rtc->dev.parent, false);
> +	trace_rtc_alarm_irq_enable(0);

Since there's so many new events already, why not add an enable/disable variant 
instead of parameterizing the 'enable' event?

>  	timerqueue_del(&rtc->timerqueue, &timer->node);
> +	trace_rtc_timer_dequeue(timer, rtc_ktime_to_tm(timer->node.expires));

> +		trace_rtc_timer_dequeue(timer,
> +				rtc_ktime_to_tm(timer->node.expires));

> +		trace_rtc_timer_fired(timer,
> +				rtc_ktime_to_tm(timer->node.expires));

> +			trace_rtc_timer_enqueue(timer,
> +					rtc_ktime_to_tm(timer->node.expires));

All the decoding of expiry time should be done in the trace handler, don't bloat 
the call site with it.

Thanks,

	Ingo
