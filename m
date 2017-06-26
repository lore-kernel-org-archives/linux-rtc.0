Return-Path: <rtc-linux+bncBCZ3LK4RZYHRBFFSYPFAKGQEZ5CB22A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk. [2a00:1098:0:82:1000:25:2eeb:e3e3])
        by gmr-mx.google.com with ESMTPS id 5si512247wmj.1.2017.06.26.02.51.16
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jun 2017 02:51:16 -0700 (PDT)
Message-ID: <1498470673.9477.3.camel@collabora.co.uk>
Subject: [rtc-linux] Re: [PATCH 1/2] RTC: s35390a: handle invalid RTC time
From: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com
Date: Mon, 26 Jun 2017 11:51:13 +0200
In-Reply-To: <20170117110016.ids6xheti242lxhe@piout.net>
References: <1484217818-27845-1-git-send-email-fabien.lahoudere@collabora.co.uk>
	 <1484217818-27845-2-git-send-email-fabien.lahoudere@collabora.co.uk>
	 <20170116175018.z74inrcapwqqtbcz@piout.net>
	 <1484641457.20968.6.camel@collabora.co.uk>
	 <20170117110016.ids6xheti242lxhe@piout.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, 2017-01-17 at 12:00 +0100, Alexandre Belloni wrote:
> On 17/01/2017 at 09:24:17 +0100, Fabien Lahoudere wrote :
> > On Mon, 2017-01-16 at 18:50 +0100, Alexandre Belloni wrote:
> > > Hi,
> > >=20
> > > On 12/01/2017 at 11:43:37 +0100, Fabien Lahoudere wrote :
> > > > If RTC time have been altered by low voltage, we notify users
> > > > that RTC time is invalid by returning -EINVAL.
> > > > The RTC time needs to be set correctly to clear the invalid flag.
> > > > If the RTC is not set before restarting, the information will be lo=
st.
> > > >=20
> > > > Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
> > > > ---
> > > > =C2=A0drivers/rtc/rtc-s35390a.c | 9 +++++++++
> > > > =C2=A01 file changed, 9 insertions(+)
> > > >=20
> > > > diff --git a/drivers/rtc/rtc-s35390a.c b/drivers/rtc/rtc-s35390a.c
> > > > index 5dab466..ef4ada9 100644
> > > > --- a/drivers/rtc/rtc-s35390a.c
> > > > +++ b/drivers/rtc/rtc-s35390a.c
> > > > @@ -62,6 +62,7 @@ struct s35390a {
> > > > =C2=A0	struct i2c_client *client[8];
> > > > =C2=A0	struct rtc_device *rtc;
> > > > =C2=A0	int twentyfourhour;
> > > > +	int isinvalid;
> > > > =C2=A0};
> > > > =C2=A0
> > > > =C2=A0static int s35390a_set_reg(struct s35390a *s35390a, int reg, =
char *buf, int len)
> > > > @@ -135,6 +136,8 @@ static int s35390a_reset(struct s35390a *s35390=
a, char *status1)
> > > > =C2=A0	=C2=A0* The 24H bit is kept over reset, so set it already he=
re.
> > > > =C2=A0	=C2=A0*/
> > > > =C2=A0initialize:
> > > > +	/* set the RTC time as invalid */
> > > > +	s35390a->isinvalid =3D 1;
> > > > =C2=A0	*status1 =3D S35390A_FLAG_24H;
> > > > =C2=A0	buf =3D S35390A_FLAG_RESET | S35390A_FLAG_24H;
> > > > =C2=A0	ret =3D s35390a_set_reg(s35390a, S35390A_CMD_STATUS1, &buf, =
1);
> > > > @@ -221,6 +224,8 @@ static int s35390a_set_datetime(struct i2c_clie=
nt *client, struct
> > > > rtc_time *tm)
> > > > =C2=A0		buf[i] =3D bitrev8(buf[i]);
> > > > =C2=A0
> > > > =C2=A0	err =3D s35390a_set_reg(s35390a, S35390A_CMD_TIME1, buf, siz=
eof(buf));
> > > > +	if (err >=3D 0)
> > > > +		s35390a->isinvalid =3D 0;
> > > > =C2=A0
> > > > =C2=A0	return err;
> > > > =C2=A0}
> > > > @@ -231,6 +236,9 @@ static int s35390a_get_datetime(struct i2c_clie=
nt *client, struct
> > > > rtc_time *tm)
> > > > =C2=A0	char buf[7];
> > > > =C2=A0	int i, err;
> > > > =C2=A0
> > > > +	if (s35390a->isinvalid)
> > > > +		return -EINVAL;
> > > > +
> > >=20
> > > That's fine but what happens if it became invalid between probe and
> > > s35390a_get_datetime()? (This is particularly relevant after patch 2/=
2.
> >=20
> > This is not possible with our design. When the system is on, its power
> > supply replace the backup battery. (See p38 Figure 49).
> >=20
>=20
> Well, it depends on the tolerances of each components (but yeah, I doubt
> your SoC is more tolerant than the RTC).
>=20
>=20
> > If you prefer I can call s35390a_reset if s35390a->isinvalid is set to
> > 0?
> >=20
>=20
> Actually, after reading the datasheet, I realize it is only POC that is
> reset to 0 after reading so isinvalid is not needed. Just read status1
> and look for BLD instead of caching it.
>=20

isinvalid is also used in s35390a_set_datetime. So if I remove it how can I=
 detect that time setting
failed?

> I think it is probably worth separating s35390a_reset() into two
> functions. One that does the initialization and another one that reads
> status1 and immediately doest the initialization when POC is set. If BLD
> is set, then we can wait for set_time to happen before initializing.
>=20

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
