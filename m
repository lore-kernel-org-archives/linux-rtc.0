Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBBVVWO5QKGQEM7JC2CA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id f70si77300wmf.0.2016.06.24.00.00.22
        for <rtc-linux@googlegroups.com>;
        Fri, 24 Jun 2016 00:00:22 -0700 (PDT)
Date: Fri, 24 Jun 2016 09:00:21 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	Knut Wohlrab <Knut.Wohlrab@de.bosch.com>,
	Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
Subject: Re: [rtc-linux] [PATCH v2 3/4] rtc: rv8803: add device tree
 compatible names
Message-ID: <20160624070021.GH5809@piout.net>
References: <1466577742-18824-1-git-send-email-dirk.behme@de.bosch.com>
 <1466577742-18824-4-git-send-email-dirk.behme@de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1466577742-18824-4-git-send-email-dirk.behme@de.bosch.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 22/06/2016 at 08:42:21 +0200, Dirk Behme wrote :
> From: Knut Wohlrab <Knut.Wohlrab@de.bosch.com>
> 
> Add device tree compatible names for usage in a compatible
> list of alternative RTC devices.
> 

This patch is unnecessary, the i2c subsystem is making sure the driver
is probed without it.

> Signed-off-by: Knut Wohlrab <Knut.Wohlrab@de.bosch.com>
> Signed-off-by: Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
> Cc: devicetree@vger.kernel.org
> ---
>  drivers/rtc/rtc-rv8803.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
> index f623038..e122b51 100644
> --- a/drivers/rtc/rtc-rv8803.c
> +++ b/drivers/rtc/rtc-rv8803.c
> @@ -18,6 +18,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/rtc.h>
> +#include <linux/of.h>
>  
>  #define RV8803_SEC			0x00
>  #define RV8803_MIN			0x01
> @@ -520,9 +521,19 @@ static const struct i2c_device_id rv8803_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, rv8803_id);
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id rv8803_of_match[] = {
> +	{ .compatible = "microcrystal,rv8803", },
> +	{ .compatible = "epson,rx8900", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, rv8803_of_match);
> +#endif
> +
>  static struct i2c_driver rv8803_driver = {
>  	.driver = {
>  		.name = "rtc-rv8803",
> +		.of_match_table = of_match_ptr(rv8803_of_match),
>  	},
>  	.probe		= rv8803_probe,
>  	.remove		= rv8803_remove,
> -- 
> 1.9.1
> 
> -- 
> You received this message because you are subscribed to "rtc-linux".
> Membership options at http://groups.google.com/group/rtc-linux .
> Please read http://groups.google.com/group/rtc-linux/web/checklist
> before submitting a driver.
> --- 
> You received this message because you are subscribed to the Google Groups "rtc-linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
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
