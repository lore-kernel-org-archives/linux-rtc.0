Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9699324DCF9
	for <linux-rtc@vger.kernel.org>; Sun, 19 Jul 2026 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784467790; cv=none; b=tgjBbG+tfibDMbIWzgU1cApgX66R+Qp7U95fHLtCBHJSSlyzyf+iZGvAp2Y5/DtVJ6oHYOcxCvRhn10CJdtKJ2Sxxloxu+9bnVQBdNKSK3teUnOKopS3mwhR3qgf7Jm96+NhgkoFyXsIExYPzkYy9aGsefst3PuEhaTrqZu8Lkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784467790; c=relaxed/simple;
	bh=Xaq7RQ3DmIHqyyvVvwMjeuLuuIAP7Ugenr1ER60EbtM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YrO1Jof2WQZK3MYwT0T7AJmhMk52mmNX5ACicrjgKW9ASqo9LzaIqUutZ5CNBTcdYG5WhISKVr3QSWmgh1NkopIUPWGSswiWhxlLqUIR5429+sV6BfLdEJP5CduZsV6S8Ar2gxWX1blFariD1xheELybaoud/7kYhWXW1k3oJRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=njfPPkRB; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="njfPPkRB"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so64348635e9.1
        for <linux-rtc@vger.kernel.org>; Sun, 19 Jul 2026 06:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784467787; x=1785072587; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oTTnLvB5EKr1ilWHZeKrVDJrENmEbx/nOStJCKmeMiQ=;
        b=njfPPkRBoGlVv2ArYuZPZR2D3wW8m5WWYQduo+n5egLfyRUZUEu/K/cQmmvuavdWpo
         uYAACsGS5yCvnI+wk059pRgWihoUvLN6mixIjmHp5p0U1eHgHQCYPN/xlLT06ukXsFdN
         Y0uI/6CpWCBOBfeL7ZOUDHlGI711QdUm0iucH+JzWFKrcQdLIcTpQ0kCIuJ0CkAC/DUh
         LT+HcNYxfGvUurAh1gTc1WW7UNpBZhYMds0rMNG1+Fq8rCjC/AwuLZ9aMlt8xoBKCu7I
         nzKjMAW70ieALOWlrTk/7QHK3GJlDakpgThf6slLtX3KLbV0Yf7juMxE2YhAIch5PHQg
         bj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784467787; x=1785072587;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oTTnLvB5EKr1ilWHZeKrVDJrENmEbx/nOStJCKmeMiQ=;
        b=E+rvV0ni5wifrVojnGmkFPEg33X0kaLqID0wTcM1Dqc+kv7MS2is+AxJMd95d+uzVn
         upxEpRREjkvOA79P8P+rWrdBdvm6E1cMSAZ1zLZ6E9DziwnmWpHBS0KBN+uq7W05zeZQ
         AWNa5lVoPlop8NiGRRl3Djt+89rOK+aeW2h/gjb59Fb8GwmT9QYi8/Osuu1u1NQmSFym
         BQIJrd2GZ0vC5ReCm//hDS/u9GWjdPfLdn6xeAipXb+4F3BswitGEYPfmm1qUfUe29o/
         9BwENS5YDSMzB38EkCj1pPUkjuJfBlloWmEBrgNKXt1QAVkPnacaUHKUuaITuQzn+dij
         ReNA==
X-Forwarded-Encrypted: i=1; AHgh+RqDiLGbW87tABvAvEBEFqZXQZxitMHuYUNzUUtUFEGm/5+glnoc55PwyWKOoifSOyZRQe51mjZSwYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDA0YhPQzBotUF7VJSqaxbSDoIwJpZCCmp2BF3VwjG8Bski7DF
	L/hDLVLSvrO77rzfXrrxDYBtgjnmwhc9dvrj7kggc22lCP7LNjhEnEyptvucR7Hj9U8=
X-Gm-Gg: AfdE7cnuK6+AfsZO/0UdxYafGmBjTuHZ8KqHjET5XAe+pB9TxawovUsMZMXm4/+IObd
	0na+M1jeeQX8WRPnTWSMJWZCnkKKGRn2hwkzK+nWwSDtFcLhpXU0ZWmh3pAaLjAhgsWonhpoIUR
	7OBaKFtffoomu7R91peeAGuD/t5dspbsSVQ8SeH8NZFQQGd0cXw1+H4GEihqhHf8VQ7fETbbc0P
	Ac++2rVrisjXYM574YOtmxItACta+/EIF3xoOf07KfCR93YEqRu1yeyCGtmi4FnQd/u3gUZwhER
	V4+HQqkQmoJl840ZPfgAVfd+WIePHz9NR5ItVeCXeC0ZeoqoWuXW7eXYKhhlessJggo+qTFyStW
	6mQl7lieHtYRMjPCQbk7j3tofmN6bS/CQjssjCVJR7FLyi6UkNiHOhPv3nFXNSx6BKW6yC5n10R
	g=
