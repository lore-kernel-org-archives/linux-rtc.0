Return-Path: <rtc-linux+bncBAABBXOU4CZAKGQE3EX65VA@googlegroups.com>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id g21si249943wmd.3.2015.11.27.02.03.08
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 27 Nov 2015 02:03:09 -0800 (PST)
Date: Fri, 27 Nov 2015 11:02:54 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Harald Geyer <harald@ccbib.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	rtc-linux@googlegroups.com, Wolfram Sang <wsa@the-dreams.de>,
	kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>
Subject: [rtc-linux] Re: [PATCH 2/2] watchdog: stmp3xxx: Implement GETBOOTSTATUS
Message-ID: <20151127100254.GR19888@pengutronix.de>
References: <1444220352-20548-1-git-send-email-harald@ccbib.org>
 <1444220352-20548-2-git-send-email-harald@ccbib.org>
 <20151126092526.GM19888@pengutronix.de>
 <E1a1wm1-0000XO-S7@stardust.g4.wien.funkfeuer.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <E1a1wm1-0000XO-S7@stardust.g4.wien.funkfeuer.at>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Thu, Nov 26, 2015 at 02:39:45PM +0100, Harald Geyer wrote:
> Hi Uwe,
>=20
> thanks for looking into this.
>=20
> Uwe Kleine-K=C3=B6nig writes:
> > On Wed, Oct 07, 2015 at 12:19:12PM +0000, Harald Geyer wrote:
> > > This device doesn't provide any information about boot status.
> > > As workaround we use a persitent bit to track watchdog activity.
> >=20
> > Hmm, so you set a bit in a persistent register iff the watchdog is
> > running.  And if that bit is set during probe you assume the watchdog
> > reset the machine. But this also happens, when the user presses the
> > reset button which makes the detection unreliable.
>=20
> Yes, kind of. I'm using this driver on an imx233-olinuxino, where the
> reset button causes the device to power cycle and thus clears the
> persitent bit. So I can't test your case, but surely there are some paths
> into reset, that don't clear the bit and cause false positives.

OK, I found a i.MX28 machine in our repository:

	barebox# mw 0x80056080 0xbabecafe
	barebox# boot
	...
	linux# reboot
	barebox# md 0x80056080+4
	80056080: babecafe

After a power cycle the value disappears (I didn't check the details, if
there is a battery it might be empty).

> I have considered gathering some additional information from the
> power subsystem to refine the result, but decided that it's not
> worth the complexity. Since the power system is a different silicon
> block, we can't rely on it being available and would need to provide
> a fall back implementation anyway.

It would be really nice to get some details about boot rom usage of the
persistent flags in use. I'd expect that these allow to determine the
boot source.

> > >   */
> > > =20
> > >  static void stmp3xxx_wdt_set_timeout(struct device *dev, u32 timeout=
)
> > > @@ -93,16 +111,30 @@ static void stmp3xxx_wdt_set_timeout(struct devi=
ce *dev, u32 timeout)
> > >  		       rtc_data->io + STMP3XXX_RTC_CTRL + STMP_OFFSET_REG_SET);
> > >  		writel(STMP3XXX_RTC_PERSISTENT1_FORCE_UPDATER,
> > >  		       rtc_data->io + STMP3XXX_RTC_PERSISTENT1 + STMP_OFFSET_REG_S=
ET);
> > > +		writel(STMP3XXX_RTC_PERSISTENT2_WDT_ACTIVE,
> > > +		       rtc_data->io + STMP3XXX_RTC_PERSISTENT2 + STMP_OFFSET_REG_S=
ET);
> > >  	} else {
> > >  		writel(STMP3XXX_RTC_CTRL_WATCHDOGEN,
> > >  		       rtc_data->io + STMP3XXX_RTC_CTRL + STMP_OFFSET_REG_CLR);
> > >  		writel(STMP3XXX_RTC_PERSISTENT1_FORCE_UPDATER,
> > >  		       rtc_data->io + STMP3XXX_RTC_PERSISTENT1 + STMP_OFFSET_REG_C=
LR);
> > > +		writel(STMP3XXX_RTC_PERSISTENT2_WDT_ACTIVE,
> > > +		       rtc_data->io + STMP3XXX_RTC_PERSISTENT2 + STMP_OFFSET_REG_C=
LR);
> >=20
> > checkpatch tells:
> >=20
> > WARNING: line over 80 characters
> > #131: FILE: drivers/rtc/rtc-stmp3xxx.c:115:
> > +                      rtc_data->io + STMP3XXX_RTC_PERSISTENT2 + STMP_O=
FFSET_REG_SET);
> >=20
> > WARNING: line over 80 characters
> > #138: FILE: drivers/rtc/rtc-stmp3xxx.c:122:
> > +                      rtc_data->io + STMP3XXX_RTC_PERSISTENT2 + STMP_O=
FFSET_REG_CLR);
>=20
> I tried to follow the style of the surrounding code. If there is a clear
> statement about the preferred style for this driver from whoever is
> responsible, I will happily change my patch to whatever it is.

Yeah, I don't care much. I would have broken the newly introduced lines,
but I'd not go so far to nack your patch when you don't.

> > >  	}
> > >  }
> > > =20
> > > +static void stmp3xxx_wdt_clear_bootstatus(struct device *dev)
> > > +{
> > > +	struct stmp3xxx_rtc_data *rtc_data =3D dev_get_drvdata(dev);
> > > +
> > > +	writel(STMP3XXX_RTC_PERSISTENT2_WDT_ACTIVE,
> > > +	       rtc_data->io + STMP3XXX_RTC_PERSISTENT2 + STMP_OFFSET_REG_CL=
R);
> > > +}
> > > +
> > >  static struct stmp3xxx_wdt_pdata wdt_pdata =3D {
> > >  	.wdt_set_timeout =3D stmp3xxx_wdt_set_timeout,
> > > +	.wdt_clear_bootstatus =3D stmp3xxx_wdt_clear_bootstatus,
> > > +	.bootstatus =3D 0,
> > >  };
> >=20
> > This is out of the scope of your patch, but IMHO wdt_pdata should be
> > const in case it is used for >1 device.
>=20
> Hm, if you want to change wdt_pdata to const, then I can't add the
> bootstatus field. But I think you can't change this to const anyway,
> because the platform_data pointer of struct device is not a const void
> pointer. However didn't look into this in detail, so maybe I'm missing
> something ...

Conceptually platform data should be const for a driver, not necessarily
for the code that sets it up. So the right thing to do is to add a const
to struct device::platform_data. That is usually not in the way during
creation of the device, but stops drivers to modify it.

Then you can do in stmp3xxx_wdt_register:

	struct ... pdata =3D {
		.wdt_set_timeout =3D stmp3xxx_wdt_set_timeout,
		.bootstatus =3D whatever;
	};
	struct platform_device_info pdevinfo =3D {
		.parent =3D &rtc_pdev->dev;
		.data =3D pdata;
		.size_data =3D sizeof(pdata);
	}
	platform_device_register_full(&pdevinfo);

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

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
