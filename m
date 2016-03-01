Return-Path: <rtc-linux+bncBDS7HNEFSALRBVOB3C3AKGQEFETUHEQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id s141si100958wmd.1.2016.03.01.15.08.05
        for <rtc-linux@googlegroups.com>;
        Tue, 01 Mar 2016 15:08:05 -0800 (PST)
Date: Wed, 2 Mar 2016 00:07:45 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Michael =?iso-8859-1?Q?B=FCsch?= <m@bues.ch>
Cc: Gregory Hermant <gregory.hermant@calao-systems.com>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] rtc-rv3029c2: Add trickle charger
Message-ID: <20160301230745.GJ23985@piout.net>
References: <20160301213322.661fe771@wiggum>
 <20160301213655.GG23985@piout.net>
 <20160301225401.3f0aeabb@wiggum>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160301225401.3f0aeabb@wiggum>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 01/03/2016 at 22:54:01 +0100, Michael B=C3=BCsch wrote :
>=20
> > > +	/* Check whether we are in the allowed voltage range. */
> > > +	for (i =3D 100; i > 0; i--) {
> > > +		ret =3D rv3029c2_i2c_get_sr(client, &sr);
> > > +		if (ret < 0)
> > > +			return ret;
> > > +		if (!(sr & (RV3029C2_STATUS_VLOW1 | RV3029C2_STATUS_VLOW2)))
> > > +			break;
> > > +
> > > +		sr &=3D ~RV3029C2_STATUS_VLOW1;
> > > +		sr &=3D ~RV3029C2_STATUS_VLOW2;
> > > +		ret =3D rv3029c2_i2c_set_sr(client, sr);
> > > +		if (ret < 0)
> > > +			return ret; =20
> >=20
> > I wouldn't reset the VLOW1 and VLOW2 flags here. Just bail out if the
> > voltage is not sufficient. I don't think that condition will actually
> > get better simply by waiting.
>=20
>=20
> I do actually think so that we should clear them at least once (that is
> retry once). According to the data sheet these bits will not reset
> automatically and might be left over from machine start (brown out).
>=20

No, this should be handled differently. I have some pending patches to
handle those bits. The main issue is that if you reset those bits there,
there is now way to know whether the date has been set or is invalid.

I think the best way to handle this case is to call the function again
when the date/time are set and we have to reset VLOW1/2.

> > > +	err =3D of_property_read_u32(of_node, "trickle-resistor-ohms", &ohm=
s);
> > > +	if (err) {
> > > +		/* Disable trickle charger. */
> > > +		eectrl &=3D ~RV3029C2_TRICKLE_MASK; =20
> >=20
> > I wouldn't touch it at all, some people may set it in the bootloader an=
d
> > don't expect linux to change the value.
>=20
> But that would mean there is no way to disable it once it got enabled.
> So I'd rather keep it like this or use special values (like a huge
> value) like we already discussed.
>=20

Agreed, keep it that way.

> > > +	rc =3D rv3029c2_of_init(client);
> > > +	if (rc < 0) {
> > > +		dev_err(&client->dev, "OF init failed.\n");
> > > +		return rc; =20
> >=20
> > I don't think this should be a hard failure, the RTC can function
> > without that particular configuration, the previous error message is
> > enough (no need for two messages).
>=20
> Only 50% agree here. :)
> And RTC without a working backup battery is not really that useful.
> But I can remove the error checking of course.
>=20

As proposed, I think we can retry to set trickle charging when
necessary, when setting the date.

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
