Return-Path: <SRS0=N1Xq=OA=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092AFC43441
	for <linux-rtc@archiver.kernel.org>; Wed, 21 Nov 2018 10:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0DE920C01
	for <linux-rtc@archiver.kernel.org>; Wed, 21 Nov 2018 10:23:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0DE920C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbeKUU5N (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:57:13 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41436 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbeKUU5M (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 21 Nov 2018 15:57:12 -0500
Received: by mail-vs1-f66.google.com with SMTP id t17so2910650vsc.8;
        Wed, 21 Nov 2018 02:23:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DEY70jtPvGl/QYsJ5zXBpzrAQUz8A+yKM33FuNHlcTY=;
        b=ANe6nA+jg3gX5k9/j9N8Y1HvNGDjy3Jh0kD04eg8ZU/08suqTLvtRATrK33xx4vqBP
         7rYegNcpY+fw3S/0QqoDybddWHehmTH9Fgcg37JM6MWnq+WLH500qlnPi5ygukiRH+vn
         Axly9mljRE494RzK7vIZ719bX8me1uZwd/KcaBYbNmhU3+Zhrk3ZXDmqDNAz+YCFbFM2
         oOoui2KnlJHRWzwDGNpR53Cq4t+xnp0/WNySWfiY7DIZeESjihhtXwBGFDZVBud/SCZJ
         Bqzxy+LVFZbjn9AoV2edjiaPEfEXHP0sqXyRIXHSAHSOqMpBVuXxf1TgU3Er/li62u8R
         +BXg==
X-Gm-Message-State: AGRZ1gLDneBIghGueCLQGmhnacniyYmEwkdXXSBZYwdX5jnKmUx+YiI6
        w0J2C6hzJKf6jGxSxYBZmKPSDByi6HodJywciJw=
X-Google-Smtp-Source: AJdET5ekLmzK29y9WSqVxRn+SLv52EyNbJtx9sbEHrQ8NZblBKg7Mh/fOgr2VWB9+NeKcssFyQPZUMM3iJrX+cZzLmY=
X-Received: by 2002:a67:b60d:: with SMTP id d13mr2546567vsm.152.1542795801339;
 Wed, 21 Nov 2018 02:23:21 -0800 (PST)
MIME-Version: 1.0
References: <1542626108-61344-1-git-send-email-biju.das@bp.renesas.com> <1542626108-61344-3-git-send-email-biju.das@bp.renesas.com>
In-Reply-To: <1542626108-61344-3-git-send-email-biju.das@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 21 Nov 2018 11:23:08 +0100
Message-ID: <CAMuHMdVpaB0mJq9LmBoHgBY9MNAXYAKN=h8hCX+iph+D_5pY=Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] rtc: pcf85363: Add support for NXP pcf85263 rtc
To:     Biju Das <biju.das@bp.renesas.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi Biju,

On Mon, Nov 19, 2018 at 12:23 PM Biju Das <biju.das@bp.renesas.com> wrote:
> Add support for NXP pcf85263 real-time clock. pcf85263 rtc is compatible
> with pcf85363,except that pcf85363 has additional 64 bytes of RAM.
>
> 1 byte of nvmem is supported and exposed in sysfs (# is the instance
> number,starting with 0): /sys/bus/nvmem/devices/pcf85263-#/nvmem
>
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/rtc/rtc-pcf85363.c
> +++ b/drivers/rtc/rtc-pcf85363.c
> @@ -311,7 +311,30 @@ static int pcf85363_nvram_write(void *priv, unsigned int offset, void *val,
>                                  val, bytes);
>  }
>
> -static const struct regmap_config regmap_config = {
> +static int pcf85263_nvram_read(void *priv, unsigned int offset, void *val,
> +                              size_t bytes)
> +{
> +       struct pcf85363 *pcf85363 = priv;
> +
> +       return regmap_read(pcf85363->regmap, CTRL_RAMBYTE, val);
> +}

AFAIU without reading the datasheet, the pcf85363 also has this RAMBYTE
register. Would it make sense to expose the contents on both parts?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
