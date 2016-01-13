Return-Path: <rtc-linux+bncBD2OLRXW4ABBBGFJ3C2AKGQECWHDZYA@googlegroups.com>
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com. [216.228.121.143])
        by gmr-mx.google.com with ESMTPS id a76si29551pfj.2.2016.01.13.01.10.48
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jan 2016 01:10:48 -0800 (PST)
Message-ID: <5696122A.6000509@nvidia.com>
Date: Wed, 13 Jan 2016 14:30:26 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, <robh+dt@kernel.org>,
	<pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<linus.walleij@linaro.org>, <gnurou@gmail.com>, <lee.jones@linaro.org>,
	<broonie@kernel.org>, <a.zummo@towertech.it>,
	<alexandre.belloni@free-electrons.com>
CC: <lgirdwood@gmail.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<rtc-linux@googlegroups.com>, <swarren@nvidia.com>, <treding@nvidia.com>,
	Chaitanya Bandi <bandik@nvidia.com>, Mallikarjun Kasoju <mkasoju@nvidia.com>
Subject: [rtc-linux] Re: [PATCH V2 2/6] mfd: max77620: add core driver for MAX77620/MAX20024
References: <1452590273-16421-1-git-send-email-ldewangan@nvidia.com> <1452590273-16421-3-git-send-email-ldewangan@nvidia.com> <56959E9A.3060903@samsung.com>
In-Reply-To: <56959E9A.3060903@samsung.com>
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


On Wednesday 13 January 2016 06:17 AM, Krzysztof Kozlowski wrote:
> On 12.01.2016 18:17, Laxman Dewangan wrote:

>> +	}
>> +	dev_dbg(chip->dev, "NVERC = 0x%02x\n", val);
>> +	for (i = 0; i < 8; ++i) {
>> +		if (val & BIT(i))
>> +			dev_info(chip->dev, "NVERC: %s\n", max77620_nverc[i]);
> You are still printing two dev_info (OTP, ES) and here NVERC (probably
> one?). This will be printed on each boot, over and over, till the user
> will learn it and will remember it forever :).
>
>  From my point of view: one dev_info for one probed device.
>
> I don't know if others agree with that, though. What's your opinion Lee?

OK, I make single line print for OTP and ES version.
I remove the NVREC reading and printing as this is read on clear and 
better to move on uboot for this prints.


>
>
> +
> +	ret = regmap_add_irq_chip(chip->rmap[MAX77620_PWR_SLAVE],
> +		chip->chip_irq, IRQF_ONESHOT | IRQF_SHARED, chip->irq_base,
> Why do you need IRQF_SHARED?

In one of my design,  I have three PMICs, one MAX77620, two MAX77621. 
MAX77621 alert an MAX77620 interrupt line is tied and going to single 
interrupt of SoC.

To register same interrupt from all driver, I made it SHARED.

This is per discussion on the other patch
regulator: max8973: add support for junction thermal warning


>> +		&max77620_top_irq_chip, &chip->top_irq_data);
> More tabs needed for indentation of arguments.
>
> Actually the alignment of arguments here is mixed. Sometimes arguments
> are aligned with opening parenthesis, mostly not. Can you make it
> consistent - always aligned?


In my 3rd patch, I tried to align it little more where is possible. But 
I feel that all these indenting is more over individual choice. Example, 
I added one more indent in below example to look better.


         ret = max77620_reg_update(chip->dev, MAX77620_PWR_SLAVE,
-               MAX77620_REG_ONOFFCNFG2, MAX77620_ONOFFCNFG2_WK_EN0,
-               MAX77620_ONOFFCNFG2_WK_EN0);
+                       MAX77620_REG_ONOFFCNFG2, MAX77620_ONOFFCNFG2_WK_EN0,
+                       MAX77620_ONOFFCNFG2_WK_EN0);



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
