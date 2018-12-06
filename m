Return-Path: <SRS0=to0F=OP=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2C1C04EB9
	for <linux-rtc@archiver.kernel.org>; Thu,  6 Dec 2018 09:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7A420892
	for <linux-rtc@archiver.kernel.org>; Thu,  6 Dec 2018 09:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7A420892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeLFJlS (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:41:18 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37379 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFJlS (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 6 Dec 2018 04:41:18 -0500
Received: by mail-vs1-f68.google.com with SMTP id h18so13905788vsj.4;
        Thu, 06 Dec 2018 01:41:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=81Z3CG/0v3EDIi5JrRBo0k2r90HeZatwZ0P6XOPxOag=;
        b=tR0k8yZhoqA1sdOUKW6u6n5f+u8Bu9N0XEtj9E0UZyZC7BmHpRk9Co9z0DGENgTPPG
         1jjI6CXtbNwYJusD2dVOUpF/qyOCP/VtBctKA9uL6p4mGyXkIYfLHer8aXZZm2EuH78u
         j6HRQsn/jPxCf6KFq5+WBJVqLK0aihyXKmwFXNQAZ9ohD8x9BHUZu3lEiVW3Npu5wP1n
         VuQIjqD+zl+KvldMavy4M6XNX89ZwxdMobi2LsNgnVvo4u/H3fc4YR0CVuWMUVKgD8gr
         3KnpWHC2Gh87fiRV6TBcyK4sLFE+Bvuo2KftNlDCybN4MUPJF29Kl4xTCjB7HiOQA6xi
         Oh/g==
X-Gm-Message-State: AA+aEWYH+zQ/XyfVCq4MPrAK405S2NiW8B32uGhzguLX2i3aciRKpm+l
        m2+YWlxaa/SY0rCLi0nCEJ6x54//v8SnJZgo1YU=
X-Google-Smtp-Source: AFSGD/UYMfCw1BU650SyAefGanK2tqU3fIIll0aipmQLQvnCw99443AaNCWXkRVb88aEAOOHYOymojFXHOXZJEor+mI=
X-Received: by 2002:a67:3885:: with SMTP id n5mr10738189vsi.96.1544089277202;
 Thu, 06 Dec 2018 01:41:17 -0800 (PST)
MIME-Version: 1.0
References: <1544086559-47141-1-git-send-email-biju.das@bp.renesas.com> <1544086559-47141-4-git-send-email-biju.das@bp.renesas.com>
In-Reply-To: <1544086559-47141-4-git-send-email-biju.das@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 6 Dec 2018 10:41:04 +0100
Message-ID: <CAMuHMdWTwfRu-NQSf3GbhG=r64uAiq5OHSHix8v13d8TLB5esA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] ARM: shmobile: Enable NXP pcf85363 rtc in shmobile_defconfig
To:     Biju Das <biju.das@bp.renesas.com>
Cc:     Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Thu, Dec 6, 2018 at 10:04 AM Biju Das <biju.das@bp.renesas.com> wrote:
>
> The iWave RZ/G1C SBC supports RTC (NXP pcf85263). To increase hardware
> support enable the driver in the shmobile_defconfig multiplatform
> configuration.
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
