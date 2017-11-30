Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:38172 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752975AbdK3C4X (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 29 Nov 2017 21:56:23 -0500
Received: by mail-ot0-f195.google.com with SMTP id p3so4943734oti.5
        for <linux-rtc@vger.kernel.org>; Wed, 29 Nov 2017 18:56:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <64a38f4a15a2f8dae4a9fd0a3fc2a312e86c733d.1510749847.git.baolin.wang@linaro.org>
References: <64a38f4a15a2f8dae4a9fd0a3fc2a312e86c733d.1510749847.git.baolin.wang@linaro.org>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Thu, 30 Nov 2017 10:56:22 +0800
Message-ID: <CAMz4ku+eNkkrpboFpcmNN1yqktRu17SZzMbv6qXfV8_fxqm8mQ@mail.gmail.com>
Subject: Re: [PATCH v2] rtc: Add tracepoints for RTC system
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc: linux-rtc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi Alexandre and Ingo,

On 16 November 2017 at 13:59, Baolin Wang <baolin.wang@linaro.org> wrote:
> It will be more helpful to add some tracepoints to track RTC actions when
> debugging RTC driver. Below sample is that we set/read the RTC time, then
> set 2 alarms, so we can see the trace logs:
>
> set/read RTC time:
> kworker/0:1-67 [000] 21.814245: rtc_set_time: 2017-11-10 08:13:00 UTC (1510301580) (0)
> kworker/0:1-67 [000] 21.814312: rtc_read_time: 2017-11-10 08:13:00 UTC (1510301580) (0)
>
> set the first alarm timer:
> kworker/0:1-67 [000] 21.829238: rtc_timer_enqueue: RTC timer:(ffffffc15eb49bc8) expires:1510301700000000000 period:0
> kworker/0:1-67 [000] 22.018279: rtc_set_alarm: 2017-11-10 08:15:00 UTC (1510301700) (0)
>
> set the second alarm timer:
> kworker/0:1-67 [000] 22.230284: rtc_timer_enqueue: RTC timer:(ffffff80088e6430) expires:1510301820000000000 period:0
>
> the first alarm timer was expired:
> kworker/0:1-67 [000] 145.155584: rtc_timer_dequeue: RTC timer:(ffffffc15eb49bc8) expires:1510301700000000000 period:0
> kworker/0:1-67 [000] 145.155593: rtc_timer_fired: RTC timer:(ffffffc15eb49bc8) expires:1510301700000000000 period:0
> kworker/0:1-67 [000] 145.172504: rtc_set_alarm: 2017-11-10 08:17:00 UTC (1510301820) (0)
>
> the second alarm timer was expired:
> kworker/0:1-67 [000] 269.102353: rtc_timer_dequeue: RTC timer:(ffffff80088e6430) expires:1510301820000000000 period:0
> kworker/0:1-67 [000] 269.102360: rtc_timer_fired: RTC timer:(ffffff80088e6430) expires:1510301820000000000 period:0
>
> disable alarm irq:
> kworker/0:1-67 [000] 269.102469: rtc_alarm_irq_enable: disable RTC alarm IRQ (0)
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes since v1:
>  - Use unconditional tracepoints with tracing the failures.
>  - Simplify the rtc_timer_class.
> ---

Do you have any comments for this patch? Thanks.

-- 
Baolin Wang
Best Regards
