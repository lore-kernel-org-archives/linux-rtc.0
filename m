Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:60422 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752687AbdLMLEi (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 13 Dec 2017 06:04:38 -0500
Date: Wed, 13 Dec 2017 12:04:26 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Baolin Wang <baolin.wang@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-rtc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] rtc: Add tracepoints for RTC system
Message-ID: <20171213110426.GQ8318@piout.net>
References: <64a38f4a15a2f8dae4a9fd0a3fc2a312e86c733d.1510749847.git.baolin.wang@linaro.org>
 <20171212221643.GL8318@piout.net>
 <CAMz4ku+Hpbb+4Wj2auFFf7NGdd95VN6L8y5ONEqt3utndzUjVQ@mail.gmail.com>
 <CAK8P3a06svzg8mG1Gw9n9tqsr6rNmkzLLvirWP6wZdnCm=5_CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAK8P3a06svzg8mG1Gw9n9tqsr6rNmkzLLvirWP6wZdnCm=5_CA@mail.gmail.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 13/12/2017 at 09:33:23 +0100, Arnd Bergmann wrote:
> On Wed, Dec 13, 2017 at 6:47 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
> >
> >>> diff --git a/include/trace/events/rtc.h b/include/trace/events/rtc.h
> >>> new file mode 100644
> >>> index 0000000..b5a4add
> >>> --- /dev/null
> >>> +++ b/include/trace/events/rtc.h
> >>> +
> >>
> >> Also, I'm a bit concerned about having a struct rtc_time here. I think
> >> its goal is mainly to have a nice representation on the time but maybe
> >
> > Yes.
> >
> >> the best would be to make printk able to pretty print the time (some
> >> patches were proposed).
> >
> > If I understood your point correctly, you did not like the format of
> > TP_printk() here, right? So how about if I remove the 'struct
> > rtc_time' and just pass one 'ktime_t' parameter? But it will be not
> > readable for user to trace the RTC time/alarm.
> >

> >>
> >> How bad would that be to change it later? I didn't follow the whole
> >> tracepoint ABI issue closely.
> 
> There is no general rule here other than "if it breaks for existing
> users, we have to fix it". Anyone who uses the tracepoints correctly
> would end up showing zero-date if we change all the fields, but
> it should not crash here.
> 
> Printing a time64_t instead of rtc_time may be better here, as it's
> cheaper to convert rtc_time to time64_t that vice versa. User space
> looking at the trace data can then do the conversion back to struct tm
> for printing in a C program or using /bin/date from a shell
> script, but I agree it's an extra step.
> 
> It's also possible that we don't care about the overhead of doing
> a time64_to_tm() or rtc_time64_to_tm() in the trace function, as long
> as that only needs to be done if the tracepoint is active. I find trace
> points a bit confusing, so I don't know if that is the case or not when
> the tracepoint is compiled into the kernel but disabled at run time.
> 

Sorry, I was not clear and I never actually used tracepoints.

My point was that the printk format is nice and can probably be kept as
is. But I would like tracepoint to take a time64_t instead of an rtc_time even
if that means having a conversion before calling the tracepoint and
converting back to display the date/time.

Also, I think we could try having only the time64_t in the ring buffer.
Maybe I'm wrong but I think tools reading that buffer can do the
conversion themselves. Maybe I don't understand correctly how
tracepoints work and this doesn't make sense, tell me.

The printk patches I was referring to are:
https://marc.info/?l=linux-rtc&m=149693060517054&w=2
But they don't provide a way to pretty print a time64_t yet (it was just
suggested by Arnd).

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
