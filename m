Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([185.11.138.130]:41270 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727189AbeHBNHJ (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Thu, 2 Aug 2018 09:07:09 -0400
From: Heiko Stuebner <heiko@sntech.de>
To: Tony Xie <tony.xie@rock-chips.com>
Cc: broonie@kernel.org, lee.jones@linaro.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenjh@rock-chips.com,
        xsf@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com
Subject: Re: [PATCH v2 3/5] dt-bindings: mfd: rk808: Add binding informations for RK809 and RK817.
Date: Thu, 02 Aug 2018 13:16:18 +0200
Message-ID: <2820701.ErqR8ge6r7@phil>
In-Reply-To: <1533023850-29004-4-git-send-email-tony.xie@rock-chips.com>
References: <1533023850-29004-1-git-send-email-tony.xie@rock-chips.com> <1533023850-29004-4-git-send-email-tony.xie@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi Tony,

Am Dienstag, 31. Juli 2018, 09:57:28 CEST schrieb Tony Xie:
> Add device tree bindings documentation for Rockchip's RK809 & RK817 PMIC.
> 
> Signed-off-by: Tony Xie <tony.xie@rock-chips.com>

I don't see the devicetree binding maintainers listed in the recipient
list, so adding them in the next iteration might increase your chances
to get an Ack on the binding.

scripts/get_maintainer.pl -f Documentation/devicetree/bindings lists

Rob Herring <robh+dt@kernel.org>
Mark Rutland <mark.rutland@arm.com>

as the main dt maintainers.

[...]

> @@ -99,6 +147,13 @@ number as described in RK818 datasheet.
>  	- HDMI_SWITCH
>  	- OTG_SWITCH
>  
> +There are three pins needed to config, named "gpio_ts" "gpio_gt" "gpio_slp".
> +	The gpio_gt and gpio_ts pins support the gpio function.
> +	The gpio_slp pin is for controlling the pmic states, as below:
> +		- reset
> +		- power down
> +		- sleep
> +

Is this common for all rk8xx pmics or just the two new ones?
As the paragraph above makes it sound like these are present on all
and I didn't find mention of them in the datasheets for previous pmics
I have.

Also to me it is not clear in what way these should be used and I didn't
find any mention of them at all in the rest of your series.


Heiko
