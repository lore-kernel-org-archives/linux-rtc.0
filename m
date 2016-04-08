Return-Path: <rtc-linux+bncBCQPVKWLVAIRBR4NT64AKGQESUE6JKY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from muru.com (muru.com. [72.249.23.125])
        by gmr-mx.google.com with ESMTP id r4si123779pfr.1.2016.04.08.07.57.10
        for <rtc-linux@googlegroups.com>;
        Fri, 08 Apr 2016 07:57:10 -0700 (PDT)
Date: Fri, 8 Apr 2016 07:57:03 -0700
From: Tony Lindgren <tony@atomide.com>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Marcin Niestroj <m.niestroj@grinn-global.com>,
	rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: [rtc-linux] Re: [PATCH v2] rtc: omap: Support ext_wakeup configuration
Message-ID: <20160408145703.GR16484@atomide.com>
References: <1459960367-29399-1-git-send-email-m.niestroj@grinn-global.com>
 <1459960367-29399-2-git-send-email-m.niestroj@grinn-global.com>
 <20160406191103.GE27411@atomide.com>
 <57056352.1060801@grinn-global.com>
 <57063B1A.7080700@ti.com>
 <570694B0.4040500@grinn-global.com>
 <57077769.1050101@ti.com>
 <57078313.70803@grinn-global.com>
 <57078B16.2020402@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <57078B16.2020402@ti.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

* Grygorii Strashko <grygorii.strashko@ti.com> [160408 03:43]:
> On 04/08/2016 01:08 PM, Marcin Niestroj wrote:
> >>>>>>> @@ -18,8 +18,12 @@ Optional properties:
> >>>>>>>      through pmic_power_en
> >>>>>>>    - clocks: Any internal or external clocks feeding in to rtc
> >>>>>>>    - clock-names: Corresponding names of the clocks
> >>>>>>> +- gpio-controller: Mark as gpio controller when using ext_wakeup
> >>>>>>> +- #gpio-cells: Should be set to 2
> >>>>>>> +- ngpios: Number of ext_wakeup sources supported by processor 
> >>>>>>> (board)
> >>>>>>> +- ext-wakeup-gpios: List of ext_wakeup sources to configure

I think the naming standard here should be gpio-*, so in this
case gpio-wakeup.

> >>> We don't have power-button connected right to the processor. It is
> >>> connected to PMIC. During runtime we receive IRQs about power-button
> >>> from PMIC using i2c bus. The only purpose of this patch is to
> >>> configure processor's ext_wakeup line, which is triggered during
> >>> RTC-only mode (for example when power-button is pressed), causing
> >>> device wakeup. On the other hand, it is not possible to use ext_wakeup
> >>> during runtime, as we are only able to read it's status, but it
> >>> cannot trigger any interrupts.
> >>
> >> Sry, but I don't like this approach - it could make sense if RTC
> >> EXT_WAKEUP will be at least partially mapped on gpiolib interface.
> >> But your gpiochip is fake, you do not/can't use GPIO hogging mechanism
> >> and you're even parsing DT on your own (in V3).
> > 
> > With gpio hogging we can't pass polarity to the driver. It is hidden
> > in gpiolib.
> 
> kirkwood-openrd.dtsi-			p2 {
> kirkwood-openrd.dtsi:				gpio-hog;
> kirkwood-openrd.dtsi-				gpios = <2 GPIO_ACTIVE_HIGH>;
> 						[input;]
> 
> Sry, if you can't do smth like above - it's just prove that this approach is not right.

Yes let's stick to the standards. It should be using gpiolib interface.

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
