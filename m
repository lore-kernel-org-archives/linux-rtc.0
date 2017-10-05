Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:48700 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751988AbdJEUvF (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 5 Oct 2017 16:51:05 -0400
Received: by mail-qk0-f170.google.com with SMTP id d67so12647989qkg.5
        for <linux-rtc@vger.kernel.org>; Thu, 05 Oct 2017 13:51:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1710051943570.2398@nanos>
References: <CAOdF7nvHfh_M3UQDYjbofNOm0-S_-LXHdmsMY7DeEwgOQCmfFA@mail.gmail.com>
 <alpine.DEB.2.20.1710041931560.2406@nanos> <CAOdF7ntda5TuCDBUTsuPZ0TCofo-GVfBmrGVyPk-hqGgHEkBQw@mail.gmail.com>
 <alpine.DEB.2.20.1710051216050.2083@nanos> <CAOdF7nu9JpG0C=d_2vMka00eEX_wWWv-UUaiUo-YsDcP9-7VdQ@mail.gmail.com>
 <alpine.DEB.2.20.1710051943570.2398@nanos>
From: Gabriel Beddingfield <gabe@nestlabs.com>
Date: Thu, 5 Oct 2017 13:51:03 -0700
Message-ID: <CAOdF7nssJZZG_VKO+G_K6+aukOApmXp823yA9k3sUsSYpSB71g@mail.gmail.com>
Subject: Re: Extreme time jitter with suspend/resume cycles
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        John Stultz <john.stultz@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Guy Erb <guy@nestlabs.com>,
        Howard Harte <hharte@nestlabs.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi Thomas,

On Thu, Oct 5, 2017 at 11:01 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> > Which SoC/clocksource driver are you talking about?
>>
>> NXP i.MX 6SoloX
>> drivers/clocksource/timer-imx-gpt.c
>
> So that clocksource driver looks correct. Do you have an idea in which
> context this time jump happens? Does it happen when you exercise your high
> frequency suspend/resume dance or is that happening just when you let the
> machine run forever as well?

We couldn't devise any reproduction steps. We observed it happening at
unexpected
times in a fleet of devices -- and we couldn't find any patterns to clue us in.

>
> The timekeeping_resume() path definitely has an issue:
>
>         cycle_now = tk_clock_read(&tk->tkr_mono);
>         if ((clock->flags & CLOCK_SOURCE_SUSPEND_NONSTOP) &&
>                 cycle_now > tk->tkr_mono.cycle_last) {
>
> This works nice for clocksources which wont wrap across suspend/resume but
> not for those which can. That cycle_now -> cycle_last check should take
> cs-mask into account ...
>
> Of course for clocksources which can wrap within realistic suspend times,
> which 36 hours might be accounted for, this would need an extra sanity
> check against a RTC whether wrap time has been exceeded.
>
> I haven't thought it through whether that buggered check fully explains
> what you are observing, but it's wrong nevertheless. John?

Nah. It looks like the consequence is that you'll either fail to
inject the sleep time
or you'll fall back to having the RTC inject the sleep time. In our
case, we never
sleep for more than a couple of minutes so the error would be seconds rather
than hours.

-gabe
