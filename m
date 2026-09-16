Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742214AE11E
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 12:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561194; cv=pass; b=MjAQGpQMCchd7bZ/ZBN/z5LUwQKkuoBX4AC3r4JmG3eazSzfy0MWj6Af+PlmsGJFmrefj+PKFEO1gNa2YxDi+Bi3eDLh4+1X67483pGALAwxRGxr8MEBFmulvRJg6R0ZlQxHSlJg4hnH3P0muUYfIY6wWAU7+DoIhl0aUWAS9G0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561194; c=relaxed/simple;
	bh=G9HVo9Aqceivkz0iz3E2b6xqgfO688o5efKuLJyMWQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a4BwiFrAjtuWGH433XMqoIabWLJNNw8T1QIx3HJRYmJSJT5WYxxjU48GwWEzBcrwfOLW6O2QyYpvG+kRMXY+Fg0HsQ/nE6Z3Bhb78Jpf6FzouLtW9UWqeLKLAEXdZYEbpsIFV7hEny5mySUGLJVI4WtITzok2zDYSxWZ51bBziw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CE6GJzDY; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CE6GJzDY"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b5so5248075e9.2
        for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 05:19:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789561191; cv=none;
        d=google.com; s=arc-20260327;
        b=n/dAza8xbR2UP0VMJFvxZaxmR2r20CWOhFJs/WuiVNfQBj4+RBGtlNgP8xb3cMvhLi
         fOIkBGs30JbEm8wkUAGaoWxeVfU2NOlt95Ce1N4EDO/ppJr27Ar26OHNiZKywkk4mSdB
         j/6WvI478unSlX6f2BiRJ3GgSJ8XQHCVOKI9mZw8qPZ6kLUW2r3qBZ121mI2eUAEhz2p
         yT4cqdk8y10eA0AA3W/JUCmVDDvLWVCx+TCNLa8upGWi+T9KCQVu+LTvoVxclx0CI3Jp
         HG8ulPxigcP5QJSwZT5Oc/L2+3vxYzVMCaYk3FiPZKdx+WEcAcnzLx9nbB56yHVtJIzR
         SGOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1fYP31x+ZetoLZvZ2p72nx1+nYq/7JEa4GCnuVLu/WQ=;
        fh=bRaIC6GK0JblZlnsy/NoX1URLNAn5GfUShGufVJ8AoI=;
        b=NE1MvvaSQyZVqf6ZB/tu8pJY2fHdrwmLTYasRmglYYncjuKFj5xzUkfupcQhbWPiGD
         DH/5CgWOU/po8jsLHrRZ4rfrMieVLEUN0zSR6QtcVa+0a++7xDCOAETnnxj7eCwLcH1u
         oGBFGob3nUrV44ATUbRjuRPyKiYyjRmSqHQugnoi5lsrL2a6mY+dMTSdpQl4rhHEsRP8
         F01xuf7hxu8qEYc04o93IoJ8vzqo8Ba7u2ACZTJdUQ1H3hAVol9IcJGu2hu2ap9o2gMB
         0qtSsZohDyaAvwxunRxNMszhTcxJiKmSYD6+MrSFMCVP9GxuVrJBxsc4nedxEgUAfdw1
         NYgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789561191; x=1790165991; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1fYP31x+ZetoLZvZ2p72nx1+nYq/7JEa4GCnuVLu/WQ=;
        b=CE6GJzDY/d7HkzqrJ+KeOC4w4GfSvpThLkpOg96srSpGusgb53Akcpuuxir1EG8aua
         JoKCOQdN4IwmIZ/BYS6uzfvSUmTY5k4LW1CrHawipN46v65lojXc2PCNHLdOKM21hi57
         +NznhneORojBRO5B+cNMS0FJ0OLRsSznhjpYLm//c/kYLTBJW1eIIQwlebeUgKMLXUQ+
         WKRcTq9TxsZqHhn02jqnUszAiDvlBWkks8TO/NYHzPYpgJUS1DHZigx5QuuWeqtKTzWc
         yauhN1CWVQhOH+XwU98UHR08WdKHHFGoaDXlrztOqryG3TWvlb+LgdaRCzOOGvH1xU7i
         AsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789561191; x=1790165991;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1fYP31x+ZetoLZvZ2p72nx1+nYq/7JEa4GCnuVLu/WQ=;
        b=bw0dC6PvX0f3PaNzzwsN17BclAYMFZwJ9gxYMZiTJ3XtGPcPF5nihnqY/Fgn7OTNCw
         kQGUefSfdcCR2LzuLAgWwtOJ4W/m4tK5dvezarwT2eDRoI43DxV/RBdWBqPiklyxrhkf
         Do7ZHFAw34QRaehPwG9JehO7eC0DT0p5/wy+Snaw6m57Hc6og+lZhIYlIG1O39gMoPDJ
         8UOOQ8e+TX+uRtpiF9AvWC06npP6RGTPteKIFuUu2ylEyP240vPKLzaqxsxjyqEWUWmO
         sc9eC8PU6SdxHY5BeUoL/kjOgNrCZrtpjvT3LXkQwrNyf2N6VXnIgggjwCt5FEBtTXu1
         Sebg==
