Return-Path: <rtc-linux+bncBDU7VC56WAFBBGMP3K3AKGQEGFIATHA@googlegroups.com>
Received: from bues.ch (bues.ch. [2a01:138:9005::1:4])
        by gmr-mx.google.com with ESMTPS id h126si133549wme.0.2016.03.01.22.26.33
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 01 Mar 2016 22:26:33 -0800 (PST)
Date: Wed, 2 Mar 2016 07:26:27 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Gregory Hermant <gregory.hermant@calao-systems.com>,
 rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] rtc-rv3029c2: Add trickle charger
Message-ID: <20160302072627.14e53e94@wiggum>
In-Reply-To: <20160301230745.GJ23985@piout.net>
References: <20160301213322.661fe771@wiggum>
 <20160301213655.GG23985@piout.net>
 <20160301225401.3f0aeabb@wiggum>
 <20160301230745.GJ23985@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/mrlj/lIY/5NhI4z1vtY0trR"; protocol="application/pgp-signature"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--Sig_/mrlj/lIY/5NhI4z1vtY0trR
Content-Type: text/plain; charset=UTF-8

On Wed, 2 Mar 2016 00:07:45 +0100
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> > > I wouldn't reset the VLOW1 and VLOW2 flags here. Just bail out if the
> > > voltage is not sufficient. I don't think that condition will actually
> > > get better simply by waiting.  
> > 
> > 
> > I do actually think so that we should clear them at least once (that is
> > retry once). According to the data sheet these bits will not reset
> > automatically and might be left over from machine start (brown out).
> >   
> 
> No, this should be handled differently. I have some pending patches to
> handle those bits. The main issue is that if you reset those bits there,
> there is now way to know whether the date has been set or is invalid.
> 
> I think the best way to handle this case is to call the function again
> when the date/time are set and we have to reset VLOW1/2.

Yes, right. But as of now we do not have VLOW handling. So I don't see
an issue with clearing the bits here.
The clearing can be removed, if VLOW handling is added eventually.

The issue currently is: We need to check VLOW before accessing the
eeprom, because otherwise it would mean data corruption. This is
especially true for writing. And if we read VLOW, we need a way to
reset the bits from the probable initial brown out. Otherwise we can
never access the eeprom as this check would hit often.

So when are your VLOW patches going to be available?

-- 
Michael

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--Sig_/mrlj/lIY/5NhI4z1vtY0trR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW1oeTAAoJEPUyvh2QjYsOrlsP/A65qa6+1mtu9CsR0o7UHQIf
+k+LH7/V9nBhBHgUGYep8WUSrCEA6p41RE4J7MVwAVit5xVxu4Wxq1mdxwCj3/xh
WKZJy8oznRfcVIO+Kp+EKVxz+davqyeCw9vJBOU8oKXloax3cIfrBczoJzIyd/co
WPrkEQAuMmORIEDRsDR1ka1StKyhTFBdAbXWE63LdT7s10VrCYQmx6IixLa67mKn
2QFg06EdwIDQpikiLUqC2PB369+z7LaC+TvSzaoLhtcY5Wa9NUqG00BrcdFcWk50
eMlUA03+0ysIsRd1+2nIxoH/4wqUA6YeDCdHyRq4K0AYqkA85DEQVlyP1gviD4Jl
2X9bs14D0W9aLGccve72PTFhHrpm0hOgMtfHi0f7cvSf7085/neC9isJnqu+C0Cb
hDy7S8t8/xG+jDxaFWFHBG8PEogbn1eY1FFxE3N1PWh/IR7ZXkLQdUbYj/9e9qtL
VzX+ZHM9495PpVqX1mCwISwn9wh3lKK4Hkc/Aez8YjWPr1LHW8YGsBrI/nGhpX5K
lrEhYRsZ0A5BSaXehqvMn83Zhxdpl6UnJAPZ3Mxdb8ERSVHGf+0P6CKKLJg+P1XZ
3TbU7iTqvHwXI3Vg8Rph6wISN21NB4IaR85Ukb8JsTm12AZ4S5qCzPqiqlUJEULs
nbPDl0V0+aMJ6aBMdX3S
=DfvZ
-----END PGP SIGNATURE-----

--Sig_/mrlj/lIY/5NhI4z1vtY0trR--
