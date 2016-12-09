Return-Path: <rtc-linux+bncBDJNHL5JSEOBBQNZVPBAKGQEYIPQEMA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from vps0.lunn.ch (vps0.lunn.ch. [178.209.37.122])
        by gmr-mx.google.com with ESMTPS id o77si1975476wme.0.2016.12.09.08.33.04
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Dec 2016 08:33:04 -0800 (PST)
Date: Fri, 9 Dec 2016 17:33:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com, Jason Cooper <jason@lakedaemon.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Shaker Daibes <shaker@marvell.com>
Subject: [rtc-linux] Re: [PATCH 1/3] rtc: armada38x: improve RTC errata implementation
Message-ID: <20161209163302.GF9923@lunn.ch>
References: <20161208171010.29446-1-gregory.clement@free-electrons.com>
 <20161208171010.29446-2-gregory.clement@free-electrons.com>
 <20161208172923.GQ26852@lunn.ch>
 <8760mtf538.fsf@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <8760mtf538.fsf@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Fri, Dec 09, 2016 at 05:19:07PM +0100, Gregory CLEMENT wrote:
> Hi Andrew,
> =20
>  On jeu., d=C3=A9c. 08 2016, Andrew Lunn <andrew@lunn.ch> wrote:
>=20
> >> +struct str_value_to_freq {
> >> +	unsigned long value;
> >> +	u8 freq;
> >> +} __packed;
> >> +
> >> +static unsigned long read_rtc_register_wa(struct armada38x_rtc *rtc, =
u8 rtc_reg)
> >> +{
> >> +	unsigned long value_array[SAMPLE_NR], i, j, value;
> >> +	unsigned long max =3D 0, index_max =3D SAMPLE_NR - 1;
> >> +	struct str_value_to_freq value_to_freq[SAMPLE_NR];
> >
> > Hi Gregory
> >
> > This appears to be putting over 900 bytes on the stack. Is there any
>=20
> Actually the structure being packed it is 500 bytes.

Did you verify this? I never remember where the __packed needs to go.
You clearly have a packed structure, but is the array of structures
packed?

And the long value_array[SAMPLE_NR] is another 400 bytes, totalling
900. And as Russell pointed out, this is on 32 bit systems. Until your
third patch, 64 bit systems probably have double that. I would also
suggest squashing patch #3 into #1.

> > danger of overflowing the stack? Would it be safer to make these
> > arrays part of armada38x_rtc?
>=20
> We could do this if you fear a stack overflow.

It is generally consider not a good idea to put > $BIG structures on
the stack, but the value of $BIG is not clearly defined. Stack
overflow seems to be an issue with lots of layering going on, swap on
NFS etc. But it seems unlikely to me reading the RTC will happen with
an already deep stack. So this is probably O.K.

   Andrew

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
