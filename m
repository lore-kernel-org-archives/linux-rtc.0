Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-ot0-f177.google.com ([74.125.82.177]:55515 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755732AbdKOKFV (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 15 Nov 2017 05:05:21 -0500
Received: by mail-ot0-f177.google.com with SMTP id u10so11800371otc.12
        for <linux-rtc@vger.kernel.org>; Wed, 15 Nov 2017 02:05:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171115092539.xrenngsxvsxzizs3@piout.net>
References: <354301cc7c61ba39021bb56e7ede5ba959e9dbb2.1510730564.git.baolin.wang@linaro.org>
 <20171115092539.xrenngsxvsxzizs3@piout.net>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Wed, 15 Nov 2017 18:05:20 +0800
Message-ID: <CAMz4kuKEMNNkzjgg9e7u2R2ty5Wed8K-E5ZxFcMK01bWiukMUQ@mail.gmail.com>
Subject: Re: [PATCH] rtc: Add tracepoints for RTC system
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

On 15 November 2017 at 17:25, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Hi,
>
> On 15/11/2017 at 15:30:21 +0800, Baolin Wang wrote:
>> It will be more helpful to add some tracepoints to track RTC actions when
>> debugging RTC driver. Below sample is that we set/read the RTC time, then
>> set 2 alarms, so we can see the trace logs:
>
> I'm not sure it is actually useful when debugging an RTC driver because
> you will be interested in the real values that are written to or read
> from the RTC, not what is returned by the driver to the RTC core as this
> information is already readily available to userspace.
>
> Is this really worth the added overhead?
>
> Maybe you have another use case?

Suppose one case like one thread set one alarm into RTC unexpectedly,
which maybe affect the system suspend. So we can catch out which
thread set the RTC alarm by trace logs. From trace log, I also can
know who set the RTC time, when and who disable the alarm irq to debug
some cases like the alarm event was not fired.
In some respects I think it will be helpful, maybe I need delete some
unuseful trace events? Thanks.

-- 
Baolin.wang
Best Regards
