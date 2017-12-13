Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:35187 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750785AbdLMIdY (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 13 Dec 2017 03:33:24 -0500
MIME-Version: 1.0
In-Reply-To: <CAMz4ku+Hpbb+4Wj2auFFf7NGdd95VN6L8y5ONEqt3utndzUjVQ@mail.gmail.com>
References: <64a38f4a15a2f8dae4a9fd0a3fc2a312e86c733d.1510749847.git.baolin.wang@linaro.org>
 <20171212221643.GL8318@piout.net> <CAMz4ku+Hpbb+4Wj2auFFf7NGdd95VN6L8y5ONEqt3utndzUjVQ@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 13 Dec 2017 09:33:23 +0100
Message-ID: <CAK8P3a06svzg8mG1Gw9n9tqsr6rNmkzLLvirWP6wZdnCm=5_CA@mail.gmail.com>
Subject: Re: [PATCH v2] rtc: Add tracepoints for RTC system
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-rtc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Wed, Dec 13, 2017 at 6:47 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>
>>> diff --git a/include/trace/events/rtc.h b/include/trace/events/rtc.h
>>> new file mode 100644
>>> index 0000000..b5a4add
>>> --- /dev/null
>>> +++ b/include/trace/events/rtc.h
>>> +
>>
>> Also, I'm a bit concerned about having a struct rtc_time here. I think
>> its goal is mainly to have a nice representation on the time but maybe
>
> Yes.
>
>> the best would be to make printk able to pretty print the time (some
>> patches were proposed).
>
> If I understood your point correctly, you did not like the format of
> TP_printk() here, right? So how about if I remove the 'struct
> rtc_time' and just pass one 'ktime_t' parameter? But it will be not
> readable for user to trace the RTC time/alarm.
>
>>
>> How bad would that be to change it later? I didn't follow the whole
>> tracepoint ABI issue closely.

There is no general rule here other than "if it breaks for existing
users, we have to fix it". Anyone who uses the tracepoints correctly
would end up showing zero-date if we change all the fields, but
it should not crash here.

Printing a time64_t instead of rtc_time may be better here, as it's
cheaper to convert rtc_time to time64_t that vice versa. User space
looking at the trace data can then do the conversion back to struct tm
for printing in a C program or using /bin/date from a shell
script, but I agree it's an extra step.

It's also possible that we don't care about the overhead of doing
a time64_to_tm() or rtc_time64_to_tm() in the trace function, as long
as that only needs to be done if the tracepoint is active. I find trace
points a bit confusing, so I don't know if that is the case or not when
the tracepoint is compiled into the kernel but disabled at run time.

        Arnd
