Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750916AbdLMQpN (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 13 Dec 2017 11:45:13 -0500
Date: Wed, 13 Dec 2017 11:45:09 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Baolin Wang <baolin.wang@linaro.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Ingo Molnar <mingo@redhat.com>, linux-rtc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] rtc: Add tracepoints for RTC system
Message-ID: <20171213114509.33006be6@gandalf.local.home>
In-Reply-To: <CAK8P3a06svzg8mG1Gw9n9tqsr6rNmkzLLvirWP6wZdnCm=5_CA@mail.gmail.com>
References: <64a38f4a15a2f8dae4a9fd0a3fc2a312e86c733d.1510749847.git.baolin.wang@linaro.org>
        <20171212221643.GL8318@piout.net>
        <CAMz4ku+Hpbb+4Wj2auFFf7NGdd95VN6L8y5ONEqt3utndzUjVQ@mail.gmail.com>
        <CAK8P3a06svzg8mG1Gw9n9tqsr6rNmkzLLvirWP6wZdnCm=5_CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Wed, 13 Dec 2017 09:33:23 +0100
Arnd Bergmann <arnd@arndb.de> wrote:


> >> How bad would that be to change it later? I didn't follow the whole
> >> tracepoint ABI issue closely.  
> 
> There is no general rule here other than "if it breaks for existing
> users, we have to fix it". Anyone who uses the tracepoints correctly
> would end up showing zero-date if we change all the fields, but
> it should not crash here.

But if a tool depends on that value correct, that still is a user space
breakage, even though it was using tracepoints correctly.

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

Everything that is done in TP_fast_assign() is only performed when the
tracepoint is active. It adds no more overhead when tracing is
disabled, as tracepoints incorporate jump labels, and the call itself
is a nop. As long as the parameters to the trace_*() functions don't do
logic, all should be fine: like if you had:

  trace_rtc_set_alarm(call_some_function_to_return_tm(), err);

gcc could make that call_some_function_to_return_tm() happen even when
the tracepoint is not enabled. But that's not the case with this patch.

-- Steve
