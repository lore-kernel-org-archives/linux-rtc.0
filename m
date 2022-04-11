Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D132C43217
	for <linux-rtc@archiver.kernel.org>; Mon, 11 Apr 2022 15:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347900AbiDKPZQ (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 11 Apr 2022 11:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347871AbiDKPZG (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 11 Apr 2022 11:25:06 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291593BF82;
        Mon, 11 Apr 2022 08:22:51 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id bk12so10882473qkb.7;
        Mon, 11 Apr 2022 08:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lku+hoHFzt1e28Ahk8UaGKlfUPzqGYonqFhWJ98wq7g=;
        b=q9YbdKAiqR/XTl7eW7yU7a41tsT4j2VSefLRDxK62445GPhgpZgKifcQwUVJgojpx/
         YSHZQvPkxHGr0N3qVB9I+7jbys5gUJ0MsWx5CABRCEfSIMzlRe5AKZ1Ws2Ax8dM5EVdU
         cKmJEy+pGV79sEN9ffDXs3PtiBfisNDqh4y7k1oMdRpRq+qANp5kfGJLMyvna2aYvHl+
         J5PotLDYU+m/6CnAzVtC1rMhCKtldX6QwM4MzcnfHEJfftGNtbrlOzGGhzcR+hIYpZId
         vEsp6OwtByzIJ0mof+OXVwUTMqJuJG50PMDhHMgiYOm5KGbFEkKqZ19NlMidcT9+aVTY
         dhdg==
X-Gm-Message-State: AOAM533bhOQ1YYxWtzbNsdaepwQWIEdvjciFIpQOmGxoLA4QGWaqRb//
        SoSDv028H/O3scSVtowRHtU/GhFJvnCKkg==
X-Google-Smtp-Source: ABdhPJwWX3jRX6WeAgI6DT2YEK/BcXC0KeDlUdI2hg0VMxJZkToU49DQOVAyYQGhTMxMUNi0WbPqRw==
X-Received: by 2002:a05:620a:44d3:b0:680:9eb3:e7ad with SMTP id y19-20020a05620a44d300b006809eb3e7admr21753851qkp.376.1649690569408;
        Mon, 11 Apr 2022 08:22:49 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id c10-20020ac87dca000000b002e1db1b7b10sm25337271qte.25.2022.04.11.08.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 08:22:49 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2ebf3746f87so74612727b3.6;
        Mon, 11 Apr 2022 08:22:48 -0700 (PDT)
X-Received: by 2002:a81:618b:0:b0:2db:d952:8a39 with SMTP id
 v133-20020a81618b000000b002dbd9528a39mr26340123ywb.132.1649690568687; Mon, 11
 Apr 2022 08:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220405184716.1578385-1-miquel.raynal@bootlin.com> <20220405184716.1578385-7-miquel.raynal@bootlin.com>
In-Reply-To: <20220405184716.1578385-7-miquel.raynal@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Apr 2022 17:22:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVQFXYKBiqN0eZTVH4VCf6WuVLWezWj4CCzhkYkt2WMeA@mail.gmail.com>
Message-ID: <CAMuHMdVQFXYKBiqN0eZTVH4VCf6WuVLWezWj4CCzhkYkt2WMeA@mail.gmail.com>
Subject: Re: [PATCH 6/7] MAINTAINERS: Add myself as maintainer of the RZN1 RTC driver
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Tue, Apr 5, 2022 at 8:47 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> After contributing it, I'll volunteer to maintain it.

Thanks a lot!

> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
