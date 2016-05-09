Return-Path: <rtc-linux+bncBDP6N55ZUYDRBLPXYK4QKGQEIJZPXOQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-pa0-x22e.google.com (mail-pa0-x22e.google.com. [2607:f8b0:400e:c03::22e])
        by gmr-mx.google.com with ESMTPS id 17si4839872pfw.0.2016.05.09.09.32.44
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 May 2016 09:32:44 -0700 (PDT)
Received: by mail-pa0-x22e.google.com with SMTP id r5so76144783pag.1
        for <rtc-linux@googlegroups.com>; Mon, 09 May 2016 09:32:44 -0700 (PDT)
Date: Mon, 9 May 2016 09:32:41 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Richard Purdie <rpurdie@rpsys.net>,
	Jacek Anaszewski <j.anaszewski@samsung.com>,
	Lee Jones <lee.jones@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org, rtc-linux@googlegroups.com,
	r.baldyga@hackerion.com,
	Marek Szyprowski <m.szyprowski@samsung.com>, stable@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [rtc-linux] Re: [PATCH v6 1/9] input: max8997-haptic: Fix NULL
 pointer dereference
Message-ID: <20160509163241.GB15535@dtor-ws>
References: <1462519289-2356-1-git-send-email-k.kozlowski@samsung.com>
 <1462519289-2356-2-git-send-email-k.kozlowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1462519289-2356-2-git-send-email-k.kozlowski@samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Fri, May 06, 2016 at 09:21:21AM +0200, Krzysztof Kozlowski wrote:
> From: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> NULL pointer derefence happens when booting with DTB because the
> platform data for haptic device is not set in supplied data from parent
> MFD device.
> 
> The MFD device creates only platform data (from Device Tree) for itself,
> not for haptic child.
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000009c
> pgd = c0004000
> 	[0000009c] *pgd=00000000
> 	Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> 	(max8997_haptic_probe) from [<c03f9cec>] (platform_drv_probe+0x4c/0xb0)
> 	(platform_drv_probe) from [<c03f8440>] (driver_probe_device+0x214/0x2c0)
> 	(driver_probe_device) from [<c03f8598>] (__driver_attach+0xac/0xb0)
> 	(__driver_attach) from [<c03f67ac>] (bus_for_each_dev+0x68/0x9c)
> 	(bus_for_each_dev) from [<c03f7a38>] (bus_add_driver+0x1a0/0x218)
> 	(bus_add_driver) from [<c03f8db0>] (driver_register+0x78/0xf8)
> 	(driver_register) from [<c0101774>] (do_one_initcall+0x90/0x1d8)
> 	(do_one_initcall) from [<c0a00dbc>] (kernel_init_freeable+0x15c/0x1fc)
> 	(kernel_init_freeable) from [<c06bb5b4>] (kernel_init+0x8/0x114)
> 	(kernel_init) from [<c0107938>] (ret_from_fork+0x14/0x3c)
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: <stable@vger.kernel.org>
> Fixes: 104594b01ce7 ("Input: add driver support for MAX8997-haptic")
> [k.kozlowski: Write commit message, add CC-stable]
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Applied, thank you.

> ---
>  drivers/input/misc/max8997_haptic.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/misc/max8997_haptic.c b/drivers/input/misc/max8997_haptic.c
> index a806ba3818f7..8d6326d7e7be 100644
> --- a/drivers/input/misc/max8997_haptic.c
> +++ b/drivers/input/misc/max8997_haptic.c
> @@ -255,12 +255,14 @@ static int max8997_haptic_probe(struct platform_device *pdev)
>  	struct max8997_dev *iodev = dev_get_drvdata(pdev->dev.parent);
>  	const struct max8997_platform_data *pdata =
>  					dev_get_platdata(iodev->dev);
> -	const struct max8997_haptic_platform_data *haptic_pdata =
> -					pdata->haptic_pdata;
> +	const struct max8997_haptic_platform_data *haptic_pdata = NULL;
>  	struct max8997_haptic *chip;
>  	struct input_dev *input_dev;
>  	int error;
>  
> +	if (pdata)
> +		haptic_pdata = pdata->haptic_pdata;
> +
>  	if (!haptic_pdata) {
>  		dev_err(&pdev->dev, "no haptic platform data\n");
>  		return -EINVAL;
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Dmitry

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
