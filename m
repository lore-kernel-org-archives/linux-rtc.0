Return-Path: <rtc-linux+bncBDAMN6NI5EERB5F3QDDAKGQEUQYNW7Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from Galois.linutronix.de (Galois.linutronix.de. [2a01:7a0:2:106d:700::1])
        by gmr-mx.google.com with ESMTPS id n128si702495wmf.2.2017.03.08.07.06.28
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Mar 2017 07:06:28 -0800 (PST)
Date: Wed, 8 Mar 2017 16:06:23 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
cc: "Hadimani, Jagadish" <Jagadish.Hadimani@amd.com>,
    "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
    "a.zummo@towertech.it" <a.zummo@towertech.it>,
    "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
    Ingo Molnar <mingo@kernel.org>
Subject: [rtc-linux] Re: Kernel without RTC
In-Reply-To: <20170308134748.yk52f7aqm7d4kwdg@piout.net>
Message-ID: <alpine.DEB.2.20.1703081602460.3521@nanos>
References: <221f9318-749f-03b8-aac8-85e9f9bec318@amd.com> <20170308131730.zrznsnk5oldfuoib@piout.net> <016032B5-A966-48A9-B60D-AD75B8B857EE@amd.com> <20170308134748.yk52f7aqm7d4kwdg@piout.net>
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

On Wed, 8 Mar 2017, Alexandre Belloni wrote:
> On 08/03/2017 at 13:33:33 +0000, Hadimani, Jagadish wrote:
> > Hello Alexandre,
> > 
> > I guess the Linux kernel uses HPET timer...
> > But can we can force Linux kernel to use Tsc or per core timer...
> > 
> 
> That is probably the case but your are targeting the wrong subsystem.
> The timekeeping is done using two different devices: clocksource and
> clockevent. Usually, the drivers are in drivers/clocksource. I'm
> definitively not an expert in x86 but the clockevent seems to be
> registered from arch/x86/kernel/hpet.c and the clocksource from
> arch/x86/kernel/tsc.c
> 
> IIRC the clocksource is optional but the clockevent is mandatory so if
> you don't have an HPET, you will need to register a clockevent device
> from somewhere else.
> 
> Maybe the simplest thing to do is to ask the x86 maintainers and the
> time maintainers. Luckily for you, they are the same people (Thomas and
> Ingo, added in cc).

The scheduler uses TSC anyway.

The RTC is only used for setting the wall clock time at boot and for
figuring out the time a system spent in suspend. If you don't have an RTC
then the boot wall clock time will be simply 1/1/1970 00:00:00.

Jagadish, can you please explain what your problem is. Does the system fail
to boot or does it behave strange or what?

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
