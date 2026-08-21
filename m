Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5386D415F06
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 07:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787298652; cv=pass; b=GB+Z/QidlNBDvFwdArci0GghQKRb4+eRYHgh+I/rWZwAjwTtaXS9RUhMqkUVG6wPxN/hLYckQnuslBrCj4e1rJXgQMCWPAo2AXNhs3GOaLLMv2W1BEz0zOkC+m/WrbQzX0JefVAVD1u233zRBbYUG7QqjLv1qtRcsS4xVtSjrAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787298652; c=relaxed/simple;
	bh=Ar7dl1WOm0eueofGyFFcOraww8SO8wyju6lWFB7ENAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gYa7NY1cx0o6PfzAQjsoD2hQdodQv1NL3wbn9+iOhMi/Hv5XwXeZVGSvgt2TbrnNysNxCHEwHVqLcTH0yRwHz01qfUSCVOYX4g4vnIyUydZZx5xUMlrCrtn6B3rOKdgAk6fhQYg1I3e7pztKt8JQGr2EcmZ8/7GwHXl6XVaQnTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tf2VjWPC; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tf2VjWPC"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47fde295992so495079f8f.0
        for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 00:50:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787298649; cv=none;
        d=google.com; s=arc-20260327;
        b=A82UuS0+HGzlbSuAAamZFqa9XhSXPcun6I4iFqEPqoM0f6Ff9TuROsZgJF3SDeodLe
         DDM0RtJhbSnjySIQyGRd0qUYDlSuFJLDuS8eywjERNPoB0tIOvD6sSrXhwVV90eUxjgV
         auhQf1izQfylRQ5L59+kqxtxGoero0FC2BO11IiPQTd+/7lBUYpcujVOalxafIS+gjle
         CoLCRZVF67rnsWws11N3jM7K96q41qHgK1+eBLoVvRaBwMmaHoaO9hKAayiXuwEF1jBQ
         Yy+8+4Ak9rQ3bKVS1PVak8pUKEC4zepgpOGpqMZnXabvz9e+u9hwvMu4iVVgDRW6AEuC
         RekQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pq8cs14CPosYQ8esPWunZ9jxmDxJEbeMDQbryhvhdwk=;
        fh=1OybvLoLWs4FnP1ZhSFO5CLJ2uWnq2fq+kw9xRnXIqM=;
        b=LntWI4AciIFZ09hlVLkURlYxS4PEFXM05oxuMj830iqD9vaQgu+HQcPxhy25BcsJaw
         Pp2u5dhtUqTN+KZ/MNf1oCfktuCkJJCn4XG+Qzn6zMDQ1NuMEaCVgqRSCLspZuaOcHXm
         T8gMexBqQXaKZ55ejaI5IXQ4B+O8pDAKuv7mitcSo0NGZAZoSqDd3XVAMdJx+9KOTarh
         ILcjdpql6Lc7pVI50K8jLgRvBpbPF9L8NF/3GZS8ndpwe9iOiEkO44/kz7hS8ZMBh09I
         2hP4/c5ltEYmg6HPi84L8HEh+Hg1olJk0P8TUjScXrLc+LJJvzst3Qrug//e1FdNU70C
         uB3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787298649; x=1787903449; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Pq8cs14CPosYQ8esPWunZ9jxmDxJEbeMDQbryhvhdwk=;
        b=Tf2VjWPC1g3e+ax6WJguxRrDugAWU8CKvJInvdeUBxnFnA2wWsPl5Udgk82RvAZCo6
         dyHpFY3DnKxuBRmY3iAc3jXmaGGKZXVq7kzyF5/AvFceuYeWALuD4vNIARuiCVVADSXe
         8uZMRYNU5Ll5OQ5Eeba01okdkAjMyqhhevQBAP2NJg/98FQd4fGPRVa58MiPHrLTG+em
         y4NBrYZ9YIzmD8Ee6sYZAqwJmV51annif3djiL8HdI/menmc+f9jCHmvHurk84aNUa9t
         Z+ERU1salpIaVwR47esX1bFxEfwdB7yUKcNewXhWGa6sMgGNgV5XXhESJXg+IlvJ4q8L
         DROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787298649; x=1787903449;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pq8cs14CPosYQ8esPWunZ9jxmDxJEbeMDQbryhvhdwk=;
        b=n/e7JL33p101P79LipNtmcytjDbMdi+vk7m/imYSGwwt+UMske7b5IbDD3EQMrWrIX
         Wox9ehqe7PVTTCrBzA0sT3AZ2H++mGYkFcmOiQg7jUoq8imlbEouSPqNuBTb3LTLHW02
         n7jd/qFDdGL/3NELZ5SI2XVY5LO9BCrApB91jIlDlSFelTT+Y3uPBoQsnznLUGZumVxB
         TpgUH0gIvIvbmkTIJNjZ0fknISouyq9SRa6lQ9X1WY3iQpLF5rdwx1/dx5/OTLg9yU9I
         3IO5ry8ue9vrFEpmHFX9N3bMSfHqg1PsEhsKz1qilidMFoflNKf6iJAcfvZ9pcFvrr+e
         /SPQ==
