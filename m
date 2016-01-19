Return-Path: <rtc-linux+bncBD2OLRXW4ABBB3OE662AKGQESTBDIQQ@googlegroups.com>
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com. [216.228.121.143])
        by gmr-mx.google.com with ESMTPS id i25si2879965pfj.2.2016.01.18.23.14.51
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2016 23:14:51 -0800 (PST)
Message-ID: <569DDFEE.4080307@nvidia.com>
Date: Tue, 19 Jan 2016 12:34:14 +0530
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
	Mallikarjun Kasoju <mkasoju@nvidia.com>
Subject: [rtc-linux] Re: [PATCH V3 5/5] regulator: max77620: add regulator
 driver for max77620/max20024
References: <1452771166-13694-1-git-send-email-ldewangan@nvidia.com> <1452771166-13694-6-git-send-email-ldewangan@nvidia.com> <569DC9AD.7000504@samsung.com>
In-Reply-To: <569DC9AD.7000504@samsung.com>
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

Thanks for review.
Here is my view on the some of the review comment.

On Tuesday 19 January 2016 10:59 AM, Krzysztof Kozlowski wrote:
> On 14.01.2016 20:32, Laxman Dewangan wrote:

> +	return ret;
> +}
> +
> +static int max77620_init_pmic(struct max77620_regulator *pmic, int id)
> +{
> This function seems to be used only from max77620_of_parse_cb(). I would
> find easier to read if this was located before definition of
> max77620_of_parse_cb(). Can you move it (or you had other idea of
> placing algorithm)?

I wanted to keep all local function on top which is used on this file 
and not the regulator ops.
Then implement regulator ops and then probe.
Let me see if I can do anything here.

>
>> +		     pmic->enable_power_mode[id]) {
>> +			ret = max77620_regulator_set_power_mode(
>> +					pmic, pmic->enable_power_mode[id], id);
> The 'pmic' argument should be after opening parenthesis, not at new line.

This is done for indenting alignment. I am using checkpatch --strict 
option and for this the next line should be on same column of first 
charcter after opening parenthesis.
To avoid this error, if we want to re-align the indenting for next line 
then left the line empty after "(".

+
+static int __init max77620_regulator_init(void)
+{
+	return platform_driver_register(&max77620_regulator_driver);
+}
+subsys_initcall(max77620_regulator_init);
+

> Does it have to be subsys_initcall? Any special requirements for
> ordering the drivers? Probe deferring is encouraged instead.
>
>


This is to make sure th regulators are ready before other driver get 
probed. This is basic need of some of driver and hence subsys_initcall.
I will move to module_init() as some of other PMIC driver (as3722) is in 
the module init and used in tegra platform so not seeing much issue on this.


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
