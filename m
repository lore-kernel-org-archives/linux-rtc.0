Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F3924DD17
	for <linux-rtc@vger.kernel.org>; Sun, 26 Jul 2026 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785078972; cv=pass; b=ujINyPfohgtTvXvN1WcogTLb2s/MkJrLv0AjR92w4iGs4G/ej2ltS87moR3mMppoz5eHgjlSsg1+dEDtEwLED5TX1cYllx9V4TO4CqyV3JmHsD//d3zobYk05nVTFdC0wBYjN4oZjCiYL/h91pVZUkQrV9VK01zKe35hlyPzCqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785078972; c=relaxed/simple;
	bh=TWerGqVdBjEBG1N0LmaVsGNSMTfvwB+N7AwXE1/zGGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YT9fhJYXdGurpuKjulcj4rlvcXHgstmfqj3Ns4Y7uOdzEqwAqPdK9Hz2Pl+K6NafZaymE1zPAwWJ/0kW60nFLN8Rc5ZpH2FjgZuHK4agX4xw6DhM4Ngvsj9xEmAdYO5Ka/hHCPsM4UM+re7ZbtcFSEIQ4lbhaZxve/f+4snRWk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kH7oGc5L; arc=pass smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kH7oGc5L"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6aaf2f9ce3dso749672eaf.1
        for <linux-rtc@vger.kernel.org>; Sun, 26 Jul 2026 08:16:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785078970; cv=none;
        d=google.com; s=arc-20260327;
        b=MkmA44eNNX58GDa1pwv1DlStNtbhrfJzwmSPlkOqlVXbAFQc47rE/mdkfVnvh3ksF2
         ZD5ZZjGT0qZQfwCmy4BPTxi5RFL+eItjdA4pDzjqgHr5NCQAkNIpiZBHiMW2aRR+xIKU
         HqXTc75pWBLJYx1AHwWzBlfExzS1JQPiiFSVYAcgWB/uO2aMhTRh4SCtBMJNOaoRldvB
         iZ+5gGS8IZ7LzKbe6F7QIrTMbjKuREDV6WITknMuIvCCPFveOD05zPDguRvSY9Sea+My
         RIPC+MSt7x2l0o64NvuaTEhX3VbO9QcIIP5455WCg7la5TQ2/RBQQIZyFtC8MinY0MI2
         +ROQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jMIou7laWwsLhO0AMdNsLPcQONV9DUMoZ+TZ+5bQCzI=;
        fh=ly/oP7gsWj30DZHabpg9K5+Ra02z21e9aqNtGIzDCuI=;
        b=ikb2MIf0HN9svEw6CuRuPEFV84+yjTcFe6Oc7kQ2RumpqJ9Q+MzO0MzJqJKB6wmY54
         X9YCFDa5C2tNUT6Ae1B12BGyJxxwW5SNNNT3tzuz5WtKk+nL/AGY74lUQkasMu7C6rcW
         ICvodSCj4RpQtclHSs+rf27CFTXjlpMyBXWQpjoFuwyJV/iYQBAp0tgayuf7x0MNDjGY
         p2LrjaTcJhbgMNft+/FdUFp6Vtg5v/VZRbU0cAnxAtxEcK6viqPWD2lyVamhTwThjxXf
         4LsJxxxoE5PFItSCQ1uCUWT8okGw2npeZYp0whrVLrN+f6S+hAXOdDPjxsLzdRih8Fjz
         K7NQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785078970; x=1785683770; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jMIou7laWwsLhO0AMdNsLPcQONV9DUMoZ+TZ+5bQCzI=;
        b=kH7oGc5LIaZaRVhze5Hw0Cbye2jLI55ocMzz72DFegf4/LQBX7du7paOtL1s2nsVVl
         RiB6kkzkJAiDM8HcMoznHVYkU314Qu5iTC7AzikISCrMXId/XGl73/zYPioGcqWd7rwa
         ynLEizaYhljDE6oI0TmB7+ZCAPuxn1pCf5juLvzTVCge5iXF8fHOjIVYjSq5aoWYA5++
         ZR2clBN8u6fbpYjMlMWEqsgLWeLKBDM/aDDX/VysSz98qyB0oM1tPqG/AYxHLgXbcmsz
         OHtJgJvyvKDgOp09zOPDhnonTA+jSspUFu17HsKToP4evtreQ5DeKdcBVofrPalKmqqc
         //tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785078970; x=1785683770;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jMIou7laWwsLhO0AMdNsLPcQONV9DUMoZ+TZ+5bQCzI=;
        b=RtNumqqafIe8/y/u0bJUWpKnqAsO/lIfoKdYzcsChiyMpInbb+re8sIItXXa44LFrK
         ikOnGEklDspP2I87sJBO/udmwwB71z3KzClbxDnbniNu5nCjRMywQtRPH0sZRqt1Z2wt
         TxdDwamN7G55391hEk9OiOygp0eWZD3Nd3ZUztIALGPbGBA8DxJu4e/4mSBbYxV0hVcO
         ruyMErjwD52MKqPAZEoT0zy2B2Rj25h9M0b7B3t5ywv03v12BCZwg5JH4vL0gCNpkfzq
         2uxXifu97Xzg3Vo0DtEftMsr745UA3emM1vSWb60X/ditgyiWARFiCYwx6605yqVQV9W
         o3vg==
