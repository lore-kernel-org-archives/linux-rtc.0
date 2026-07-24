Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68924334AE
	for <linux-rtc@vger.kernel.org>; Fri, 24 Jul 2026 13:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784899940; cv=none; b=dimFZ92KzCJHZ1PLM5Bbt8hm4iEtOH3fFf7iI/jMRNJ3t1v3/5mUWe8inoQMjiEuuX4excLsOOOrwm1BQsqXi+3Gg5OEHj5blwcFa+iRPiZfG/fc+0JxtDBbKOe9KLS9V6V6evkcN0C0q1l6ybKwyUDnj61LvQiitBoRqJonFF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784899940; c=relaxed/simple;
	bh=4Vz7bLvr5WHA0dMOR9VX2kvuY4SKO3y6uJgdiq2R870=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=inmmysZrA9rOTZxbf1sITHDzIBuzomKkuQwhuhV6osNsF5PxWGuf5wQFe94EQWooDFOORe02iBN9g/p/IC/IiwBE87gvbQZx6pc6YP+gRAUxg9hzsn5s7I77dWTQx50DGX/HYAw63Nh7Ml7T+yGkYfwvsf/30SDl3fP04+5flkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=MXn3c+v8; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="MXn3c+v8"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c0ecfaee7so3175501cf.0
        for <linux-rtc@vger.kernel.org>; Fri, 24 Jul 2026 06:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1784899936; x=1785504736; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VkOeO7FvZNYqVYKq41a3VAqmcoUNFjFQHw8ZY64/eu8=;
        b=MXn3c+v8CcJfC/ThAnBUNNHVun7sgB8Xm+1rBadMb4954ixexnRarA7qbFf1I/zTw2
         4hus4c+SkAuXsqLKSDyJaxk+TNDVJPLUY6XuRjWpHNeWyIKtphQokP9QTX95dx/cs34M
         i+ZIQvyQ0GluYwu9aAs7UBC10H1KSKIH2YtHC7pzMhRi1QmjU0xdyJr8c6bhR8F0C5uz
         Vmm9pzJKrP39O55yJzCGFtng37tHprujho0RrTSzydWYR6IidSQuGx5gPmiAo20M1KPS
         veuc0NJh2mlHQ3aRpuCktcYF0dBXJRsJZfF6eMzKu4mqH0qJWP5RjJMdc+yU/gnyOurS
         hpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784899936; x=1785504736;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VkOeO7FvZNYqVYKq41a3VAqmcoUNFjFQHw8ZY64/eu8=;
        b=RYWiVgY8eX9IhHFbTSXuYgINJKeWMGL7mfxrhidZbAK9plpDcYO59a6H+A5oFvxKQl
         EkWoGPpsXUIk4EjWO3KDRogMtAizj22Xl1bqIWseH1zsaLmcUSqpO7AaL6pyHOioBEo3
         LHnDcQekcUSlADOJxvOaZKAtciOt3DrrG57aSGONVwjnFd2TtQTfNtlHFIIuSvrXxXXv
         s3yalmTKew0oKNltO4V/iXrjoG648hlJc6ZY5oxe5x4r8kqod2gwK+EG6OLTHCE0kfDH
         y6rdG92TDdDG2lqXtXcRPkQpzyITvsURWS6doW1Wv2tqoD1JKpyux75dLz7dzqAx63W7
         YzdQ==
X-Gm-Message-State: AOJu0Yz3Ip6/Hmb1uem1oJoC8hT4ej/2TRm3/mCo3/xCGYC0NSTgd4L6
	zyZk9m5lkmJKGOlS9CznTyIphrtpDh4EkQwTldYe5JDNoyro44cG1wH5XwK4GKCSFaU=
