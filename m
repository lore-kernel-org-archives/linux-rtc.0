Return-Path: <SRS0=hZ7y=OJ=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EA7C04EB8
	for <linux-rtc@archiver.kernel.org>; Fri, 30 Nov 2018 11:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442C820834
	for <linux-rtc@archiver.kernel.org>; Fri, 30 Nov 2018 11:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 442C820834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbeK3WOY (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 30 Nov 2018 17:14:24 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:40946 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeK3WOY (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 30 Nov 2018 17:14:24 -0500
Received: by mail-vk1-f196.google.com with SMTP id v70so1167629vkv.7;
        Fri, 30 Nov 2018 03:05:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fzKz+VOoLGRU5UUTqgR3Itrf24cd7iIjZhfLdZ2LzqY=;
        b=UCeCQac2SVnVOdG4XkeyKjyVFMKOb/i852K1yT3U916vc1stZGEzFSD0eGITB18fWd
         +c7p45zegIX3/GQD6nxP/xyWbdZWuQQZZt5+dO3+NXNiDFPDHPhWlcSvJAOW0C0oLyP2
         V/ZjxPL6hvM9o/kgQE6wYWlubc4HnieCIgu5haZJD1dvhT0LgNK3BzwQkuSIpC6oNk2g
         6ewSva6m+eLyvm4TxEZJhsujWKKXil8Igejwv3i9qZ/JMuSgAOa0f2WL68danCSW3p9I
         1HHZ0UwoVtWefUo4MgawNmMJSrSmDR3DOlp+2B+b4AujFCBvpfdb6pG6k+ULzpfVUmph
         ObYA==
X-Gm-Message-State: AA+aEWbEQzC0z2+nGO/F1OoKHz9T3QyrZveiu5Oyba7K1AOL004v6+u0
        WKiUa8mViNAVV8yw5wLttKmM3X5xz3cyvh6yNHcPsjT+
X-Google-Smtp-Source: AFSGD/WqghSJgx0C7qoBJooa35jvrSZ+k3pLhb2RewQAr1ff7o98LRfA3by/N+gaLTSaEoq7OmEPOS2hNdtTOT4Jt/U=
X-Received: by 2002:a1f:1881:: with SMTP id 123mr2282355vky.40.1543575928120;
 Fri, 30 Nov 2018 03:05:28 -0800 (PST)
MIME-Version: 1.0
References: <1543510486-29532-1-git-send-email-biju.das@bp.renesas.com> <1543510486-29532-3-git-send-email-biju.das@bp.renesas.com>
In-Reply-To: <1543510486-29532-3-git-send-email-biju.das@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 30 Nov 2018 12:05:16 +0100
Message-ID: <CAMuHMdXmS6cCZhX_b+oszDjt+t8zgAkCGApweOX-k0Uq05=AEg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] rtc: pcf85363: Add support for NXP pcf85263 rtc
To:     Biju Das <biju.das@bp.renesas.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi Biju,

On Thu, Nov 29, 2018 at 6:03 PM Biju Das <biju.das@bp.renesas.com> wrote:
> Add support for NXP pcf85263 real-time clock. pcf85263 rtc is compatible
> with pcf85363,except that pcf85363 has additional 64 bytes of RAM.
>
> 1 byte of nvmem is supported and exposed in sysfs (# is the instance
> number,starting with 0): /sys/bus/nvmem/devices/pcf85x63-#/nvmem
>
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> ---
>  V1-->V2 Incorporated Alexandre and Geert's review comment.

Thanks for the update!

> --- a/drivers/rtc/rtc-pcf85363.c
> +++ b/drivers/rtc/rtc-pcf85363.c

> @@ -321,15 +344,25 @@ static int pcf85363_probe(struct i2c_client *client,
>                           const struct i2c_device_id *id)
>  {
>         struct pcf85363 *pcf85363;
> -       struct nvmem_config nvmem_cfg = {
> -               .name = "pcf85363-",
> -               .word_size = 1,
> -               .stride = 1,
> -               .size = NVRAM_SIZE,
> -               .reg_read = pcf85363_nvram_read,
> -               .reg_write = pcf85363_nvram_write,
> +       const struct regmap_config *regmap_config = &pcf_85363_regmap_config;
> +       struct nvmem_config nvmem_cfg[] = {

static?

Although the nvmem_config is copied, and thus static is not needed, I
guess using static will decrease kernel size.

> +               {
> +                       .name = "pcf85x63-",
> +                       .word_size = 1,
> +                       .stride = 1,
> +                       .size = 1,
> +                       .reg_read = pcf85x63_nvram_read,
> +                       .reg_write = pcf85x63_nvram_write,
> +               }, {
> +                       .name = "pcf85363-",
> +                       .word_size = 1,
> +                       .stride = 1,
> +                       .size = NVRAM_SIZE,
> +                       .reg_read = pcf85363_nvram_read,
> +                       .reg_write = pcf85363_nvram_write,
> +               },
>         };
> -       int ret;
> +       int ret, i, num_nvmem = 2;
>
>         if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
>                 return -ENODEV;
> @@ -339,7 +372,13 @@ static int pcf85363_probe(struct i2c_client *client,
>         if (!pcf85363)
>                 return -ENOMEM;
>
> -       pcf85363->regmap = devm_regmap_init_i2c(client, &regmap_config);
> +       if (of_device_get_match_data(&client->dev) ==
> +                                       &pcf_85263_regmap_config) {
> +               regmap_config = &pcf_85263_regmap_config;
> +               num_nvmem = 1;

I think it's cleaner if you store the full config (regmap_config + num_nvmem)
in of_device_id.data, instead of just the regmap_config, using

    struct pcf85x63_config {
            struct regmap_config regmap;
            unsigned int num_nvram;
    };

    static const struct pcf85x63_config pcf85263_config = { ... };
    static const struct pcf85x63_config pcf85363_config = { ... };

    static const struct of_device_id dev_ids[] = {
            { .compatible = "nxp,pcf85263", .data = &pcf_85263_config },
            { .compatible = "nxp,pcf85363", .data = &pcf_85363_config },
            { /* sentinel */ }
    };

Then you can just do

        struct pcf85x63_config *config = &pcf85363_config; /* default
for non-DT */
        void *data = of_device_get_match_data(&client->dev);
        if (data)
                config = data;

> +       }
> +
> +       pcf85363->regmap = devm_regmap_init_i2c(client, regmap_config);
>         if (IS_ERR(pcf85363->regmap)) {
>                 dev_err(&client->dev, "regmap allocation failed\n");
>                 return PTR_ERR(pcf85363->regmap);


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
