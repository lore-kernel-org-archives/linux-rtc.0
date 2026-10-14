Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E59C4BB815
	for <linux-rtc@vger.kernel.org>; Wed, 14 Oct 2026 10:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791972211; cv=pass; b=CPXQ8s/1BKBqSNSdvU5pQMJ+oVAQIlwH8aNdS7Z4Rm9WAuLr+uu4YUQ1/flAE4+bNIzD5xu+2H0zG45PQCTzwJAWLTqeikyj02ThS4Cqs4yI9tlUwBHZBcYV0q41bjgFa+tIbt6DGd8/CP2QWxuutqcEZGUSnKkxyt27KAXy95s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791972211; c=relaxed/simple;
	bh=X4IPUWRzqd3vNvyDbKw42IC1Li/8214eRkoZv4hcu5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lf/q/5ulDBeSmQ+Kr7yNMm0hbQrNskAbbAdf6lInmcT6/V/aGxeIDvUfjqZFTNsZPwXXn1lGEx6XzqfSeBANJEepKYSvQPVqfjheNXMgB4Tuqmf+3eK8jjZ5Iv53/wf+WIn9lNHc1kq2ezPKpGVJloUt+tojC4DnaSjUJcqnQVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/fTK789; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/fTK789"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e60f9af6e6so6422645ad.3
        for <linux-rtc@vger.kernel.org>; Wed, 14 Oct 2026 03:03:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791972210; cv=none;
        d=google.com; s=arc-20260327;
        b=GwSJj4d0aCx/k132yYncWAcwMMF7d30R2yvNK+nCDFFfzMyXoLEtCe0/YULatFkMSx
         BxtJ6g5D0c7SqXTSuufafM3krWGuPciEPxEVOIlH1vKb2GO7xB61opeKj3nAtONNvqug
         5zA1ssNQPnBnIrTEN9cy5tYXmPWGS1k2GxrwM4R+olxW2Q2XBs2O04s2aQ2PVnRoUkn6
         I/OFuHtezZqXrnW8AIUGHJboh0mBGgRjgih4sRnQxpiJd0EvphypUOHwnvej1oKSICh0
         98ROW/vDb75li5wPD3+XJ4Nv99KDj0hEokKBBlaqyRcIRp1D9N8wz5IniW4gLynFfSxY
         dqMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TkBY0USOLdA22gx/2rOX5OcC9aCnCnZClTEGNm0xQJA=;
        fh=m9uQCJyZ5wz5POfcHLTgF8Htpa8EyPGa2NoYtfbvuq4=;
        b=CTPrX59wkD+JgmFmILwIEBEG5W5xotH9rB5QjjQRy1KV6bS0lCCpvaJLqhr8k9db0O
         FQwXv5eCHHAoSMu/2hLgv7UL0TFlqnAdsDvJkPxFUKjwT22FkBimD2oG1aV+/ogy4n2w
         pQCc+dMmc9nZIpWasJ7sGLkTJcfj7x5X/C2n5XC2jnamyQQ2XLzPvX/LrqjlZnWQM557
         nGCoUN1bRMpl4YmtlcwmaUCeu/GISU1kQNL8aNHLJboU4CwLcpum5nkprNx3gmLQDUDc
         2cBbL0+ZDcVcBjDK04BlmooUorZAYB16TDzsfzPgE7S8J39zvjDZcc/hIzFU8HtReIPH
         IybQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791972210; x=1792577010; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TkBY0USOLdA22gx/2rOX5OcC9aCnCnZClTEGNm0xQJA=;
        b=Z/fTK789A+okaxurLpsVesjB0Mf4XqeL4GmWnKZO3zmvPcFXU0ugZuF4JHf4wLv2hP
         mnrBcvGrm0PSQB33n0fJgQS7d1bfEuysmJXKkDGofNZrEip4jME6tHFHxBkQEleU4l4J
         MVc17cz6O606zEn+Rhz2hOwTL97BKUm9KZaQ3Nn6b20Yhf/HWw7AhiOhUdKV5GtmYT5i
         X/y4BWM7u4zWY+4vtqNMiSKnTrmSAnGgtBT6AygEGHyt6LUDvP9HQQGUxAebCkrTkPxa
         aAFLGj7w9Dq23AzalUtki4P7fsMPkEKS/F5sUXSQLIUrMQqO4dGQIQsKkwJ48YMiHyYc
         ySXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791972210; x=1792577010;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TkBY0USOLdA22gx/2rOX5OcC9aCnCnZClTEGNm0xQJA=;
        b=ffkT+wbKlFn4anzuqMQ6VyNnefNt4qECm8mToOjiWYz8xVFTCdpAxuwT4+T2aeBZ5F
         7sDL3PtXSveD2x/Iu9vy9CT09KExjVnbd+N87suoTQ+yY71W/RnpsPOqDfV4qEDzfOgl
         MKkpyXQgo5Aktin3vdkn2ECK7Fssnxkv8dNob6n0OK3nbCnmOYl3C+goVImz5fq7wS4M
         Y1teogM/W3FTHmK7l9qdkw/CH/EETSbXjLiBXRtKGlwlrGJLjEC1mNY3iLmjcWfvTBgZ
         60EQbzALAn+r9OcoZgmgfB+/5FtB7VLkl0c/TWp4/qkI5Zjr1LMG+Y1kp3IM/b2BIiHj
         kGaQ==
