Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBBMXQDDAKGQELCNHUHY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id n128si673088wmf.2.2017.03.08.05.47.49
        for <rtc-linux@googlegroups.com>;
        Wed, 08 Mar 2017 05:47:49 -0800 (PST)
Date: Wed, 8 Mar 2017 14:47:48 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: "Hadimani, Jagadish" <Jagadish.Hadimani@amd.com>
Cc: "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
	"a.zummo@towertech.it" <a.zummo@towertech.it>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [rtc-linux] Re: Kernel without RTC
Message-ID: <20170308134748.yk52f7aqm7d4kwdg@piout.net>
References: <221f9318-749f-03b8-aac8-85e9f9bec318@amd.com>
 <20170308131730.zrznsnk5oldfuoib@piout.net>
 <016032B5-A966-48A9-B60D-AD75B8B857EE@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <016032B5-A966-48A9-B60D-AD75B8B857EE@amd.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 08/03/2017 at 13:33:33 +0000, Hadimani, Jagadish wrote:
> Hello Alexandre,
> 
> I guess the Linux kernel uses HPET timer...
> But can we can force Linux kernel to use Tsc or per core timer...
> 

That is probably the case but your are targeting the wrong subsystem.
The timekeeping is done using two different devices: clocksource and
clockevent. Usually, the drivers are in drivers/clocksource. I'm
definitively not an expert in x86 but the clockevent seems to be
registered from arch/x86/kernel/hpet.c and the clocksource from
arch/x86/kernel/tsc.c

IIRC the clocksource is optional but the clockevent is mandatory so if
you don't have an HPET, you will need to register a clockevent device
from somewhere else.

Maybe the simplest thing to do is to ask the x86 maintainers and the
time maintainers. Luckily for you, they are the same people (Thomas and
Ingo, added in cc).


> Sent from my iPhone
> 
> > On 8 Mar 2017, at 6:47 PM, Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
> > 
> > Hi,
> > 
> >> On 07/03/2017 at 00:48:18 +0530, Shah, Nehal-bakulchandra wrote:
> >> Hi,
> >> 
> >> Currently we are having hardware which does not have RTC. It is single processor system. However it does have TSC timer.
> >> 
> >> Now, how to use scheduler with only TSC as current kernel scheduler leverage the RTC for scheduling? I had seen one old patch
> >> 
> >> http://marc.info/?l=linux-kernel&m=112013203625990&w=2 
> >> 
> >> But i guess this patch was later on not taken, It will be great if you can some pointers to move forward?
> >> 
> > 
> > The kernel doesn't use the RTC for its time source so it can
> > already work without an RTC.
> > 
> > 
> > -- 
> > Alexandre Belloni, Free Electrons
> > Embedded Linux and Kernel engineering
> > http://free-electrons.com

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
