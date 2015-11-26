Return-Path: <rtc-linux+bncBAABBK4X3SZAKGQE45SJMXI@googlegroups.com>
Received: from mail.cosmopool.net (h1.radempa.de. [176.9.142.194])
        by gmr-mx.google.com with ESMTP id i77si78375wmf.1.2015.11.26.05.39.54
        for <rtc-linux@googlegroups.com>;
        Thu, 26 Nov 2015 05:39:54 -0800 (PST)
From: Harald Geyer <harald@ccbib.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
cc: Alessandro Zummo <a.zummo@towertech.it>,
    Alexandre Belloni <alexandre.belloni@free-electrons.com>,
    Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
    linux-watchdog@vger.kernel.org, rtc-linux@googlegroups.com,
    Wolfram Sang <wsa@the-dreams.de>, kernel@pengutronix.de,
    Fabio Estevam <festevam@gmail.com>
Subject: [rtc-linux] Re: [PATCH 2/2] watchdog: stmp3xxx: Implement GETBOOTSTATUS
In-reply-to: <20151126092526.GM19888@pengutronix.de>
References: <1444220352-20548-1-git-send-email-harald@ccbib.org> <1444220352-20548-2-git-send-email-harald@ccbib.org> <20151126092526.GM19888@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2015 14:39:45 +0100
Message-Id: <E1a1wm1-0000XO-S7@stardust.g4.wien.funkfeuer.at>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi Uwe,

thanks for looking into this.

Uwe Kleine-K=C3=B6nig writes:
> On Wed, Oct 07, 2015 at 12:19:12PM +0000, Harald Geyer wrote:
> > This device doesn't provide any information about boot status.
> > As workaround we use a persitent bit to track watchdog activity.
>=20
> Hmm, so you set a bit in a persistent register iff the watchdog is
> running.  And if that bit is set during probe you assume the watchdog
> reset the machine. But this also happens, when the user presses the
> reset button which makes the detection unreliable.

Yes, kind of. I'm using this driver on an imx233-olinuxino, where the
reset button causes the device to power cycle and thus clears the
persitent bit. So I can't test your case, but surely there are some paths
into reset, that don't clear the bit and cause false positives.

I have considered gathering some additional information from the
power subsystem to refine the result, but decided that it's not
worth the complexity. Since the power system is a different silicon
block, we can't rely on it being available and would need to provide
a fall back implementation anyway.

