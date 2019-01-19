Return-Path: <SRS0=3b/R=P3=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41993C61CE4
	for <linux-rtc@archiver.kernel.org>; Sat, 19 Jan 2019 20:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1AE92084C
	for <linux-rtc@archiver.kernel.org>; Sat, 19 Jan 2019 20:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547929029;
	bh=mqGm6X2eZMUFptS/4Oq08eQNeNvwDx9jAYjReL1y0MI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J///HPZxgJumeu38GvuwbbZKqnWFo6KQaGenJOmeEUr6HH8R+1U9eymPo2oC3ZOmy
	 uGv18KaOGa7WVCeIRdZdLf+5QIVOd6PLKVBrVuPNcK6mtpbGGhBtjnc1JUx6liUEah
	 bSrMHFDhB7yiGXwvJPpNHHNUxcoEX1TGnVcIi7Rs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfASURI (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sat, 19 Jan 2019 15:17:08 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43639 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbfASURI (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 19 Jan 2019 15:17:08 -0500
Received: by mail-ed1-f65.google.com with SMTP id f9so13717833eds.10;
        Sat, 19 Jan 2019 12:17:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0mjfd0KbYif+yAFPHgGlEoNTBbpzMX0rqu3NNvolxBg=;
        b=QiEym9CW7Ohw9YO7ng9HlG+8Wzo9KfSGtWW+t0LhoewNMKgGkBeo/Ixqch+UqSKEvi
         HZuvDlXlUyJVXR5f6FmMiw1Y87gHyk9O7xxQJOFvij00whZYjk5vU82BAaWlNaXKXqoB
         2BDoYxikaf5MzF0MAlkK0h/gE0AfCrj0E8vOVyOvvNCJL/2XVnwBhjWn1tBL93RK/aHx
         qgHVfhB8+gUFBPqZz9aFBNTNv1BmJDSVl6bKPfJV94Qy6xB4ZWXHIK7PMrbgpz0SXbJo
         hcqaOPXtiJ0LmVvCGbrNHGZ4KVtOn8VEQlReDzHtRIBMZhNGPyT/opEgIKTRYpIJE0ka
         wP6Q==
X-Gm-Message-State: AJcUukfI5UNY6DfrCeH+PjnRq4lF4EMcBTYbl9175xUnGeHPpxKtV5ka
        iSqen7Y4Qad0YNzimeUd2kw=
X-Google-Smtp-Source: ALg8bN7TAWszg8+Qdj9uwpygJ/LBPjDeHFE1IGVR/DANE5CQXL0uSP+yQIu0HcX75km5ubltGVfchg==
X-Received: by 2002:a17:906:e2c9:: with SMTP id gr9-v6mr19182895ejb.108.1547929025588;
        Sat, 19 Jan 2019 12:17:05 -0800 (PST)
Received: from kozik-lap ([194.230.155.148])
        by smtp.googlemail.com with ESMTPSA id e7-v6sm4446836ejt.23.2019.01.19.12.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 19 Jan 2019 12:17:04 -0800 (PST)
Date:   Sat, 19 Jan 2019 21:17:02 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-rtc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] rtc: s3c: Rewrite clock handling
Message-ID: <20190119201702.GA3590@kozik-lap>
References: <CGME20190118132826eucas1p2b158579e05c57a4e73edfaf376b0108c@eucas1p2.samsung.com>
 <20190118132754.15660-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190118132754.15660-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Fri, Jan 18, 2019 at 02:27:54PM +0100, Marek Szyprowski wrote:
> s3c_rtc_enable/disable_clk() functions were designed to be called multiple
> times without reference counting, because they were initially used in

s/used/used only/
(if I understand correctly the logic)

> alarm setting/clearing functions, which can be called both when alarm is
> already set or not. Later however, calls to those functions have been added to
> other places in the driver - like time and /proc reading callbacks, what
> results in broken alarm if any of such events happens after the alarm has
> been set. Fix this by simplifying s3c_rtc_enable/disable_clk() functions
> to rely on proper reference counting in clock core and move alarm enable
> counter to s3c_rtc_setaie() function.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/rtc/rtc-s3c.c | 67 ++++++++++++++++++-------------------------
>  1 file changed, 28 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
> index 04c68178c42d..e682977b4f6e 100644
> --- a/drivers/rtc/rtc-s3c.c
> +++ b/drivers/rtc/rtc-s3c.c
> @@ -39,7 +39,7 @@ struct s3c_rtc {
>  	void __iomem *base;
>  	struct clk *rtc_clk;
>  	struct clk *rtc_src_clk;
> -	bool clk_disabled;
> +	bool alarm_enabled;
>  
>  	const struct s3c_rtc_data *data;
>  
> @@ -47,7 +47,7 @@ struct s3c_rtc {
>  	int irq_tick;
>  
>  	spinlock_t pie_lock;
> -	spinlock_t alarm_clk_lock;
> +	spinlock_t alarm_lock;

Maybe add short comment that it protects only "alarm_enabled" property?

>  
>  	int ticnt_save;
>  	int ticnt_en_save;
> @@ -70,44 +70,28 @@ struct s3c_rtc_data {
>  
>  static int s3c_rtc_enable_clk(struct s3c_rtc *info)
>  {
> -	unsigned long irq_flags;
>  	int ret = 0;
>  
> -	spin_lock_irqsave(&info->alarm_clk_lock, irq_flags);
> +	ret = clk_enable(info->rtc_clk);
> +	if (ret)
> +		goto out;

The out label is now empty so just "return ret". It is easier to read -
no need to jump anywhere to see the simple return.

>  
> -	if (info->clk_disabled) {
> -		ret = clk_enable(info->rtc_clk);
> -		if (ret)
> +	if (info->data->needs_src_clk) {
> +		ret = clk_enable(info->rtc_src_clk);
> +		if (ret) {
> +			clk_disable(info->rtc_clk);
>  			goto out;
> -
> -		if (info->data->needs_src_clk) {
> -			ret = clk_enable(info->rtc_src_clk);
> -			if (ret) {
> -				clk_disable(info->rtc_clk);
> -				goto out;
> -			}
>  		}
> -		info->clk_disabled = false;
>  	}
> -
>  out:
> -	spin_unlock_irqrestore(&info->alarm_clk_lock, irq_flags);
> -
>  	return ret;
>  }
>  
>  static void s3c_rtc_disable_clk(struct s3c_rtc *info)
>  {
> -	unsigned long irq_flags;
> -
> -	spin_lock_irqsave(&info->alarm_clk_lock, irq_flags);
> -	if (!info->clk_disabled) {
> -		if (info->data->needs_src_clk)
> -			clk_disable(info->rtc_src_clk);
> -		clk_disable(info->rtc_clk);
> -		info->clk_disabled = true;
> -	}
> -	spin_unlock_irqrestore(&info->alarm_clk_lock, irq_flags);
> +	if (info->data->needs_src_clk)
> +		clk_disable(info->rtc_src_clk);
> +	clk_disable(info->rtc_clk);
>  }
>  
>  /* IRQ Handlers */
> @@ -135,6 +119,7 @@ static irqreturn_t s3c_rtc_alarmirq(int irq, void *id)
>  static int s3c_rtc_setaie(struct device *dev, unsigned int enabled)
>  {
>  	struct s3c_rtc *info = dev_get_drvdata(dev);
> +	unsigned long flags;
>  	unsigned int tmp;
>  	int ret;
>  
> @@ -151,17 +136,19 @@ static int s3c_rtc_setaie(struct device *dev, unsigned int enabled)
>  
>  	writeb(tmp, info->base + S3C2410_RTCALM);
>  
> -	s3c_rtc_disable_clk(info);
> +	spin_lock_irqsave(&info->alarm_lock, flags);
>  
> -	if (enabled) {
> -		ret = s3c_rtc_enable_clk(info);
> -		if (ret)
> -			return ret;
> -	} else {
> +	if (info->alarm_enabled && !enabled)
>  		s3c_rtc_disable_clk(info);
> -	}
> +	else if (!info->alarm_enabled && enabled)
> +		ret = s3c_rtc_enable_clk(info);
>  
> -	return 0;
> +	info->alarm_enabled = enabled;
> +	spin_unlock_irqrestore(&info->alarm_lock, flags);
> +
> +	s3c_rtc_disable_clk(info);
> +
> +	return ret;
>  }
>  
>  /* Set RTC frequency */
> @@ -357,10 +344,10 @@ static int s3c_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
>  
>  	writeb(alrm_en, info->base + S3C2410_RTCALM);
>  
> -	s3c_rtc_disable_clk(info);
> -
>  	s3c_rtc_setaie(dev, alrm->enabled);
>  
> +	s3c_rtc_disable_clk(info);

I do not understand this change - why do you have to move the disable
clk? The s3c_rtc_setaie() takes care about clock enabling/disabling for
the time of accessing registers.

> +
>  	return 0;
>  }
>  
> @@ -491,7 +478,7 @@ static int s3c_rtc_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  	spin_lock_init(&info->pie_lock);
> -	spin_lock_init(&info->alarm_clk_lock);
> +	spin_lock_init(&info->alarm_lock);
>  
>  	platform_set_drvdata(pdev, info);
>  
> @@ -591,6 +578,8 @@ static int s3c_rtc_probe(struct platform_device *pdev)
>  
>  	s3c_rtc_setfreq(info, 1);
>  
> +	s3c_rtc_disable_clk(info);

I cannot find the reason why this is related to this particular change.
I mean, it looks reasonable because previously the clock looked like it
was enabled all the time... but maybe this should be separate pach?


Best regards,
Krzysztof

> +
>  	return 0;
>  
>  err_nortc:
> -- 
> 2.17.1
> 
