Return-Path: <rtc-linux+bncBDRMFBMIXEGBBEVT5XAAKGQE6E7MY5Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from foss.arm.com (foss.arm.com. [217.140.101.70])
        by gmr-mx.google.com with ESMTP id qv3si3111454pab.2.2016.11.03.08.36.50
        for <rtc-linux@googlegroups.com>;
        Thu, 03 Nov 2016 08:36:50 -0700 (PDT)
Date: Thu, 3 Nov 2016 15:36:48 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: khilman@baylibre.com, carlo@caione.org, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [RFC PATCH 2/3] rtc: Add Amlogic Virtual Wake RTC
Message-ID: <20161103153647.GD25852@remoulade>
References: <1478183365-23708-1-git-send-email-narmstrong@baylibre.com>
 <1478183365-23708-3-git-send-email-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1478183365-23708-3-git-send-email-narmstrong@baylibre.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Thu, Nov 03, 2016 at 03:29:24PM +0100, Neil Armstrong wrote:
> The Amlogic Meson GX SoCs uses a special register to store the
> time in seconds to wakeup after a system suspend.

Where does this register live, exactly? What IP block is it part of?

> In order to be able to reuse the RTC wakealarm feature, this
> driver implements a fake RTC device which uses the system time
> to deduce a suspend delay.

This sounds like an always-on oneshot timer device, not an RTC.

> +static int meson_vrtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	unsigned long local_time;
> +	struct timeval time;
> +
> +	do_gettimeofday(&time);
> +	local_time = time.tv_sec - (sys_tz.tz_minuteswest * 60);
> +	rtc_time_to_tm(local_time, tm);
> +
> +	return 0;
> +}

... if this were a timer, you wouldn't need this hack.

> +static int meson_vrtc_probe(struct platform_device *pdev)
> +{
> +	struct meson_vrtc_data *vrtc;
> +	struct resource *res;
> +
> +	vrtc = devm_kzalloc(&pdev->dev, sizeof(*vrtc), GFP_KERNEL);
> +	if (!vrtc)
> +		return -ENOMEM;
> +
> +	vrtc->pdev = pdev;
> +
> +	/* Alarm registers */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	vrtc->io_alarm = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(vrtc->io_alarm))
> +		return PTR_ERR(vrtc->io_alarm);
> +
> +	device_init_wakeup(&pdev->dev, 1);
> +
> +	platform_set_drvdata(pdev, vrtc);
> +
> +	vrtc->rtc = devm_rtc_device_register(&pdev->dev, "meson-vrtc",
> +			&meson_vrtc_ops, THIS_MODULE);
> +	if (IS_ERR(vrtc->rtc))
> +		return PTR_ERR(vrtc->rtc);
> +
> +	return 0;
> +}

I see that no interrupt is described. How exactly does this wake the system
from suspend? Is there some interrupt managed by FW for this, for example?

> +static const struct of_device_id meson_vrtc_dt_match[] = {
> +	{ .compatible = "amlogic,meson-vrtc"},

There was no binding documentation in this patch series.

Thanks,
Mark.

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
