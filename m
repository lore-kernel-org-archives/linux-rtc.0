Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08DD3FA5E9
	for <linux-rtc@vger.kernel.org>; Tue,  4 Aug 2026 14:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785853881; cv=none; b=NFCLVbNSWaAtQENrtvicFmdLii4TGTr4r8O+kKjV3HFdJDuOo7Vp89kR8fortHb6drggk9vcN0QLSffz6JznFfyVoddiA1ZOWhKk3aKDiGOKAb3tX7h7CdQEE6lshe1NYTnRHNl+iP6HGUzfk0Wp4Sd+rCkMD6RAK3lS30mjZkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785853881; c=relaxed/simple;
	bh=QiJCNRyg0hPZ2mI4Gjma0OFzO/BLvZ2oUgJygGTgQGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C23LB8TxmefM8dHwk2GlYrn7xsFa4UNolPwwtAdlEVuFaxJ9I98ui7MIIlc7MzGH9oym2JnxxwFleYVNUmS7kI3t44zSgM07dE9pQL68ybLnHV3JjJhbiMJDLGubGv+HmrnUyOgw9F6ilVGP/b76/QPLP9+pTMNhVC+VNPgqicw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5c3163a88a1so1391987e0c.3
        for <linux-rtc@vger.kernel.org>; Tue, 04 Aug 2026 07:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785853874; x=1786458674;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WfbQ4y5yUdy2TJAvCiAC8jxLj5JOJo3d5fP3Tj0QSMo=;
        b=H1/zCfVlNYRlqEY6Q1hnF5ztLg/cYQC/SZnTWC2qH1ixW814LTsXDaYn4nch6tlr0i
         driWVK7UO94FKgXxkRy5p1aTEpQIRu3cUhIBMpAQawuX+iKh5vH+Zvjk5GHX0cNYHB99
         wlSdzZTTYKkLkpvv+Lv9nJcUxUHgxm+BfnvJf5YqGVx15xVkP6Vtuuu6n1rsgStUPE4d
         kE/SabUIL44niF9GNED4ywPL96SQom00zfl29B3yb7eH+1goxPxPQiwg9g7OeoPVB6T5
         E7NO5hRcoQGwV9LTVBil+vS44xrI0/xYAWEdyU8p7gBNpn9ajOtksH1uzy9RxZ56L9yQ
         NCvA==
X-Gm-Message-State: AOJu0Yzlj6eRfZ0glZY/fz079vkt2QdQHwtzhvwGqQpHswTSqTUjkYZO
	iIIFQGMXp5cQmQjj/8TkujP/9QYyYSqmVnMn/Gwj13dIjHAEe1GdrjS0k105loGF
X-Gm-Gg: AR+sD10K+I1/XgIYU5Us0eI1bN717fYk7YBM7jOfBWp98NCVKHvt7IFDduqHkDuJoxP
	In5UKakiv7alOzQxHzwDSfJgxSEquAEaiviK3TLe+jxrNFVl6JVKxj5kEj2dGWoUSL4d2yJULuq
	x12RoC7EOS5KvoiionY1hUuOUwFzqsQ9d4fkETpEtEV2pU7XhClBXkI1Rt7FJyqm00HzhXXMx8Z
	4blG4kv+z5/Hw15Mz8+pVYiVypk+ncFXuM1uoH/SrD+Ko9YjzUjSccmmyb6YqUJhsXzSTjVdfSI
	NOicCuRNH/9VJrVL+2UQohbt0+LBL3TBTRs6jfAV32u/r+eIAwJoNQf20pE0UvA+NXD4/CadRWX
	28Yl/7q+cigyziDUe2Fmni1p7TVbhBsE41i64iJ4XzBjBYu4rcS2fmWbPj5ao5QpvF1sPqRVfCP
	xwPMNtrAvo/cZQyL0nYFHmyVBL4jhVoZQhDYHMYdRkyWuquAwKFpwAuDdBfjQSQkrwoC4+lqnd1
	vXYZJEKKURXDA/swBXnJs4dHbp6gRXEwm5jdp0uOA==
X-Received: by 2002:a05:6122:d26:b0:5bf:bb66:414f with SMTP id 71dfb90a1353d-5c3877e01f0mr4717520e0c.11.1785853874155;
        Tue, 04 Aug 2026 07:31:14 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9782c8ea85bsm189175241.8.2026.08.04.07.31.13
        for <linux-rtc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 07:31:13 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5c3163a88a1so1391971e0c.3
        for <linux-rtc@vger.kernel.org>; Tue, 04 Aug 2026 07:31:13 -0700 (PDT)
X-Received: by 2002:a05:6122:4687:b0:5c2:ac92:eb18 with SMTP id
 71dfb90a1353d-5c387704235mr3498906e0c.7.1785853873478; Tue, 04 Aug 2026
 07:31:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728005610.575268-1-rosenp@gmail.com>
In-Reply-To: <20260728005610.575268-1-rosenp@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 4 Aug 2026 16:31:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUmAd0dba9_EPdJkqw4kQubtKms03Ws8P-WfY__yxTEjA@mail.gmail.com>
X-Gm-Features: AUfX_mzx-BRg1E-s4SG7HkbYeAMYP1kt95Rsysb98ELpkM0oLgUWl-DNPpZmMiA
Message-ID: <CAMuHMdUmAd0dba9_EPdJkqw4kQubtKms03Ws8P-WfY__yxTEjA@mail.gmail.com>
Subject: Re: [PATCH] rtc: msm6242: use devm_platform_ioremap_resource()
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-rtc@vger.kernel.org, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, open list <linux-kernel@vger.kernel.org>, 
	linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"

CC linux-m68k

On Tue, 28 Jul 2026 at 02:56, Rosen Penev <rosenp@gmail.com> wrote:
> Replace the open-coded platform_get_resource() plus devm_ioremap()
> sequence with a single devm_platform_ioremap_resource() call, which folds
> the resource lookup and mapping into one step and returns an ERR_PTR on
> failure, checked with IS_ERR() and propagated via PTR_ERR().

Thanks for your patch!

> The rtc-msm6242 platform device (arch/m68k/amiga/platform.c) provides a
> single IORESOURCE_MEM window (0x00dc0000-0x00dcffff). It shares that
> resource definition with rtc-rp5c01, but the two are registered under the
> mutually exclusive A2000_CLK and A3000_CLK hardware flags, so only one
> RTC device exists on a given machine. The region reservation now
> performed by devm_platform_ioremap_resource() therefore introduces no
> conflict.

Any patches adding seemingly safe region reservations need testing on
actual hardware.

> Assisted-by: opencode:hy3-free
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

> --- a/drivers/rtc/rtc-msm6242.c
> +++ b/drivers/rtc/rtc-msm6242.c
> @@ -188,21 +188,20 @@ static const struct rtc_class_ops msm6242_rtc_ops = {
>
>  static int __init msm6242_rtc_probe(struct platform_device *pdev)
>  {
> -       struct resource *res;
>         struct msm6242_priv *priv;
>         struct rtc_device *rtc;
> +       void __iomem *regs;
>
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       if (!res)
> -               return -ENODEV;
> +       regs = devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(regs))
> +               return PTR_ERR(regs);
>
>         priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>         if (!priv)
>                 return -ENOMEM;
>
> -       priv->regs = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> -       if (!priv->regs)
> -               return -ENOMEM;
> +       priv->regs = regs;
> +
>         platform_set_drvdata(pdev, priv);
>
>         rtc = devm_rtc_device_register(&pdev->dev, "rtc-msm6242",

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
