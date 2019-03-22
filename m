Return-Path: <SRS0=8ZG9=RZ=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E840C10F03
	for <linux-rtc@archiver.kernel.org>; Fri, 22 Mar 2019 07:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0749E218FE
	for <linux-rtc@archiver.kernel.org>; Fri, 22 Mar 2019 07:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfCVH0z (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 22 Mar 2019 03:26:55 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34273 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbfCVH0z (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 22 Mar 2019 03:26:55 -0400
Received: by mail-vs1-f66.google.com with SMTP id t78so832265vsc.1;
        Fri, 22 Mar 2019 00:26:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U2MqBwNbXo7fUXIhYH4WOldqdsZmiVXbqfMjxPv2uWg=;
        b=S0Wr0SwmUEabPJnSDhxmjnF/+x4Yji/abMhddAeX3wl6phi+8nVT2ynNYNshgP/9eX
         JG/G6DCxPOLkYZpzlwVoX18et0OBlAh41T97PRHwolxDXvfsvvqvIDV/+spWerNxyvCR
         /hKUIJ2e8GAkCUYTLn4AWnaCOCA3Milv8cfj4hHxHCCYq+DyXBPx4y/kCvX0m4nWKBpr
         lZxV8D27jfR2S2Rp2orcySpjXHhNPPOi3FOeySxzsW8GgwJkxK9Dw8HlFb+T+S1TeXYd
         zgK7rsDi9eKq6CgS/wMJI28+hTdfxSrdUfa69z+bQsYeToYveC14PDIZzvKebZ17Exr4
         GSow==
X-Gm-Message-State: APjAAAVSecNpnZeOM3dLBxnSUt8u8IrQGT4qtjbwq94NJvbTq2kUo/BY
        Mnr5F2uLLDmUXvQdwTJASswAfifRCLcCRabzXMg=
X-Google-Smtp-Source: APXvYqwTDGCNDQSA3J/wxgw1WEgwAufanVHnBujCtwdAew9Z9EPIfAnQ2sp9aFl43qMzOD+xJnLZrs6KMvjN/4x6l8k=
X-Received: by 2002:a67:d011:: with SMTP id r17mr4540052vsi.96.1553239614205;
 Fri, 22 Mar 2019 00:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190320113010.8955-1-alexandre.belloni@bootlin.com>
 <20190320113010.8955-3-alexandre.belloni@bootlin.com> <CAMuHMdUOigr35gDjDNACkk2L4Cq-HQ=TtBAKGLiAhsmcVPOhSQ@mail.gmail.com>
 <20190322061207.GV29054@piout.net>
In-Reply-To: <20190322061207.GV29054@piout.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 22 Mar 2019 08:26:42 +0100
Message-ID: <CAMuHMdUPw3W6M68NOpuevum+zGrBOvsCF4zPH5KHq5sdpeaDcw@mail.gmail.com>
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

Hi Alexander,

On Fri, Mar 22, 2019 at 7:12 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> On 21/03/2019 11:22:26+0100, Geert Uytterhoeven wrote:
> > On Wed, Mar 20, 2019 at 12:30 PM Alexandre Belloni
> > <alexandre.belloni@bootlin.com> wrote:
> > > The SH RTC is a BCD RTC with some version having 4 digits for the year.
> > >
> > > The range for the RTCs with only 2 digits for the year was unfortunately
> > > shifted to handle 1999 to 2098.
> > >
> > > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > > --- a/include/linux/rtc.h
> > > +++ b/include/linux/rtc.h
> > > @@ -165,6 +165,7 @@ struct rtc_device {
> > >  #define RTC_TIMESTAMP_BEGIN_1900       -2208989361LL /* 1900-01-01 00:00:00 */
> >
> > mktime64(1900, 1, 1, 0, 0, 0) = -2208988800 ??
> >
> > Is this due to leap seconds, and mktime64() is valid for 1970 and later only?
> >
>
> That's a bug, it seems I didn't use the correct timezone when doing the
> calculation. Thanks for spotting that, you can send a patch to correct
> it or I can do it.

Thanks for confirming, done.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
