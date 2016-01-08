Return-Path: <rtc-linux+bncBD2OLRXW4ABBBXE7X22AKGQESEBPCVY@googlegroups.com>
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com. [216.228.121.143])
        by gmr-mx.google.com with ESMTPS id dz2si5265787pab.1.2016.01.08.02.30.52
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jan 2016 02:30:52 -0800 (PST)
Message-ID: <568F8D7E.10500@nvidia.com>
Date: Fri, 8 Jan 2016 15:50:46 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	<rtc-linux@googlegroups.com>
CC: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<linus.walleij@linaro.org>, <gnurou@gmail.com>, <lee.jones@linaro.org>,
	<broonie@kernel.org>, <a.zummo@towertech.it>,
	<alexandre.belloni@free-electrons.com>, <lgirdwood@gmail.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>, <swarren@nvidia.com>, <treding@nvidia.com>,
	Chaitanya Bandi <bandik@nvidia.com>
Subject: Re: [rtc-linux] [PATCH 5/6] rtc: max77620: add support for
 max77620/max20024 RTC driver
References: <1452177524-23192-1-git-send-email-ldewangan@nvidia.com>	<1452177524-23192-6-git-send-email-ldewangan@nvidia.com> <CAJKOXPd938soaa5M0GFo5HpVCYzAS1w8j8Hko3Ja9mx47NYkEQ@mail.gmail.com>
In-Reply-To: <CAJKOXPd938soaa5M0GFo5HpVCYzAS1w8j8Hko3Ja9mx47NYkEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Krzysztof,
Thanks for review.

Accepted most of review comment and will update in next patch.

Answer to query:


On Friday 08 January 2016 07:33 AM, Krzysztof Kozlowski wrote:
> 2016-01-07 23:38 GMT+09:00 Laxman Dewangan <ldewangan@nvidia.com>:
> ---
>   drivers/rtc/Kconfig        |   9 +
>   drivers/rtc/Makefile       |   1 +
>   drivers/rtc/rtc-max77620.c | 574 +++++++++++++++++++++++++++++++++++++++++++++
> The driver (as most of Maxim's) looks quite similar to existing RTC
> driver, like max77802. It is difficult to spot the exact differences
> (I don't have 77620's datasheet) but I would suggest not duplicating
> the work. Maybe the biggest difference is the way you configure the
> regmap... but still sometimes the regmap config can be shared.
Yaah, that is the issue on IP based PMIC system and it happen with the 
Maxim and TI.
The MFD and its sub module drivers are too much couped  and hence 
dificult to use the IP driver across PMIC. For almost all Maxim PMIC, we 
end up of same type of RTC driver.

Probably, we need to enhance the mfd sub system to allow sub module 
driver to decoupe from its APIs.


+
+       rtc->irq = platform_get_irq(pdev, 0);
+       ret = devm_request_threaded_irq(&pdev->dev, rtc->irq, NULL,
+                       max77620_rtc_irq, IRQF_ONESHOT | IRQF_EARLY_RESUME,

> Why early resume?

When we go on suspend, the interrupts are masked by framework. For 
regmap-irq, it is stored on local reg value but not written into the 
PMIC register.
In Nvidia Tegra system, ARM GIC controller registered before the other 
interrupt controller like GPIO, PMIC etc.
When wakeup happened through RTC alarm, we get the interrupt from PMIC 
and on resume path, the PMIC isr handler get called after PMIC interrupt 
to the GIC is unmasked. But at this time, PMIC RTC alarm is still in 
masked state by regmap-irq which causes the interrupt to RTC ignore in 
the PMIC ISR handler and so RTC Isr did not get called and not cleared 
interrupt. This causes PMIC ISr handler to stuck on loop.

The need is to unmask the RTC alarm interrupt on PMIC interrupt driver 
before PMIC interrupt served so that we can have proper interrupt status 
in handler and rtc isr can get called.

For this, RTC alarm interrupt need to be EARLY_RESUME.


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
