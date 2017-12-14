Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754231AbdLNRtP (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 14 Dec 2017 12:49:15 -0500
Date: Thu, 14 Dec 2017 12:49:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
        mingo@redhat.com, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de, broonie@kernel.org
Subject: Re: [PATCH v3] rtc: Add tracepoints for RTC system
Message-ID: <20171214124912.3171dafd@gandalf.local.home>
In-Reply-To: <f819febcf2104918bfda1eadba021f9cc08ed866.1513221837.git.baolin.wang@linaro.org>
References: <f819febcf2104918bfda1eadba021f9cc08ed866.1513221837.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, 14 Dec 2017 13:31:43 +0800
Baolin Wang <baolin.wang@linaro.org> wrote:


> @@ -53,6 +56,8 @@ int rtc_read_time(struct rtc_device *rtc, struct rtc_time *tm)
>  
>  	err = __rtc_read_time(rtc, tm);
>  	mutex_unlock(&rtc->ops_lock);
> +
> +	trace_rtc_read_time(rtc_tm_to_time64(tm), err);

There's a possibility that gcc may put the call to rt_tm_to_time64()
outside the tracepoint area that gets nop'd out. Could you just pass in
the tm to the tracepoint, and have the call to rtc_tm_to_time64() done
within the TP_fast_assign? This would guarantee that we don't incur
overhead when tracing is off.

	TP_PROTO(struct rtc_time *tm, int err),

	TP_ARGS(tm, err),

	TP_fast_assign(
		__entry->secs = rt_tm_to_time64(tm);

-- Steve


> diff --git a/include/trace/events/rtc.h b/include/trace/events/rtc.h
> new file mode 100644
> index 0000000..621333f
> --- /dev/null
> +++ b/include/trace/events/rtc.h
> @@ -0,0 +1,206 @@
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
> +	TP_PROTO(time64_t secs, int err),
> +
> +	TP_ARGS(secs, err),
> +
> +	TP_STRUCT__entry(
> +		__field(time64_t, secs)
> +		__field(int, err)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->secs = secs;
> +		__entry->err = err;
> +	),
> +
> +	TP_printk("UTC (%lld) (%d)",
> +		  __entry->secs, __entry->err
> +	)
> +);
> +
> +DEFINE_EVENT(rtc_time_alarm_class, rtc_set_time,
> +
> +	TP_PROTO(time64_t secs, int err),
> +
> +	TP_ARGS(secs, err)
> +);
> +
> +DEFINE_EVENT(rtc_time_alarm_class, rtc_read_time,
> +
> +	TP_PROTO(time64_t secs, int err),
> +
> +	TP_ARGS(secs, err)
> +);
> +
