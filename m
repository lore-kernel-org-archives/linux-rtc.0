Return-Path: <rtc-linux+bncBCQPVKWLVAIRBR4VT64AKGQE373JRIA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from muru.com (muru.com. [72.249.23.125])
        by gmr-mx.google.com with ESMTP id y20si161836pfa.2.2016.04.08.08.14.14
        for <rtc-linux@googlegroups.com>;
        Fri, 08 Apr 2016 08:14:15 -0700 (PDT)
Date: Fri, 8 Apr 2016 08:14:09 -0700
From: Tony Lindgren <tony@atomide.com>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Marcin Niestroj <m.niestroj@grinn-global.com>,
	rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org,
	Dave Gerlach <d-gerlach@ti.com>, "Menon, Nishanth" <nm@ti.com>
Subject: [rtc-linux] Re: [PATCH] rtc: omap: Support ext_wakeup configuration
Message-ID: <20160408151408.GS16484@atomide.com>
References: <1459785403-1725-1-git-send-email-m.niestroj@grinn-global.com>
 <20160404224046.GA17042@atomide.com>
 <57078A89.3080809@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <57078A89.3080809@ti.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

* Grygorii Strashko <grygorii.strashko@ti.com> [160408 03:41]:
> Hi Tony,
> 
> On 04/05/2016 01:40 AM, Tony Lindgren wrote:
> > Hi,
> > 
> > * Marcin Niestroj <m.niestroj@grinn-global.com> [160404 08:57]:
> >> Support configuration of ext_wakeup sources. This patch makes it
> >> possible to enable ext_wakeup and set it's polarity, depending on board
> >> configuration. AM335x's dedicated PMIC (tps65217) uses ext_wakeup to
> >> notify about power-button presses. Handling power-button presses enables
> >> to recover from RTC-only power states correctly.
> > 
> > I suggest you just set this pin up as a minimal gpiochip. That way
> > we can use the standard binding :) And if we get lucky, this pin can
> > also trigger during runtime.
> > 
> 
> Following my comments on v2 of this patch I propose to rollback to
> this version of the patch.
> 
> It seems doesn't fit in gpiochip, it's more likely irqchip, but since
> rtc can't generate IRQ there are nor reasons for these genetic
> experiments and RTC's specific bindings looks more suitable, at least for me.

Hmm well gpiochips typically are irqchip too. IMO the generic binding
here sounds like "gpio-wakeup" as it's an input with polarity and with
an optional interrupt.

Plain irqchip would work too in this case if there are no other GPIO
specific features. Some other RTCs may have more GPIO like features.

In any case, setting the ext_wakeup up as an irqchip means that the
RTC controller can be used as a dedicated wakeirq with Linux :)

Are you guys sure there's no wake pin events during runtime? AFAIK
the RTCs just typically produce an interrupt when programmed to
do so, they don't know the state of the SoC.

Regards,

Tony

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
