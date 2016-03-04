Return-Path: <rtc-linux+bncBDS7HNEFSALRB6OR463AKGQE2GSOIHA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id s141si107435wmd.1.2016.03.04.11.58.49
        for <rtc-linux@googlegroups.com>;
        Fri, 04 Mar 2016 11:58:49 -0800 (PST)
Date: Fri, 4 Mar 2016 20:58:48 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Michael =?iso-8859-1?Q?B=FCsch?= <m@bues.ch>
Cc: Gregory Hermant <gregory.hermant@calao-systems.com>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 6/6] rtc-rv3029: Add device tree property for
 trickle charger
Message-ID: <20160304195848.GD2970@piout.net>
References: <20160301213322.661fe771@wiggum>
 <20160301213655.GG23985@piout.net>
 <20160301225401.3f0aeabb@wiggum>
 <20160301230745.GJ23985@piout.net>
 <20160302072627.14e53e94@wiggum>
 <20160302120045.GO23985@piout.net>
 <20160304195337.51439645@wiggum>
 <20160304195654.578b8f6c@wiggum>
 <20160304194336.GC2970@piout.net>
 <20160304204954.29a47f88@wiggum>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160304204954.29a47f88@wiggum>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 04/03/2016 at 20:49:54 +0100, Michael B=C3=BCsch wrote :
> On Fri, 4 Mar 2016 20:43:37 +0100
> Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
>=20
> > On 04/03/2016 at 19:56:54 +0100, Michael B=C3=BCsch wrote :
> > > +	err =3D of_property_read_u32(of_node, "trickle-resistor-ohms", &ohm=
s);
> > > +	if (err) {
> > > +		/* Disable trickle charger. */
> > > +		eectrl &=3D ~RV3029_TRICKLE_MASK;
> > > +	} else {
> > > +		/* Enable trickle charger. */
> > > +		for (i =3D 0; i < ARRAY_SIZE(rv3029_trickle_tab); i++) {
> > > +			elem =3D &rv3029_trickle_tab[i];
> > > +			if (elem->r >=3D ohms)
> > > +				break;
> > > +		}
> > > +		eectrl &=3D ~RV3029_TRICKLE_MASK;
> > > +		eectrl |=3D elem->conf;
> > > +		dev_info(&client->dev,
> > > +			 "Trickle charger enabled at %d ohms resistance.\n",
> > > +			 elem->r);
> > > +	} =20
> >=20
> > Now the you have an update_bits functions, you probably want to use it
> > here. This simplifies the function.
>=20
>=20
> No. This operates on the eeprom. The update_bits function operates on
> bare registers.
> If we have more mask/set operations on the eeprom later, we can add an
> update_bits function for the eeprom, too.
>=20

Indeed, I read too fast

> --=20
> Michael



--=20
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
