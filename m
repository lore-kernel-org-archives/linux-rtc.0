Return-Path: <SRS0=to0F=OP=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7323EC04EB8
	for <linux-rtc@archiver.kernel.org>; Thu,  6 Dec 2018 09:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44EA520850
	for <linux-rtc@archiver.kernel.org>; Thu,  6 Dec 2018 09:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44EA520850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbeLFJzR (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:55:17 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36064 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbeLFJzR (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 6 Dec 2018 04:55:17 -0500
Received: by mail-vs1-f68.google.com with SMTP id v205so13929096vsc.3;
        Thu, 06 Dec 2018 01:55:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DAfkmd2c6mS/kMhir3uQOsr4xFIe1dLwgi4Y//K3fKE=;
        b=p4zTmO3wfEFTRjMrdNFlpV3JMyywCvM1V7Pi+mDaEZ2M/EZYNGhUMyO0q9iEv1kAtD
         bE3oLnnsnVrHEQ+Sv76032F9lwzoQcwdTQ1VygNBSKKIS3FJQpQUfMmNiusDx7qXbtbw
         ym/lPeTXS5XieTbMQ6hYNjbHEZLj9T12emhzIrWbAHiZkUnlY9PoTuQH4P6O5Jd+mw1L
         +qhxjm0H18qcqtNXVAO2aOxmxHAxZ0/mm2g4jnj1YlatjcHM+5lUxEXWMWkQVitH+FQ+
         Ou4RtzdOgxghN8h7j+PTQNfMTtjGUhcCWVkbMoNobPqK4gdZmcCxb4Wn/GVqc9ZhPNVG
         M3NQ==
X-Gm-Message-State: AA+aEWZPGPvD4+voqN5cReCSbKxslZF8NB+oKY37Wu1kpSQO4E8v/VPn
        7UBkiKAk5nihZlaF+lvue5An/55OfXQyx+Y5ink=
X-Google-Smtp-Source: AFSGD/XDhR8bB9d4v3ey31gRbNCAmrTJfKb2CmuT6jIMcMwucvFnHQjNct9mT6QdOMuaqhPtevjlANH1jf6yo6q1fNo=
X-Received: by 2002:a67:c202:: with SMTP id i2mr11318455vsj.11.1544090116320;
 Thu, 06 Dec 2018 01:55:16 -0800 (PST)
MIME-Version: 1.0
References: <1544086559-47141-1-git-send-email-biju.das@bp.renesas.com> <1544086559-47141-5-git-send-email-biju.das@bp.renesas.com>
In-Reply-To: <1544086559-47141-5-git-send-email-biju.das@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 6 Dec 2018 10:55:04 +0100
Message-ID: <CAMuHMdUp2yOiMFFqT5MWhbK=O4fEuTMzH21Wp7HqYBdaruJ1nw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] ARM: dts: iwg23s-sbc: Enable RTC
To:     Biju Das <biju.das@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi Biju,

On Thu, Dec 6, 2018 at 10:04 AM Biju Das <biju.das@bp.renesas.com> wrote:
> Enable NXP pcf85263 real time clock for the iWave SBC based on RZ/G1C.
>
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
> +++ b/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
> @@ -84,12 +84,30 @@
>         clock-frequency = <20000000>;
>  };
>
> +&i2c3 {
> +       pinctrl-0 = <&i2c3_pins>;
> +       pinctrl-names = "default";
> +
> +       status = "okay";
> +       clock-frequency = <400000>;
> +
> +       rtc@51 {
> +               compatible = "nxp,pcf85263";
> +               reg = <0x51>;

You might want to enable the optional interrupt:

    interrupt-parent = <&gpio0>;
    interrupts = <2 IRQ_TYPE_LEVEL_LOW>;

> +       };


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
