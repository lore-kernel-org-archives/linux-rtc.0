Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB2939021C
	for <linux-rtc@vger.kernel.org>; Sun, 19 Jul 2026 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784458789; cv=none; b=Oq149TlO2Hfdot/ZCkF9h6/ptfhUbtIBGuBHZknG6lEb2wzaa4j5z8tSKRUoutcpRfga2yHQuFsv1Vcwkw5MP8SOn0WgSgPdy0LfKxWrUkrC9EtIWhRMqX3mH8cy3WQXhn4Apcuv7sY49z5WLrfQ+qzsgaIDZmsgcna3nnUloQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784458789; c=relaxed/simple;
	bh=4JnNKMHEgbNPLyqtTuirt9mnHKvZBNPnvgWzS8OMrko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kIUzZZH8+mu6GvYgQ0m8m59qzh+LTRwgVgiejE2+Mku0CkJ5dq/E9ALG+V7Z/nyoabvVzkZs6THP88oeCJYyAevFy6G4V5i7+THXFBuLwh5zHdc1LeVLbULdRyUNm/qaDmtwRF8kGW4ZjQYsmoQ5GMfAZv2NxPMwOK8eqB/FQ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boAymyLW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boAymyLW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E8F1F000E9
	for <linux-rtc@vger.kernel.org>; Sun, 19 Jul 2026 10:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784458787;
	bh=kT5fQKydHb0o/kmDIhHcIiX0lFZIcFPyW/gk+fnkOGg=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
	b=boAymyLWEaSHndgHTo/eu2acHzPYH1hDazg+SPic0YVrSScebokmsQZoNJjFMmNpw
	 s0eDCL4DX6jXdH8cm0iToVLP7nGd+iYQ8W/Cv7n6J+HaZmhKd5lhApK6zw6v/zrWdI
	 8ELk3oNnOFdJQC2mTvj8pG1gWlaWwbTzI/2SbI3cTkwYcWadZdIpEj3lOUsOx7ipQw
	 qxdeB2vhcggDYIiwlwZLemUMYBxt6ezlHhgRwuOm4aP+oiso7LmOz8AGlcmbOTKlYm
	 7XvXoPCcK8jnknln+EBMpeqjZmq8LQ9hLqDNoJey55/9Umm1SCn0C4Xi217TRADQ/D
	 xVpXPY+Kb562g==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39c94fccf3eso55763601fa.0
        for <linux-rtc@vger.kernel.org>; Sun, 19 Jul 2026 03:59:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpTzVAjTwKeiJuBbeW6zbVanTFN46IL0DbpYBabP50QDUGO4LyhLLDlHzKgLtTZaRsAUqw4XLsAkgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YytMatvV25xo5FsbapbmpytQa+pyGsZm2QspfDSqTdAwli2f1iM
	6ys63yX15Tc6GDhHeqYcur59MgjhW4+8CAjPrlBRYdDJyz5yKHZhWf2hE0aMWLtLhvZKj7OzXZl
	OPg4Zc6Iy6FkrxMLwI+vbC5L7gpdOtSk=
X-Received: by 2002:a05:651c:18c6:b0:39c:6d3a:2dd7 with SMTP id
 38308e7fff4ca-39eb27cae55mr18285731fa.17.1784458786357; Sun, 19 Jul 2026
 03:59:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717-a733-rtc-v5-0-3874cc26abf7@baylibre.com>
 <20260717-a733-rtc-v5-2-3874cc26abf7@baylibre.com> <20260717154005.444E41F000E9@smtp.kernel.org>
In-Reply-To: <20260717154005.444E41F000E9@smtp.kernel.org>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sun, 19 Jul 2026 18:59:33 +0800
X-Gmail-Original-Message-ID: <CAGb2v65PmMnm=gusbVRJqwHkMFAdKpFyk8coXK=pf0-dBgv8kw@mail.gmail.com>
X-Gm-Features: AUfX_mymMBCpHipsNNhAnYECDp1Z2HGesriBpzKuCW5vwQp793h1LgYos6np7vY
Message-ID: <CAGb2v65PmMnm=gusbVRJqwHkMFAdKpFyk8coXK=pf0-dBgv8kw@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] clk: sunxi-ng: div: add read-only operation support
To: sashiko-reviews@lists.linux.dev
Cc: Jerome Brunet <jbrunet@baylibre.com>, robh@kernel.org, linux-rtc@vger.kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 11:40=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> New issues:
> - [High] Missing `.set_parent` in `ccu_rodiv_ops` leads to silent softwar=
e-hardware clock tree desynchronization during reparenting.
>
> Pre-existing issues:
> - [High] Unvalidated hardware register read passed to `divider_ro_determi=
ne_rate()` can cause a divide-by-zero kernel panic.
> --
>
> --- Patch [2]: [PATCH v5 2/4] clk: sunxi-ng: div: add read-only operation=
 support ---
