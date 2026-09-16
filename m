Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475CE5013CD
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 13:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789565601; cv=none; b=aRKTA3mVzBnzDqMHSoZQRNH48rxvpMzz37defhwPTUVzmmKEMA943R+bI6Wr7o3q3pMwMphdP2iUH9s2kKJ5w/dwWnRtmrvozdZ8WjLvWPDWG5J7AP+3riFVHbnqm6IyQqiSCzCmJea/tOzUpaO/sFFJ/8Tv6/kSgl4VSg44700=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789565601; c=relaxed/simple;
	bh=mb2XQ1KGNSPMgyuxBLUyXCoX4VmOMT1Nq+RjhXhPzMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hwPKnD4AkrlPEFgbjHUpSIE1TmzydqZtC8nmLNERh/m9Li7AfvGjy8aNvfLANCH7zU54lCwYt0NW159RRsCzMTUUmW+kyH2nQ8loqo+oAxIr1H6NsKxvWr+Cg9huJFGeyP0wH9driq3Tr8ZwwizHQwOr+xiDDHC+bIoGH26pK2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c82bb05ddaso607909e0c.3
        for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 06:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789565594; x=1790170394;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KZim0+JELLYTz16Ra4InawCH9gXGh4ZTsyUS8+i0IEA=;
        b=Z1hcfAz7fO9d723KAOZ9oqwxUwjhEc7zfDB7HHmNsm5LGu1BIqwYP3oUFNK8P9E+/4
         tb5eHYhbzLcLuyDFzNSU6oSti1qnPpA9V7aluGR37CDLvugmH4l69I7VcMuaIT5TKBvh
         szHE9xoPgWdd0V0lLcn6fDzUuzPNCl/VJtTP/YoTz5/SCzqjnZIf4j3Kqz3geQs0KQpd
         ZvpkqT6DzAQvs2hrXNuaarRK8USfE6/YWRDIkgXD0b6S5+yxOYPJN14DKhRgWqK5KuSt
         D983OHJRyjQsZbVGN9oM3DRELPAorlulowCnR6JBlHoljE0x6dQMNfUkchnYBcG+Hesv
         kLyQ==
X-Forwarded-Encrypted: i=1; AKwUvBxldBTfQVCV5jBwwdT2O8T1p3Wl1GqAiy3+JWKNFylB7L3g7Y2Iei25ou6cIThTX2ZBtK3N4ZVFePs=@vger.kernel.org
X-Gm-Message-State: AFuF++nil3n5Tw5+rI888ihNNtnJU2TYQiWUL1R/A04zrQZASwz9dzUq
	RTE6gkeHv+TOpo2UDuNbZId/VN4fmm9fmzDhCgjffgaxpW1ByuPHXKiSURl1U3vA2TE=
X-Gm-Gg: AYBFou2jphQ0QJP7P6oK/aN+5OJTAp3WtMm4te6zTyd5z5MFWnbKB3ppFC6Q/1sN4Af
	PP0Lf8zFhOSwSXO3q36FPMob4D2qMRs2eRKg2dmGucjjXWcG2tZ8yq6Li6GvzcAIAphFyGqKJmL
	2KBXXMhPXYdu8x7mB23dHshwsNvrVLdYdmYIrN9eR3Hoy6dhc3QhfV2OBB9MNfa+iB35NZJS6NY
	vBoEmAYoezozW21zhR7MaUbXeh72Rf1/yjCI/RcJFMNJOLVhwV1b1NAk5AxafmXyB0jCdd5c/FX
	XMstsAb729nuJFTzSnRcV3BpnRiB4p2SzkgbSGF75QfeZV6egdm5IntfyplMow6oy8b9PHR2V9w
	5JbKkJw8BmPh/ml3K6Y8tywGysYkN1KNlC5jw5btrafNRqPg1KJuaA61fLAL2qJcDeuY3DnFWrv
	BINyWpQANc1QzM7AlZGzTmfGe5rj0rP49teb3AzORpCMOvqqAVDeE4t6t9so1f/UHdXuEydvlJU
	mTvcrR3q4YzFTrTzlJn6v9ecQrlljGdbTBh3Q==
X-Received: by 2002:a05:6122:2907:b0:5c5:ad20:1fc3 with SMTP id 71dfb90a1353d-5c99ac4d654mr2841395e0c.5.1789565593755;
        Wed, 16 Sep 2026 06:33:13 -0700 (PDT)
Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com. [74.125.226.204])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9831521c86csm2542130241.6.2026.09.16.06.33.13
        for <linux-rtc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 06:33:13 -0700 (PDT)
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e7c7b4ed2so532097241.2
        for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 06:33:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxO3tE+m/PbkiG+uaULP6QqVEcjCftZvISu2CgYc4wQ86Kh2mmm+5UverJblQXtp+BXK0SGGMcbfMA=@vger.kernel.org