X-Forwarded-Encrypted: i=1; AKwUvBxWUDzsTWG2ZNB4qHyk2L8cz3+nT9YQb2p+Kl/OiVtreyDu1AJgPe0+qqLh77eHEh8iffQV9NiIVkI=@vger.kernel.org
X-Gm-Message-State: AFuF++k+9+dB8d8j+IuLb4Pd97/B6KtTZHIKavaQeASD9pqAz9YpWtnB
	nGxRbsUyM/fGpVxdvbdcvaTvVqvBHePJ7NW5TFR7Fg5zrc2yTf25NetUnkUxUFUjJIJCkYjcBOd
	Jg6VA22Txr01XYlYSr1pA+wRjOtHRBY0=
X-Gm-Gg: AYBFou2KYu+G7kwBnSpx1v03dI+yufW8mDpovLwzClaWb7EsYNLQcXY3bnXqkJjcm4w
	3nqct2BAWcGRqC8Y5OvWrH5tzmmBEOm3exSPI4ufZdwnCLSyXNSIw4QC+4Z3RHtASzQHxOX/kma
	wspa5YoodFqhXcVFrQfCHjNoK5wuMUt04fB/q88OX5R0IhvM1M4DI9uPKeXAzXoeXCr8pxgOicE
	pLbKZNuZvh6VdMlbDIR6oAwKPCUO08z9RKAu++jU4avE+ZFDItg5KuNmG7APBbnHX8n7eBcG9BF
	bak6GEnjolczkSt99bSRZsNmcBnBAGiTBHoFIgmHKu3YnzsyCrrZyknsbg+o2JQHo313FuCZK4c
	h2/tljZ8NcZYBT9ODwOMQR3G/MofMP/ZQ2Wb1SAh2
X-Received: by 2002:a05:600d:1b:b0:49b:9105:cdaf with SMTP id
 5b1f17b1804b1-49f1d516a12mr50465085e9.8.1789561190370; Wed, 16 Sep 2026
 05:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916102520.24288-1-wsa+renesas@sang-engineering.com> <20260916102520.24288-5-wsa+renesas@sang-engineering.com>