X-Received: by 2002:a05:600c:4743:b0:493:bc4a:fb55 with SMTP id 5b1f17b1804b1-4954a508d60mr115272795e9.38.1784467786385;
        Sun, 19 Jul 2026 06:29:46 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:9a7:ef90:b513:8cdd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4954a2b87c6sm353074595e9.7.2026.07.19.06.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 06:29:45 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: sashiko-reviews@lists.linux.dev,  robh@kernel.org,
  linux-rtc@vger.kernel.org,  conor+dt@kernel.org,
  devicetree@vger.kernel.org,  linux-sunxi@lists.linux.dev,  Alexandre
 Belloni <alexandre.belloni@bootlin.com>,  linux-clk
 <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v5 2/4] clk: sunxi-ng: div: add read-only operation support
In-Reply-To: <CAGb2v65PmMnm=gusbVRJqwHkMFAdKpFyk8coXK=pf0-dBgv8kw@mail.gmail.com>
	(Chen-Yu Tsai's message of "Sun, 19 Jul 2026 18:59:33 +0800")
References: <20260717-a733-rtc-v5-0-3874cc26abf7@baylibre.com>
	<20260717-a733-rtc-v5-2-3874cc26abf7@baylibre.com>
	<20260717154005.444E41F000E9@smtp.kernel.org>
	<CAGb2v65PmMnm=gusbVRJqwHkMFAdKpFyk8coXK=pf0-dBgv8kw@mail.gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Sun, 19 Jul 2026 15:29:43 +0200
Message-ID: <1jqzkzds54.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On dim. 19 juil. 2026 at 18:59, Chen-Yu Tsai <wens@kernel.org> wrote:

>
>> > +
>> > +     } else {
>>
>> [ ... ]
>>
>> > @@ -143,3 +157,15 @@ const struct clk_ops ccu_div_ops =3D {
>> >       .set_rate       =3D ccu_div_set_rate,
>> >  };
>> >  EXPORT_SYMBOL_NS_GPL(ccu_div_ops, "SUNXI_CCU");
>> > +
>> > +const struct clk_ops ccu_rodiv_ops =3D {
>> > +     .disable        =3D ccu_div_disable,
>> > +     .enable         =3D ccu_div_enable,
>> > +     .is_enabled     =3D ccu_div_is_enabled,
>> > +
>> > +     .get_parent     =3D ccu_div_get_parent,
>> > +
>> > +     .determine_rate =3D ccu_div_determine_rate,
>> > +     .recalc_rate    =3D ccu_div_recalc_rate,
>> > +};
>>
>> [Severity: High]
>> Could the missing .set_parent callback in ccu_rodiv_ops lead to a silent
>> desynchronization between the software clock tree and the hardware?
>>
>> The struct provides reparenting capabilities via .get_parent and
>> .determine_rate, but omits .set_parent. If a rate request causes
>> ccu_mux_helper_determine_rate() to evaluate and select a new parent, the
>> Common Clock Framework will apply this new parent in software but skip
>> updating the hardware since .set_parent is NULL.
>
> This is an issue. I'm not sure if what Sashiko says actually happens.

I think it could. I've defenitely made a mistake here.

> But 1. this is "read-only divider", not "read-only mux & divider",

The correct way to choose between the 2 is CLK_SET_RATE_NO_REPARENT I think.

> so the .set_parent callback should be provided. And 2. this is using
> the ccu_mux_determine_rate_helper, so it's possible a clk_set_rate()
> call is going to cause a reparent.
>
> I can add it while applying if there are no other issues.

As you prefer, I don't mind sending another version in a few days
(giving some review time to patch #1)

>
> ChenYu
>
>> This would leave all downstream clock rate calculations incorrect.
>>
>> --
>> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717-a733-rt=
c-v5-0-3874cc26abf7@baylibre.com?part=3D2
>>

--=20
Jerome
