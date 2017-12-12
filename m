Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:46845 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752320AbdLLWQq (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 12 Dec 2017 17:16:46 -0500
Date: Tue, 12 Dec 2017 23:16:43 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: a.zummo@towertech.it, rostedt@goodmis.org, mingo@redhat.com,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, broonie@kernel.org
Subject: Re: [PATCH v2] rtc: Add tracepoints for RTC system
Message-ID: <20171212221643.GL8318@piout.net>
References: <64a38f4a15a2f8dae4a9fd0a3fc2a312e86c733d.1510749847.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <64a38f4a15a2f8dae4a9fd0a3fc2a312e86c733d.1510749847.git.baolin.wang@linaro.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi Baolin,

On 16/11/2017 at 13:59:28 +0800, Baolin Wang wrote:
> @@ -779,6 +797,7 @@ static int rtc_timer_enqueue(struct rtc_device *rtc, struct rtc_timer *timer)
>  	}
>  
>  	timerqueue_add(&rtc->timerqueue, &timer->node);
> +	trace_rtc_timer_enqueue(timer);

This doesn't apply because of 74717b28cb32e1ad3c1042cafd76b264c8c0f68d.
Can you rebase?

> diff --git a/include/trace/events/rtc.h b/include/trace/events/rtc.h
> new file mode 100644
> index 0000000..b5a4add
> --- /dev/null
> +++ b/include/trace/events/rtc.h
> @@ -0,0 +1,220 @@
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM rtc
> +
> +#if !defined(_TRACE_RTC_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_RTC_H
> +
> +#include <linux/rtc.h>
> +#include <linux/tracepoint.h>
> +
> +DECLARE_EVENT_CLASS(rtc_time_alarm_class,
> +
> +	TP_PROTO(struct rtc_time *tm, int err),
> +
> +	TP_ARGS(tm, err),
> +
> +	TP_STRUCT__entry(
> +		__field(int, sec)
> +		__field(int, min)
> +		__field(int, hour)
> +		__field(int, mday)
> +		__field(int, mon)
> +		__field(int, year)
> +		__field(time64_t, secs)
> +		__field(int, err)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->sec = tm->tm_sec;
> +		__entry->min = tm->tm_min;
> +		__entry->hour = tm->tm_hour;
> +		__entry->mday = tm->tm_mday;
> +		__entry->mon = tm->tm_mon;
> +		__entry->year = tm->tm_year;
> +		__entry->secs = rtc_tm_to_time64(tm);
> +		__entry->err = err;
> +	),
> +
> +	TP_printk("%d-%02d-%02d %02d:%02d:%02d UTC (%lld) (%d)",
> +		  __entry->year + 1900, __entry->mon + 1, __entry->mday,
> +		  __entry->hour, __entry->min, __entry->sec, __entry->secs,
> +		  __entry->err
> +	)
> +);
> +

Also, I'm a bit concerned about having a struct rtc_time here. I think
its goal is mainly to have a nice representation on the time but maybe
the best would be to make printk able to pretty print the time (some
patches were proposed).

How bad would that be to change it later? I didn't follow the whole
tracepoint ABI issue closely.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