X-Forwarded-Encrypted: i=1; AKwUvBwD7sc3j6Orby9pP/K1H4TebliCcg9MlbmMf01wLHRKxAxGrh/c4dZWfXq5Aqvv6vDaU10x4p3VTps=@vger.kernel.org
X-Gm-Message-State: AFq9FYKrZOrBAzukZUXoy8ZaxRi9AvMdWpMjKSAvUv0p1VoTdb6eq46j
	N1PV4bX/SMT0q9Lpij3pApdSFg1HcuD+wrv1rg8KjomtmoMlRRHohx6yHA6Z7N3mEqlHpTfbByY
	eyDxETGub/HCzp1ek5A8rJD1VYBhWuYmg6rbVj6m+yA==
X-Gm-Gg: AYBFou0Wnwfn6FUhgjFob120UcFZPLXJs5u7C/r8zj3su4SB2AfoBME7pIT2P8MEN8i
	dUm3fMqgT4K8ovVb8ljmEmmPzaTomQQuISECE1AosXyykFOnKCD65fP0QG1/4atwnzvR5vQfM19
	HePwHyg97i5ZY9g1nDvquHkWAhEsNkY7tSorbHiALl+Y/TuOjkoNbOSfpkvxzGjwgfQiYtzr7GD
	czczXvLIN0kLJz6SoY4Ay0wUEHo4PgcnfqydTXzFV7tGk7W0W3R4xfabsDOcgZuvceXCKk/Kx9D
	FhJ2ljfatC/rWu4ftXxCFT3kjXiNKZjG7sM8o2M5iBEsOYZ8t7f6mhAiUCuvMLtSY6cUew==
X-Received: by 2002:a17:902:c40d:b0:2e2:dc50:16a8 with SMTP id
 d9443c01a7336-2e842cfd967mr144835445ad.27.1791972209741; Wed, 14 Oct 2026
 03:03:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012100816.331033-1-pmazzini@gmail.com> <20261012100816.331033-7-pmazzini@gmail.com>
 <sashiko-outbox-167946@kernel.org>
In-Reply-To: <sashiko-outbox-167946@kernel.org>
From: Pablo Mazzini <pmazzini@gmail.com>
Date: Wed, 14 Oct 2026 11:03:01 +0100
X-Gm-Features: AclHuK_IjvhnMV0ZgXT4S6uhoftE_NPkdNnWLTaSlgrxF5SaMhOEDanyjwfKrQs
Message-ID: <CAAxh=juJViKpvj3hBdWE0E2Z5jLLGqc6EWRqD0aZnr40sPHQWA@mail.gmail.com>
Subject: Re: [PATCH v4 06/11] rtc: sun6i: add Allwinner B288 compatible
To: sashiko-reviews@lists.linux.dev
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-sunxi@lists.linux.dev, 
	linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

