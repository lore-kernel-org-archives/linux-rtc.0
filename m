Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA56C3EEAC1
	for <linux-rtc@vger.kernel.org>; Thu, 18 Jun 2026 10:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781779071; cv=pass; b=IzhR2z0dFKYLdxbVYm8gXVtx6/UslNE2vwH5xRCx5qZK1XeKmDfVB/ROrnIiDIDrZE+nyEb+dj4rMsewKQwkCeEtB5+Y6iwc0E7SmU6LvRroIO9y+DYOGeQpWK+fObEXsIn6Y5lJ+qsN64i7rGMCOKMuCrDdKUiuzVmoIjnpwNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781779071; c=relaxed/simple;
	bh=TuPYQkya6tmZ/l8MKVs8GX5qhrHA3EFBkCVctB9px04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sjsBtCMfa2rKj1+cxSE25pHJ1UR/E0DdsntV92WM0C9nPMb8ei7uc/tsfhhP6ZQ9e68yuXzlFp/qnYr4x7vHtQ9MGfoAKw7lHR8I6IZM0ReCzOpQekKc2KYVRddiggSMt+r88U7izSLQlGlofzuH4oQxdXQvXcX2wHlMREyozDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tEu4gm7q; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tEu4gm7q"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4629d80fa08so792281f8f.3
        for <linux-rtc@vger.kernel.org>; Thu, 18 Jun 2026 03:37:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781779067; cv=none;
        d=google.com; s=arc-20240605;
        b=aNZjOpzaZSAIxlTALP1c18UQ86Xj8PeS5dIyNnAfmDx/Bwk5JeBGVjezUYlaqoU7ee
         vtlBLFGdhOjdJcAq8TmShRxzBKd69RyDiAiJFE52UKzKkTNA7ymw3ueJu4k0UklFp/Mg
         8ONNOzooYdcT/1zKSymgnXmuxuNLdbBAgvZxy7wD5FibBod/oDyDmAplJTaz7pSUAN8V
         /Md6+ugVBZGy4PDD2de+cOTYAByoTgJN0mG6EJTa0SORfP29jMp2pRp/Z7k5bTUk4sAY
         +bHRgRY4kXNmq08gi2A9bTwPJY4+sGnaPGFXjLhibDWKAINX3ZEowGSWTs4t4JHlzjq3
         AxrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TuPYQkya6tmZ/l8MKVs8GX5qhrHA3EFBkCVctB9px04=;
        fh=T7hhyv/BCC1XgLVYRit0qSJ/qSQGSOkueb8fUFKn2nM=;
        b=amOktZ/iI0gozJ4IQBz5Vz5ZucLhhVvp8AULX71FoDnh9TCE1kSmORddIE5UKEcjaC
         uVHloPPisawO12uMEh2tDPD5wt1KLIiwY7FZVSpWquk4W2Vh30ETOcKex6M5att+e/xF
         efQxYJNn2KudW/K+vAF5x4iijyZsHk/ENjx3IDzQqmGi8c0iqrWi1qZIYegIKzj+peKo
         AZvmvrH9q6JnEPfJNwHs7GrrsuvUjD0lh2+e9mfDmtZGR5LwdhRJqczg/07LSyJhsma9
         FzK61T7b1U40Hbpzw43uWQfNfjOUX/388IpdjWNDCmpUKXOsXBwEmnEra6Ydo0NoPrP9
         HhCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781779067; x=1782383867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TuPYQkya6tmZ/l8MKVs8GX5qhrHA3EFBkCVctB9px04=;
        b=tEu4gm7qVnEnUNpLwGXRBpmUObM+sYQh5LQv3qZjptgI+HsyTJ/Gl3AMmCn+50hPiw
         vZgTbMsKMfMFRgWqNlhGbn0hr5tNItEoRdJfN/JvJb0GyKUXHgq6z+8it0wkDI8nqBA6
         lJhuzIQQCzvmCBcOqIOI8c9DZs3PnA4xXUxkFKls5JV26Q+ygzgylG4hEnzyRGYWvDJY
         tnNiYS6V5GtaxIE7TtJVKck12IH2xch5zleHsXBmIkzPXHQFARmZAWUK+rDX8bsqpIHY
         wloagToibDodLWsD0vOtPsZZde9+3ou2oWjS3l1OQq8hD6HPYs+w30TIPEpsN7hynYbT
         38ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781779067; x=1782383867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TuPYQkya6tmZ/l8MKVs8GX5qhrHA3EFBkCVctB9px04=;
        b=eLEmGADWW4LqqMw2M3qT23BtDT4dmyh9UEDRqWzVJ7UobZjmYVQJP1XLXP3dPip8Yx
         hFsQISIu3t7tunjxIhJEr968WgGb+3dbycVkGg7OzJvX2J6SvGB3otziQAPo/ZWX0c6L
         k5GoGZKr55ZvO7bFGcZ9pHDIfuEqjdcDZJb8XrinRx3OZScflFVTFPNy5L9Gj0kJBWbs
         VPZJpV643LumuQI4sXYWUYJzqGIK/6zcJiZ2MNtmgzLDTTvdsvoe/Xo2Pv05OF2kkjYV
         D15ASB0P08Pv6YKIu8tPjhiKyYNqE17ZEqIMQ3jD6K6lAZhCHOkAAY4ikv2wNN4A/NXs
         o4jA==
