Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DA838C2A0
	for <linux-rtc@vger.kernel.org>; Thu, 23 Jul 2026 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784801771; cv=none; b=cKM82qlD9OpIMdXtHIcR6edQur5BlAgt+EmLT3r+Za21WCJXWgH1J4v4iaPI45446u6H+Re+wmdLKVMtQsWUWYHf/dvc2DpS30ja9iZmuZUbTvofHwMNigrMcfiq5o4ZOOENR43SA7C9cOhBiIAeqX5StB+S0OaM9eYlxKjZYzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784801771; c=relaxed/simple;
	bh=CHwYmjjXvq+8uROkOrJZ4JWdMaxoWOILzhysYy6KQXg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RZW9OWBXkUJ9/IRmrE7edr/c0cbzIf12xBYZujLtPQH+ohpSTqft50NinQ2XTQ+6DbGQpcHGc2+/wckEEOCawBfuV6F+Iuo6AfONT0x/NbQANCp2ziBp0DExczmdyxjVGlVtA9kRn9qSk1CPBf2SiIjFj4B6p3bzHpZv61r++WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=lGtt+/u0; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="lGtt+/u0"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-495635a85d2so4555335e9.0
        for <linux-rtc@vger.kernel.org>; Thu, 23 Jul 2026 03:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784801767; x=1785406567; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SvxQyKuOV5lWONhd9i+2aKTNhL+M8+Dbfq8CvjA8KJA=;
        b=lGtt+/u0YfYSKqvroKUSigqJYndz+JpdYW2B0yaMkliRVsvzvlH14RnQuv1vIM8T1X
         sM7UL4FTt0DRP8hTOSTBERMQ2o+oWAFkr+GlM9BHZzmOehLUZK8exi+1+PG1Le72C3h6
         gpqlQipI6ZoqqZxIJZWQAZnxo8s/LB7eM4cvQcZV/HNgwSheGPqji1dSLI6z0SBKRzy6
         0itl6adA1pJobbCujZHj5pbMQ4QCMMm6isEYaUqKYa/yKQN/TxsOhWo2S9U27FjVwyEb
         hjxtHgabbZOBYas8RhkaVJU2cf8LReL0zT7GLKUFNQmOrRygU0/rLmk9zvHB1Hr7/QT6
         ukAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784801767; x=1785406567;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=SvxQyKuOV5lWONhd9i+2aKTNhL+M8+Dbfq8CvjA8KJA=;
        b=HTqyAU0tBOkqmmqZgqRYC4dabY9YyL83Q1coyhayCTvxj2bA9ny8aejERm67EmxEOh
         2/2qNyKRfv2mJGJzfWy37k2vg4/LY5PFk2+Ik0re2GdcspoTVduNMiWiwXjdK6vCVCFN
         4zILZdsIZKvwre9qb7uQnL7rSZIugxigCaub13imIFbui56XzXn8fbVdqjxxSs8UZSgC
         hxtjrjHnoColzE9mvfRfhti/JvraLqOPa2Fr4Km/ZiWy3Ey5WBlk5lN1ACaBUvIWZ1Gx
         7W8CJM8eoPUiyxvEXrWYjlTIVbN8Uqh1DADZ2oUXP+fnpraEZVuDHnSqOyp5LsEemtVa
         EZOg==
X-Forwarded-Encrypted: i=1; AHgh+RqHyQu/HGdHaObmbNdyaunS6b+0nolfjfpoZI1whkMOCqM+SyUzmP7oxLszwg2NR3JfcsKbJdBk0B4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIVHPfP0+7arEFlhqsT3uZOj5X+7k/IKn8FxlrezBuxFzMmFKO
	8d+RgDS/uYEEdWCo2JMoAKavU4LsMkSuSVhcz84caGyPwLx0OFMr/en4wTIYW9Did+o=
