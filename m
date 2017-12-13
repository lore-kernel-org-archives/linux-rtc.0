Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753356AbdLMQqc (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 13 Dec 2017 11:46:32 -0500
Date: Wed, 13 Dec 2017 11:46:29 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Brown <broonie@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Baolin Wang <baolin.wang@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Ingo Molnar <mingo@redhat.com>, linux-rtc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rtc: Add tracepoints for RTC system
Message-ID: <20171213114629.1beaa9c8@gandalf.local.home>
In-Reply-To: <20171213121603.GF6416@sirena.org.uk>
References: <64a38f4a15a2f8dae4a9fd0a3fc2a312e86c733d.1510749847.git.baolin.wang@linaro.org>
        <20171212221643.GL8318@piout.net>
        <CAMz4ku+Hpbb+4Wj2auFFf7NGdd95VN6L8y5ONEqt3utndzUjVQ@mail.gmail.com>
        <CAK8P3a06svzg8mG1Gw9n9tqsr6rNmkzLLvirWP6wZdnCm=5_CA@mail.gmail.com>
        <20171213110426.GQ8318@piout.net>
        <20171213121603.GF6416@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Wed, 13 Dec 2017 12:16:03 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Wed, Dec 13, 2017 at 12:04:26PM +0100, Alexandre Belloni wrote:
> 
> > Also, I think we could try having only the time64_t in the ring buffer.
> > Maybe I'm wrong but I think tools reading that buffer can do the
> > conversion themselves. Maybe I don't understand correctly how
> > tracepoints work and this doesn't make sense, tell me.  
> 
> Tools reading the buffer can do the conversion themselves but it's also
> useful for users to just view the log directly via tracing/trace
> sometimes.  OTOH the whole point is to be low overhead so...

Ideally, we want TP_fast_assign() do as little as possible, and put all
the work in TP_printk() as the printk happens on read of the trace
buffer and TP_fast_assign() happens at the tracepoint invocation.

-- Steve
