Return-Path: <SRS0=JUId=RY=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1525FC43381
	for <linux-rtc@archiver.kernel.org>; Thu, 21 Mar 2019 10:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D6F218AE
	for <linux-rtc@archiver.kernel.org>; Thu, 21 Mar 2019 10:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfCUKWj (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:22:39 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:45910 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbfCUKWj (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 21 Mar 2019 06:22:39 -0400
Received: by mail-vk1-f195.google.com with SMTP id v187so1224512vkf.12;
        Thu, 21 Mar 2019 03:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AKUtZl8NClDnFzZw6+WVXCTH6fgoAAltG9cKzrnzI48=;
        b=s095xYdyLTonfA116aUfV8l+eN/hSH+PVPvLrWEnkmmolaCarWAYG1VmQ03mHhljo8
         nPdyYaNmTpv9k3m7jXh0WdYa7ZWpD97QpBWu2PQhfl7R0jn/YJEPaiJXyFMkto9WP7SI
         pQ95nSC/UFX7gxhDLCeGgbZBKigCik0xQL+6BPR6xShvltDFVYABsnSDu3akYse5H7Ym
         8k3+9PkeAD7XOBrKSG3g0coHTioSL4ZleYR54nO2i4OYwxN99l7GcR7NOiLApiwlF63Z
         Hj6OH4s0CT+Q9da4+FZEI0HETrP80B3Yi6t5GnOJlDt6oa95aaBnyUQMcqNyBGRTreBW
         QWyA==
X-Gm-Message-State: APjAAAVg2y6iozaH8znehyUb1syTUATIKjCtP1em6IXAUBTJXqz/cCPZ
        ee3AAh2nAYFaR4onps3y/sMvNg3utcs4dAjLdRM=
X-Google-Smtp-Source: APXvYqwaDsIfq4yhjOdNyKnEaRzaDnH8hcckBy5D7u3ioRQEm0eBIMzckP9Ii3zC42dupaWs27NKuhx6HZFjqzaeEu8=
X-Received: by 2002:a1f:95d5:: with SMTP id x204mr1631681vkd.72.1553163758177;
 Thu, 21 Mar 2019 03:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190320113010.8955-1-alexandre.belloni@bootlin.com> <20190320113010.8955-3-alexandre.belloni@bootlin.com>
In-Reply-To: <20190320113010.8955-3-alexandre.belloni@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Mar 2019 11:22:26 +0100
Message-ID: <CAMuHMdUOigr35gDjDNACkk2L4Cq-HQ=TtBAKGLiAhsmcVPOhSQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] rtc: sh: set range
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Brandt <chris.brandt@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Wed, Mar 20, 2019 at 12:30 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> The SH RTC is a BCD RTC with some version having 4 digits for the year.
>
> The range for the RTCs with only 2 digits for the year was unfortunately
> shifted to handle 1999 to 2098.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/include/linux/rtc.h
> +++ b/include/linux/rtc.h
> @@ -165,6 +165,7 @@ struct rtc_device {
>  #define RTC_TIMESTAMP_BEGIN_1900       -2208989361LL /* 1900-01-01 00:00:00 */

mktime64(1900, 1, 1, 0, 0, 0) = -2208988800 ??

Is this due to leap seconds, and mktime64() is valid for 1970 and later only?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