X-Gm-Gg: AR+sD11TP8M33K/R2dUWqQ2v9l4Zf0VdCvZ0DO6fUWIuCnAji1EWoPhIOke8wrAjiEz
	SUruf+zEF59nSWZSemFojFuYCcAooaFnn54zjh2f5gNsc7gVXFt5MfLSfToXAHNlNnMbAXNpZz5
	voPcyzdJ095btplDVqamZXSp7xyweWZktFtYC4DlnQH0x+x2j6Ky3dHbORy1nXXHHPmcj3PLe/a
	iMQZ/HIWeoe2rJs3b7zCDE7uzQSllS8AhamPYD0WeFT1pjGNFU90TvpuYJc6LSJ6f5zaaCka1O2
	E3x4uzZPR5IdVlnKL16NFvetlcZpM+3IVcUsB9VMU9UL8JTrgxLo3dsaXI389tK2AyCDcRjDDEY
	ZUgDUUWlBgVegAQyjMpbaDgN9YhKkyst32mAQWT+oyQMaG9yhmp+WuNFeqUEL5aOx0PPYYcV4Ga
	GQ
X-Received: by 2002:a05:600c:468e:b0:493:f140:c3fb with SMTP id 5b1f17b1804b1-49573cc12efmr27600575e9.7.1784801766924;
        Thu, 23 Jul 2026 03:16:06 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:3274:dbb5:2710:802b])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4956a508aa6sm143386295e9.7.2026.07.23.03.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 03:16:06 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev,  robh@kernel.org,
  devicetree@vger.kernel.org,  linux-sunxi@lists.linux.dev,  "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>,  linux-rtc@vger.kernel.org,
  conor+dt@kernel.org
Subject: Re: [PATCH v7 1/4] clk: sunxi-ng: mux: fix determine helper rate
 propagation
