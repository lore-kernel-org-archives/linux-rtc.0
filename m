Return-Path: <rtc-linux+bncBDS7HNEFSALRBVWH7OVAKGQE54XGCQY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id q10si212990wiz.0.2015.05.22.01.07.50
        for <rtc-linux@googlegroups.com>;
        Fri, 22 May 2015 01:07:50 -0700 (PDT)
Date: Fri, 22 May 2015 10:07:49 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Frank.Li@freescale.com
Cc: lznuaa@gmail.com, shawn.guo@linaro.org, dmitry.torokhov@gmail.com,
	robh+dt@kernel.org, linux@arm.linux.org.uk,
	linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
	rtc-linux@googlegroups.com, devicetree@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v3 1/6] rtc: arm: imx: snvs: change use syscon
 to access register
Message-ID: <20150522080749.GI3244@piout.net>
References: <1432225012-20598-1-git-send-email-Frank.Li@freescale.com>
 <1432225012-20598-2-git-send-email-Frank.Li@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1432225012-20598-2-git-send-email-Frank.Li@freescale.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

This looks good to me, a few nits below

On 22/05/2015 at 00:16:47 +0800, Frank.Li@freescale.com wrote :
> -	spin_unlock_irqrestore(&data->lock, flags);
> +	regmap_update_bits(data->regmap, data->offset + SNVS_LPCR,
> +			  (SNVS_LPCR_LPTA_EN | SNVS_LPCR_LPWUI_EN),
That line is not properly aligned (missing one space)

[...]

> +	if (of_device_is_compatible(snvs_np, "syscon")) {
> +		data->regmap = syscon_node_to_regmap(snvs_np);
> +		data->offset = 0x34;
> +	} else {
> +		pr_warning("snvs rtc: you use old dts file, please update it\n");

This should be pr_warn()


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
