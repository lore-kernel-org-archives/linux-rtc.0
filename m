Return-Path: <rtc-linux+bncBDS7HNEFSALRBWGF3C2AKGQEJIELO4Y@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id v7si34078wmg.3.2016.01.13.02.11.36
        for <rtc-linux@googlegroups.com>;
        Wed, 13 Jan 2016 02:11:36 -0800 (PST)
Date: Wed, 13 Jan 2016 11:11:35 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	linus.walleij@linaro.org, gnurou@gmail.com, lee.jones@linaro.org,
	broonie@kernel.org, a.zummo@towertech.it, lgirdwood@gmail.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, rtc-linux@googlegroups.com,
	swarren@nvidia.com, treding@nvidia.com,
	Chaitanya Bandi <bandik@nvidia.com>,
	Mallikarjun Kasoju <mkasoju@nvidia.com>
Subject: [rtc-linux] Re: [PATCH V2 2/6] mfd: max77620: add core driver for MAX77620/MAX20024
Message-ID: <20160113101135.GI3367@piout.net>
References: <1452590273-16421-1-git-send-email-ldewangan@nvidia.com>
 <1452590273-16421-3-git-send-email-ldewangan@nvidia.com>
 <56959E9A.3060903@samsung.com>
 <5696122A.6000509@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <5696122A.6000509@nvidia.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 13/01/2016 at 14:30:26 +0530, Laxman Dewangan wrote :
> In my 3rd patch, I tried to align it little more where is possible. But I
> feel that all these indenting is more over individual choice. Example, I
> added one more indent in below example to look better.
> 
> 
>         ret = max77620_reg_update(chip->dev, MAX77620_PWR_SLAVE,
> -               MAX77620_REG_ONOFFCNFG2, MAX77620_ONOFFCNFG2_WK_EN0,
> -               MAX77620_ONOFFCNFG2_WK_EN0);
> +                       MAX77620_REG_ONOFFCNFG2, MAX77620_ONOFFCNFG2_WK_EN0,
> +                       MAX77620_ONOFFCNFG2_WK_EN0);
> 
> 

You should probably use checkpatch.pl --strict, it requires that you
align on the open parenthesis.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