X-Gm-Gg: AR+sD10zK2zkPF5SijUJXLKkpaQALG3nwI2ndv1iKYIY/9ck7vlB2ylIxAfxVei8Jzf
	XwlHYCoWgri6c7uEK2u/+6hggB3LlK3AzUJWhzudAgZB/hZ+HeYlja1iPYKWXFGXNLG4HAms+c6
	um0Ny7TuImMddDpyTPcPzDFvbqx3NiN287DT1Pe5HzSd1S+36q+MDR6hG/lUvel3oDD4Qpdu1gb
	il+JsqzIEas9u1RLm+de259OjHGknM9T5Sh9teZB+oFwWXC+fWRNOGDEpUS7FpBo6MZ4ABjqORK
	sjSWZ0CVqMJ0oDqgkpdFd1sAwzkhLUzHQGbCEVTn1RlTHIbgFlHJviZwXeFlC45rIWROC80u5LJ
	JjZcADziTx2UxjrVqJbJyZPqgpIdNKfOBtgwb30We5FxkSJXQAgyOqZdWg5iHKiW43VtXYYwc2Y
	cMog==
X-Received: by 2002:a05:622a:8c:b0:51c:db4:3cb2 with SMTP id d75a77b69052e-5283df63187mr68450411cf.63.1784899936358;
        Fri, 24 Jul 2026 06:32:16 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-527d0c4fe92sm53114091cf.11.2026.07.24.06.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 06:32:15 -0700 (PDT)
Message-ID: <39995013-3520-4290-a791-1f5d6a25388c@riscstar.com>
Date: Fri, 24 Jul 2026 08:32:13 -0500
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rtc: spacemit: handle regmap_test_bits() error return
To: kr494167@gmail.com, alexandre.belloni@bootlin.com, dlan@kernel.org
Cc: linux-rtc@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260724024220.10113-1-kr494167@gmail.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260724024220.10113-1-kr494167@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/26 9:42 PM, kr494167@gmail.com wrote:
> From: Surendra Singh Chouhan <kr494167@gmail.com>
> 
> p1_rtc_read_time() called if (!regmap_test_bits(regmap, RTC_CTRL, RTC_EN))
> to check if the RTC was enabled.
> 
> regmap_test_bits() returns 1 if the bit is set, 0 if not set, and a
> negative error code (e.g. -EIO) if reading the control register fails.
> Using !regmap_test_bits(...) evaluates a negative error code as boolean
> false, causing I2C/regmap read failures to be ignored and incorrectly
> proceeding to read time registers from a failing device.
> 
> Fix this by capturing the return value of regmap_test_bits() and returning
> the error code if negative, or -EINVAL if the RTC is disabled.
> 
> Fixes: a6de182daa2b ("rtc: spacemit: support the SpacemiT P1 RTC")
> Signed-off-by: Surendra Singh Chouhan <kr494167@gmail.com>

This is an I2C-based regmap, so yes, we do need to test
for errors when reading or writing registers.

I think this is a good fix.  I have a minor suggestion or
two below but either way:

Reviewed-by: Alex Elder <elder@riscstar.com>

> ---
>   drivers/rtc/rtc-spacemit-p1.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-spacemit-p1.c b/drivers/rtc/rtc-spacemit-p1.c
> index 43ab62494bb4..c1820c920ba3 100644
> --- a/drivers/rtc/rtc-spacemit-p1.c
> +++ b/drivers/rtc/rtc-spacemit-p1.c
> @@ -57,8 +57,9 @@ static int p1_rtc_read_time(struct device *dev, struct rtc_time *t)
>   	u8 time[6];
>   	int ret;
>   
> -	if (!regmap_test_bits(regmap, RTC_CTRL, RTC_EN))
> -		return -EINVAL;		/* RTC is disabled */
> +	ret = regmap_test_bits(regmap, RTC_CTRL, RTC_EN);
> +	if (ret <= 0)
> +		return ret ? ret : -EINVAL;	/* RTC is disabled or error */

Since regmap_test_bits() can return -EINVAL, I wonder if a
different error code would be better to indicate "disabled".
It can return -EBUSY and -EIO too, as well as anything any
regmap->reg_read() can return.  Scanning through the list of
basic error codes I don't have a good suggestion, unfortunately.

Otherwise, perhaps just:

		return ret ? : -EINVAL;  /* comment if you like */

>   
>   	ret = regmap_bulk_read(regmap, RTC_TIME, time, sizeof(time));
>   	if (ret)

