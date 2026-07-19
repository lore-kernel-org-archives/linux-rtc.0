Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E664A391501
	for <linux-rtc@vger.kernel.org>; Sun, 19 Jul 2026 10:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784458396; cv=none; b=t7gaT6vbvIijZo/lqOSTGPjFI/6bZNAuryidnHH8zxX7/RmS4PLdnV1g323Uk7X9na1l4zMaRKwd2/Ay73EFvBg/y6AoagWDFFve/rJY5Lvs+gmwPHKdZqVK55pSnMJHMPysdMs413unhCinZPCnD+rKd1RoXEqmZlRBipMvWVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784458396; c=relaxed/simple;
	bh=xiWJCg+K70PNnHYQYuop9vFbcWQnQg/pw4mdJOG9ZdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=abRU33zgn7R2693oEYx/XtVI5DjtVeVEvlcXz0BGmiuBFo3ovv4J/KZV8x6Idk7Dwp0h25k+fIUw9lewihnIs7yYi7G9d//kg2m991NvjdIsnPZPRTeqbjq7sLRLgMgc8FcGQP0/+7r5kbCN8TMpCHm3ESLbLE54QZWgsIY7BUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyTJgIkf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyTJgIkf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40511F00ADE
	for <linux-rtc@vger.kernel.org>; Sun, 19 Jul 2026 10:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784458394;
	bh=xiWJCg+K70PNnHYQYuop9vFbcWQnQg/pw4mdJOG9ZdI=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=ZyTJgIkf1FoSvkAQx9ZMwsuHcg4db2Ntmm6SsBGxLQeVWueg+ib7i3xjE9+4kRM9x
	 CHUJ3maizZsg4LjP8kh3ujq9uO8PI+0WAESkcMswfHvOt8nI8rjoNPQbfA56eIHE36
	 1fRboNAK1KhN0aJ1Qmz2q9CrveQHTAGKvHTkpYIlA32H81lD/PqlmfbtMuEuu0PDfA
	 GNQUvXSdYgdxw83nMt0N69UDsAvWG7Lvhu4QaKK9IcUQl53tQ3bZRQoduheKBKjFQ7
	 NTQx9IzH2va9jzoz3dtv0LFFguXoqA9V9M0lNviMzFvzT0rGOPPtBHN8hRl1l3mfGv
	 F7dHQikmWYKwg==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39c74722e27so34814141fa.0
        for <linux-rtc@vger.kernel.org>; Sun, 19 Jul 2026 03:53:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpZJCuWjPhIEPhzOVd8IyHq1lnKGGnLBUagtr7jlPYV+AmNJI/mdW0/h6yRX3eMmJhWZzYSnJQ8w+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvIhLRve2J3Y7jWGYBUOHeVJk130oV4CJdbxSHLTKlt/RFu36j
	r26bJyVRd6T5RBPZvHcZikCc2czRgE5N6Uzcde2mBgjPaJv/Rb/CECvyLlDJNh1w11Hh85Ik1iw
	Zais1JSvzb0wIxYQKh4kJF3+karafWQo=
X-Received: by 2002:a2e:a286:0:b0:39c:6a3c:953a with SMTP id
 38308e7fff4ca-39ea015858fmr15722871fa.11.1784458392988; Sun, 19 Jul 2026
 03:53:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717-a733-rtc-v5-0-3874cc26abf7@baylibre.com> <20260717-a733-rtc-v5-1-3874cc26abf7@baylibre.com>
In-Reply-To: <20260717-a733-rtc-v5-1-3874cc26abf7@baylibre.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sun, 19 Jul 2026 18:53:00 +0800
X-Gmail-Original-Message-ID: <CAGb2v657_62Ky=oNyx-WK1=UuSBvOeMxyEZ+ifxp-Gp0LmVCag@mail.gmail.com>
X-Gm-Features: AUfX_my_i9ygLUgOUcSlS_CiEH1KIWUcMgqwo_sNf9Y9u0foqvVGbsR0em4SCF0
Message-ID: <CAGb2v657_62Ky=oNyx-WK1=UuSBvOeMxyEZ+ifxp-Gp0LmVCag@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] clk: sunxi-ng: mux: fix determine helper rate propagation
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Junhui Liu <junhui.liu@pigmoral.tech>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Maxime Ripard <mripard@kernel.org>, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 11:25=E2=80=AFPM Jerome Brunet <jbrunet@baylibre.co=
m> wrote:
>
> Applying the pre divider on the parent rate is wrong because, while
> handling rate propagation through determine_rate(), the framework will
> likely round the parent rate again while cycling through the possibilitie=
s,
> throwing away the prediv applied. This means, the parent rate will then
> be wrong when the prediv is unapplied from a parent rate on which it
> was never applied to begin with.
>
> The right way to do it is to unapply the prediv from the requested rate,
> which is the wanted rate at the input on the clock element, and pass this
> to framework to do its thing.
>
> Change the determine rate mux helper in this way.
>
> Fixes: 1c8d7af61b37 ("clk: sunxi-ng: convert from divider_round_rate_pare=
nt() to divider_determine_rate()")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>

Will wait a few more days before merging the series in case anyone
else spots anything.
