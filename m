Return-Path: <rtc-linux+bncBAABBGEVT24AKGQE6STUKNY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from comal.ext.ti.com (comal.ext.ti.com. [198.47.26.152])
        by gmr-mx.google.com with ESMTPS id xg10si133055igb.0.2016.04.08.03.40.24
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 08 Apr 2016 03:40:24 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH] rtc: omap: Support ext_wakeup configuration
To: Tony Lindgren <tony@atomide.com>,
        Marcin Niestroj
	<m.niestroj@grinn-global.com>
References: <1459785403-1725-1-git-send-email-m.niestroj@grinn-global.com>
 <20160404224046.GA17042@atomide.com>
CC: <rtc-linux@googlegroups.com>, <devicetree@vger.kernel.org>,
        Rob Herring
	<robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Alessandro Zummo
	<a.zummo@towertech.it>,
        Alexandre Belloni
	<alexandre.belloni@free-electrons.com>,
        Keerthy <j-keerthy@ti.com>, <linux-omap@vger.kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>, "Menon,
 Nishanth" <nm@ti.com>
From: Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <57078A89.3080809@ti.com>
Date: Fri, 8 Apr 2016 13:40:09 +0300
MIME-Version: 1.0
In-Reply-To: <20160404224046.GA17042@atomide.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Tony,

On 04/05/2016 01:40 AM, Tony Lindgren wrote:
> Hi,
> 
> * Marcin Niestroj <m.niestroj@grinn-global.com> [160404 08:57]:
>> Support configuration of ext_wakeup sources. This patch makes it
>> possible to enable ext_wakeup and set it's polarity, depending on board
>> configuration. AM335x's dedicated PMIC (tps65217) uses ext_wakeup to
>> notify about power-button presses. Handling power-button presses enables
>> to recover from RTC-only power states correctly.
> 
> I suggest you just set this pin up as a minimal gpiochip. That way
> we can use the standard binding :) And if we get lucky, this pin can
> also trigger during runtime.
> 

Following my comments on v2 of this patch I propose to rollback to
this version of the patch.

It seems doesn't fit in gpiochip, it's more likely irqchip, but since
rtc can't generate IRQ there are nor reasons for these genetic
experiments and RTC's specific bindings looks more suitable, at least for me.


-- 
regards,
-grygorii

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
