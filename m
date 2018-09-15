Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:34170 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbeIORIm (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Sat, 15 Sep 2018 13:08:42 -0400
Date: Sat, 15 Sep 2018 13:49:57 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Denis Osterland <Denis.Osterland@diehl.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] rtc: isl1208: fix error handling in isl1208_probe()
Message-ID: <20180915114957.GW14988@piout.net>
References: <1533766387-30529-1-git-send-email-khoroshilov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1533766387-30529-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hello Alexey,

On 09/08/2018 01:13:07+0300, Alexey Khoroshilov wrote:
> After moving rtc_register_device() sysfs group is left unremoved
> on the error path.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> Fixes: 236b7187034e ("rtc: isl1208: switch to rtc_register_device")

Thank you for that report, I've fixed it that way which also avoid the
sysfs race:

http://patchwork.ozlabs.org/patch/970216/

> ---
>  drivers/rtc/rtc-isl1208.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
> index 1a2c38cc0178..4b5df9bfb8d4 100644
> --- a/drivers/rtc/rtc-isl1208.c
> +++ b/drivers/rtc/rtc-isl1208.c
> @@ -674,7 +674,12 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  		}
>  	}
>  
> -	return rtc_register_device(rtc);
> +	rc = rtc_register_device(rtc);
> +	if (rc) {
> +		sysfs_remove_group(&client->dev.kobj, &isl1208_rtc_sysfs_files);
> +		return rc;
> +	}
> +	return 0;
>  }
>  
>  static int
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
