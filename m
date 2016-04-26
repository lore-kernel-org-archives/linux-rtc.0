Return-Path: <rtc-linux+bncBCQPVKWLVAIRBSUX724AKGQE6XWUESA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from muru.com (muru.com. [72.249.23.125])
        by gmr-mx.google.com with ESMTP id yr8si376895pac.0.2016.04.26.08.39.53
        for <rtc-linux@googlegroups.com>;
        Tue, 26 Apr 2016 08:39:54 -0700 (PDT)
Date: Tue, 26 Apr 2016 08:39:48 -0700
From: Tony Lindgren <tony@atomide.com>
To: Marcin Niestroj <m.niestroj@grinn-global.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>,
	rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org,
	Dave Gerlach <d-gerlach@ti.com>, "Menon, Nishanth" <nm@ti.com>
Subject: [rtc-linux] Re: [PATCH] rtc: omap: Support ext_wakeup configuration
Message-ID: <20160426153948.GR5995@atomide.com>
References: <1459785403-1725-1-git-send-email-m.niestroj@grinn-global.com>
 <20160404224046.GA17042@atomide.com>
 <57078A89.3080809@ti.com>
 <20160408151408.GS16484@atomide.com>
 <5707E764.7050204@ti.com>
 <570D2F79.9040202@grinn-global.com>
 <57111AF4.6070505@ti.com>
 <fe6ab23a-5f0d-a317-14d9-f538c3ad4052@grinn-global.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <fe6ab23a-5f0d-a317-14d9-f538c3ad4052@grinn-global.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

* Marcin Niestroj <m.niestroj@grinn-global.com> [160426 00:40]:
> In below code we check reg resource size in order to know if we
> should update RTC_PMIC or it is pinctrl responsibility. It's a little
> hack, but we make sure, that every device with not modified device-tree
> will work as previously. If we want to add support for ext_wakeup, we
> just change reg resouce size in device-tree in order to not overlap
> requested memory regions in rtc-omap and pinctrl.
> 
> I used am335x-chilisom instead of dra7 and updated
> pinctrl-single,funcion-mask so the EXT_WAKEUP_STATUS is always cleared
> after boot.
> 
> So the question now is: is this acceptable? Do we want to continue with
> this approach?

Well the concern I have here is that we not use pinctrl-single
as a separate driver if any of the registers are shared with
the RTC driver. If the registers are shared, the pinctrl
functionality should be implemented in the RTC driver.

The pinctrl driver can also implement a chained IRQ later
on for consumer device drivers to use with the wakeirq API.
Maybe eventually we'll have real chained interrupt for the
RTC to use from Linux side of the C-M3 driver.

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