X-Forwarded-Encrypted: i=1; AFNElJ8gOMx9ysmLCwto3gEi2hUDV1VvHZR1B7iYJZDKlKTST33TWPtWcmEmJSGSYcZEXonCFS9pgqrAI+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRIxfTkIu+OLdS5Eb6cct0V3voXltz/bhoXjaENjom/72dmT1K
	9jSN1R2I7F4arsOwIZHjLU1Li9tZ5lFHW2CacLjUsoQDU2b7Uc3PelkptUWYHNLy9RRWDjarTQ0
	NT5ThSG1iWyMz7r+KYV4BEBkfx5C2L5o=
X-Gm-Gg: AfdE7cklu77/AvJVPjZHqcSvdrx69L3nJug5yfpFRSa6g85kqIVjX7J2tfgTirOMk8H
	wN9irqjoRFSKg9rcL0a+8pGpQ1aY3kgKDEG7WUzKlXTjE9xOCPtzR4TCOGt4Xyk7uZ2aPfHBRpt
	hSikrNCoVmtF0aKmm3Rj/EIWZVs5K1LQrWuGgtPTzHdh+A7uaerXUMiCFa9UqcTqZQGPn6cgbtM
	5cNNjpjB0XOvrM+itm/+iJLCXbuq8MOCGRmB/UPwZq2kio8/F5viVg/JqrYBjnf0ywXxe4U7fG8
	kBwIT9CgsCFjwskyb3PW8UKC4YGrjAF+aOhfE15kOyc98IfeNWd745CVUbPEUE1E9xzhDoO672N
	Z1pJIgc+CDJtja2s=
X-Received: by 2002:adf:f691:0:b0:460:3234:293d with SMTP id
 ffacd0b85a97d-4623955c292mr9564839f8f.40.1781779066727; Thu, 18 Jun 2026
 03:37:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615154805.1619693-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260615154805.1619693-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ajJwqDt2jUfhSD1x@shikoro> <CA+V-a8uo9sr3m9F_MQYbHVD5wa3LT3n6MWrVpiNiPDumnVHMYQ@mail.gmail.com>
 <ajPJHKut92mAoo-B@shikoro>
In-Reply-To: <ajPJHKut92mAoo-B@shikoro>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 18 Jun 2026 11:37:20 +0100
X-Gm-Features: AVVi8Cd18WA81bqmRQKOqLppbTyxhBpMr_k_9brs1kLBCen_Zb_vX_vTX4BhCAQ
Message-ID: <CA+V-a8v1DPFvu0_M_XV+efkJL9UaqnmuuRE2o7w9pyh8geCJ_A@mail.gmail.com>
Subject: Re: [PATCH 05/12] rtc: rzn1: Add system suspend/resume support and
 wakeup capability
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-rtc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

On Thu, Jun 18, 2026 at 11:31=E2=80=AFAM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > For running s2idle cases with rtcwake > 60sec this feature would be
> > helpful. What do you think?
>
> I think maintaining such a fragile feature is cumbersome. People might
> have different expectations and the maintainers have to handle the delta
> then. So, if we cannot to support to a large degree some feature, I
> think we should just skip it. Until some user really wants (and tests
> and accepts) a half-baked solution.
>
Ok, I will drop this patch from the series in v2.

Cheers,
Prabhakar