These are in sun6i_rtc_clk_init(), which this patch reuses unchanged for
the B288, so they apply to all the SoCs using it. I can look into it
separately.

On Mon, Oct 12, 2026 at 11:19=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [High] rtc: sun6i: missing ERR_PTR check causes crash in probe on clk_r=
egister failure
> - [Medium] rtc: sun6i: resource leak of losc clock on initialization erro=
r path
> - [Low] rtc: sun6i: memory leak of rtc structure in sun6i_rtc_clk_init er=
ror path
> --
>
> commit 903d00f6b5cb6afede9ad6ad5fca01853d776ce4
> Author: Pablo Mazzini <pmazzini@gmail.com>
> Subject: rtc: sun6i: add Allwinner B288 compatible
>
> This commit adds support for the Allwinner B288 RTC by reusing the A23
> clock configuration. It maps the new compatible string
> allwinner,sun8i-b288-rtc to the existing initialization functions.
>
> > diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
> > index 7fc60880e4094..05004e80ac089 100644
> > --- a/drivers/rtc/rtc-sun6i.c
> > +++ b/drivers/rtc/rtc-sun6i.c
> > @@ -350,6 +350,10 @@ static void __init sun8i_a23_rtc_clk_init(struct d=
evice_node *node)
> >  CLK_OF_DECLARE_DRIVER(sun8i_a23_rtc_clk, "allwinner,sun8i-a23-rtc",
> >                     sun8i_a23_rtc_clk_init);
> >
> > +/* The B288 RTC clocks are the same as the A23's */
> > +CLK_OF_DECLARE_DRIVER(sun8i_b288_rtc_clk, "allwinner,sun8i-b288-rtc",
> > +                   sun8i_a23_rtc_clk_init);
> > +
>
> [Severity: High]
> Does adding this compatible string expose an issue in the error handling
> of sun6i_rtc_clk_init on registration failure?
>
> If clk_register fails for rtc->losc, the function returns an error
> pointer and jumps to the err_register label. Since the global sun6i_rtc
> pointer is already assigned to the allocated rtc struct earlier:
>
> sun6i_rtc_clk_init()
>     /* Yes, I know, this is ugly. */
>     sun6i_rtc =3D rtc;
>     ...
>     rtc->losc =3D clk_register(NULL, &rtc->hw);
>     if (IS_ERR(rtc->losc)) {
>         pr_crit("Couldn't register the LOSC clock\n");
>         goto err_register;
>     }
>
> The probe function sun6i_rtc_probe later fetches this dangling pointer:
>
> sun6i_rtc_probe()
>     struct sun6i_rtc_dev *chip =3D sun6i_rtc;
>     ...
>     clk_prepare_enable(chip->losc);
>
> Can this lead to a kernel panic when clk_prepare_enable attempts to
> dereference the error pointer stored in chip->losc?
>
> [Severity: Medium]
> Additionally, if clk_register succeeds for rtc->losc but a later clock
> registration fails, triggering the jump to err_register, does this
> cleanup path leak the rtc->losc clock?
>
> sun6i_rtc_clk_init()
> err_register:
>     clk_hw_unregister_fixed_rate(rtc->int_osc);
> err:
>     kfree(clk_data);
>
> The err_register path unregisters rtc->int_osc but appears to omit
> calling clk_unregister(rtc->losc).
>
> [Severity: Low]
> Does the err cleanup path also leak the dynamically allocated rtc
> structure?
>
> sun6i_rtc_clk_init()
>     rtc =3D kzalloc_obj(*rtc);
>     ...
> err:
>     kfree(clk_data);
>
> The error path frees clk_data but seems to omit freeing the allocated
> rtc structure.
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012100816.33=
1033-1-pmazzini@gmail.com?part=3D6
