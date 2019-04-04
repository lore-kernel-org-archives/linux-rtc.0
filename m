Return-Path: <SRS0=xpCi=SG=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EBFC4360F
	for <linux-rtc@archiver.kernel.org>; Thu,  4 Apr 2019 10:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E940204EC
	for <linux-rtc@archiver.kernel.org>; Thu,  4 Apr 2019 10:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="SwJCCw1D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbfDDKxC (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:53:02 -0400
Received: from mail.andi.de1.cc ([85.214.239.24]:43476 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfDDKxC (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 4 Apr 2019 06:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PduC7Cz+Gh+1uwvEmTTDxj8L0TyXLSjg9OtN9cZttHY=; b=SwJCCw1DJb5S4H7UbCPanNMIU
        7D6SXy234aQuOuzWnVXVrP/ok/y8tSiGHDgQms5HM73q8x5BF9zkyIsY13hkK8xVATscCt6XidN4W
        yo1KBYeE037LTU0PAV4nzGPSzj59S7OAlMY09cbyqoKf7BxS4Mdp2+IuNXciMnGgTJy28=;
Received: from p578b2b7d.dip0.t-ipconnect.de ([87.139.43.125] helo=localhost)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1hBzz8-0002ed-1n; Thu, 04 Apr 2019 12:52:42 +0200
Received: from [::1] (helo=localhost)
        by eeepc with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1hBzxt-0003DJ-1k; Thu, 04 Apr 2019 12:51:25 +0200
Date:   Thu, 4 Apr 2019 12:51:11 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Keerthy <j-keerthy@ti.com>, alexandre.belloni@bootlin.com,
        a.zummo@towertech.it, t-kristo@ti.com, ssantosh@kernel.org,
        d-gerlach@ti.com, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 3/5] arm: mach-omap2: pm33xx: Add support for rtc+ddr in
 self refresh mode
Message-ID: <20190404125111.3800e26d@kemnade.info>
In-Reply-To: <20190401204033.GK49658@atomide.com>
References: <20190322171619.4180-1-j-keerthy@ti.com>
        <20190322171619.4180-4-j-keerthy@ti.com>
        <20190401175245.GJ49658@atomide.com>
        <20190401203854.3b6ec1a2@kemnade.info>
        <20190401204033.GK49658@atomide.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zBEpOfvpEgH9e0gZc=FJ858"; protocol="application/pgp-signature"
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

--Sig_/zBEpOfvpEgH9e0gZc=FJ858
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 1 Apr 2019 13:40:33 -0700
Tony Lindgren <tony@atomide.com> wrote:

> * Andreas Kemnade <andreas@kemnade.info> [190401 18:39]:
> > On Mon, 1 Apr 2019 10:52:45 -0700
> > Tony Lindgren <tony@atomide.com> wrote:
> >  =20
> > > Hi,
> > >=20
> > > * Keerthy <j-keerthy@ti.com> [190322 17:16]: =20
> > > > +static int am43xx_check_off_mode_enable(void)
> > > > +{
> > > > +	/*
> > > > +	 * Check for am437x-sk-evm which due to HW design cannot support
> > > > +	 * this mode reliably.
> > > > +	 */
> > > > +	if (of_machine_is_compatible("ti,am437x-sk-evm") && enable_off_mo=
de) {
> > > > +		pr_warn("WARNING: This platform does not support off-mode, enter=
ing DeepSleep suspend.\n");
> > > > +		return 0;
> > > > +	}
> > > > +
> > > > +	return enable_off_mode;
> > > > +}   =20
> > >=20
> > > Considering off-mode suspend depends on how the board is
> > > wired for various things such as memory, PMIC and the related
> > > signal lines, I agree using the machine compatible is the best
> > > check we can do here.
> > >=20
> > > But since the device can hang during suspend unless things are
> > > configured right for the board, I suggest you rather list allowed
> > > boards here that are known to work with off-mode.
> > >  =20
> > Could we somehow describe this property of the hardware
> > (is-offmode-capable or is-wired-for-offmode) as a separate devicetree
> > property of the soc?
> >=20
> > In mmc we have for example "cap-power-off-card" for
> > indicating some is-wired-suitable-for thing. =20
>=20
> And we also have "regulator-off-in-suspend".
>=20
> How about "soc-off-in-suspend" for the generic name?
>=20
Well, remember my "omap3: give off mode enable a more prominent place"
maybe we can use the same  capability property for both proposes.

I was a bit unsure about it, so I did not continue with it yet

Regards,
Andreas

--Sig_/zBEpOfvpEgH9e0gZc=FJ858
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAlyl4aAACgkQl4jFM1s/
ye9U5w//T34g0MW+LB3Q7G9x68lh+6J5P3XCgBURVZ/W43orCCNdDqXTC+5l4j+0
75q+jiK8XN5A9YBRU7AVE94FPTdVhvbEYvaKIT2qAuT2NZRWlITHsjxFv3sY2Pse
3zU+OvzYVRpt8d/X1OHouIe9APy4zqsfIT+bq1YizvpAIofOQEe/0EDwvaSq8SCH
cYb1h+RQLGIUphYQ8wWJeBxLzr0gRuXPwdYzU7tx2UmJEVZNePUg0rf9ftTg9GT0
UbZ5FvrlM/cv7d/NPfpfEpNnATEa0edZumrOOGsptuRjH4iGKP97UFa6ItN/K/lS
sQWYJH5WgkEsFHtFVDWnt0jn4qF1o0uYWDGHDc5/o7oJYOBgunikNPfgui7ARkBK
xLlqQmmpsgMoxHVwMlYqxt/iAD7b/o+VAFG05Za4Pce5NP/ff4BEJJ2xKU4ushvx
Y6dUFpVl6gU4JVR59sbeCIAWJAsOWFoTNFJZnc5ZXBQvSzUnuijKULtVt60CyiWg
ytV7Atfl5XW38Nryi86haI9wycljGOeZTmg4Q6HSx4yuzAscvjSyRIVFgGQ6cJP3
x+WPeRN2EjDcQzjX0ktsb4Akt/dcak1wNoOs8ix/UVe4WoKF3d8Zyb5uXfVk9xPp
ZpZoXRHtsDcMrxrKR+NMU4z7rSQgLNTn+I5t6MXGo3zPz1iHm5c=
=Izd4
-----END PGP SIGNATURE-----

--Sig_/zBEpOfvpEgH9e0gZc=FJ858--
