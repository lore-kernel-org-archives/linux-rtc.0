Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBFEZ7PBQKGQESECYB6Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id v70si27397wmf.0.2017.01.17.18.01.56
        for <rtc-linux@googlegroups.com>;
        Tue, 17 Jan 2017 18:01:56 -0800 (PST)
Date: Wed, 18 Jan 2017 03:01:56 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	Olof Johansson <olof@lixom.net>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Stephen Barber <smbarber@chromium.org>
Subject: [rtc-linux] Re: [PATCH 4/4] mfd: cros_ec: add RTC as mfd subdevice
Message-ID: <20170118020156.ynayqtudiu5j2db3@piout.net>
References: <20170111165221.17337-1-enric.balletbo@collabora.com>
 <20170111165221.17337-4-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170111165221.17337-4-enric.balletbo@collabora.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Lee,

I don't think that one has your ack, is it ok for me to take it?


On 11/01/2017 at 17:52:21 +0100, Enric Balletbo i Serra wrote :
> From: Stephen Barber <smbarber@chromium.org>
> 
> If the EC supports RTC host commands, expose an RTC device.
> 
> Signed-off-by: Stephen Barber <smbarber@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  drivers/platform/chrome/cros_ec_dev.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_dev.c b/drivers/platform/chrome/cros_ec_dev.c
> index 47268ec..ebe029d 100644
> --- a/drivers/platform/chrome/cros_ec_dev.c
> +++ b/drivers/platform/chrome/cros_ec_dev.c
> @@ -383,6 +383,24 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
>  	kfree(msg);
>  }
>  
> +static const struct mfd_cell cros_ec_rtc_devs[] = {
> +	{
> +		.name = "cros-ec-rtc",
> +		.id   = -1,
> +	},
> +};
> +
> +static void cros_ec_rtc_register(struct cros_ec_dev *ec)
> +{
> +	int ret;
> +
> +	ret = mfd_add_devices(ec->dev, 0, cros_ec_rtc_devs,
> +			      ARRAY_SIZE(cros_ec_rtc_devs),
> +			      NULL, 0, NULL);
> +	if (ret)
> +		dev_err(ec->dev, "failed to add cros-ec-rtc device: %d\n", ret);
> +}
> +
>  static int ec_device_probe(struct platform_device *pdev)
>  {
>  	int retval = -ENOMEM;
> @@ -441,6 +459,10 @@ static int ec_device_probe(struct platform_device *pdev)
>  	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
>  		cros_ec_sensors_register(ec);
>  
> +	/* check whether this EC instance has RTC host command support */
> +	if (cros_ec_check_features(ec, EC_FEATURE_RTC))
> +		cros_ec_rtc_register(ec);
> +
>  	return 0;
>  
>  dev_reg_failed:
> -- 
> 2.9.3
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