> commit d732b1bc291c593bb4873ef5f04edb2855137f30
> Author: Jerome Brunet <jbrunet@baylibre.com>
>
> clk: sunxi-ng: div: add read-only operation support
>
> This commit adds support for read-only dividers in the sunxi-ng clock
> driver. It introduces a new ccu_rodiv_ops structure and updates the rate
> determination helper to handle the read-only flag.
>
> > diff --git a/drivers/clk/sunxi-ng/ccu_div.c b/drivers/clk/sunxi-ng/ccu_=
div.c
> > index 62d680ccb524b..93cb4cb93abe8 100644
> > --- a/drivers/clk/sunxi-ng/ccu_div.c
> > +++ b/drivers/clk/sunxi-ng/ccu_div.c
> > @@ -20,8 +20,22 @@ static int ccu_div_determine_rate_helper(struct ccu_=
mux_internal *mux,
> >       if (cd->common.features & CCU_FEATURE_FIXED_POSTDIV)
> >               req->rate *=3D cd->fixed_post_div;
> >
> > -     ret =3D divider_determine_rate(&cd->common.hw, req, cd->div.table=
,
> > -                                  cd->div.width, cd->div.flags);
> > +     if (cd->div.flags & CLK_DIVIDER_READ_ONLY) {
> > +             unsigned long val;
> > +             u32 reg;
> > +
> > +             reg =3D readl(cd->common.base + cd->common.reg);
> > +             val =3D reg >> cd->div.shift;
> > +             val &=3D (1 << cd->div.width) - 1;
> > +
> > +             ret =3D divider_ro_determine_rate(&cd->common.hw, req, cd=
->div.table,
> > +                                             cd->div.width, cd->div.fl=
ags, val);
>
> [Severity: High]
> This is a pre-existing issue, but could this unvalidated register read ca=
use
> a divide-by-zero kernel panic?
>
> In ccu_div_determine_rate_helper(), the raw register value is read and
> passed as 'val' to divider_ro_determine_rate(). If the register contains
> an unexpected value from the bootloader (or 0 when CLK_DIVIDER_ONE_BASED
> is set) that _get_div() maps to 0, divider_ro_determine_rate() lacks a
> zero-check before calculating:
>
>     req->rate =3D DIV_ROUND_UP_ULL((u64)req->best_parent_rate, div);

Well that would be either an invalid hardware state or unpowered / gated
hardware. Neither is correct and should never happen and blowing up is
the correct response.

In any case we don't have CLK_DIVIDER_ONE_BASED dividers so we are fine.

> > +
> > +     } else {
>
> [ ... ]
>
> > @@ -143,3 +157,15 @@ const struct clk_ops ccu_div_ops =3D {
> >       .set_rate       =3D ccu_div_set_rate,
> >  };
> >  EXPORT_SYMBOL_NS_GPL(ccu_div_ops, "SUNXI_CCU");
> > +
> > +const struct clk_ops ccu_rodiv_ops =3D {
> > +     .disable        =3D ccu_div_disable,
> > +     .enable         =3D ccu_div_enable,
> > +     .is_enabled     =3D ccu_div_is_enabled,
> > +
> > +     .get_parent     =3D ccu_div_get_parent,
> > +
> > +     .determine_rate =3D ccu_div_determine_rate,
> > +     .recalc_rate    =3D ccu_div_recalc_rate,
> > +};
>
> [Severity: High]
> Could the missing .set_parent callback in ccu_rodiv_ops lead to a silent
> desynchronization between the software clock tree and the hardware?
>
> The struct provides reparenting capabilities via .get_parent and
> .determine_rate, but omits .set_parent. If a rate request causes
> ccu_mux_helper_determine_rate() to evaluate and select a new parent, the
> Common Clock Framework will apply this new parent in software but skip
> updating the hardware since .set_parent is NULL.

This is an issue. I'm not sure if what Sashiko says actually happens.
But 1. this is "read-only divider", not "read-only mux & divider",
so the .set_parent callback should be provided. And 2. this is using
the ccu_mux_determine_rate_helper, so it's possible a clk_set_rate()
call is going to cause a reparent.

I can add it while applying if there are no other issues.

ChenYu

> This would leave all downstream clock rate calculations incorrect.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717-a733-rtc=
-v5-0-3874cc26abf7@baylibre.com?part=3D2
>