I believe my patch does all that can be done with only the registers,
that belong to the device, but if you have any idea how to make
it more reliable, then I'd be very interested in that.
=20
> > Signed-off-by: Harald Geyer <harald@ccbib.org>
> > ---
> > Changes since v2:
> > * make code ordering more consistent
> > * move part of the commit message to a code comment
> > * rewrite the commit message
> >=20
> > Changes since v1:
> > * make code formatting more consistent with the rest of the driver
> > * Cc some people who might have better documentation then I do
> >=20
> > Changes since initially posting this patch on 08/04/2015:
> > * fix a spelling error in the commit message
> > * rebase to a recent version
> >=20
> >  drivers/rtc/rtc-stmp3xxx.c          |   37 +++++++++++++++++++++++++++=
++++++++
> >  drivers/watchdog/stmp3xxx_rtc_wdt.c |    6 +++++-
> >  include/linux/stmp3xxx_rtc_wdt.h    |    2 ++
> >  3 files changed, 44 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
> > index ca54d03..47947ea 100644
> > --- a/drivers/rtc/rtc-stmp3xxx.c
> > +++ b/drivers/rtc/rtc-stmp3xxx.c
> > @@ -30,6 +30,7 @@
> >  #include <linux/of.h>
> >  #include <linux/stmp_device.h>
> >  #include <linux/stmp3xxx_rtc_wdt.h>
> > +#include <linux/watchdog.h>
> > =20
> >  #define STMP3XXX_RTC_CTRL			0x0
> >  #define STMP3XXX_RTC_CTRL_ALARM_IRQ_EN		0x00000001
> > @@ -62,6 +63,9 @@
> >  /* missing bitmask in headers */
> >  #define STMP3XXX_RTC_PERSISTENT1_FORCE_UPDATER	0x80000000
> > =20
> > +#define STMP3XXX_RTC_PERSISTENT2		0x80
> > +#define STMP3XXX_RTC_PERSISTENT2_WDT_ACTIVE	0x00000001
> > +
> >  struct stmp3xxx_rtc_data {
> >  	struct rtc_device *rtc;
> >  	void __iomem *io;
> > @@ -81,6 +85,20 @@ struct stmp3xxx_rtc_data {
> >   * The watchdog driver is passed the below accessor function via platf=
orm_data
> >   * to configure the watchdog. Locking is not needed because accessing =
SET/CLR
> >   * registers is atomic.
> > + *
> > + * Since this device doesn't report the cause of the last reset, we us=
e
> > + * a persistent bit to track watchdog activity. The code from the Free=
scale
> > + * BSP uses the STMP3XXX_RTC_PERSISTENT1 register, which is dedicated =
to
> > + * controlling the boot ROM, for this purpose. However it seems the bi=
t
> > + * there can't be cleared once it has been set. So we are using
> > + * STMP3XXX_RTC_PERSISTENT2 instead, which is the first register avail=
able
> > + * for "software use" without restriction.
>=20
> Adding a link to the vendor kernel might be interesting here.

Ok, I'll try to dig it up again.
=20
> > + * I (Harald Geyer <harald@ccbib.org>) don't know if the code touching=
 the
> > + * STMP3XXX_RTC_PERSISTENT1 register is doing anything useful. Maybe t=
his
> > + * is just a leftover from the BSP code, but then maybe there is somet=
hing
> > + * in the boot ROM or in some bootloader that is using this. Hard to t=
ell
> > + * without proper documentation about this register.
>=20
> Fabio: anything you can do here to help?
>=20
> >   */
> > =20
> >  static void stmp3xxx_wdt_set_timeout(struct device *dev, u32 timeout)
> > @@ -93,16 +111,30 @@ static void stmp3xxx_wdt_set_timeout(struct device=
 *dev, u32 timeout)
> >  		       rtc_data->io + STMP3XXX_RTC_CTRL + STMP_OFFSET_REG_SET);
> >  		writel(STMP3XXX_RTC_PERSISTENT1_FORCE_UPDATER,
> >  		       rtc_data->io + STMP3XXX_RTC_PERSISTENT1 + STMP_OFFSET_REG_SET=
);
> > +		writel(STMP3XXX_RTC_PERSISTENT2_WDT_ACTIVE,
> > +		       rtc_data->io + STMP3XXX_RTC_PERSISTENT2 + STMP_OFFSET_REG_SET=
);
> >  	} else {
> >  		writel(STMP3XXX_RTC_CTRL_WATCHDOGEN,
> >  		       rtc_data->io + STMP3XXX_RTC_CTRL + STMP_OFFSET_REG_CLR);
> >  		writel(STMP3XXX_RTC_PERSISTENT1_FORCE_UPDATER,
> >  		       rtc_data->io + STMP3XXX_RTC_PERSISTENT1 + STMP_OFFSET_REG_CLR=
);
> > +		writel(STMP3XXX_RTC_PERSISTENT2_WDT_ACTIVE,
> > +		       rtc_data->io + STMP3XXX_RTC_PERSISTENT2 + STMP_OFFSET_REG_CLR=
);
>=20
> checkpatch tells:
>=20
> WARNING: line over 80 characters
> #131: FILE: drivers/rtc/rtc-stmp3xxx.c:115:
> +                      rtc_data->io + STMP3XXX_RTC_PERSISTENT2 + STMP_OFF=
SET_REG_SET);
>=20
> WARNING: line over 80 characters
> #138: FILE: drivers/rtc/rtc-stmp3xxx.c:122:
> +                      rtc_data->io + STMP3XXX_RTC_PERSISTENT2 + STMP_OFF=
SET_REG_CLR);

I tried to follow the style of the surrounding code. If there is a clear
statement about the preferred style for this driver from whoever is
responsible, I will happily change my patch to whatever it is.

> >  	}
> >  }
> > =20
> > +static void stmp3xxx_wdt_clear_bootstatus(struct device *dev)
> > +{
> > +	struct stmp3xxx_rtc_data *rtc_data =3D dev_get_drvdata(dev);
> > +
> > +	writel(STMP3XXX_RTC_PERSISTENT2_WDT_ACTIVE,
> > +	       rtc_data->io + STMP3XXX_RTC_PERSISTENT2 + STMP_OFFSET_REG_CLR)=
;
> > +}
> > +
> >  static struct stmp3xxx_wdt_pdata wdt_pdata =3D {
> >  	.wdt_set_timeout =3D stmp3xxx_wdt_set_timeout,
> > +	.wdt_clear_bootstatus =3D stmp3xxx_wdt_clear_bootstatus,
> > +	.bootstatus =3D 0,
> >  };
>=20
> This is out of the scope of your patch, but IMHO wdt_pdata should be
> const in case it is used for >1 device.

Hm, if you want to change wdt_pdata to const, then I can't add the
bootstatus field. But I think you can't change this to const anyway,
because the platform_data pointer of struct device is not a const void
pointer. However didn't look into this in detail, so maybe I'm missing
something ...

I guess we could move wdt_pdata into rtc_data, but this would
entangle rtc and watchdog drivers even more, so I'd rather not do that.
What do you think?

Thanks,
Harald

--=20
If you want to support my work:
see http://friends.ccbib.org/harald/supporting/
or donate via bitcoin to 1FUtd8T9jRN1rFz63vZz7s2fDtB6d6A7aS

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