X-Forwarded-Encrypted: i=1; AHgh+RptFgxMM6wteSvPkwqYzCzPQ3Fui+abW+GDOnNNHgK8fht1nC1vA8GpUyx5ppu+r6RbBPiOblyzNdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyjemI6uTnIwmlFQdRYZKgwCIGvTCVkWa0RyfPt2APHRCl16pM
	uu4cXSruM0eO6OevOhc04oxVpyXbx1yWGFjvxG/c52hM/qC/y5/MLlxIsg52PlNj6AxQ/yz4LOn
	P37/MEU83zbtOB2R0AXgAx17AYSOG7yY=
X-Gm-Gg: AR+sD12ymAwG9aQBlLBeV3LUkUOLr9xJqv/4jWe/Z9qGtTZH74cpCsQgCUiIj8UkogC
	BASWjdidNKqOglhz4BiT/JNMo46od3Si9x4DN3NwrkRrORxTNbqdDIqs4wZ/a4hHA+vz0Ufed79
	2h78kMpD7Orqoa13+gTCBpZFRR3FFsFdAhS3wnyWWR+86oqNuPdRGj0KCPrnaJa656OwjMZtmLC
	zEplHEgQ9tEP1SGKfqHkbtsEBrSx2V+fLfOPhgBjKHhC6T7P8MN6A9qubRX+Q==
X-Received: by 2002:a05:6820:f008:b0:6aa:e436:9930 with SMTP id
 006d021491bc7-6aaff99f310mr3935654eaf.21.1785078970497; Sun, 26 Jul 2026
 08:16:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723184538.3888637-1-ekffu200098@gmail.com> <20260723184538.3888637-30-ekffu200098@gmail.com>
In-Reply-To: <20260723184538.3888637-30-ekffu200098@gmail.com>
From: Bruno Thomsen <bruno.thomsen@gmail.com>
Date: Sun, 26 Jul 2026 17:15:54 +0200
X-Gm-Features: AUfX_mwuTyvufEEqfV1DrvXKVeoz07p2bdZcc-g6WVPL3BiLOG5iAxIUoLYwBi0
Message-ID: <CAH+2xPB1CQ=_FgBFUZ7dg=R3wKYwu27ndybWeX8XwsKtvYFsQw@mail.gmail.com>
Subject: Re: [PATCH 29/36] rtc: pcf2127: remove conditional return with no effect
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Julia.Lawall@inria.fr, Alexandre Belloni <alexandre.belloni@bootlin.com>, cocci@inria.fr, 
	linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Den tors. 23. jul. 2026 kl. 21.02 skrev Sang-Heon Jeon <ekffu200098@gmail.com>:
>
> Both branches of the check return the same value, so the check has
> no effect. Remove it and return the value directly.
>
> This is the result of running the Coccinelle script from
> scripts/coccinelle/misc/cond_return_no_effect.cocci.
>
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>  drivers/rtc/rtc-pcf2127.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> index 1995e9f2756d..ff2023908f5a 100644
> --- a/drivers/rtc/rtc-pcf2127.c
> +++ b/drivers/rtc/rtc-pcf2127.c
> @@ -1184,12 +1184,7 @@ static int pcf2127_configure_interrupt_pins(struct device *dev)
>         if (ret)
>                 return ret;
>
> -       ret = regmap_write(pcf2127->regmap,
> -                          PCF2131_REG_INT_A_MASK2, 0);
> -       if (ret)
> -               return ret;
> -
> -       return ret;
> +       return regmap_write(pcf2127->regmap, PCF2131_REG_INT_A_MASK2, 0);
>  }

Reviewed-by: Bruno Thomsen <bruno.thomsen@gmail.com>

>
>  static int pcf2127_probe(struct device *dev, struct regmap *regmap,
> --
> 2.43.0
>
>
