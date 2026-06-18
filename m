Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A7A3B27C1
	for <linux-rtc@vger.kernel.org>; Thu, 18 Jun 2026 13:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781789349; cv=pass; b=TOkwPenmHK+zjHATzRKbbSH7JjGWeJbu3A9OMMGydU8Yyp4c3CjGT+8N4Q9b6qanCpouM+PpHqcESxaRPAhRKdU7LnK9GXdZ2QFYc38FsBPVMkWmJXB/s86UkpSmBbN+7xUwB9t2NfnZzeHGMr3pI8gRUlVSle3oECm32Hp2ajo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781789349; c=relaxed/simple;
	bh=Odn8V4Jyj7HSHR6zsb+AXJEMe1hlNU8CNhlMB76w9UI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RxRD8ulHvtQC2FyMdfQtY1ewwGyXJNkT9ICBMrpsRodeoTiOWh/zuNPH7A+e05Cxz4ma38robKJ3U2Pn0YngmoxLwgh6vizgWaJ3e4FmKwZxb/hYkxOhOQauvNCPngGvh2WBlbj54mW5HxPWm6v17yGc1Szsl4bA08VfIRePFIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cV2EXpNN; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cV2EXpNN"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso9554075e9.3
        for <linux-rtc@vger.kernel.org>; Thu, 18 Jun 2026 06:29:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781789346; cv=none;
        d=google.com; s=arc-20240605;
        b=hhTZsXAtE5NARGHCJY7NXrOL01Mv1kOQhCohIfjuQXTfQdAKKMH7z4w/v9ezYzjvO7
         8xbPgIQnu3WahwH9k+37iqCqpaV91vQiD1tyxqJpH1IqxgUSdszO32xn579fvN1nHChv
         9+tZckeCiQq61eXlVQL1HXUwcocfc7JkEoSkDUyCyFgyJPfs4Mwl1iWMKKdxacbPiaPO
         SVhBRpwqUaf5UWArbLC7X5r2IhxO6Uh0V8c87mOwnGS+svKjO+3iN0Nrdog0f/JRZ2dN
         gA5NEhlofLzs1SNUNtKy+s+Rb8kGVv38Mb1cPqNBanGr5c7UILGExG/TOaquNz7Lyjte
         kecg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r3QY9vRVEn5lFujWnbDukyrJMoT8zbIIk0s1XIR+6sY=;
        fh=ePg4DQ3MMros8U6L+yvlr+2GFYtno6tLbEBV7/MYlQ8=;
        b=LiD6Eden8WdCvYqHdLOxpLP7GQBVxy7mYstj9aRQRXJUW3/OOd/pKc5H5Eu+erdOHb
         CfxnSvsYdUlqLOYKZ22r8hEfNCpCWjdyjoAjgIgkwGcPAWgPKirF1tEXVbzlgwGWPNY2
         M8xsddpMfAYxm5MUxXZMeleQsaDcNXDiAHxp6vEoCUmeCcpYTeVu2ysM+HdY9TUzsgpA
         aptqaxYKt0DzpFsB1WZlUp6i3qgkcrccrMPNkfE6uibCuJu5jFLQb2Q09i9Od9y0fkCS
         zW+hY8s7ji55QcLeOw6KWbM6bwRy2uwdh6jDNXeIY9mxlNzedAEou9mo6oWctVu+FTDF
         C1ZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781789346; x=1782394146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3QY9vRVEn5lFujWnbDukyrJMoT8zbIIk0s1XIR+6sY=;
        b=cV2EXpNNI4ws6wXdj7IVEfDHEHkFelEga4rqKEfuAoHNVuUel+PqNbZa0Sd9ugPXHS
         nGrUge/8C+1u/UZgN51JUMuT0jej9wLa1FCIMClEf+G42AEA0SsigrXUOav3CrkykmKE
         HX2EdTq3hbpWY7nqsM0kwF+ug9AmC/tI7q4O5Hnr+KnWcx7jSV7Ppe+UV33goRubKnwC
         a8IcRDHC6JwhFc/0ugLK1OxcnRMuX2HIbeizWRe9fjN7wqOAaR+YMgoGpeg7yWqzD+/L
         vGHHoPYIlpMrTJ+2LW5/fyPVOoQ7cKMQgxUKTMORF5KcE05a1iyLiOu+O6yzj3XCvCeh
         8e4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781789346; x=1782394146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r3QY9vRVEn5lFujWnbDukyrJMoT8zbIIk0s1XIR+6sY=;
        b=Q9PgTbljL5UFnhd+2pRPF9DNQaoN6nSiOmAlANH4FXCSiNL2V260C4Y4w3CJrLo2bX
         i4HYQHiDxeKrekAjveuYJ1PYX2UzssS3xlJ87WKhXjxVg3AaGNu4ctIw0YbgK3n3ac4W
         KRBFFILpgAA+W9NAe0FWMl4kZEgw9AnmYV0Z4Q+uNxtAF2BZPEq85uMKVbP52YTQ6tE+
         5a0NSUGQClcp5bj7LeWGzZPy6O8Lrt91Kb7u8y8d9JnSdZmlhbRG13UlSBjpyaseLnlR
         RT7bJI335ZTbzqNTS8GkvNKtPhCofD5S2xiUa2saVO9AiC8xorReTSRRXXe0CDfRlfWj
         vTUw==
