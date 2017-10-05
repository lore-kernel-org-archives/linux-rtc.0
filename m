Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:44441 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751969AbdJEVM7 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 5 Oct 2017 17:12:59 -0400
Received: by mail-qk0-f175.google.com with SMTP id r64so15850604qkc.1
        for <linux-rtc@vger.kernel.org>; Thu, 05 Oct 2017 14:12:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1710052302440.2398@nanos>
References: <CAOdF7nvHfh_M3UQDYjbofNOm0-S_-LXHdmsMY7DeEwgOQCmfFA@mail.gmail.com>
 <alpine.DEB.2.20.1710041931560.2406@nanos> <CAOdF7ntda5TuCDBUTsuPZ0TCofo-GVfBmrGVyPk-hqGgHEkBQw@mail.gmail.com>
 <alpine.DEB.2.20.1710051216050.2083@nanos> <CAOdF7nu9JpG0C=d_2vMka00eEX_wWWv-UUaiUo-YsDcP9-7VdQ@mail.gmail.com>
 <alpine.DEB.2.20.1710051943570.2398@nanos> <CAOdF7nssJZZG_VKO+G_K6+aukOApmXp823yA9k3sUsSYpSB71g@mail.gmail.com>
 <alpine.DEB.2.20.1710052302440.2398@nanos>
From: Gabriel Beddingfield <gabe@nestlabs.com>
Date: Thu, 5 Oct 2017 14:12:57 -0700
Message-ID: <CAOdF7nuAY5P6fAQymtVPsgdHt+UybkZ5eCzvB=unvW8r+v_fDQ@mail.gmail.com>
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

On Thu, Oct 5, 2017 at 2:04 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> > So that clocksource driver looks correct. Do you have an idea in which
>> > context this time jump happens? Does it happen when you exercise your high
>> > frequency suspend/resume dance or is that happening just when you let the
>> > machine run forever as well?
>>
>> We couldn't devise any reproduction steps. We observed it happening at
>> unexpected times in a fleet of devices -- and we couldn't find any
>> patterns to clue us in.
>
> Ok. Did you talk to NXP about that? Or did you try to exercise reads in a
> loop to detect the wreckage and maybe a pattern in there?

Yes, we talked to NXP about it. They don't have a conclusion on what happened.
While they've been very helpful... we were off the path from their reference
implementation and so it's not a high priority for them.

No, we didn't try that because we prioritized the "persistent clock" approach.
I have a little more time now and can try the loop-reading strategy.

-gabe
