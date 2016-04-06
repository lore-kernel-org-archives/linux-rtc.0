Return-Path: <rtc-linux+bncBCQPVKWLVAIRBYE6S24AKGQEELIK2PI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from muru.com (muru.com. [72.249.23.125])
        by gmr-mx.google.com with ESMTP id uh9si1599837igb.1.2016.04.06.15.36.15
        for <rtc-linux@googlegroups.com>;
        Wed, 06 Apr 2016 15:36:16 -0700 (PDT)
Date: Wed, 6 Apr 2016 15:36:13 -0700
From: Tony Lindgren <tony@atomide.com>
To: Marcin Niestroj <m.niestroj@grinn-global.com>
Cc: rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v2] rtc: omap: Support ext_wakeup configuration
Message-ID: <20160406223612.GH16484@atomide.com>
References: <1459960367-29399-1-git-send-email-m.niestroj@grinn-global.com>
 <1459960367-29399-2-git-send-email-m.niestroj@grinn-global.com>
 <20160406191103.GE27411@atomide.com>
 <57056352.1060801@grinn-global.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <57056352.1060801@grinn-global.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

* Marcin Niestroj <m.niestroj@grinn-global.com> [160406 12:29]:
> Hi,
> 
> On 06.04.2016 21:11, Tony Lindgren wrote:
> >* Marcin Niestroj <m.niestroj@grinn-global.com> [160406 09:34]:
> >>Support configuration of ext_wakeup sources. This patch makes it
> >>possible to enable ext_wakeup (and set it's polarity), depending on
> >>board configuration. AM335x's dedicated PMIC (tps65217) uses ext_wakeup
> >>in SLEEP mode (RTC-only) to notify about power-button presses. Handling
> >>power-button presses enables to recover from RTC-only power states
> >>correctly.
> >>
> >>Implementation uses gpiochip to utilize standard bindings. However,
> >>configuration is possible only using device-tree (no runtime changes).
> >
> >Hey looks good to me, adding linux-omap list to Cc.
> >
> >Can you please check that the "depends on GPIOLIB" does not disable
> >the RTC driver for omap1?
> 
> Looks ok for omap1. ARCH_OMAP1 selects ARCH_REQUIRE_GPIOLIB, which
> selects GPIOLIB.

OK thanks for checking.

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
