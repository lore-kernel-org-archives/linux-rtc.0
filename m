Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAAA2BEC4E
	for <linux-rtc@vger.kernel.org>; Thu, 22 Jan 2026 00:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769041578; cv=none; b=iF8R/3X3Ww10v1llMu5ZQQQ44kGRzQ2xOVAzuF+JTTjEIa24vRHYVFXNdLlz5cAL8RoLJ6C0hAIVzR6SmFtrVH484HPv889mnY1+nFQJfv/2emTY1Re1AOsdJk6Y7NFK/ZzpWxRXjCx962XDnWIhoZNto4h+ej+SL/zA5xjxuX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769041578; c=relaxed/simple;
	bh=hP+9fk7VaCo2SPT/AetIm7YfIJIqEA8BJRaRGX3vSrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beA7KNagwU/4j4sQliXdaQuL7IWXYFruvtk1L2Te/JQDskTONcR893IobqlGf70t948lOFYq4egSybwFnSlwDdh7rrrtnhFurQMeN2rTgwiP4czi++Zi/TmiVl0HRW2vxfEsLXL+rIem2xBb6dsgfojwGsaBszYjcAGIQjb7oMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2eXjaZn+; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2eXjaZn+"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id BEB2EC21A95;
	Thu, 22 Jan 2026 00:26:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 010EC60711;
	Thu, 22 Jan 2026 00:26:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0D39D102F0B74;
	Thu, 22 Jan 2026 01:26:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769041572; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=x4jg29QU41LLNzuVU5AM3L7b1Wlo+jm9c6ZZ5u4Zv4A=;
	b=2eXjaZn+jaZCAHoQX8mXzr+COm0SdUn4VylHsLTEi0nPXCh+HiD9OdSCL17urswEnm1bPv
	YICTmjXUKNQB6boklJvHme4rm+WRCTKf3v7PgoIVEr/7W3umx3E0sKLEmcf04TFCdokodY
	PGmznMvhodZsSnsBu2x1dk2FpiAF4T62Hr4ZXR3q75VaAafPbgAfOVhmOA0Tx1tChHLHi2
	KA7rD8wPRquZt4IuGB1Wa8owWlvKUaqyD3qTpa7/iqjnAUxY25kSHYJif+G/LAyM8bPwTG
	sHICX4Igpx2fDePAbJLfnk8PrTM1QO20F7dZsnsI143NZi4Uf0KJT7gZWgxNIg==
Date: Thu, 22 Jan 2026 01:26:09 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Brian Masney <bmasney@redhat.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 03/27] rtc: ac100: convert from divider_round_rate() to
 divider_determine_rate()
Message-ID: <202601220026092a75a45e@mail.local>
References: <20260108-clk-divider-round-rate-v1-0-535a3ed73bf3@redhat.com>
 <20260108-clk-divider-round-rate-v1-3-535a3ed73bf3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108-clk-divider-round-rate-v1-3-535a3ed73bf3@redhat.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On 08/01/2026 16:16:21-0500, Brian Masney wrote:
