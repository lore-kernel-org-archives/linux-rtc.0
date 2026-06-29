Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27482436379
	for <linux-rtc@vger.kernel.org>; Mon, 29 Jun 2026 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782746732; cv=none; b=NjVyWVvcL31ek2xoYn65kMtiPvC0IT79H6AjkYyc6UF/xhsEhuL4dzp11WPrZcOS1zwxfs7EjtE2UVksIeADUOI630Us0v/hQWpBvvGp49I6FBGl4E40k9JiY0+7UspY4kUva0dAg2+cnXOqO82zNlUTrXZaHLDZPCW00PXjL1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782746732; c=relaxed/simple;
	bh=EuaEiP1R/Ld6EoN/FwVrc43DhXOZIUY3usyXo926Mcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g6J3CC/STP8HSY1J1gh9MTnnJWQZ3eJT8o3pxpwXDZVVk67YL1l18y9M+Z4FQnh2YzLr1b50/gW0lnnU8PRODuLS1S0wOjczF6uxGb7Hg8C24S41NLIQNJIGbeWe/zXiYruHW2nPup/99+LhCqyf8V+FcsF8tVSSmqtb37scp24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEaaQMMm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEaaQMMm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C253B1F00A3A
	for <linux-rtc@vger.kernel.org>; Mon, 29 Jun 2026 15:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782746730;
	bh=EuaEiP1R/Ld6EoN/FwVrc43DhXOZIUY3usyXo926Mcw=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=NEaaQMMmgiu3Bi9aHlfHaIAXM4xHO2fxsd3nLwPGvb0LQbca34Sbhj2utpQT13UCR
	 uxC2ZiOdYhwUHtZr28/r/ExV41qLjJDePbNblKiQedtsyF1Iu509vzKboVFudoJmn1
	 0bifMfsOAVN62Z31LJlaLH+gT4E7c4KxQfFkca/TfJsKacxZ2Ei4Z3hiBgS6xwuWlF
	 FOEqn/tiU1AgRsLsGE79j91UHJGYQJB4tFkrVFE6X1RhVahVfUotEWBMh47uPfo0P+
	 Y8IbwL1dnhGw+iN2yi0Bz6f7q1qeDokuKnMMUuzK2gYjBrRiGsAAD7XR6LYdxvly26
	 sRMQZMVoPt5Bg==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39adcae789dso25658601fa.3
        for <linux-rtc@vger.kernel.org>; Mon, 29 Jun 2026 08:25:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr/Avz16ehb0ISHWQy2nEB3VP0oHVvhFOtGGsJBk7b1xx3fA4pYFRk73diDNbPHwD1uhRPzoMk9OX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8qIxhc7iwnC5HJFbrdCE5WPadLK+iBE0S1C6exXGpG2BzlcX2
	MiGFvyBEPwuh4qnrAbWCLgSZbd0rAJhxmoxobpb96TqkYZRxIT2XcMMDt38GOL+Mb9mUalNw7OA
	oj2lkFn/ZwTZeH20IlxxPSDM/mCU1ioU=
X-Received: by 2002:a2e:a988:0:b0:39b:70:e808 with SMTP id 38308e7fff4ca-39b0070f5f8mr12585631fa.35.1782746729301;
 Mon, 29 Jun 2026 08:25:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629-a733-rtc-v2-0-7b72112784f8@baylibre.com> <20260629-a733-rtc-v2-3-7b72112784f8@baylibre.com>
In-Reply-To: <20260629-a733-rtc-v2-3-7b72112784f8@baylibre.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Mon, 29 Jun 2026 23:25:16 +0800
X-Gmail-Original-Message-ID: <CAGb2v67_N5WQ4GqGsn6xzivVpGDN5_GNtPXKmUMC4WTHmDyztg@mail.gmail.com>
X-Gm-Features: AVVi8CecxM3k7I339CdtYTrFlBU6hFBOIy50N3ezSA0spmb-80bIde-G7mpTp9c
Message-ID: <CAGb2v67_N5WQ4GqGsn6xzivVpGDN5_GNtPXKmUMC4WTHmDyztg@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] clk: sunxi-ng: sun6i-rtc: Add feature bit for IOSC calibration
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

On Mon, Jun 29, 2026 at 8:42=E2=80=AFPM Jerome Brunet <jbrunet@baylibre.com=
> wrote:
>
> From: Junhui Liu <junhui.liu@pigmoral.tech>
>
> The sun6i-rtc CCU driver currently uses a global static variable to
> denote whether calibration is supported, which makes IOSC operations
> tightly coupled to this file.
>
> Convert this into a feature bit to decouple the logic. This allows the
> IOSC clock code to be moved into a shared module for reuse by other SoCs.
>
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> Signed-off-by: Jerome Brunet<jbrunet@baylibre.com>

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
