Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109953B4E8B;
	Wed, 19 Aug 2026 13:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787146573; cv=none; b=cSYzUwcHlLUkwgV3fP3LcAZT7BF3n4EfNoH9+aLDELMXKu/whWVC93kVoKLsfeg4KEX/a8xeFj9rqjNEG2TemACjAhDFycNf9V93Xldba1D5MwmWvPjuhkOKB96tbl2rppjx28IEIHf6Q2w1eqCgkQIWM8NVRid8kNj9p4VMFs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787146573; c=relaxed/simple;
	bh=4Z1j0j1UD3aCRnzp0jJ3gO79cTv6IxfKV9MKfqUk1x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZc/FV5egJuVFbdAZor1V+aSy/Xjrl+TrO85xmn7nUBdXf9C/oyeHr/P60GFDj6DyDIyoADH51VMer03BQcVPN9Cek6aPtDDDJw0O1uUHEKlS1fDgrf1W04mBYWtqN5iv+0w/O8VO85/3vEoA1Zeu7S00f6R5/dBbEwHR/ufVxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0rG0l2pH; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0rG0l2pH"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 611AB4E412D6;
	Wed, 19 Aug 2026 13:36:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2D8445FF42;
	Wed, 19 Aug 2026 13:36:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2EB8311C7570C;
	Wed, 19 Aug 2026 15:36:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787146563; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=5+UmtWGq+oMHHux+0HehZ/aRCJpMZvziH7JNziGQsos=;
	b=0rG0l2pHk+fEH/o1XxAD807Q9uWBMCC267HhjJmkCgNYcR7MZBcnWh0MsPxvJ2jCfC3jXa
	vO1LLHRjMSmgkdX89YAwrUA/jaKzr66jGgmn+ZPZUQfjUa/fNc+h3Zb/tD0f6IO08TYJXn
	0riNe2Y7A+FFzW30gPoZTaVHSlKaS5lEXpTP8Pgwpk0cvG9i9ZjNpuHTlSdce6YG6cvtkR
	PgRimfCBsrTRbnwalsI43HknSqPYn9GP7zetPfOq5dtIJKAoKqRIuo0VmulZPcNSNMdAlT
	KSderBxcRtXb8YGP5Shgx3LSI9RQUOUYuztT6WnIt/KMfrZr00yLXvIqW41cWQ==
Date: Wed, 19 Aug 2026 15:36:02 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: xianwei.zhao@amlogic.com
Cc: Yiting Deng <yiting.deng@amlogic.com>,
	linux-amlogic@lists.infradead.org, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: amlogic-a4: clear unsupported update interrupt
 feature
Message-ID: <20260819133602f197f6b5@mail.local>
References: <20260624-rtc-feature-v1-1-42dccd22c0ee@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624-rtc-feature-v1-1-42dccd22c0ee@amlogic.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On 24/06/2026 07:24:34+0000, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> The Amlogic A4 RTC does not support update interrupt. Clear
> RTC_FEATURE_UPDATE_INTERRUPT before registering the RTC device to
> prevent userspace from enabling an unsupported RTC UIE function.
> 

Because the driver supports alarms, it should support UIE. Is there any
reason the RTC can't handle arming alarms every seconds?
There are some that would only support alarms avery 2s, in that case,
please set RTC_FEATURE_ALARM_RES_2S.

> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
> Clear RTC_FEATURE_UPDATE_INTERRUPT before registering the RTC device.
> ---
>  drivers/rtc/rtc-amlogic-a4.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/rtc/rtc-amlogic-a4.c b/drivers/rtc/rtc-amlogic-a4.c
> index 50938c35af36..116cf095a9e9 100644
> --- a/drivers/rtc/rtc-amlogic-a4.c
> +++ b/drivers/rtc/rtc-amlogic-a4.c
> @@ -379,6 +379,7 @@ static int aml_rtc_probe(struct platform_device *pdev)
>  	rtc->rtc_dev->ops = &aml_rtc_ops;
>  	rtc->rtc_dev->range_min = 0;
>  	rtc->rtc_dev->range_max = U32_MAX;
> +	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->rtc_dev->features);
>  
>  	return devm_rtc_register_device(rtc->rtc_dev);
>  }
> 
> ---
> base-commit: 851d961ff248218f681c53cf0f7f08cf8201a117
> change-id: 20260624-rtc-feature-03ce3f3843a9
> 
> Best regards,
> -- 
> Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