> The divider_round_rate() function is now deprecated, so let's migrate
> to divider_determine_rate() instead so that this deprecated API can be
> removed.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> 
> ---
> To: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: linux-rtc@vger.kernel.org
> ---
>  drivers/rtc/rtc-ac100.c | 75 +++++++++++++++++++++++++------------------------
>  1 file changed, 38 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-ac100.c b/drivers/rtc/rtc-ac100.c
> index 33626311fa781b5ce90dcc472f948dc933bbc897..16aca4431da8c029e6195d8a3c9fe75fa95d0bc0 100644
> --- a/drivers/rtc/rtc-ac100.c
> +++ b/drivers/rtc/rtc-ac100.c
> @@ -140,42 +140,16 @@ static unsigned long ac100_clkout_recalc_rate(struct clk_hw *hw,
>  				   AC100_CLKOUT_DIV_WIDTH);
>  }
>  
> -static long ac100_clkout_round_rate(struct clk_hw *hw, unsigned long rate,
> -				    unsigned long prate)
> -{
> -	unsigned long best_rate = 0, tmp_rate, tmp_prate;
> -	int i;
> -
> -	if (prate == AC100_RTC_32K_RATE)
> -		return divider_round_rate(hw, rate, &prate, NULL,
> -					  AC100_CLKOUT_DIV_WIDTH,
> -					  CLK_DIVIDER_POWER_OF_TWO);
> -
> -	for (i = 0; ac100_clkout_prediv[i].div; i++) {
> -		tmp_prate = DIV_ROUND_UP(prate, ac100_clkout_prediv[i].val);
> -		tmp_rate = divider_round_rate(hw, rate, &tmp_prate, NULL,
> -					      AC100_CLKOUT_DIV_WIDTH,
> -					      CLK_DIVIDER_POWER_OF_TWO);
> -
> -		if (tmp_rate > rate)
> -			continue;
> -		if (rate - tmp_rate < best_rate - tmp_rate)
> -			best_rate = tmp_rate;
> -	}
> -
> -	return best_rate;
> -}
> -
>  static int ac100_clkout_determine_rate(struct clk_hw *hw,
>  				       struct clk_rate_request *req)
>  {
> -	struct clk_hw *best_parent;
> +	int i, ret, num_parents = clk_hw_get_num_parents(hw);
> +	struct clk_hw *best_parent = NULL;
>  	unsigned long best = 0;
> -	int i, num_parents = clk_hw_get_num_parents(hw);
>  
>  	for (i = 0; i < num_parents; i++) {
>  		struct clk_hw *parent = clk_hw_get_parent_by_index(hw, i);
> -		unsigned long tmp, prate;
> +		unsigned long prate;
>  
>  		/*
>  		 * The clock has two parents, one is a fixed clock which is
> @@ -199,13 +173,40 @@ static int ac100_clkout_determine_rate(struct clk_hw *hw,
>  
>  		prate = clk_hw_get_rate(parent);
>  
> -		tmp = ac100_clkout_round_rate(hw, req->rate, prate);
> -
> -		if (tmp > req->rate)
> -			continue;
> -		if (req->rate - tmp < req->rate - best) {
> -			best = tmp;
> -			best_parent = parent;
> +		if (prate == AC100_RTC_32K_RATE) {
> +			struct clk_rate_request div_req = *req;
> +
> +			div_req.best_parent_rate = prate;
> +
> +			ret = divider_determine_rate(hw, &div_req, NULL,
> +						     AC100_CLKOUT_DIV_WIDTH,
> +						     CLK_DIVIDER_POWER_OF_TWO);
> +			if (ret != 0 || div_req.rate > req->rate)
> +				continue;

This leaves a braces inbalance

> +			else if (req->rate - div_req.rate < req->rate - best) {
> +				best = div_req.rate;
> +				best_parent = parent;
> +			}
> +		} else {
> +			int j;
> +
> +			for (j = 0; ac100_clkout_prediv[j].div; j++) {
> +				struct clk_rate_request div_req = *req;
> +				unsigned long tmp_prate;
> +
> +				tmp_prate = DIV_ROUND_UP(prate, ac100_clkout_prediv[j].div);
> +				div_req.best_parent_rate = tmp_prate;
> +
> +				ret = divider_determine_rate(hw, &div_req, NULL,
> +							     AC100_CLKOUT_DIV_WIDTH,
> +							     CLK_DIVIDER_POWER_OF_TWO);
> +				if (ret != 0 || div_req.rate > req->rate)
> +					continue;

Ditto.

> +				else if (req->rate - div_req.rate < req->rate - best) {
> +					best = div_req.rate;
> +					best_parent = parent;
> +				}
> +			}
>  		}
>  	}


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
