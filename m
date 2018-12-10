Return-Path: <SRS0=WBM2=OT=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B971C04EB8
	for <linux-rtc@archiver.kernel.org>; Mon, 10 Dec 2018 12:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFB520855
	for <linux-rtc@archiver.kernel.org>; Mon, 10 Dec 2018 12:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="mdFan03r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DFB520855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbeLJMQD (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 10 Dec 2018 07:16:03 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:41766 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbeLJMQD (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 10 Dec 2018 07:16:03 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 5F0F525B7A1;
        Mon, 10 Dec 2018 23:16:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1544444160; bh=Ulyiiihg9Mrtsw5IajC4cPx1aw+R1e0DroyqH/VeEKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mdFan03r8qa/A4r1GRMLAXEqdjChUoVNbMTMiBbV/bDJdnUr4oVZehXufMaqmPL7Q
         ldC6kfv/3dWRtHdLSqidEfjXf7EdmxaONDw6gJZ3sdUXVT28jGi/33aeVw3l/ye0Yh
         tJphfQVijQPaKaprc0k394G2VS36Cpnh/k/SDkXQ=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id DDB5A9402E1; Mon, 10 Dec 2018 13:15:58 +0100 (CET)
Date:   Mon, 10 Dec 2018 13:15:58 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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
Subject: Re: [PATCH v3 4/4] ARM: dts: iwg23s-sbc: Enable RTC
Message-ID: <20181210121557.s5oyide2rimejfff@verge.net.au>
References: <1544086559-47141-1-git-send-email-biju.das@bp.renesas.com>
 <1544086559-47141-5-git-send-email-biju.das@bp.renesas.com>
 <CAMuHMdUp2yOiMFFqT5MWhbK=O4fEuTMzH21Wp7HqYBdaruJ1nw@mail.gmail.com>
 <OSBPR01MB210383AE5748C0E18A370C96B8A90@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <CAMuHMdXfHZayA5E=M1GQkChsj6G-qQLdPHkycLf2Hnt-=vXvTA@mail.gmail.com>
 <20181210115209.vlhcwni2tkyn3hyv@verge.net.au>
 <CAMuHMdVnoJ2Oe1hXDGWoKa_4k4Ti6kx80Qr7eH5dd2EOJotPFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVnoJ2Oe1hXDGWoKa_4k4Ti6kx80Qr7eH5dd2EOJotPFQ@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Mon, Dec 10, 2018 at 12:56:11PM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Mon, Dec 10, 2018 at 12:52 PM Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Dec 06, 2018 at 01:59:58PM +0100, Geert Uytterhoeven wrote:
> > > On Thu, Dec 6, 2018 at 1:41 PM Biju Das <biju.das@bp.renesas.com> wrote:
> > > > > Subject: Re: [PATCH v3 4/4] ARM: dts: iwg23s-sbc: Enable RTC
> > >
> > > > > On Thu, Dec 6, 2018 at 10:04 AM Biju Das <biju.das@bp.renesas.com> wrote:
> > > > > > Enable NXP pcf85263 real time clock for the iWave SBC based on RZ/G1C.
> > > > > >
> > > > > > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > > > >
> > > > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > >
> > > > > > --- a/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
> > > > > > +++ b/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
> > > > > > @@ -84,12 +84,30 @@
> > > > > >         clock-frequency = <20000000>;
> > > > > >  };
> > > > > >
> > > > > > +&i2c3 {
> > > > > > +       pinctrl-0 = <&i2c3_pins>;
> > > > > > +       pinctrl-names = "default";
> > > > > > +
> > > > > > +       status = "okay";
> > > > > > +       clock-frequency = <400000>;
> > > > > > +
> > > > > > +       rtc@51 {
> > > > > > +               compatible = "nxp,pcf85263";
> > > > > > +               reg = <0x51>;
> > > > >
> > > > > You might want to enable the optional interrupt:
> > > >
> > > > I have enabled this but unfortunately it is generating 100000 of gpio interrupts during boot.
> > >
> > > Oh, the DT bindings claim interrupt support hasn't been implement yet ;-)
> > >
> > > > The reason is, by default this pin is configured as function(Power on reset/at u-boot).
> > > > Currently there is no function available in kernel to convert a pin from function to gpio (Similar to the issue Fab is facing for display hot plug interrupt)
> > > >
> > > > May be we can add optional interrupt at a later stage, once we have a solution for converting  pin from function to gpio.
> > > >
> > > > Please share your opinion on this.
> > >
> > > IC. In that case, please postpone describing the interrupt until the issue is
> > > fixed.
> >
> > It feels like this patch is ready to be accepted.
> > Geert, do you concur?
> 
> Yes, I agree.

Thanks, I have applied v4 (which is the same as v3).
