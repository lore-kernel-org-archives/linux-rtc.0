Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBUU4VLCAKGQEDLKUKXI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id v70si81226wmf.0.2017.01.26.16.03.29
        for <rtc-linux@googlegroups.com>;
        Thu, 26 Jan 2017 16:03:29 -0800 (PST)
Date: Fri, 27 Jan 2017 01:03:29 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Meng Yi <meng.yi@nxp.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [RFC PATCH] rtc/nxp: add FTM alarm driver as the
 wakeup source
Message-ID: <20170127000329.jekcc3a3fxim4mbb@piout.net>
References: <1477273336-48449-1-git-send-email-meng.yi@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1477273336-48449-1-git-send-email-meng.yi@nxp.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 24/10/2016 at 09:42:16 +0800, Meng Yi wrote:
> For the platforms including LS1021A, LS1043A that has the
> flextimer module, implementing alarm functions within RTC
> subsystem to wakeup the system when system going to sleep.
> Only Ftm0 can be used to wakeup the system.
> 
> Signed-off-by: Meng Yi <meng.yi@nxp.com>
> ---
>  drivers/rtc/Kconfig       |   9 ++
>  drivers/rtc/Makefile      |   1 +
>  drivers/rtc/rtc-nxp-ftm.c | 255 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 265 insertions(+)
>  create mode 100644 drivers/rtc/rtc-nxp-ftm.c
> 
> +static const struct of_device_id nxp_ftm_rtc_of_match[] = {
> +	{
> +		.compatible	= "fsl,ftm-clock",
> +	}, {
> +		/* sentinel */
> +	}
> +};
> +MODULE_DEVICE_TABLE(of, nxp_ftm_rtc_of_match);
> 

I think the patch is generally fine but I think you will get an issue
later if anybody is trying to use an FTM to actually do something else
(e.g. PWM, counter, quad decoder,...).

I'm asking because there is exactly this issue on atmel SoCs.

I think we may be missing a proper subsystem.

> +static int nxp_ftm_rtc_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct resource *r;
> +	int irq;
> +	int ret;
> +
> +	rtc.alarm_freq = (u32)FIXED_FREQ_CLK / (u32)MAX_FREQ_DIV;
> +
> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!r)
> +		return -ENODEV;
> +
> +	rtc.base = devm_ioremap_resource(&pdev->dev, r);
> +	if (IS_ERR(rtc.base))
> +		return PTR_ERR(rtc.base);
> +
> +	irq = irq_of_parse_and_map(np, 0);
> +	if (irq <= 0) {
> +		pr_err("ftm: unable to get IRQ from DT, %d\n", irq);
> +		return -EINVAL;
> +	}
> +
> +	rtc.endian = of_property_read_bool(np, "big-endian");
> +
Doesn't the platform know the endianness, is it really necessary to have
that in the device tree?


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
