Return-Path: <SRS0=to0F=OP=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A123C04EB8
	for <linux-rtc@archiver.kernel.org>; Thu,  6 Dec 2018 13:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 386D220878
	for <linux-rtc@archiver.kernel.org>; Thu,  6 Dec 2018 13:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386D220878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbeLFNAM (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:00:12 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:33614 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728648AbeLFNAM (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 6 Dec 2018 08:00:12 -0500
Received: by mail-ua1-f66.google.com with SMTP id t8so127060uap.0;
        Thu, 06 Dec 2018 05:00:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RZYGDjZ8MrPhF/QDr9fPq5exj+rD8hj6C3+k3Yyj7RE=;
        b=XwCQofQa4Fz66U+uG/wUc4onbgaLfkFbA4cfgqMDLV44dS4e1FNGKv3qhQAhrP2gbs
         V/BfZIWvEIXygGFUqasq2rQl7GIdVR7F6QLwdWTrwBqzytfZbADVQs6HXcM6TBoqqJqu
         1fl17E7MJFw/UPmO7OHlYX9LEaQIBmRxdA/WjRw556WVF3aFWnL8Vc3w+Sm/9o/VqCLL
         UgbGxzkLjR8cQEF3JMMCVeJpP6unjNa/peKcsAclf2KckBsh/xrXskHHdaxhP88A8D7o
         8SNKooZMoWwADvyiGP+JPeEE6K3mXtirbxHT2+HYauva2tSj4aPYuH9UTJW8NSsko93f
         689w==
X-Gm-Message-State: AA+aEWZ59pxriUhOhS36QLpJj9sqp854TDD4TmCKwAB8+mmMcAb9gsJc
        5EMWod06ocY6GAj0orh92e/V1cH4W660EgadN7xq2g==
X-Google-Smtp-Source: AFSGD/W537OASF1tM2e6ADm/kG4xUA1HDuygW1nsoKEbYGFWybaSfthBdN0vtwCqOmMJm2JJugNN1PiI3RW1a+BU8bo=
X-Received: by 2002:a9f:364a:: with SMTP id s10mr12075692uad.78.1544101211063;
 Thu, 06 Dec 2018 05:00:11 -0800 (PST)
MIME-Version: 1.0
References: <1544086559-47141-1-git-send-email-biju.das@bp.renesas.com>
 <1544086559-47141-5-git-send-email-biju.das@bp.renesas.com>
 <CAMuHMdUp2yOiMFFqT5MWhbK=O4fEuTMzH21Wp7HqYBdaruJ1nw@mail.gmail.com> <OSBPR01MB210383AE5748C0E18A370C96B8A90@OSBPR01MB2103.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB210383AE5748C0E18A370C96B8A90@OSBPR01MB2103.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 6 Dec 2018 13:59:58 +0100
Message-ID: <CAMuHMdXfHZayA5E=M1GQkChsj6G-qQLdPHkycLf2Hnt-=vXvTA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] ARM: dts: iwg23s-sbc: Enable RTC
To:     Biju Das <biju.das@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Simon Horman <horms@verge.net.au>,
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

Hi Biju,

On Thu, Dec 6, 2018 at 1:41 PM Biju Das <biju.das@bp.renesas.com> wrote:
> > Subject: Re: [PATCH v3 4/4] ARM: dts: iwg23s-sbc: Enable RTC

> > On Thu, Dec 6, 2018 at 10:04 AM Biju Das <biju.das@bp.renesas.com> wrote:
> > > Enable NXP pcf85263 real time clock for the iWave SBC based on RZ/G1C.
> > >
> > > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > > --- a/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
> > > +++ b/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
> > > @@ -84,12 +84,30 @@
> > >         clock-frequency = <20000000>;
> > >  };
> > >
> > > +&i2c3 {
> > > +       pinctrl-0 = <&i2c3_pins>;
> > > +       pinctrl-names = "default";
> > > +
> > > +       status = "okay";
> > > +       clock-frequency = <400000>;
> > > +
> > > +       rtc@51 {
> > > +               compatible = "nxp,pcf85263";
> > > +               reg = <0x51>;
> >
> > You might want to enable the optional interrupt:
>
> I have enabled this but unfortunately it is generating 100000 of gpio interrupts during boot.

Oh, the DT bindings claim interrupt support hasn't been implement yet ;-)

> The reason is, by default this pin is configured as function(Power on reset/at u-boot).
> Currently there is no function available in kernel to convert a pin from function to gpio (Similar to the issue Fab is facing for display hot plug interrupt)
>
> May be we can add optional interrupt at a later stage, once we have a solution for converting  pin from function to gpio.
>
> Please share your opinion on this.

IC. In that case, please postpone describing the interrupt until the issue is
fixed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
