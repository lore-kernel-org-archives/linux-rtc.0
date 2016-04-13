Return-Path: <rtc-linux+bncBDS7HNEFSALRB3MZXO4AKGQECVQUPVA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id y80si881469wmd.3.2016.04.13.15.49.17
        for <rtc-linux@googlegroups.com>;
        Wed, 13 Apr 2016 15:49:17 -0700 (PDT)
Date: Thu, 14 Apr 2016 00:49:16 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Tomas Krcka <tomas.krcka@nkgroup.cz>
Cc: rtc-linux@googlegroups.com, a.zummo@towertech.it,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: support for rv4162c7
Message-ID: <20160413224916.GH7765@piout.net>
References: <570EAE8B.7010706@nkgroup.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <570EAE8B.7010706@nkgroup.cz>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 13/04/2016 at 22:39:39 +0200, Tomas Krcka wrote :
> This patch is for support of rv4162c7 RTC chip.
> The device has same parameters as rv4162, but with different identification.
> Tested with PhyTec module AM335x. 
> 

Well, technically, it is an rv4162. rv4162-c7 is the only available one.
So this patch is not necessary.

> Signed-off-by: Tomas Krcka <tomas.krcka@nkgroup.cz> 
> 
> ---
>  drivers/rtc/rtc-m41t80.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
> index d107a8e..1aa57d8 100644
> --- a/drivers/rtc/rtc-m41t80.c
> +++ b/drivers/rtc/rtc-m41t80.c
> @@ -81,6 +81,7 @@ static const struct i2c_device_id m41t80_id[] = {
>      { "m41st85", M41T80_FEATURE_HT | M41T80_FEATURE_BL | M41T80_FEATURE_SQ },
>      { "m41st87", M41T80_FEATURE_HT | M41T80_FEATURE_BL | M41T80_FEATURE_SQ },
>      { "rv4162", M41T80_FEATURE_SQ | M41T80_FEATURE_WD | M41T80_FEATURE_SQ_ALT },
> +    { "rv4162c7", M41T80_FEATURE_SQ | M41T80_FEATURE_WD | M41T80_FEATURE_SQ_ALT },
>      { }
>  };
>  MODULE_DEVICE_TABLE(i2c, m41t80_id);
> -- 1.9.1
> 

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
