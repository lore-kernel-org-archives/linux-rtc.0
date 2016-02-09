Return-Path: <rtc-linux+bncBD2OLRXW4ABBBOME5C2QKGQEUSQZY4Y@googlegroups.com>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com. [216.228.121.65])
        by gmr-mx.google.com with ESMTPS id 12si4695977pfb.1.2016.02.09.07.14.01
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2016 07:14:01 -0800 (PST)
Message-ID: <56B9FF80.7010107@nvidia.com>
Date: Tue, 9 Feb 2016 20:32:24 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<linus.walleij@linaro.org>, <gnurou@gmail.com>, <lee.jones@linaro.org>,
	<broonie@kernel.org>, <a.zummo@towertech.it>,
	<alexandre.belloni@free-electrons.com>
CC: <lgirdwood@gmail.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<rtc-linux@googlegroups.com>, <swarren@nvidia.com>, <treding@nvidia.com>,
	<k.kozlowski@samsung.com>, <vreddytalla@nvidia.com>, Mallikarjun Kasoju
	<mkasoju@nvidia.com>
Subject: [rtc-linux] Re: [PATCH V7 8/8] regulator: max77620: add regulator
 driver for max77620/max20024
References: <1454171931-27752-1-git-send-email-ldewangan@nvidia.com> <1454171931-27752-9-git-send-email-ldewangan@nvidia.com>
In-Reply-To: <1454171931-27752-9-git-send-email-ldewangan@nvidia.com>
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

Hi Mark,

I have taken care of all your previous comment on this patch.

Can you please review?

I got the macro from Lee's and spinning the V8 of this series so if 
there is any thing, I can take care on my next version.

Thanks,
Laxman


On Saturday 30 January 2016 10:08 PM, Laxman Dewangan wrote:
> MAXIM Semiconductor's PMIC, MAX77620 and MAX20024 have the
> multiple DCDC and LDOs. This supplies the power to different
> components of the system.
> Also these rails has configuration for ramp time, flexible
> power sequence, slew rate etc.
>
> Add regulator driver to access these rails via regulator APIs.
>
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Signed-off-by: Mallikarjun Kasoju <mkasoju@nvidia.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>
> - Cleanup code based on comment received on mfd/rtc.
> - Avoid duplication on error message.
>
> Changes form V2:
> - Run coccicheck and checkpatch in strict mode for the alignment.
> - Refactor Regulator driver to use core API for DT parsing.
> - Update based on API changes.
>
> Changes from V3:
> - Change all sys initcall to module driver.
> - change the max77620_read argument to unisgned int from u8.
>   
> Changes from V4:
> - Added DT binding document as devicetree/bindings/regulator/regulator-max77620.txt
> - Detail out properties.
>
> Changes from V5:
> - Separate out DT binding doc for regulator.
>
> Changes from V6:
> - Use direct regmap APIs.
> - Drop active-discharge configuration as it wil be move to core and through
>    callback. Follow on patches are palnned for this.
>

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
