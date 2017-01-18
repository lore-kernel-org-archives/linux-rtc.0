Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBNUY7PBQKGQEEOYAAWY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id d130si1116716wmf.0.2017.01.17.18.00.22
        for <rtc-linux@googlegroups.com>;
        Tue, 17 Jan 2017 18:00:22 -0800 (PST)
Date: Wed, 18 Jan 2017 03:00:21 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	Olof Johansson <olof@lixom.net>, Lee Jones <lee.jones@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Stephen Barber <smbarber@chromium.org>
Subject: [rtc-linux] Re: [PATCH 3/4] rtc: cros-ec: add cros-ec-rtc driver.
Message-ID: <20170118020021.rnfchgbmtnrbljck@piout.net>
References: <20170111165221.17337-1-enric.balletbo@collabora.com>
 <20170111165221.17337-3-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170111165221.17337-3-enric.balletbo@collabora.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


Hi,

This seems mostly good to me.

On 11/01/2017 at 17:52:20 +0100, Enric Balletbo i Serra wrote :
> From: Stephen Barber <smbarber@chromium.org>
> 
> On platforms with a Chrome OS EC, the EC can function as a simple RTC.
> Add a basic driver with this functionality.
> 
> Signed-off-by: Stephen Barber <smbarber@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  drivers/rtc/Kconfig       |  10 ++
>  drivers/rtc/Makefile      |   1 +
>  drivers/rtc/rtc-cros-ec.c | 416 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 427 insertions(+)
>  create mode 100644 drivers/rtc/rtc-cros-ec.c
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index c93c5a8..b58ce06 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -207,6 +207,16 @@ config RTC_DRV_AS3722
>  	  This driver can also be built as a module. If so, the module
>  	  will be called rtc-as3722.
>  
> +config RTC_DRV_CROS_EC
> +	tristate "Chrome OS EC RTC driver"
> +	depends on MFD_CROS_EC
> +	help
> +	  If you say yes here you will get support for the
> +	  Chrome OS Embedded Controller's RTC.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called rtc-cros-ec.
> +

This doesn't look like and i2c RTC, you probably want to put that block
somewhere after "Platform RTC drivers"

>  config RTC_DRV_DS1307
>  	tristate "Dallas/Maxim DS1307/37/38/39/40, ST M41T00, EPSON RX-8025, ISL12057"
>  	help


> +	ret = rtc_valid_tm(&tm);
> +	if (ret)
> +		dev_err(&pdev->dev, "invalid date/time\n");
> +
nitpick: I'm not sure this is useful. You'll probably know soon enough
that it is invalid as I'm pretty sure something will read the date at
boot time.


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
