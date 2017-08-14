Return-Path: <rtc-linux+bncBDP47C6LHEIILPOFZQCRUBAHTRHXE@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from pokefinder.org (sauhun.de. [88.99.104.3])
        by gmr-mx.google.com with ESMTP id a195si266153wme.4.2017.08.14.01.25.41
        for <rtc-linux@googlegroups.com>;
        Mon, 14 Aug 2017 01:25:41 -0700 (PDT)
Date: Mon, 14 Aug 2017 10:25:40 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-i2c@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 1/3] mfd: dm355evm_msp: move header file out
 of I2C realm
Message-ID: <20170814082540.g3w3aur2nwuf5s6h@ninjato>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-2-wsa@the-dreams.de>
 <20170523071727.tw6vblpnevihqgqk@dell>
 <20170813133418.e7lftrmry3gu3dcc@ninjato>
 <20170814064336.secnn77amfjgbltw@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="l42lrog343rsfn2u"
In-Reply-To: <20170814064336.secnn77amfjgbltw@dell>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--l42lrog343rsfn2u
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

On Mon, Aug 14, 2017 at 07:43:36AM +0100, Lee Jones wrote:
> On Sun, 13 Aug 2017, Wolfram Sang wrote:
> 
> > On Tue, May 23, 2017 at 08:17:27AM +0100, Lee Jones wrote:
> > > On Mon, 22 May 2017, Wolfram Sang wrote:
> > > 
> > > > include/linux/i2c is not for client devices. Move the header file to a
> > > > more appropriate location.
> > > > 
> > > > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> > > > ---
> > > >  drivers/input/misc/dm355evm_keys.c        | 2 +-
> > > 
> > > >  drivers/mfd/dm355evm_msp.c                | 2 +-
> > > 
> > > For my own reference:
> > >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > 
> > Does that mean it will be in 4.14? Or is something else needed?
> 
> Can this patch be applied on its own, or does it have dependencies?

These patches are self-contained; they only move an include file from A
to B.

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--l42lrog343rsfn2u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmRXoQACgkQFA3kzBSg
KbY0qA//ZeC2kaNfHB4JD4f+qJc3moP6Ba4+WG2IzQuP2Hrl3eN1qus229sicq9r
UZXE2RdWVSKi4F9uvnjtN4nr5E/TITcIOODa55AXD4Ia1eZMUtL9YG91i3W82xtR
azChlDZUA0ITFJ3KffBZKn/vmSHkunZ0TWR7QR1wRwcSjvcAcMWy57jc+WhcPYY3
7YyAjZWteGIXkcbZIEkh1wrZwWOWL3NL6/v+X9Fj5SGMaqkhrXUDIOK7hQVAuVTF
Gx4N1Aj0gfRIm5TRYwev5jYQ08aZ9mEkv0tel2Ava35qSZ9cIlrbtnMzvNxggXQB
nN6z+pfq9aROoRSTheSC1rgJk3ZKtdrWRZ2DUzEm2SWSCu8Yb+DlxWSteNz67i/v
Mx742hm9sdyjN67Vt7bsiGw+5azpleFr5Z2agzrTonPTSqGP+qdBEEHD4atno15W
iUGFpiyfERgn4fbelhpLZZ5w806FyYfp+yj+tVFNe6TNW74FZa5lxEgmELVaW9ia
WAd403lW4FCsyENGXUqGtKRZH+Tz8p5Q1eqebBeekC5FjPF/yFELhm1mvMu2CcLF
maMOLc4ba/ydtPYn1BMXqYb0PK2Qo/fJ7DBRzeFCO0VZGpGuyEqgGZc98ZAkQehB
L4CKGreuSL71MBRhxzgvq+rC2womxL9ke5ZVHh2wNCslmqmA+t8=
=gGaZ
-----END PGP SIGNATURE-----

--l42lrog343rsfn2u--