In-Reply-To: <20260916102520.24288-5-wsa+renesas@sang-engineering.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 16 Sep 2026 13:19:24 +0100
X-Gm-Features: AcwNN1VnOb-DcBHMqbPBA1rZOv_DdI3Q5HtZCpT3BoZOqq95DEy4MHCWkXR49AA
Message-ID: <CA+V-a8v=4dA6ajrSdrZn8rBDG8E5-2m6AiUy_jRfHgJq+i9ntQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] rtc: rzn1: add R-Car Gen5 support
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 11:25=E2=80=AFAM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> In general, the RTC on R-Car Gen5 is identical to RZ/T2H. X5H is an
> exception, though, because interrupts are not wired. X5H2 will have them
> wired again. So, skip alarm setup for the X5H case.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/rtc/rtc-rzn1.c | 54 ++++++++++++++++++++++++++++--------------
>  1 file changed, 36 insertions(+), 18 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
> index b9d69ebdd224..349288a07632 100644
> --- a/drivers/rtc/rtc-rzn1.c
> +++ b/drivers/rtc/rtc-rzn1.c
> @@ -68,6 +68,7 @@
>
>  struct rzn1_rtc_data {
>         bool has_subu;
> +       bool broken_irqs;
>  };
>
>  struct rzn1_rtc {
> @@ -396,6 +397,11 @@ static const struct rtc_class_ops rzn1_rtc_ops_scmp =
=3D {
>         .alarm_irq_enable =3D rzn1_rtc_alarm_irq_enable,
>  };
>
> +static const struct rtc_class_ops rzn1_rtc_ops_scmp_no_alarm =3D {
> +       .read_time =3D rzn1_rtc_read_time,
> +       .set_time =3D rzn1_rtc_set_time,
> +};
> +
>  static void rzn1_rtc_disable_hardware(void *data)
>  {
>         struct device *dev =3D data;
> @@ -431,10 +437,6 @@ static int rzn1_rtc_probe(struct platform_device *pd=
ev)
>         if (IS_ERR(rtc->base))
>                 return dev_err_probe(dev, PTR_ERR(rtc->base), "Missing re=
g\n");
>
> -       irq =3D platform_get_irq_byname(pdev, "alarm");
> -       if (irq < 0)
> -               return irq;
> -
>         rtc->rtcdev =3D devm_rtc_allocate_device(dev);
>         if (IS_ERR(rtc->rtcdev))
>                 return PTR_ERR(rtc->rtcdev);
> @@ -503,25 +505,39 @@ static int rzn1_rtc_probe(struct platform_device *p=
dev)
>
>         spin_lock_init(&rtc->ctl1_access_lock);
>
> -       ret =3D devm_request_irq(dev, irq, rzn1_rtc_alarm_irq, 0, "RZN1 R=
TC Alarm", rtc);
> -       if (ret)
> -               return dev_err_probe(dev, ret, "RTC alarm interrupt not a=
vailable\n");
> -
> -       irq =3D platform_get_irq_byname_optional(pdev, "pps");
> -       if (irq =3D=3D -EPROBE_DEFER)
> -               return irq;
> -       if (irq >=3D 0)
> -               ret =3D devm_request_irq(dev, irq, rzn1_rtc_1s_irq, 0, "R=
ZN1 RTC 1s", rtc);
> -
> -       if (irq < 0 || ret) {
> -               set_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->rtcdev->featur=
es);
> -               clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->rtcdev->feat=
ures);
> -               dev_warn(dev, "RTC pps interrupt not available. Alarm has=
 only minute accuracy\n");
> +       if (data->broken_irqs) {
> +               /* All known broken irqs are on SCMP only variants */
> +               rtc->rtcdev->ops =3D &rzn1_rtc_ops_scmp_no_alarm;
> +       } else {
> +               irq =3D platform_get_irq_byname(pdev, "alarm");
> +               if (irq < 0)
> +                       return irq;
> +
> +               ret =3D devm_request_irq(dev, irq, rzn1_rtc_alarm_irq, 0,=
 "RZN1 RTC Alarm", rtc);
> +               if (ret)
> +                       return dev_err_probe(dev, ret, "RTC alarm interru=
pt not available\n");
> +
> +               irq =3D platform_get_irq_byname_optional(pdev, "pps");
> +               if (irq =3D=3D -EPROBE_DEFER)
> +                       return irq;
> +               if (irq >=3D 0)
> +                       ret =3D devm_request_irq(dev, irq, rzn1_rtc_1s_ir=
q, 0, "RZN1 RTC 1s", rtc);
> +
> +               if (irq < 0 || ret) {
> +                       set_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->rtcdev=
->features);
> +                       clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->rtcd=
ev->features);
> +                       dev_warn(dev, "RTC pps interrupt not available. A=
larm has only minute accuracy\n");
> +               }
>         }
>
>         return devm_rtc_register_device(rtc->rtcdev);
>  }
>
> +static const struct rzn1_rtc_data rzn1_rtc_r8a78000_data =3D {
> +       .has_subu =3D false,
> +       .broken_irqs =3D true,
> +};
> +
>  static const struct rzn1_rtc_data rzn1_rtc_rzt2h_data =3D {
>         .has_subu =3D false,
>  };
> @@ -531,7 +547,9 @@ static const struct rzn1_rtc_data rzn1_rtc_rzn1_data =
=3D {
>  };
>
>  static const struct of_device_id rzn1_rtc_of_match[] =3D {
> +       { .compatible   =3D "renesas,r8a78000-rtc", .data =3D &rzn1_rtc_r=
8a78000_data },
>         { .compatible   =3D "renesas,r9a09g077-rtc", .data =3D &rzn1_rtc_=
rzt2h_data },
> +       { .compatible   =3D "renesas,rcar-gen5-rtc", .data =3D &rzn1_rtc_=
rzt2h_data },
>         { .compatible   =3D "renesas,rzn1-rtc", .data =3D &rzn1_rtc_rzn1_=
data },
>         { /* sentinel */ }
>  };
> --
> 2.53.0
>
