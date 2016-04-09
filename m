Return-Path: <rtc-linux+bncBCQPVKWLVAIRB5HBUS4AKGQEG5BYMYY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from muru.com (muru.com. [72.249.23.125])
        by gmr-mx.google.com with ESMTP id y20si751548pfa.2.2016.04.09.09.42.27
        for <rtc-linux@googlegroups.com>;
        Sat, 09 Apr 2016 09:42:28 -0700 (PDT)
Date: Sat, 9 Apr 2016 09:42:20 -0700
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
Message-ID: <20160409164220.GA16484@atomide.com>
References: <1459785403-1725-1-git-send-email-m.niestroj@grinn-global.com>
 <20160404224046.GA17042@atomide.com>
 <57078A89.3080809@ti.com>
 <20160408151408.GS16484@atomide.com>
 <5707E764.7050204@ti.com>
 <20160408175114.GX16484@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160408175114.GX16484@atomide.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

* Tony Lindgren <tony@atomide.com> [160408 10:52]:
> * Grygorii Strashko <grygorii.strashko@ti.com> [160408 10:17]:
> > 
> > It can't :( It can't generate IRQ when state of ext_wakeup line has 
> > been changed.
> 
> Hmm to me it certainly seems it should be capable of generating and RTC
> interrupt as we have EXT_WAKEUP_STATUS register containing four bits,
> one for each wakeup line.

So I played a bit with RTC last night and the RTC_PMIC_REG options..
And I came to the same conclusion as Grygorii pretty much. It looks
like an interrupt, except it can't generate any interrupts. Sorry
for not believing it earlier. It might still be a good idea to
confirm this with some hardware folks at TI, maybe newer versions
could add support for an interrupt.

The EXT_WAKEUP configuration only seems to affect pmic_pwr_enable
pin if configured right. Depending on the PMIC, we could use a
shared interrupt for handling the ext wakeup line changes in the
RTC driver.

The ext wakeup lines are not really GPIOs either as we can't
monitor the wakeup line states, they are just trigger and then
hold the state until cleared.

If we ever need to provide the state of the wakeup lines to the
other drivers, we could still use GPIO, input, or pinctrl. All
these allow adding interrupt support for the cases that allow
sharing the interrupt with PMIC.

I guess we should just pick the framework that already has support
for configuring the debounce time for a pin.

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
