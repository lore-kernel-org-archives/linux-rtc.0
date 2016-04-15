Return-Path: <rtc-linux+bncBAABBAVWYS4AKGQE2C2PNPA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from comal.ext.ti.com (comal.ext.ti.com. [198.47.26.152])
        by gmr-mx.google.com with ESMTPS id uo2si922037igb.2.2016.04.15.09.46.57
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 15 Apr 2016 09:46:57 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH] rtc: omap: Support ext_wakeup configuration
To: Marcin Niestroj <m.niestroj@grinn-global.com>,
        Tony Lindgren
	<tony@atomide.com>
References: <1459785403-1725-1-git-send-email-m.niestroj@grinn-global.com>
 <20160404224046.GA17042@atomide.com> <57078A89.3080809@ti.com>
 <20160408151408.GS16484@atomide.com> <5707E764.7050204@ti.com>
 <570D2F79.9040202@grinn-global.com>
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
Message-ID: <57111AF4.6070505@ti.com>
Date: Fri, 15 Apr 2016 19:46:44 +0300
MIME-Version: 1.0
In-Reply-To: <570D2F79.9040202@grinn-global.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 04/12/2016 08:25 PM, Marcin Niestroj wrote:
> Hi,
> 
> On 08.04.2016 19:16, Grygorii Strashko wrote:
>> On 04/08/2016 06:14 PM, Tony Lindgren wrote:
>>> * Grygorii Strashko <grygorii.strashko@ti.com> [160408 03:41]:
>>>> Hi Tony,
>>>>
>>>> On 04/05/2016 01:40 AM, Tony Lindgren wrote:
>>>>> Hi,
>>>>>
>>>>> * Marcin Niestroj <m.niestroj@grinn-global.com> [160404 08:57]:
>>>>>> Support configuration of ext_wakeup sources. This patch makes it
>>>>>> possible to enable ext_wakeup and set it's polarity, depending on 
>>>>>> board
>>>>>> configuration. AM335x's dedicated PMIC (tps65217) uses ext_wakeup to
>>>>>> notify about power-button presses. Handling power-button presses 
>>>>>> enables
>>>>>> to recover from RTC-only power states correctly.
>>>>>
>>>>> I suggest you just set this pin up as a minimal gpiochip. That way
>>>>> we can use the standard binding :) And if we get lucky, this pin can
>>>>> also trigger during runtime.
>>>>>
>>>>
>>>> Following my comments on v2 of this patch I propose to rollback to
>>>> this version of the patch.
>>>>
>>>> It seems doesn't fit in gpiochip, it's more likely irqchip, but since
>>>> rtc can't generate IRQ there are nor reasons for these genetic
>>>> experiments and RTC's specific bindings looks more suitable, at 
>>>> least for me.
>>>
>>> Hmm well gpiochips typically are irqchip too. IMO the generic binding
>>> here sounds like "gpio-wakeup" as it's an input with polarity and with
>>> an optional interrupt.
>>>
>>> Plain irqchip would work too in this case if there are no other GPIO
>>> specific features. Some other RTCs may have more GPIO like features.
>>>
>>> In any case, setting the ext_wakeup up as an irqchip means that the
>>> RTC controller can be used as a dedicated wakeirq with Linux :)
>>
>> It can't :( It can't generate IRQ when state of ext_wakeup line has
>> been changed.
>>
>>>
>>> Are you guys sure there's no wake pin events during runtime? AFAIK
>>> the RTCs just typically produce an interrupt when programmed to
>>> do so, they don't know the state of the SoC.
>>>
>>
>> I do not think that It can be fit in gpiochip or irqchip -
>> in my opinion right way is to proceed with bindings proposed by
>> Marcin in this patch v1.
>>
>> But, probably, it could fit in pinctrl:
>> - this is pin's configuration
>> - this is one-time configuration
>> - or - configuration which can be applied before suspend
>>    and resorted after suspend.
>>
>> if you still wanna try some generic framework.
>>
> 
> pinctrl bindings looks ok for our use case (enable/disable input,
> configure debounce), except I don't see any way to pass polarity
> (active low/high) to the driver.
> 

Below code is just a POC that pinctrl can be used here.
It does one time configuration at boot, but more sates can be added
- sleep, poweroff:

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 13ac882..9580c82 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1248,11 +1248,40 @@
 
                rtc: rtc@48838000 {
                        compatible = "ti,am3352-rtc";
-                       reg = <0x48838000 0x100>;
+                       reg = <0x48838000 0x98>;
                        interrupts = <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
                                     <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>;
                        ti,hwmods = "rtcss";
                        clocks = <&sys_32k_ck>;
+                       #address-cells = <1>;
+                       #size-cells = <1>;
+                       ranges;
+                       
+                       rtc_pmx: pinmux@48838098 {
+                               compatible = "pinctrl-single";
+                               reg = <0x48838098 0x8>;
+                               #address-cells = <1>;
+                               #size-cells = <0>;
+                               pinctrl-single,register-width = <32>;
+                               pinctrl-single,function-mask = <0x007fffff>;
+
+                               pinctrl-names = "default"/*, "sleep"*/;
+                               pinctrl-0 = <&rtc_default>;
+/*                             pinctrl-1 = <&rtc_sleep>;*/
+
+                               rtc_default: rtc_default {
+                                       pinctrl-single,pins = <
+                                               0x0 0x000B0111
+                                               0x4 0x00000004
+                                       >;
+                               };
+/*                             rtc_sleep: rtc_sleep {
+                                       pinctrl-single,pins = <
+                                               0x0 0x00000000
+                                               0x4 0x00000000
+                                       >;
+                               };*/
+                       };
                };
 
                /* OCP2SCP1 */
diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index ec2e9c5..28c67a4 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -428,8 +428,10 @@ static void omap_rtc_power_off(void)
 
        rtc->type->unlock(rtc);
        /* enable pmic_power_en control */
+/*
        val = rtc_readl(rtc, OMAP_RTC_PMIC_REG);
        rtc_writel(rtc, OMAP_RTC_PMIC_REG, val | OMAP_RTC_PMIC_POWER_EN_EN);
+*/
 
        /* set alarm two seconds from now */
        omap_rtc_read_time_raw(rtc, &tm);
@@ -650,6 +652,8 @@ static int omap_rtc_probe(struct platform_device *pdev)
                          reg | OMAP_RTC_OSC_SEL_32KCLK_SRC);
        }
 
+       of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
+
        rtc->type->lock(rtc);
 
        device_init_wakeup(&pdev->dev, true);
 

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
