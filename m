Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:45218 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751586AbdFXUze (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 24 Jun 2017 16:55:34 -0400
Date: Sat, 24 Jun 2017 22:55:32 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] rtc: s3c: Handle clock enable failures
Message-ID: <20170624205532.eqykr37ynpvprklf@piout.net>
References: <20170616192807.10347-1-krzk@kernel.org>
 <20170616192807.10347-6-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170616192807.10347-6-krzk@kernel.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

On 16/06/2017 at 21:28:07 +0200, Krzysztof Kozlowski wrote:
> clk_enable() can fail so handle such case.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/rtc/rtc-s3c.c | 72 ++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 57 insertions(+), 15 deletions(-)
> 

I've applied the whole series. However, quite often, on a platform,
clk_prepare/enable are ensured to never fail and I find that the added
complexity to handle failures is not worth it.

> diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
> index 0cb2f27a30b4..a8992c227f61 100644
> --- a/drivers/rtc/rtc-s3c.c
> +++ b/drivers/rtc/rtc-s3c.c
> @@ -68,18 +68,32 @@ struct s3c_rtc_data {
>  	void (*disable) (struct s3c_rtc *info);
>  };
>  
> -static void s3c_rtc_enable_clk(struct s3c_rtc *info)
> +static int s3c_rtc_enable_clk(struct s3c_rtc *info)
>  {
>  	unsigned long irq_flags;
> +	int ret = 0;
>  
>  	spin_lock_irqsave(&info->alarm_clk_lock, irq_flags);
> +
>  	if (info->clk_disabled) {
> -		clk_enable(info->rtc_clk);
> -		if (info->data->needs_src_clk)
> -			clk_enable(info->rtc_src_clk);
> +		ret = clk_enable(info->rtc_clk);
> +		if (ret)
> +			goto out;
> +
> +		if (info->data->needs_src_clk) {
> +			ret = clk_enable(info->rtc_src_clk);
> +			if (ret) {
> +				clk_disable(info->rtc_clk);
> +				goto out;
> +			}
> +		}
>  		info->clk_disabled = false;
>  	}
> +
> +out:
>  	spin_unlock_irqrestore(&info->alarm_clk_lock, irq_flags);
> +
> +	return ret;
>  }
>  
>  static void s3c_rtc_disable_clk(struct s3c_rtc *info)
> @@ -122,10 +136,13 @@ static int s3c_rtc_setaie(struct device *dev, unsigned int enabled)
>  {
>  	struct s3c_rtc *info = dev_get_drvdata(dev);
>  	unsigned int tmp;
> +	int ret;
>  
>  	dev_dbg(info->dev, "%s: aie=%d\n", __func__, enabled);
>  
> -	s3c_rtc_enable_clk(info);
> +	ret = s3c_rtc_enable_clk(info);
> +	if (ret)
> +		return ret;
>  
>  	tmp = readb(info->base + S3C2410_RTCALM) & ~S3C2410_RTCALM_ALMEN;
>  
> @@ -136,10 +153,13 @@ static int s3c_rtc_setaie(struct device *dev, unsigned int enabled)
>  
>  	s3c_rtc_disable_clk(info);
>  
> -	if (enabled)
> -		s3c_rtc_enable_clk(info);
> -	else
> +	if (enabled) {
> +		ret = s3c_rtc_enable_clk(info);
> +		if (ret)
> +			return ret;
> +	} else {
>  		s3c_rtc_disable_clk(info);
> +	}
>  
>  	return 0;
>  }
> @@ -147,10 +167,14 @@ static int s3c_rtc_setaie(struct device *dev, unsigned int enabled)
>  /* Set RTC frequency */
>  static int s3c_rtc_setfreq(struct s3c_rtc *info, int freq)
>  {
> +	int ret;
> +
>  	if (!is_power_of_2(freq))
>  		return -EINVAL;
>  
> -	s3c_rtc_enable_clk(info);
> +	ret = s3c_rtc_enable_clk(info);
> +	if (ret)
> +		return ret;
>  	spin_lock_irq(&info->pie_lock);
>  
>  	if (info->data->set_freq)
> @@ -167,8 +191,11 @@ static int s3c_rtc_gettime(struct device *dev, struct rtc_time *rtc_tm)
>  {
>  	struct s3c_rtc *info = dev_get_drvdata(dev);
>  	unsigned int have_retried = 0;
> +	int ret;
>  
> -	s3c_rtc_enable_clk(info);
> +	ret = s3c_rtc_enable_clk(info);
> +	if (ret)
> +		return ret;
>  
>  retry_get_time:
>  	rtc_tm->tm_min  = readb(info->base + S3C2410_RTCMIN);
> @@ -212,6 +239,7 @@ static int s3c_rtc_settime(struct device *dev, struct rtc_time *tm)
>  {
>  	struct s3c_rtc *info = dev_get_drvdata(dev);
>  	int year = tm->tm_year - 100;
> +	int ret;
>  
>  	dev_dbg(dev, "set time %04d.%02d.%02d %02d:%02d:%02d\n",
>  		1900 + tm->tm_year, tm->tm_mon, tm->tm_mday,
> @@ -224,7 +252,9 @@ static int s3c_rtc_settime(struct device *dev, struct rtc_time *tm)
>  		return -EINVAL;
>  	}
>  
> -	s3c_rtc_enable_clk(info);
> +	ret = s3c_rtc_enable_clk(info);
> +	if (ret)
> +		return ret;
>  
>  	writeb(bin2bcd(tm->tm_sec),  info->base + S3C2410_RTCSEC);
>  	writeb(bin2bcd(tm->tm_min),  info->base + S3C2410_RTCMIN);
> @@ -243,8 +273,11 @@ static int s3c_rtc_getalarm(struct device *dev, struct rtc_wkalrm *alrm)
>  	struct s3c_rtc *info = dev_get_drvdata(dev);
>  	struct rtc_time *alm_tm = &alrm->time;
>  	unsigned int alm_en;
> +	int ret;
>  
> -	s3c_rtc_enable_clk(info);
> +	ret = s3c_rtc_enable_clk(info);
> +	if (ret)
> +		return ret;
>  
>  	alm_tm->tm_sec  = readb(info->base + S3C2410_ALMSEC);
>  	alm_tm->tm_min  = readb(info->base + S3C2410_ALMMIN);
> @@ -293,6 +326,7 @@ static int s3c_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
>  	struct s3c_rtc *info = dev_get_drvdata(dev);
>  	struct rtc_time *tm = &alrm->time;
>  	unsigned int alrm_en;
> +	int ret;
>  	int year = tm->tm_year - 100;
>  
>  	dev_dbg(dev, "s3c_rtc_setalarm: %d, %04d.%02d.%02d %02d:%02d:%02d\n",
> @@ -300,7 +334,9 @@ static int s3c_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
>  		1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday,
>  		tm->tm_hour, tm->tm_min, tm->tm_sec);
>  
> -	s3c_rtc_enable_clk(info);
> +	ret = s3c_rtc_enable_clk(info);
> +	if (ret)
> +		return ret;
>  
>  	alrm_en = readb(info->base + S3C2410_RTCALM) & S3C2410_RTCALM_ALMEN;
>  	writeb(0x00, info->base + S3C2410_RTCALM);
> @@ -349,8 +385,11 @@ static int s3c_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
>  static int s3c_rtc_proc(struct device *dev, struct seq_file *seq)
>  {
>  	struct s3c_rtc *info = dev_get_drvdata(dev);
> +	int ret;
>  
> -	s3c_rtc_enable_clk(info);
> +	ret = s3c_rtc_enable_clk(info);
> +	if (ret)
> +		return ret;
>  
>  	if (info->data->enable_tick)
>  		info->data->enable_tick(info, seq);
> @@ -589,8 +628,11 @@ static int s3c_rtc_probe(struct platform_device *pdev)
>  static int s3c_rtc_suspend(struct device *dev)
>  {
>  	struct s3c_rtc *info = dev_get_drvdata(dev);
> +	int ret;
>  
> -	s3c_rtc_enable_clk(info);
> +	ret = s3c_rtc_enable_clk(info);
> +	if (ret)
> +		return ret;
>  
>  	/* save TICNT for anyone using periodic interrupts */
>  	if (info->data->save_tick_cnt)
> -- 
> 2.9.3
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
