Return-Path: <rtc-linux+bncBDJLF25T6MIBBTMOWKVAKGQERFGSH3I@googlegroups.com>
Received: from lb1-smtp-cloud3.xs4all.net (lb1-smtp-cloud3.xs4all.net. [194.109.24.22])
        by gmr-mx.google.com with ESMTPS id k2si416157wif.0.2015.05.08.02.52.12
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 08 May 2015 02:52:13 -0700 (PDT)
Message-ID: <1431078730.13593.14.camel@x220>
Subject: [rtc-linux] Re: [PATCH 03/12] clocksource: sti: Provide 'use timer as
 sched clock' capability
From: Paul Bolle <pebolle@tiscali.nl>
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@stlinux.com, devicetree@vger.kernel.org, daniel.lezcano@linaro.org,
 tglx@linutronix.de, wim@iguana.be, a.zummo@towertech.it,
 linux-watchdog@vger.kernel.org, rtc-linux@googlegroups.com,
 linux@roeck-us.net
Date: Fri, 08 May 2015 11:52:10 +0200
In-Reply-To: <20150508093603.GB29044@x1>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
	 <1431005924-21777-4-git-send-email-lee.jones@linaro.org>
	 <1431074699.13593.4.camel@x220> <20150508093603.GB29044@x1>
Content-Type: text/plain; charset=UTF-8
Mime-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Fri, 2015-05-08 at 10:36 +0100, Lee Jones wrote:
> On Fri, 08 May 2015, Paul Bolle wrote:
> > On Thu, 2015-05-07 at 14:38 +0100, Lee Jones wrote:
> > > --- a/drivers/clocksource/Kconfig
> > > +++ b/drivers/clocksource/Kconfig
> > 
> > > +config CLKSRC_ST_LPC_TIMER_SCHED_CLOCK
> > > +	bool
> > > +	depends on CLKSRC_ST_LPC
> > > +	default y
> > > +	help
> > > +	  Use Low Power controller timer clock source as sched_clock
> > 
> > This adds, as far as I can see, a Kconfig symbol that will always be in
> > lockstep with CLKSRC_ST_LPC. Ie, CLKSRC_ST_LPC and
> > CLKSRC_ST_LPC_TIMER_SCHED_CLOCK will always both be 'n' or both be 'y'.
> > 
> > Are there plans to break that lockstep in the future?
> 
> What's stopping CONFIG_CLKSRC_ST_LPC_TIMER_SCHED_CLOCK=n?

If CLKSRC_ST_LPC=y you mean? The lack of a prompt, I'd say. Ie, you
would need
	bool "A very short description"

to be able to set these independently.

But now I notice that I missed that there appears to be a problem with
CLKSRC_ST_LPC too. I'll reply to 2/12 shortly.

Thanks,


Paul Bolle

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
