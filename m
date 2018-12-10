Return-Path: <SRS0=WBM2=OT=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A78C04EB8
	for <linux-rtc@archiver.kernel.org>; Mon, 10 Dec 2018 11:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3CEB20821
	for <linux-rtc@archiver.kernel.org>; Mon, 10 Dec 2018 11:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3CEB20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbeLJL4Z (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 10 Dec 2018 06:56:25 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:41104 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLJL4Z (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 10 Dec 2018 06:56:25 -0500
Received: by mail-vk1-f193.google.com with SMTP id t127so2436346vke.8;
        Mon, 10 Dec 2018 03:56:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IIeSLaUuQWzLygeHffOjIfX4wm/M5NWTsS3rxl/ztSo=;
        b=MXeLB3kR4mdAKfCJmR9gwye/JqaNHr1N/7aglVO+92OA5afZDCLihxktmoTRnFb9hy
         kOiS/oJIjxThNjI4O0zJCLz+iyBT1zPLh9ACeyKAWHBwRhdHXA7fufvfjxjBc2OnU0S5
         bVsebuc/mC52ieklOUKZDcXoZXnEpZlwMdI38Y1iLg2BInhL67uJR9+qSW3irVUP36Cg
         55kIyAOcZrixBuxaODbZvFhAjFxHYwZhyGLqZMvg5vr/mZQVHzezDHJ9mNeRaO65JWPV
         ITcYTStoRjZ3jmfljlYdh7wQX1EQZYGDG67O81/bZD9NS8KktjVqkMGLiGJ8LGKASZfD
         jvWg==
X-Gm-Message-State: AA+aEWaRzROvZ+yFcrq67aSzFBhb8s9ETE2s0ywfJQ+eVRd08qi7sYZe
        jwJ5X1Xz2O8CylGNcv3gPQyxuOwnTn2mmAD7Auw=
X-Google-Smtp-Source: AFSGD/Wckx3TTuMcRkchHM9MUUDq2Y4+mTT2OjkvvUAiksU7L9YF0+ofIUyELkMDoaz6T65WfbHqCkw6Hr5IBGIW1QE=
X-Received: by 2002:a1f:2145:: with SMTP id h66mr5087593vkh.65.1544442984088;
 Mon, 10 Dec 2018 03:56:24 -0800 (PST)
MIME-Version: 1.0
References: <1544086559-47141-1-git-send-email-biju.das@bp.renesas.com>
 <1544086559-47141-5-git-send-email-biju.das@bp.renesas.com>
 <CAMuHMdUp2yOiMFFqT5MWhbK=O4fEuTMzH21Wp7HqYBdaruJ1nw@mail.gmail.com>
 <OSBPR01MB210383AE5748C0E18A370C96B8A90@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <CAMuHMdXfHZayA5E=M1GQkChsj6G-qQLdPHkycLf2Hnt-=vXvTA@mail.gmail.com> <20181210115209.vlhcwni2tkyn3hyv@verge.net.au>
In-Reply-To: <20181210115209.vlhcwni2tkyn3hyv@verge.net.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Dec 2018 12:56:11 +0100
Message-ID: <CAMuHMdVnoJ2Oe1hXDGWoKa_4k4Ti6kx80Qr7eH5dd2EOJotPFQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] ARM: dts: iwg23s-sbc: Enable RTC
To:     Simon Horman <horms@verge.net.au>
Cc:     Biju Das <biju.das@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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

Hi Simon,

On Mon, Dec 10, 2018 at 12:52 PM Simon Horman <horms@verge.net.au> wrote:
> On Thu, Dec 06, 2018 at 01:59:58PM +0100, Geert Uytterhoeven wrote:
> > On Thu, Dec 6, 2018 at 1:41 PM Biju Das <biju.das@bp.renesas.com> wrote:
> > > > Subject: Re: [PATCH v3 4/4] ARM: dts: iwg23s-sbc: Enable RTC
> >
> > > > On Thu, Dec 6, 2018 at 10:04 AM Biju Das <biju.das@bp.renesas.com> wrote:
> > > > > Enable NXP pcf85263 real time clock for the iWave SBC based on RZ/G1C.
> > > > >
> > > > > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > > >
> > > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > >
> > > > > --- a/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
> > > > > +++ b/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
> > > > > @@ -84,12 +84,30 @@
> > > > >         clock-frequency = <20000000>;
> > > > >  };
> > > > >
> > > > > +&i2c3 {
> > > > > +       pinctrl-0 = <&i2c3_pins>;
> > > > > +       pinctrl-names = "default";
> > > > > +
> > > > > +       status = "okay";
> > > > > +       clock-frequency = <400000>;
> > > > > +
> > > > > +       rtc@51 {
> > > > > +               compatible = "nxp,pcf85263";
> > > > > +               reg = <0x51>;
> > > >
> > > > You might want to enable the optional interrupt:
> > >
> > > I have enabled this but unfortunately it is generating 100000 of gpio interrupts during boot.
> >
> > Oh, the DT bindings claim interrupt support hasn't been implement yet ;-)
> >
> > > The reason is, by default this pin is configured as function(Power on reset/at u-boot).
> > > Currently there is no function available in kernel to convert a pin from function to gpio (Similar to the issue Fab is facing for display hot plug interrupt)
> > >
> > > May be we can add optional interrupt at a later stage, once we have a solution for converting  pin from function to gpio.
> > >
> > > Please share your opinion on this.
> >
> > IC. In that case, please postpone describing the interrupt until the issue is
> > fixed.
>
> It feels like this patch is ready to be accepted.
> Geert, do you concur?

Yes, I agree.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
