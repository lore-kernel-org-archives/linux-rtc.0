Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:37041 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750886AbdLMFrW (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 13 Dec 2017 00:47:22 -0500
Received: by mail-ot0-f194.google.com with SMTP id s4so1058363ote.4
        for <linux-rtc@vger.kernel.org>; Tue, 12 Dec 2017 21:47:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171212221643.GL8318@piout.net>
References: <64a38f4a15a2f8dae4a9fd0a3fc2a312e86c733d.1510749847.git.baolin.wang@linaro.org>
 <20171212221643.GL8318@piout.net>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Wed, 13 Dec 2017 13:47:21 +0800
Message-ID: <CAMz4ku+Hpbb+4Wj2auFFf7NGdd95VN6L8y5ONEqt3utndzUjVQ@mail.gmail.com>
Subject: Re: [PATCH v2] rtc: Add tracepoints for RTC system
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-rtc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi Alexandre,

On 13 December 2017 at 06:16, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Hi Baolin,
>
> On 16/11/2017 at 13:59:28 +0800, Baolin Wang wrote:
>> @@ -779,6 +797,7 @@ static int rtc_timer_enqueue(struct rtc_device *rtc, struct rtc_timer *timer)
>>       }
>>
>>       timerqueue_add(&rtc->timerqueue, &timer->node);
>> +     trace_rtc_timer_enqueue(timer);
>
> This doesn't apply because of 74717b28cb32e1ad3c1042cafd76b264c8c0f68d.
> Can you rebase?

Sure.

>
>> diff --git a/include/trace/events/rtc.h b/include/trace/events/rtc.h
>> new file mode 100644
>> index 0000000..b5a4add
>> --- /dev/null
>> +++ b/include/trace/events/rtc.h
>> @@ -0,0 +1,220 @@
>> +#undef TRACE_SYSTEM
>> +#define TRACE_SYSTEM rtc
>> +
>> +#if !defined(_TRACE_RTC_H) || defined(TRACE_HEADER_MULTI_READ)
>> +#define _TRACE_RTC_H
>> +
>> +#include <linux/rtc.h>
>> +#include <linux/tracepoint.h>
>> +
>> +DECLARE_EVENT_CLASS(rtc_time_alarm_class,
>> +
>> +     TP_PROTO(struct rtc_time *tm, int err),
>> +
>> +     TP_ARGS(tm, err),
>> +
>> +     TP_STRUCT__entry(
>> +             __field(int, sec)
>> +             __field(int, min)
>> +             __field(int, hour)
>> +             __field(int, mday)
>> +             __field(int, mon)
>> +             __field(int, year)
>> +             __field(time64_t, secs)
>> +             __field(int, err)
>> +     ),
>> +
>> +     TP_fast_assign(
>> +             __entry->sec = tm->tm_sec;
>> +             __entry->min = tm->tm_min;
>> +             __entry->hour = tm->tm_hour;
>> +             __entry->mday = tm->tm_mday;
>> +             __entry->mon = tm->tm_mon;
>> +             __entry->year = tm->tm_year;
>> +             __entry->secs = rtc_tm_to_time64(tm);
>> +             __entry->err = err;
>> +     ),
>> +
>> +     TP_printk("%d-%02d-%02d %02d:%02d:%02d UTC (%lld) (%d)",
>> +               __entry->year + 1900, __entry->mon + 1, __entry->mday,
>> +               __entry->hour, __entry->min, __entry->sec, __entry->secs,
>> +               __entry->err
>> +     )
>> +);
>> +
>
> Also, I'm a bit concerned about having a struct rtc_time here. I think
> its goal is mainly to have a nice representation on the time but maybe

Yes.

> the best would be to make printk able to pretty print the time (some
> patches were proposed).

If I understood your point correctly, you did not like the format of
TP_printk() here, right? So how about if I remove the 'struct
rtc_time' and just pass one 'ktime_t' parameter? But it will be not
readable for user to trace the RTC time/alarm.

>
> How bad would that be to change it later? I didn't follow the whole
> tracepoint ABI issue closely.


-- 
Baolin.wang
Best Regards