X-Forwarded-Encrypted: i=1; AFNElJ+CIukA1fVNAYzQlxjEql0PiRfybgRYQeVSulX4ElZTiIq9D+DWGBQv4FRr6ABFTdwZm86/G4L/iO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqYou0l6mi2qYwOU3f98JnMl6Ty4IOV+307SenYqN+I+cczsF7
	EkYaB1HZ1WDsxHnljRy8TtITO/MUHJ9nrdfyg6zwbDJ572GBF70WK5YN11xCgFStPj6/WrmYzRi
	pn4EyZ3W2Pa3UgFIKak7FHeIMWOmEWUU=
X-Gm-Gg: AfdE7ckEXp/hrqY49YhOXoHtDS2u7hpxw4Cx1WFfuqIOoA7wc3EYoyd0/IEncto3Y8v
	6askMBkYglXofm+ify1q1q9c5MImo9xACiuqwJ75Hh68ICnfTRXwxw014FbJF71PrLliRWxLWfI
	G7X9FbQ2D9CoLR6m2Mvk/s04wrJk1cXNbiESIQ5Y+Q+ZDckTF3NatjBcUQN/VOBt5mNp3KDp1Qs
	lNFS51siMnFhfFZSNvHw5z1t8rPvFx5YCXR1nmZ+QEGE2zChT1RkZngUOw35rg+Ot0BLnWk/BZ9
	y4WBwen/qzYpiqgESI2rYsO4l2MbeiliszS5DTjjUW1ju4XjNY+J0JD7NIJ+77Vr2v1vu0bzcyi
	fWugYJRVKwgPgVmDUOkUREItiDQ==
X-Received: by 2002:a05:600c:4f84:b0:48f:d1b8:9ab1 with SMTP id
 5b1f17b1804b1-492381f0ed0mr59299565e9.9.1781789345605; Thu, 18 Jun 2026
 06:29:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615154805.1619693-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260615154805.1619693-13-prabhakar.mahadev-lad.rj@bp.renesas.com> <ajKAqn1F074JJazF@shikoro>
In-Reply-To: <ajKAqn1F074JJazF@shikoro>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 18 Jun 2026 14:28:39 +0100
X-Gm-Features: AVVi8CfPiYA_UbaiFhMeEgi8lZFPPJfpzknvE_2jphmqJ4vHnB1AeT84dC8Do0Y
Message-ID: <CA+V-a8uaNXhqMvw+SqiV5D-EsGGCjeu3Qz9e_RRrnJOqqE2g_Q@mail.gmail.com>
Subject: Re: [PATCH 12/12] rtc: rzn1: Add support for Renesas RZ/T2H and
 RZ/N2H SoCs
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

Thank you for the review.

On Wed, Jun 17, 2026 at 12:10=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> On Mon, Jun 15, 2026 at 04:48:05PM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add a new compatible string "renesas,r9a09g077-rtc" to the OF match tab=
le
> > to support the RTC IP variant found on the RZ/T2H and RZ/N2H SoCs.
> >
> > These newer SoCs integrate a closely related variant of the RZ/N1 RTC I=
P.
> > The RZ/T2H and RZ/N2H variants lack the RTCA0SUBU and RTCA0TCR  registe=
rs,
>
> The RTCA0TCR is also not on RZ/N1.
>
Ah, right I missed "Not available in this LSI.", I will update the
description accordingly in v2.

Cheers,
Prabhakar

> > those registers are not accessed or used when operating under the
> > rzn1_rtc_ops_scmp configurations, making the current infrastructure
> > compatible.
> >
> > The RZ/T2H RTC variant also supports a 1 Hz output signal on the
> > RTCAT1HZ pin, controlled by the RTCA0CTL1[RTCA01HZE] bit. This bit is
> > marked as reserved in the RZ/N1 hardware manual, making RZ/T2H a
> > distinct RTC variant despite its overall compatibility with the RZ/N1
> > implementation.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> With that fixed:
>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
