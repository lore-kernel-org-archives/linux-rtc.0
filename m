Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CAC3B2FE4
	for <linux-rtc@vger.kernel.org>; Thu, 18 Jun 2026 13:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781789197; cv=pass; b=L2OKjbQcuSn1Pc8OVblxkfVUROayNGRMkF5eaeNBn3QpWLzUxVTwAfltzu5BFjuAXBQyq5VhH7nxB+n4YC9cQP3me7QGSgg4Sxzq3L3djaHSFv3JtZ61gnPmbueBMzWLR7aiBH0fhe+X3ZBg6RxwZdQuoC1FfuYGf6Zx4SUyEK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781789197; c=relaxed/simple;
	bh=rwavQHNR5vCqgAC2vGU4xALCWjqvGo2uf7/b/yg58XQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZkFmSQmaZ56v7nqtYkcS1ak4Gny3/OWbjDUzjs9Fdj/vCGS0CrR01rLC92sGSYeQBJgWrV1cqpwCvTe8bWNtAf4vBNtywaFomKQD5x/5CuPunXMat1G2XqL0kI8FDZDj5CcLheFVBcxx4TzCPDi935i6wZnFOPhCo/NPRn+xGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCE9Ut8n; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCE9Ut8n"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4645995069bso394956f8f.1
        for <linux-rtc@vger.kernel.org>; Thu, 18 Jun 2026 06:26:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781789194; cv=none;
        d=google.com; s=arc-20240605;
        b=EqFDBLk3XRY9mtQrLqN9M9C2nCFrHBkT50CwsEhPyBxus/r39J7nPHik3n+3e5wTSH
         fRXBG7BnRzhp3TtIu4xvWPLahy/TbbpfFTjHfmRZ80A5TRPi6q3Y7Fri7EW3ZqibKiTu
         RDX/OwBJ013jm2O39ft/FOIeShP7wx0/hyYWAcgMKwB1OrEWwsnLljCptkvtd5QO3MJH
         20AdoI2X3yhTl0tDxJOOKxkGS6qZdk3k+GavnGKMF0h9pxoYBT9c3eqqiwsbAd1fY+GU
         CQ4/FR8qROYp1WCj9a4qyRlo7tT9P978QSg2MWO6lmrQ4VDkmr69VmkBZxgbmziKx2XI
         vEYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zPwka4rh++Oi4jW6U/0Wwv1+lcJvYpPIzYXrVw3cc/g=;
        fh=NvacCdzFAj4Pfi/9AIjuqKrlnHU6J6BX2VUJ3N6BsQk=;
        b=b5O67ZbfZdEpQU2yqIUM53NNWOyhUbcKG5FBSh6MFF/POKQLOo5p3UnbwD8s4F3qex
         kXpefAp1L7fvkKnVoi2zf14fXkuuNFe+WgF92QD8aW+l2hFKSjhG3dErn5PCwZQy8jt4
         9GToMg1ArMV7WlGzK3luVFF39EyggWy77B1/ZxOjuryo9tC+c8GYx9WdvzTT61cCVTP8
         hqPP998lekaW3Yg5bWhcuTu881gOUVOvNxFCt1VlSu4nErZkqywCFboTj7GXstkKFVyM
         Jm9r1FFzisWzXf4pU9S3m93KcFU74OGolEEMU9jQS8lacIUnS3SuPBx0btdkv4JxMfO0
         N2eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781789194; x=1782393994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPwka4rh++Oi4jW6U/0Wwv1+lcJvYpPIzYXrVw3cc/g=;
        b=LCE9Ut8nr5XQKA9mqz0RAx1uXSQ6iSs9JYchrR0t2lU6Rm25vLWFv743kzSDdlsSx4
         szJSCkKdQvMlx2xZccpyTWCEUTbQ/sliF1So2SegEOMtECdlypU7Yv/OEGJqgaCSmOJW
         5qq6tE3AZN0HeJYE3WSysGISHE5/BCV4pBOIDO04l0Fem6Ovqoc3QFMW3zKAFCvNEsqA
         25DEgTgSFD3Mxi2VYHvSBzaXH3eRGjFRsgBamwWjL8ASGJSfi0x2o+CI1z4TeBRwWBCx
         bBgWyeoXgf8+Sr4MXqU7H0A/ZXhR5Nbt24dUhrjaZFHuMUUEDPy/wlkiWVB5/dYsCaaB
         xmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781789194; x=1782393994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zPwka4rh++Oi4jW6U/0Wwv1+lcJvYpPIzYXrVw3cc/g=;
        b=DkyLJKz7IgjJ9gM/Hni9ZqmKTktTfKY1HZxTHNlPugwi9wUvuXmiMNRUSlpOsauw3O
         1zT9yVI7Dw6CN2A8ASp9NezPPXvwmfAqVr179jgFJ0WqKrba7K3T9/qvo+0nz5PVh3lU
         Y07eb8CrhE6TQVxuofE5sDMmCDJWAFxuujmucbBJG/sLPQWSPljSnt7ZUA4EnFaQlp51
         vR791xeyKQAohgC/gTLXHuMNlVp1HLQAp3gCHQHYgZEUR0LsEhT/eajp1V/ffuczNnYA
         LM+3bjA9/ZbObdY0KpXZrhZ1JPdRYETAp98zvKEHyIrmr1i5y/xCw8sFzyfzWq5Wbmt5
         4EzQ==