In-Reply-To: <20260723095821.629AF1F000E9@smtp.kernel.org>
	(sashiko-bot@kernel.org's message of "Thu, 23 Jul 2026 09:58:21
	+0000")
References: <20260723-a733-rtc-v7-0-8fd68aab94ae@baylibre.com>
	<20260723-a733-rtc-v7-1-8fd68aab94ae@baylibre.com>
	<20260723095821.629AF1F000E9@smtp.kernel.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 23 Jul 2026 12:16:04 +0200
Message-ID: <1jh5lqc8pn.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On jeu. 23 juil. 2026 at 09:58, sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> New issues:
> - [High] Treating the pre-divider as a post-divider changes the rounding
> order, causing a mathematical mismatch between `determine_rate` and
> `recalc_rate`.

I don't get what sashiko is trying to say here. determine_rate() and
recalc_rate() do the same thing.

Once determine rate is done, it gets the parent rate and apply the
prediv, which simulate what the signal actually does.

recalc_rate() does the same thing.

So there is confusion here ... from sashiko or from me :/


>
> Pre-existing issues:
> - [High] `ccu_mux_get_prediv` fails to translate hardware indices to
> logical indices for the active parent, breaking pre-dividers in
> `recalc_rate`.
> --
>
> --- Patch [1]: [PATCH v7 1/4] clk: sunxi-ng: mux: fix determine helper rate propagation ---
> commit 3ac5416eb08e665a33aeec5afae741b08d4fdb57
> Author: Jerome Brunet <jbrunet@baylibre.com>
>
> clk: sunxi-ng: mux: fix determine helper rate propagation
>
> Applying the pre divider on the parent rate is wrong because, while
> handling rate propagation through determine_rate(), the framework will
> likely round the parent rate again while cycling through the possibilities,
> throwing away the prediv applied. This means, the parent rate will then
> be wrong when the prediv is unapplied from a parent rate on which it
> was never applied to begin with.
>
>> diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mux.c
>> index 09230728c4009..4503c9780c39f 100644
>> --- a/drivers/clk/sunxi-ng/ccu_mux.c
>> +++ b/drivers/clk/sunxi-ng/ccu_mux.c
>> @@ -92,66 +92,65 @@ int ccu_mux_helper_determine_rate(struct ccu_common *common,
>>  		struct clk_rate_request adj_req = *req;
>>  
>>  		best_parent = clk_hw_get_parent(hw);
>> -		best_parent_rate = clk_hw_get_rate(best_parent);
>> -
>> +		adj_req.best_parent_rate = clk_hw_get_rate(best_parent);
>>  		adj_req.best_parent_hw = best_parent;
>> -		adj_req.best_parent_rate = ccu_mux_helper_apply_prediv(common, cm, -1,
>> -								       best_parent_rate);
>> +
>> +		/*
>> +		 * This effectively treats the predivider as a postdivider.
>> +		 * It stays mathematically correct and ensures whatever
>> +		 * round() will do stays correct while walking the tree.
>> +		 * It may query the parent rate too while handling rate
>> +		 * propagation.
>> +		 */
>> +		adj_req.rate = ccu_mux_helper_unapply_prediv(common, cm, -1,
>> +							     req->rate);
>>  
>>  		ret = round(cm, &adj_req, data);
>>  		if (ret)
>>  			return ret;
>>  
>> -		best_rate = adj_req.rate;
>> -
>>  		/*
>> -		 * best_parent_rate might have been modified by our clock.
>> -		 * Unapply the pre-divider if there's one, and give
>> -		 * the actual frequency the parent needs to run at.
>> +		 * parent_rate might have been modified by our clock as part
>> +		 * of the rate propagation mechanism. Same goes below.
>>  		 */
>> -		best_parent_rate = ccu_mux_helper_unapply_prediv(common, cm, -1,
>> -								 adj_req.best_parent_rate);
>> +		best_parent_rate = adj_req.best_parent_rate;
>> +		best_rate = ccu_mux_helper_apply_prediv(common, cm, -1,
>> +							adj_req.rate);
>
> [Severity: High]
> Does treating the pre-divider as a post-divider here cause a mathematical
> mismatch between determine_rate() and recalc_rate()?
>
> Because integer division with round-up does not commute, this inverted
> calculation order yields different results compared to recalculating the rate.
>
> For example, given a parent rate of 100 Hz, pre-divider 3, and main divider 8
> for a target rate of 4 Hz:
>
> - determine_rate() evaluates DIV_ROUND_UP(100, 8) / 3 = 13 / 3 = 4 Hz.
> - recalc_rate() evaluates DIV_ROUND_UP(100 / 3, 8) = DIV_ROUND_UP(33, 8) = 5 Hz.
>
> Could this violate the clock framework's requirement that determine_rate()
> accurately predicts recalc_rate(), potentially causing rate deviation warnings
> or infinite loops during rate setting?
>
>
> [Severity: High]
> This isn't a bug introduced by this patch, but while reviewing the pre-divider
> logic, I noticed a potential issue in how hardware indices are handled when
> the parent_index is less than 0.
>
> drivers/clk/sunxi-ng/ccu_mux.c:ccu_mux_get_prediv() {
>     ...
>     if (parent_index < 0) {
>         parent_index = reg >> cm->shift;
>         parent_index &= (1 << cm->width) - 1;
>     }
>     ...
>     for (i = 0; i < cm->n_fixed_predivs; i++)
>         if (parent_index == cm->fixed_predivs[i].index)
>             return cm->fixed_predivs[i].div;
>     ...
> }
>
> Does this fail to translate hardware indices to logical indices for the active
> parent?
>
> When ccu_mux_get_prediv() is called with parent_index < 0 (e.g. from
> recalc_rate), it reads the raw hardware index from the register. It then
> compares this directly against fixed_predivs[i].index, which is populated with
> logical indices.
>
> Could this cause recalc_rate() to report an incorrect clock rate by falling back
> to a pre-divider of 1 instead of the configured pre-divider for clocks with both
> a hardware mapping .table and fixed/variable predividers?

-- 
Jerome
