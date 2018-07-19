Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37623 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbeGSLXE (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 19 Jul 2018 07:23:04 -0400
Date: Thu, 19 Jul 2018 12:40:18 +0200
From: Johan Hovold <johan@kernel.org>
To: Keerthy <j-keerthy@ti.com>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        t-kristo@ti.com, linux-rtc@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan@kernel.org
Subject: Re: [PATCH v4 4/4] rtc: interface: Add power_off_program to
 rtc_class_ops
Message-ID: <20180719104018.GT10204@localhost>
References: <1531372060-10532-1-git-send-email-j-keerthy@ti.com>
 <1531372060-10532-5-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1531372060-10532-5-git-send-email-j-keerthy@ti.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, Jul 12, 2018 at 10:37:40AM +0530, Keerthy wrote:
> Add an interface function to set up the rtc for a power_off
> mode.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/rtc/interface.c | 12 ++++++++++++
>  drivers/rtc/rtc-omap.c  |  1 +
>  include/linux/rtc.h     |  2 ++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
> index 6d4012d..c19668b9 100644
> --- a/drivers/rtc/interface.c
> +++ b/drivers/rtc/interface.c
> @@ -1139,3 +1139,15 @@ int rtc_set_offset(struct rtc_device *rtc, long offset)
>  	trace_rtc_set_offset(offset, ret);
>  	return ret;
>  }
> +
> +/**
> + * rtc_power_off_program - Some of the rtc are hooked on to PMIC_EN
> + * line and can be used to power off the SoC.
> + *
> + * Kernel interface to program rtc to power off
> + */
> +int rtc_power_off_program(struct rtc_device *rtc)
> +{
> +	return rtc->ops->power_off_program(rtc->dev.parent);

Why pass in parent instead of the rtc?

> +}
> +EXPORT_SYMBOL_GPL(rtc_power_off_program);

Either way, this is likely not an acceptable interface for this as
Alexandre already mentioned.

As I already suggested, I think you submit this as part of the PM work
adding support for entering the TI RTC-only mode. That will hopefully
provide enough context to be able to determine the right interface.

Note that this also means that we shouldn't split the current rtc-omap
power-off handler before this has been settled (i.e. patches 2/4 and 4/4
should not be applied before then).

Thanks,
Johan
