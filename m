Return-Path: <SRS0=n38N=SD=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CC4C43381
	for <linux-rtc@archiver.kernel.org>; Mon,  1 Apr 2019 18:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE5B206C0
	for <linux-rtc@archiver.kernel.org>; Mon,  1 Apr 2019 18:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="DHk87esu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbfDASjS (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:39:18 -0400
Received: from mail.andi.de1.cc ([85.214.239.24]:35464 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728756AbfDASjR (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 1 Apr 2019 14:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3xNH0yYZty3T1s/vvcIFXyS+J03hT8Dc3vigYtnAaf8=; b=DHk87esucdZU0gMRMB1eOOn85
        uME0I6MFv596rOeS8L2BR0FqY9gzXyJfVHPg7irxwrbhml5lvUsRYXUNufFFdwVp5bys/fu1V0c7f
        0hkuqXSG0XzOAXFB0j9lBHgV0xATsJcKquL+ReaSRj6RcD+PGnEs2SZM4ajKGWrSYKD50=;
Received: from p200300ccfbcc5b007ee9d3fffe1fa246.dip0.t-ipconnect.de ([2003:cc:fbcc:5b00:7ee9:d3ff:fe1f:a246] helo=eeepc)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1hB1pr-0006cP-Mp; Mon, 01 Apr 2019 20:39:07 +0200
Received: from [::1] (helo=localhost)
        by localhost with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1hB1pq-0002SY-Bd; Mon, 01 Apr 2019 20:39:06 +0200
Date:   Mon, 1 Apr 2019 20:38:54 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Keerthy <j-keerthy@ti.com>, alexandre.belloni@bootlin.com,
        a.zummo@towertech.it, t-kristo@ti.com, ssantosh@kernel.org,
        d-gerlach@ti.com, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 3/5] arm: mach-omap2: pm33xx: Add support for rtc+ddr in
 self refresh mode
Message-ID: <20190401203854.3b6ec1a2@kemnade.info>
In-Reply-To: <20190401175245.GJ49658@atomide.com>
References: <20190322171619.4180-1-j-keerthy@ti.com>
        <20190322171619.4180-4-j-keerthy@ti.com>
        <20190401175245.GJ49658@atomide.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/IM5.dslcLd5HSNhpIvRvxx2"; protocol="application/pgp-signature"
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

--Sig_/IM5.dslcLd5HSNhpIvRvxx2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 1 Apr 2019 10:52:45 -0700
Tony Lindgren <tony@atomide.com> wrote:

> Hi,
>=20
> * Keerthy <j-keerthy@ti.com> [190322 17:16]:
> > +static int am43xx_check_off_mode_enable(void)
> > +{
> > +	/*
> > +	 * Check for am437x-sk-evm which due to HW design cannot support
> > +	 * this mode reliably.
> > +	 */
> > +	if (of_machine_is_compatible("ti,am437x-sk-evm") && enable_off_mode) {
> > +		pr_warn("WARNING: This platform does not support off-mode, entering =
DeepSleep suspend.\n");
> > +		return 0;
> > +	}
> > +
> > +	return enable_off_mode;
> > +} =20
>=20
> Considering off-mode suspend depends on how the board is
> wired for various things such as memory, PMIC and the related
> signal lines, I agree using the machine compatible is the best
> check we can do here.
>=20
> But since the device can hang during suspend unless things are
> configured right for the board, I suggest you rather list allowed
> boards here that are known to work with off-mode.
>=20
Could we somehow describe this property of the hardware
(is-offmode-capable or is-wired-for-offmode) as a separate devicetree
property of the soc?

In mmc we have for example "cap-power-off-card" for
indicating some is-wired-suitable-for thing.

That looks to be clearer as looking for some strange conditions
derived from something.

I have still my offmode patch os the boilerplate...

Regards,
Andreas

--Sig_/IM5.dslcLd5HSNhpIvRvxx2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAlyiWr8ACgkQl4jFM1s/
ye/cGw//ZYvBpuTdIquv8gIi92U+KCQ40dhGuS4RS+ekk6hKriDB25jH+WPtBtYE
CE5TP6wdEXzyDpuFmStNmcgHnSESuZphI9NWw6kNtkUXdzfiNh/wdoUnKzibY0UN
pyezoSkhvnlU+7ss92sV2MjtOABSSMxpAiBtX4o/MifvWe5Z65RiqgprZ364Jxg/
GToGGzFosbcdk2eYR6aBl3F42J7ot0bD49W6JC8Pd08zSg2L1D9cb017IXEuxNF5
gsWRdoncV6wI62ZPPkwgJBc/6JcVLz6C+2Be2KbWkyYph23afNWcoIfqwLxjv4Dd
Re7HkXnbeSnkUCVPIdAn/1bNVtiQGAVxsezmFuO9p1zTOt5nNYKzoPNyaYf5deau
Kj+/xqP1anSyBGEo8pluIVXE35d3yy0NqP4Ct+PVf7hYt0OeEFE1dONTRED9BwDQ
9fIh/PvWVofyev4QeKaos0wBni1fXFKwAOtgAVKVCHFjkd163tCY+b71qaQRUQLn
ZqKog7XJcnx91Zv8+YTNxczrvyio1asa0D/F07j7uQlIpoyfqxVCJ5y6nbPEi427
akwLclMYtTrj43+LCTkJMUZbJvGAwLwEKyMYq9K1l5tKM169OBS8e47jq0nnS/ut
Lorje/wJEnfQRTby20aFKl3mXVBv9drIpbGt5JAtV5PoQandrL8=
=B7hI
-----END PGP SIGNATURE-----

--Sig_/IM5.dslcLd5HSNhpIvRvxx2--
