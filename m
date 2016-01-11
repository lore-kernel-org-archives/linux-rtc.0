Return-Path: <rtc-linux+bncBD2OLRXW4ABBBZUGZ22AKGQEZF523VI@googlegroups.com>
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com. [216.228.121.64])
        by gmr-mx.google.com with ESMTPS id 190si620366pfb.1.2016.01.11.02.26.46
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jan 2016 02:26:46 -0800 (PST)
Message-ID: <569380FE.6020609@nvidia.com>
Date: Mon, 11 Jan 2016 15:46:30 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Mark Brown <broonie@kernel.org>
CC: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<linus.walleij@linaro.org>, <gnurou@gmail.com>, <lee.jones@linaro.org>,
	<a.zummo@towertech.it>, <alexandre.belloni@free-electrons.com>,
	<lgirdwood@gmail.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<rtc-linux@googlegroups.com>, <swarren@nvidia.com>, <treding@nvidia.com>,
	Mallikarjun Kasoju <mkasoju@nvidia.com>
Subject: [rtc-linux] Re: [PATCH 6/6] regulator: max77620: add regulator driver
 for max77620/max20024
References: <1452177524-23192-1-git-send-email-ldewangan@nvidia.com> <1452177524-23192-7-git-send-email-ldewangan@nvidia.com> <20160110124014.GZ6588@sirena.org.uk>
In-Reply-To: <20160110124014.GZ6588@sirena.org.uk>
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

Thanks Mark for review.

I have query in one of comment.

On Sunday 10 January 2016 06:10 PM, Mark Brown wrote:
> * PGP Signed by an unknown key
>
> On Thu, Jan 07, 2016 at 08:08:44PM +0530, Laxman Dewangan wrote:
>
>
> +	np = of_get_child_by_name(pdev->dev.parent->of_node, "regulators");
> +	if (!np) {
> +		dev_err(&pdev->dev, "Device is not having regulators node\n");
> +		return -ENODEV;
> +	}
> +	pdev->dev.of_node = np;
> +
> +	ret = of_regulator_match(&pdev->dev, np, max77620_regulator_matches,
> +			ARRAY_SIZE(max77620_regulator_matches));
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Parsing of regulator node failed: %d\n",
> +			ret);
> +		return ret;
> +	}
> Don't open code this, use the core support via regulators and of_match.
>

I did not get this point? Here I am using the of_regulator_match from 
core? Can you please help to explain this?

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
