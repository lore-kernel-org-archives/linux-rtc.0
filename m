Return-Path: <SRS0=to0F=OP=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFB7C04EBF
	for <linux-rtc@archiver.kernel.org>; Thu,  6 Dec 2018 09:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E8220892
	for <linux-rtc@archiver.kernel.org>; Thu,  6 Dec 2018 09:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E8220892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbeLFJN5 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:13:57 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:37731 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFJN5 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 6 Dec 2018 04:13:57 -0500
Received: by mail-ua1-f66.google.com with SMTP id u19so8145342uae.4;
        Thu, 06 Dec 2018 01:13:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v9Kr3rS5jNT2kWWHAh17twyvh/2cKZm9OQjwkrM7v6U=;
        b=iij5pXVvI2C089mQf1kJTuv/NR7bPGhPfP8gww4ePO2tUPgdyTMRig4zCRXoAKoOOh
         ywdRlAIiFB5jF3/p6TI6JqJvFiVurZuabLvT/ylHbuM9X92lQLG1DCrDrKFLCTLhpol2
         IVWlmjW2P7wbhm6BmT+U/LvEoP4+5hBQGUHO357MLwzrYDqV8Ve0+JkgBGGngx5seujG
         PuAoYTL5to3f5e9H2i1aJKqWffmG3cvERM+tBtil7AR87rquOH+hL9kx5WIHJBJSRLbj
         ovrtBP4Dh2LGEHfaAvmZJytkkxNbo8mKe5nZxrZOMbnTYOZ3+NpX7abOJS03l+zUUeRo
         Z+Lw==
X-Gm-Message-State: AA+aEWaBk2EBI3tK2jnpQl3DKUMkhoWKyTgdpGBovvW3wmWHg91UZP3a
        KzJPLfU0FFK3cocuQd4VW0XJ9eNeMJcjSWPDFmo=
X-Google-Smtp-Source: AFSGD/X7KIDLd4G/qptgh1XX3FH6qEhEdaOQwVFzhubmKvCF3FomrJTwOdOFoOjazP/r613Xdgb1J/plv7CeHjwUyxk=
X-Received: by 2002:ab0:465:: with SMTP id 92mr12636210uav.28.1544087635889;
 Thu, 06 Dec 2018 01:13:55 -0800 (PST)
MIME-Version: 1.0
References: <1544086559-47141-1-git-send-email-biju.das@bp.renesas.com> <1544086559-47141-2-git-send-email-biju.das@bp.renesas.com>
In-Reply-To: <1544086559-47141-2-git-send-email-biju.das@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 6 Dec 2018 10:13:43 +0100
Message-ID: <CAMuHMdV5tsqNN+_vR47J2OTCt5W0QqFLEm0u1JV+UAC+_vFn6g@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: rtc: pcf85363: Document pcf85263
 real-time clock
To:     Biju Das <biju.das@bp.renesas.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-rtc@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Thu, Dec 6, 2018 at 10:04 AM Biju Das <biju.das@bp.renesas.com> wrote:
> The pcf85263 RTC is compatible with the pcf85363 RTC.
>
> The difference between the pcf85263 and pcf85363 RTC is that the latter has
> 64 bytes more RAM. This renders them incompatible from a DT point of view.
>
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
