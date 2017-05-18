Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:59421 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932252AbdERP4d (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 18 May 2017 11:56:33 -0400
Date: Thu, 18 May 2017 17:56:31 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Michael Thalmeier <michael.thalmeier@hale.at>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@thalmeier.at
Subject: Re: [PATCH] rtc: rtc-stmp3xxx: detect power failure on backup power
 domain
Message-ID: <20170518155631.kcbkr6ldxailkg7i@piout.net>
References: <20170518144521.9294-1-michael.thalmeier@hale.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170518144521.9294-1-michael.thalmeier@hale.at>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

On 18/05/2017 at 16:45:21 +0200, Michael Thalmeier wrote:
> To detect when the backup power domain has lost power a software defined bit
> is set in one of the general purpose persistent registers when writing a new
> time into the rtc.
> When reading the time this bit is checked to determine if a power fail has
> happened since the last time the rtc time was set.
> 

I'm kind of concerned that other people may want to use those register
for something else but I don't currently have anything better to
suggest.

The other concern is that when updating the kernel, this will make amm
the rtc report that the time is invalid until the next update. So this
should be disabled by default.

> When we detect a power fail we return -ENODATA.
> 

All the other drivers return -EINVAL in that case.

> Signed-off-by: Michael Thalmeier <michael.thalmeier@hale.at>
> ---
>  drivers/rtc/rtc-stmp3xxx.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
> index d578e40..51330ec 100644
> --- a/drivers/rtc/rtc-stmp3xxx.c
> +++ b/drivers/rtc/rtc-stmp3xxx.c
> @@ -62,6 +62,9 @@
>  /* missing bitmask in headers */
>  #define STMP3XXX_RTC_PERSISTENT1_FORCE_UPDATER	0x80000000
>  
> +#define STMP3XXX_RTC_PERSISTENT2		0x80
> +#define STMP3XXX_RTC_PERSISTENT2_VALID_TIME	0x01
> +
>  struct stmp3xxx_rtc_data {
>  	struct rtc_device *rtc;
>  	void __iomem *io;
> @@ -160,6 +163,10 @@ static int stmp3xxx_rtc_gettime(struct device *dev, struct rtc_time *rtc_tm)
>  	if (ret)
>  		return ret;
>  
> +	if (!(readl(rtc_data->io + STMP3XXX_RTC_PERSISTENT2) &
> +				STMP3XXX_RTC_PERSISTENT2_VALID_TIME))
> +		return -ENODATA;
> +
>  	rtc_time_to_tm(readl(rtc_data->io + STMP3XXX_RTC_SECONDS), rtc_tm);
>  	return 0;
>  }
> @@ -169,6 +176,8 @@ static int stmp3xxx_rtc_set_mmss(struct device *dev, unsigned long t)
>  	struct stmp3xxx_rtc_data *rtc_data = dev_get_drvdata(dev);
>  
>  	writel(t, rtc_data->io + STMP3XXX_RTC_SECONDS);
> +	writel(STMP3XXX_RTC_PERSISTENT2_VALID_TIME,
> +		rtc_data->io + STMP3XXX_RTC_PERSISTENT2 + STMP_OFFSET_REG_SET);
>  	return stmp3xxx_wait_time(rtc_data);
>  }
>  
> -- 
> 2.9.2
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
