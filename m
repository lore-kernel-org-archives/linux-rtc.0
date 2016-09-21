Return-Path: <rtc-linux+bncBDAMN6NI5EERBYH6RG7QKGQEWQT4KEY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from Galois.linutronix.de (Galois.linutronix.de. [2a01:7a0:2:106d:700::1])
        by gmr-mx.google.com with ESMTPS id s6si1479491wmb.1.2016.09.21.05.38.56
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Sep 2016 05:38:56 -0700 (PDT)
Date: Wed, 21 Sep 2016 14:36:23 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Baolin Wang <baolin.wang@linaro.org>,
    Alessandro Zummo <a.zummo@towertech.it>,
    Alexandre Belloni <alexandre.belloni@free-electrons.com>,
    Ingo Molnar <mingo@redhat.com>, John Stultz <john.stultz@linaro.org>,
    Mark Brown <broonie@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
    rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 2/2] time: alarmtimer: Add the trcepoints for alarmtimer
In-Reply-To: <20160921083305.24524304@gandalf.local.home>
Message-ID: <alpine.DEB.2.20.1609211435050.5573@nanos>
References: <8c570c152c95087faa75e397c667b6d5b8d98b3b.1474177609.git.baolin.wang@linaro.org> <0d5cedb2f4ad46aa7fb07b990072bacb33517102.1474177609.git.baolin.wang@linaro.org> <alpine.DEB.2.20.1609202340560.5476@nanos> <CAMz4kuLYkyZzs33VKmo9B3JxTFFDYun7AHBYUUmHz=424yiq8g@mail.gmail.com>
 <alpine.DEB.2.20.1609210919390.5573@nanos> <20160921083305.24524304@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Wed, 21 Sep 2016, Steven Rostedt wrote:
> On Wed, 21 Sep 2016 09:26:20 +0200 (CEST)
> Thomas Gleixner <tglx@linutronix.de> wrote:
> > A single u64 does not take more storage space than this and it's a single
> > store.
> 
> So to use rtc_tm_to_time64()? Is the work to do the calculations of the
> conversion faster than a bunch of stores that are going to be in hot
> cache?

Look at the call site. It has already the scalar nsec value and it does a
conversion to rtc time in order to trace it.

Ditto for the other tracepoints where the conversion from scalar nsec is
done in the tracepoint itself.

Thanks,

	tglx

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