X-Forwarded-Encrypted: i=1; AFNElJ9FNxGtKM900FNZ2c2Qk58YzNOZi8FGxRsic7wfuADBClKYWfT3KNgsiNemwsLSiyh5469AnMojd6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj+RbZzv7BqUiR3PDZgiYjWHKsTjUy6u7QVGaiAQ1Ng7mpVxUX
	20eAGzaKq9CwyP+hYZ1eqakLXpebw3WwOBBKa0yh3DT3p5Vkl5QLmqm+YZB/VWOc06bFz4iXa4J
	QSa8Qcgi8XZJeWxhIfALfOoKnwlaYE/0=
X-Gm-Gg: AfdE7cl42LFOz89Qmv+ndJgWqCuKc7zdHGlPdMgo4YrayZmmsos8JE57aR30THGs419
	yeD4+Co2b/w8o2p9Q7dJBQJ03ClqRtNzqx5piQaNC/8t29nUGNLVWLYuUkHPMGe52Xw6MItVfLz
	/JRHd1zndRTD7CCR31kgYhKnEzHrU0uOlYqkeaVFxtRazLSUq8PiCR8btP+rev/CtzOqGZSxE6Q
	mBF2+3hxLGhB10EXyXYgI+SZJD+BIN9ulApirEVEp4mdf/nB23jw7sehRYAwflJhiL9njenpKsa
	WhgOZeXm8lB0emnXBioT1W+qVqCCEXDqDXuBFNR69/tTXg2DEeMXfIf9id5vNxkkO9JZECN3p/D
	5WfApbxPq9HjS+ic=
X-Received: by 2002:a5d:5091:0:b0:45e:eec6:500c with SMTP id
 ffacd0b85a97d-463ad9aeb84mr4495060f8f.39.1781789194279; Thu, 18 Jun 2026
 06:26:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615154805.1619693-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260615154805.1619693-12-prabhakar.mahadev-lad.rj@bp.renesas.com> <ajJ_qwXhJbKB3Xli@shikoro>
In-Reply-To: <ajJ_qwXhJbKB3Xli@shikoro>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 18 Jun 2026 14:26:08 +0100
X-Gm-Features: AVVi8CdXToo6cMOBg12R_0ExFj-dio5Daw5TR9InAuTm1Ov-5-tnr0T-5nBIcxA
Message-ID: <CA+V-a8uhjm2Pmgb0VNinHJXKhxfbXJvqFMxG0rWeaBdWnSTWrQ@mail.gmail.com>
Subject: Re: [PATCH 11/12] rtc: rzn1: use FIELD_PREP/FIELD_GET and GENMASK for
 register access
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

On Wed, Jun 17, 2026 at 12:06=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Hi,
>
> Sashiko found issues with your patch. I curated the list and left only th=
ose
> which I see as valid. Please have a look at these issues.
>
Agreed, I will replace the 0x3f with RZN1_RTC_SUBU_RTCA0FX macro in
the next version.

Cheers,
Prabhakar

> Thank you and happy hacking,
>
>    Wolfram
>
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [Low] Incomplete refactoring: open-coded logic remains for RZN1_RTC_S=
UBU_RTCA0FX
> > --
> >
> > commit 2e16f66c80c483d619655d20fbb859a42e9d1b6d
> > Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > rtc: rzn1: use FIELD_PREP/FIELD_GET and GENMASK for register access
> >
> > This commit replaces open-coded shift and mask operations with the bitf=
ield
> > API in the rzn1 RTC driver to improve readability and match the hardwar=
e
> > manual.
> >
> > > diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
> > > index c7ef3c81180f4..9f9cf9882fc49 100644
> > > --- a/drivers/rtc/rtc-rzn1.c
> > > +++ b/drivers/rtc/rtc-rzn1.c
> > [ ... ]
> > > @@ -306,7 +312,7 @@ static int rzn1_rtc_read_offset(struct device *de=
v, long *offset)
> > >     val =3D readl(rtc->base + RZN1_RTC_SUBU);
> > >     ppb_per_step =3D val & RZN1_RTC_SUBU_DEV ? 1017 : 3051;
> > >     subtract =3D val & RZN1_RTC_SUBU_DECR;
> > > -   val &=3D 0x3F;
> > > +   val =3D FIELD_GET(RZN1_RTC_SUBU_RTCA0FX, val);
> > >
> > >     if (!val)
> > >             *offset =3D 0;
> >
> > [Severity: Low]
> > Since the stated goal of this patch is to replace open-coded masks with=
 the
> > bitfield API, should the remaining 0x3F masks for this register be upda=
ted as
> > well?
> >
> > In rzn1_rtc_read_offset() just below this change, there is still an exp=
licit
> > mask used when calculating the offset:
> >
> >       *offset =3D -(((~val) & 0x3F) + 1) * ppb_per_step;
> >
> > Additionally, it looks like the write path in rzn1_rtc_set_offset() was=
 missed
> > entirely during the refactoring. It continues to use open-coded logic r=
ather
> > than FIELD_PREP when constructing the RZN1_RTC_SUBU register:
> >
> >       subu |=3D RZN1_RTC_SUBU_DECR;
> >       subu |=3D (~(-steps - 1)) & 0x3F;
> >
> > Would it make sense to update these locations so the bitfield access is
> > consistent across the driver?
> >
> > --
> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615154805.=
1619693-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D11