X-Forwarded-Encrypted: i=1; AHgh+RquC87nh/y6i0mcfUilSTilTP/rFyCHjR3pUdeioBJbmgyKQWXQZqD3PVJbs51jOcuXTFybKxYkm7U=@vger.kernel.org
X-Gm-Message-State: AFuF++ki/7bLLL7CcqGfrMyjcqbWhX4lD/62v4ke0sEDiLxaBaiKDiXs
	SKMMFdNKiWhemXsq/xvx/ZkrIqWbMhyhZIdpTJ7CfBItn81OryHqu1yqe6NnunnEVW9wZda0BI+
	L7INjkJRUzI4nbUWQMSYyjk1NRkeQgiU=
X-Gm-Gg: AR+sD10Lhv80vJv55cRp0ViCIf4pM6OrTGGOriLG+0LQrt5lQdurNX/3vCxzczrmU6H
	15M9YIddoIfPcpFzwdJvCd+wKcpsyYH1WJsXKRYoyGANmlTcAL1RbTDA++mPeEdWRxpvqYYdTvN
	SRj7lLIda2UpAC60TMbX0zu/xaQdierIKKMAPK8PvI5OJOXP+ZGrq90QCK36Vv9frSVwRDoBj3b
	n0QsSNsv6U3GYk+n04F/PgE+izcfgC6z0U5/YSwN8DJXxrDP7uAOWFN9HIdM+mqQwqtde5xD05N
	wtiVkoABjhqqmRdFpexqLebeRKg/TV9hsi/FFtpahHznQ7jZ+O96sbUBmre02O4Os+b7BvD9234
	vfcSRJ812IY92BXY+ZG6VaaPBrHG++w==
X-Received: by 2002:a05:6000:643:b0:47f:ec53:1d2d with SMTP id
 ffacd0b85a97d-482b781c048mr16263716f8f.7.1787298649421; Fri, 21 Aug 2026
 00:50:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260819103926.2136712-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260819103926.2136712-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 21 Aug 2026 08:50:22 +0100
X-Gm-Features: AcwNN1WOW3ki891qZSZZpzaaCiMqhO323D4bsoSUMUR3ubUggwI4WxPSkV9zeXc
Message-ID: <CA+V-a8s9s-SZskiamnw3jH8OWE1DgT4Y56V4n9rgyeuB7=4afg@mail.gmail.com>
Subject: Re: [PATCH v4 15/15] rtc: rzn1: Add support for Renesas RZ/T2H and
 RZ/N2H SoCs
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Magnus Damm <magnus.damm@gmail.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-rtc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Prabhakar <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

On Wed, Aug 19, 2026 at 11:41=E2=80=AFAM Prabhakar <prabhakar.csengg@gmail.=
com> wrote:
>
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add support for the RTC block found on the Renesas RZ/T2H (R9A09G077)
> and RZ/N2H (R9A09G087) SoCs.
>
> These SoCs integrate a closely related variant of the RZ/N1 RTC IP, but
> do not implement the RTCA0SUBU register. Use variant-specific match data
> to disable SUBU support for these SoCs.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v3->v4:
> - Dropped RB tag from Wolfram.
> - Added OF rzt2h_data
> - Updated commit message.
>
> v2->v3:
> - No changes.
>
> v1->v2:
> - Updated commit message to drop reference about RTCA0TCR register.
> - Added Reviewed-by tag.
> ---
>  drivers/rtc/rtc-rzn1.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
> index 6097563c5f13..32f6464fe7d2 100644
> --- a/drivers/rtc/rtc-rzn1.c
> +++ b/drivers/rtc/rtc-rzn1.c
> @@ -508,11 +508,16 @@ static int rzn1_rtc_probe(struct platform_device *p=
dev)
>         return devm_rtc_register_device(rtc->rtcdev);
>  }
>
> +static const struct rzn1_rtc_data rzt2h_data =3D {
For consistency I'll rename this to rzn1_rtc_rzt2h_data to align with
rzn1_rtc_rzn1_data.

Cheers,
Prabhakar

> +       .has_subu =3D false,
> +};
> +
>  static const struct rzn1_rtc_data rzn1_data =3D {
>         .has_subu =3D true,
>  };
>
>  static const struct of_device_id rzn1_rtc_of_match[] =3D {
> +       { .compatible   =3D "renesas,r9a09g077-rtc", .data =3D &rzt2h_dat=
a },
>         { .compatible   =3D "renesas,rzn1-rtc", .data =3D &rzn1_data },
>         { /* sentinel */ }
>  };
> --
> 2.43.0
>
