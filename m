Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBUWS6PBQKGQE5MHEPRY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id l66si925414wml.0.2017.01.16.07.40.02
        for <rtc-linux@googlegroups.com>;
        Mon, 16 Jan 2017 07:40:02 -0800 (PST)
Date: Mon, 16 Jan 2017 16:39:59 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Chen-Yu Tsai <wens@csie.org>,
	linux-arm-kernel@lists.infradead.org, rtc-linux@googlegroups.com,
	stable@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: sun6i: Switch to the external oscillator
Message-ID: <20170116153959.7qhahevikxzai664@piout.net>
References: <20170116152148.27439-1-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170116152148.27439-1-maxime.ripard@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 16/01/2017 at 16:21:48 +0100, Maxime Ripard wrote :
> The RTC is clocked from either an internal, imprecise, oscillator or an
> external one, which is usually much more accurate.
> 
> The difference perceived between the time elapsed and the time reported by
> the RTC is in a 10% scale, which prevents the RTC from being useful at all.
> 
> Fortunately, the external oscillator is reported to be mandatory in the
> Allwinner datasheet, so we can just switch to it.
> 

Still, I'm wondering whether the external clock should be taken.

We've had issues with at91 and tegra where this external clock was
suddenly able to be stopped, breaking the RTC because the CCF was not
aware the RTC was using it.

See:
http://patchwork.ozlabs.org/patch/502459/
http://patchwork.ozlabs.org/patch/714517/

Your reply can be that you don't care now and this has a low probability
and you'll handle the case when it happens and that will be fine.

> Cc: stable@vger.kernel.org
> Fixes: 9765d2d94309 ("rtc: sun6i: Add sun6i RTC driver")
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/rtc/rtc-sun6i.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
> index c169a2cd4727..dee524cfa13b 100644
> --- a/drivers/rtc/rtc-sun6i.c
> +++ b/drivers/rtc/rtc-sun6i.c
> @@ -37,9 +37,11 @@
>  
>  /* Control register */
>  #define SUN6I_LOSC_CTRL				0x0000
> +#define SUN6I_LOSC_CTRL_KEY			(0x16aa << 16)
>  #define SUN6I_LOSC_CTRL_ALM_DHMS_ACC		BIT(9)
>  #define SUN6I_LOSC_CTRL_RTC_HMS_ACC		BIT(8)
>  #define SUN6I_LOSC_CTRL_RTC_YMD_ACC		BIT(7)
> +#define SUN6I_LOSC_CTRL_EXT_OSC			BIT(0)
>  #define SUN6I_LOSC_CTRL_ACC_MASK		GENMASK(9, 7)
>  
>  /* RTC */
> @@ -404,6 +406,10 @@ static int sun6i_rtc_probe(struct platform_device *pdev)
>  	/* disable alarm wakeup */
>  	writel(0, chip->base + SUN6I_ALARM_CONFIG);
>  
> +	/* switch to the external, more precise, oscillator */
> +	writel(SUN6I_LOSC_CTRL_KEY | SUN6I_LOSC_CTRL_EXT_OSC,
> +	       chip->base + SUN6I_LOSC_CTRL);
> +
>  	chip->rtc = rtc_device_register("rtc-sun6i", &pdev->dev,
>  					&sun6i_rtc_ops, THIS_MODULE);
>  	if (IS_ERR(chip->rtc)) {
> -- 
> 2.11.0
> 

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
