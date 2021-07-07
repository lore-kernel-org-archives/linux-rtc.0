Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EECC07E9B
	for <linux-rtc@archiver.kernel.org>; Wed,  7 Jul 2021 21:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8FBC61C6C
	for <linux-rtc@archiver.kernel.org>; Wed,  7 Jul 2021 21:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhGGVtk (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 7 Jul 2021 17:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhGGVtk (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 7 Jul 2021 17:49:40 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118BDC061574
        for <linux-rtc@vger.kernel.org>; Wed,  7 Jul 2021 14:46:59 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id o12so2406915vsr.11
        for <linux-rtc@vger.kernel.org>; Wed, 07 Jul 2021 14:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OVlLJ+pAPYItXS3tJPJzpRseDWUnf4Vt5BYFXZy5W6s=;
        b=JSd4aZViw9xv9hsjqi6SjRBaCRT/OacAY8LCaxo1GKDShfdUS3AxcntMLgIsKCUU9t
         fSBv7QBvwFVj7zom9sEXO0FsKGU9kFfhx9izhIOftsHvTwEO5UXTmM30dwB4Fc9NLR6r
         Zp9Eo/unOo8bZ2IHiOLsX2KMg63xYCZGqs99eyV8cpoorX9MIkEVVL4GhcXV/q+zpXdZ
         9QF/MJvgJ9PCUdH8jZoYoRbvm6WiwRH4FN6QoPJpvpDHZpxgCoR9dNXs7GEduwU3YCvy
         et4dsthn/5F8JqGjGX6WMvZpWjvndaeJPpREVXWyBAAIzICGXLAc51PapgSmnBlYny6c
         aYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OVlLJ+pAPYItXS3tJPJzpRseDWUnf4Vt5BYFXZy5W6s=;
        b=gbUn8wjkJi+fg9ZtBdfWzfc3g1jSndp39IgAOBERH+9Fm1MNH5Z76jbt03yP800Fmd
         Ai4FdCTAPG7UuemHpKUX1irFW0O+cYzP0kS2GRfaHDCSIaaXmpfaPJm4EDidWp4MYXYE
         LzC4MzoMoY+xUFvUWDC9sDsRFkBj/t1OEvTebeJvyAQvNK4Y2IzHXzWXpi5r/Ri/Q6v6
         DvIk6Pghx8J4Fw3BSNA5b58TFYmkgXl9zinrfYtYBiCxTKkN5921ExhcQDLQAqhnjYAu
         R2wywYb7UEON68T0NGes/Xwpq1kuigYDb2U9BIy5jyUQoxntyiCSDG2AMkfdHSYgKRs5
         BLjA==
X-Gm-Message-State: AOAM530RUwxmQu+Wp3D4WRGA2PipQuhUMF83RkB5U/CuZPC9ewLnuxog
        E3SVUWREyGUkd/stZDN5rFFwUV89DDZvY/jfBxWTRLwliQ==
X-Google-Smtp-Source: ABdhPJyzpMHO0j8v9TXbeld2eR6G5cyvpMfbAaaw/P9uCLfV6lTDBvDMaedLubxyGaUOzYFA7qKCeDeosakM5C9BReg=
X-Received: by 2002:a67:ba17:: with SMTP id l23mr23711956vsn.24.1625694417381;
 Wed, 07 Jul 2021 14:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210707071616.28976-1-matt@traverse.com.au> <20210707071616.28976-3-matt@traverse.com.au>
In-Reply-To: <20210707071616.28976-3-matt@traverse.com.au>
From:   Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date:   Thu, 8 Jul 2021 06:46:31 +0900
Message-ID: <CABMQnVL379GkR_s5c91a0LAPMemup_Lq8U+qU9M1-kBWfVqmTw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: rtc: add Epson RX-8025 and RX-8035
To:     Mathew McBride <matt@traverse.com.au>
Cc:     linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi,

2021=E5=B9=B47=E6=9C=887=E6=97=A5(=E6=B0=B4) 16:17 Mathew McBride <matt@tra=
verse.com.au>:
>
> These are supported by the rtc-rx8025 module. RX-8025
> also has support in ds1307 due to compatible time registers.
>
> Signed-off-by: Mathew McBride <matt@traverse.com.au>
> ---
>  Documentation/devicetree/bindings/rtc/trivial-rtc.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml b/Doc=
umentation/devicetree/bindings/rtc/trivial-rtc.yaml
> index 7548d8714871..13925bb78ec7 100644
> --- a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
> @@ -32,6 +32,9 @@ properties:
>        - dallas,ds3232
>        # I2C-BUS INTERFACE REAL TIME CLOCK MODULE
>        - epson,rx8010
> +      # I2C-BUS INTERFACE REAL TIME CLOCK MODULE
> +      - epson,rx8025
> +      - epson,rx8035

'epson,rx8035' is unnsecessary.
This lists compatible string, so we don't list compatible that doesn't exis=
t.

>        # I2C-BUS INTERFACE REAL TIME CLOCK MODULE with Battery Backed RAM
>        - epson,rx8571
>        # I2C-BUS INTERFACE REAL TIME CLOCK MODULE
> --
> 2.30.1
>

Best regards,
  Nobuhiro


--
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org / kernel.org}
   GPG ID: 40AD1FA6
