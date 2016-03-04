Return-Path: <rtc-linux+bncBDU7VC56WAFBB5WN463AKGQEX7Y4OJA@googlegroups.com>
Received: from bues.ch (bues.ch. [2a01:138:9005::1:4])
        by gmr-mx.google.com with ESMTPS id v68si18741wmd.1.2016.03.04.11.50.14
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 04 Mar 2016 11:50:14 -0800 (PST)
Date: Fri, 4 Mar 2016 20:49:54 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Gregory Hermant <gregory.hermant@calao-systems.com>,
 rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 6/6] rtc-rv3029: Add device tree property for
 trickle charger
Message-ID: <20160304204954.29a47f88@wiggum>
In-Reply-To: <20160304194336.GC2970@piout.net>
References: <20160301213322.661fe771@wiggum>
 <20160301213655.GG23985@piout.net>
 <20160301225401.3f0aeabb@wiggum>
 <20160301230745.GJ23985@piout.net>
 <20160302072627.14e53e94@wiggum>
 <20160302120045.GO23985@piout.net>
 <20160304195337.51439645@wiggum>
 <20160304195654.578b8f6c@wiggum>
 <20160304194336.GC2970@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1/9_U0xrWjOu7PS2_+RoXAG"; protocol="application/pgp-signature"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

--Sig_/1/9_U0xrWjOu7PS2_+RoXAG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 4 Mar 2016 20:43:37 +0100
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> On 04/03/2016 at 19:56:54 +0100, Michael B=C3=BCsch wrote :
> > +	err =3D of_property_read_u32(of_node, "trickle-resistor-ohms", &ohms)=
;
> > +	if (err) {
> > +		/* Disable trickle charger. */
> > +		eectrl &=3D ~RV3029_TRICKLE_MASK;
> > +	} else {
> > +		/* Enable trickle charger. */
> > +		for (i =3D 0; i < ARRAY_SIZE(rv3029_trickle_tab); i++) {
> > +			elem =3D &rv3029_trickle_tab[i];
> > +			if (elem->r >=3D ohms)
> > +				break;
> > +		}
> > +		eectrl &=3D ~RV3029_TRICKLE_MASK;
> > +		eectrl |=3D elem->conf;
> > +		dev_info(&client->dev,
> > +			 "Trickle charger enabled at %d ohms resistance.\n",
> > +			 elem->r);
> > +	} =20
>=20
> Now the you have an update_bits functions, you probably want to use it
> here. This simplifies the function.


No. This operates on the eeprom. The update_bits function operates on
bare registers.
If we have more mask/set operations on the eeprom later, we can add an
update_bits function for the eeprom, too.

--=20
Michael

--=20
--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--Sig_/1/9_U0xrWjOu7PS2_+RoXAG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW2ebiAAoJEPUyvh2QjYsOuOgP/0IAVbYnCPHOq+j4huO8urpm
9tk6N5L4DvXkd5NOrxXr3Vbd9+yqe3mkbi9TRrtsHvsVu45CAoWuMjdB82bckn8a
ADEnRuLoWlyLp93kkqWzkNGYfSEpPxEvrTf4CLaxo/eW6HGTASnx0Qa5lEG+cTov
/EWkhYavcZWdbCiwPwCa6bE8o3tWTlxb5swO0BrnAIJpNhEPH24ugXIozWujgokE
aseRGR32SbUPIzsZKvJ1WWMe5jG2G+VAx1k0Tr4lPDpEabnEkWfN0CkFGTWwAOPj
uE/uk2iM2RcnQhh6q2WiJ6sOY05Fl/5tWf3u058CDlaaazh/6IhGHjVLGP/eeRrJ
jW7KO3CPlt/4o5m3gxeEesr5V5g/Se2VgCLE5OBZG2yI3Px4EDyTbWQEgMy1GuFi
nt6LMvJpZWkD/rOUiKQI91uMJYIjpnWDMELMv5uzLczjIRi75+pDsepgAS5uNbut
HPFjt9/0O2jbMAMJ/PLnm8SGBSvglPP/ff+ulsEbztsaCoLrvInYP/QAl3qTdYzr
1ECuTOtYptwsN1NIerhO/JohWI3BRm6S5IsNvenCzticYI5ZasdrqXhsOMCZ2VTC
4L/4atwleOVf7bSdCb8ejnn11dTzTnB1kEDgqJuYiwl6ruqSmoR6/llXyXafn8F9
HmWq0AN9dS2dvmrSxi3N
=srlH
-----END PGP SIGNATURE-----

--Sig_/1/9_U0xrWjOu7PS2_+RoXAG--