X-Received: by 2002:a05:6122:1349:b0:5bf:8c77:e89a with SMTP id
 71dfb90a1353d-5c99ab375f3mr2670104e0c.2.1789565592896; Wed, 16 Sep 2026
 06:33:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916102520.24288-1-wsa+renesas@sang-engineering.com> <20260916102520.24288-5-wsa+renesas@sang-engineering.com>
In-Reply-To: <20260916102520.24288-5-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 16 Sep 2026 15:33:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUzvSZUiS9JK2R7doct+NFEFmFy4sZNqerOwER-6wnJ4Q@mail.gmail.com>
X-Gm-Features: AcwNN1XvSPah2oUTqePVUlnZa47A7Wxsz425P1ob6Q-7r15waklaFxMMFfTjinM
Message-ID: <CAMuHMdUzvSZUiS9JK2R7doct+NFEFmFy4sZNqerOwER-6wnJ4Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] rtc: rzn1: add R-Car Gen5 support
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, 
	Lad Prabhakar <prabhakar.csengg@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Wolfram,

On Wed, 16 Sept 2026 at 12:25, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> In general, the RTC on R-Car Gen5 is identical to RZ/T2H. X5H is an
> exception, though, because interrupts are not wired. X5H2 will have them
> wired again. So, skip alarm setup for the X5H case.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks for your patch!

> --- a/drivers/rtc/rtc-rzn1.c
> +++ b/drivers/rtc/rtc-rzn1.c

> @@ -503,25 +505,39 @@ static int rzn1_rtc_probe(struct platform_device *pdev)
>
>         spin_lock_init(&rtc->ctl1_access_lock);
>
> -       ret = devm_request_irq(dev, irq, rzn1_rtc_alarm_irq, 0, "RZN1 RTC Alarm", rtc);
> -       if (ret)
> -               return dev_err_probe(dev, ret, "RTC alarm interrupt not available\n");
> -
> -       irq = platform_get_irq_byname_optional(pdev, "pps");
> -       if (irq == -EPROBE_DEFER)
> -               return irq;
> -       if (irq >= 0)
> -               ret = devm_request_irq(dev, irq, rzn1_rtc_1s_irq, 0, "RZN1 RTC 1s", rtc);
> -
> -       if (irq < 0 || ret) {
> -               set_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->rtcdev->features);
> -               clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->rtcdev->features);
> -               dev_warn(dev, "RTC pps interrupt not available. Alarm has only minute accuracy\n");
> +       if (data->broken_irqs) {
> +               /* All known broken irqs are on SCMP only variants */
> +               rtc->rtcdev->ops = &rzn1_rtc_ops_scmp_no_alarm;
> +       } else {
> +               irq = platform_get_irq_byname(pdev, "alarm");
> +               if (irq < 0)
> +                       return irq;

As the DT bindings declare "renesas,r8a78000-rtc" to be compatible with
"renesas,rcar-gen5-rtc" (which does not set the broken_irqs flag),
a missing interrupt must not be fatal?

> +
> +               ret = devm_request_irq(dev, irq, rzn1_rtc_alarm_irq, 0, "RZN1 RTC Alarm", rtc);
> +               if (ret)
> +                       return dev_err_probe(dev, ret, "RTC alarm interrupt not available\n");
> +
> +               irq = platform_get_irq_byname_optional(pdev, "pps");
> +               if (irq == -EPROBE_DEFER)
> +                       return irq;
> +               if (irq >= 0)
> +                       ret = devm_request_irq(dev, irq, rzn1_rtc_1s_irq, 0, "RZN1 RTC 1s", rtc);
> +
> +               if (irq < 0 || ret) {
> +                       set_bit(RTC_FEATURE_ALARM_RES_MINUTE, rtc->rtcdev->features);
> +                       clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->rtcdev->features);
> +                       dev_warn(dev, "RTC pps interrupt not available. Alarm has only minute accuracy\n");
> +               }
>         }
>
>         return devm_rtc_register_device(rtc->rtcdev);
>  }
>
> +static const struct rzn1_rtc_data rzn1_rtc_r8a78000_data = {
> +       .has_subu = false,
> +       .broken_irqs = true,
> +};
> +
>  static const struct rzn1_rtc_data rzn1_rtc_rzt2h_data = {
>         .has_subu = false,
>  };
> @@ -531,7 +547,9 @@ static const struct rzn1_rtc_data rzn1_rtc_rzn1_data = {
>  };
>
>  static const struct of_device_id rzn1_rtc_of_match[] = {
> +       { .compatible   = "renesas,r8a78000-rtc", .data = &rzn1_rtc_r8a78000_data },
>         { .compatible   = "renesas,r9a09g077-rtc", .data = &rzn1_rtc_rzt2h_data },
> +       { .compatible   = "renesas,rcar-gen5-rtc", .data = &rzn1_rtc_rzt2h_data },
>         { .compatible   = "renesas,rzn1-rtc", .data = &rzn1_rtc_rzn1_data },
>         { /* sentinel */ }
>  };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
