Return-Path: <linux-rtc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15494C77B7F
	for <linux-rtc@archiver.kernel.org>; Fri, 19 May 2023 12:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjESMit convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 19 May 2023 08:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjESMis (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 19 May 2023 08:38:48 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8371F4;
        Fri, 19 May 2023 05:38:47 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-561b7729a12so11638887b3.1;
        Fri, 19 May 2023 05:38:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684499927; x=1687091927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RsiohPyfmUuh1RDjB7JqkRWD8PxiG5Qasv8IirbWDCQ=;
        b=g+OxegRl9hcDvp81xlE1CUN+BqU42M7rtXvJ5AyF+GNh6KFcd50vh21F30iJ4jaDkX
         up4ibKyZ1X/DCNKdJmOuzO0V12Vmk9Q8wMMeNC7uPsnGFJU69Qu0dVokTPAQm0SLiSqr
         GvxIxMFuMp3rHS3OmlZKntEGWXqm456WIydmLwMrYGeIUZA6f+x0hxobO5TmQy1rGfQm
         ZOoIGLyWFNPNYYauWG0jqG30wDSACONOnWL9c8huW2W9WMNIp7xV5TUvPTdH0UjPeiMs
         CrpoN54JZOsweV/Qk/PpVZDwl3EzbKmF6v0lVfaKVAe5Di2izgsCmc6X5dry1O8LwGnG
         FDAA==
X-Gm-Message-State: AC+VfDw5oisnQoRO02pSKID048POURw0gvqXfRp7soMCATfqzPCC316E
        j9eAaEo/v6tkk/8KIAk2tTMDcQ9AqL8CKA==
X-Google-Smtp-Source: ACHHUZ6eEN7ErPnTr881PAPr7duD0mwm14796+5QJmexT6Tv1YoVnJO1ZcKn6gpN1AD5/10X832lSg==
X-Received: by 2002:a0d:cac7:0:b0:55a:2084:9e05 with SMTP id m190-20020a0dcac7000000b0055a20849e05mr1585062ywd.23.1684499926810;
        Fri, 19 May 2023 05:38:46 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id y16-20020a0dd610000000b00561608bc0dfsm1133249ywd.56.2023.05.19.05.38.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 05:38:46 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-55db055b412so11922887b3.0;
        Fri, 19 May 2023 05:38:45 -0700 (PDT)
X-Received: by 2002:a81:494c:0:b0:561:1cb6:f3d6 with SMTP id
 w73-20020a81494c000000b005611cb6f3d6mr1637337ywa.0.1684499925543; Fri, 19 May
 2023 05:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230518113643.420806-1-biju.das.jz@bp.renesas.com> <20230518113643.420806-6-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230518113643.420806-6-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 19 May 2023 14:38:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXaJtZVxp5faw=vovsdukdwiXH8RbaJfiKAoOKTLWrZzA@mail.gmail.com>
Message-ID: <CAMuHMdXaJtZVxp5faw=vovsdukdwiXH8RbaJfiKAoOKTLWrZzA@mail.gmail.com>
Subject: Re: [PATCH v4 05/11] rtc: isl1208: Make similar I2C and DT-based
 matching table
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Thu, May 18, 2023 at 1:37 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> The isl1208_id[].driver_data could store a pointer to the config,
> like for DT-based matching, making I2C and DT-based matching
> more similar.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v4:
>  * New patch.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> @@ -822,9 +822,9 @@ isl1208_probe(struct i2c_client *client)
>         } else {
>                 const struct i2c_device_id *id = i2c_match_id(isl1208_id, client);
>
> -               if (id->driver_data >= ISL_LAST_ID)
> +               if (!id)
>                         return -ENODEV;
> -               isl1208->config = &isl1208_configs[id->driver_data];
> +               isl1208->config = (struct isl1208_config *)id->driver_data;

It's a pity there's no i2c_get_match_data() yet...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
