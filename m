Return-Path: <rtc-linux+bncBDS7HNEFSALRBVVBX6VAKGQEUQXWRAQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id ec7si299296wib.3.2015.05.10.14.42.45
        for <rtc-linux@googlegroups.com>;
        Sun, 10 May 2015 14:42:45 -0700 (PDT)
Date: Sun, 10 May 2015 23:42:44 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>,
	Shawn Guo <shawn.guo@linaro.org>
Cc: rtc-linux@googlegroups.com, Andrew Morton <akpm@linux-foundation.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Kim Phillips <kim.phillips@freescale.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Stephen Boyd <sboyd@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] Re: [PATCH] rtc: snvs: improve timeout handling in snvs_rtc_enable()
Message-ID: <20150510214244.GJ3338@piout.net>
References: <20527.38172.621130.368019@ipc1.ka-ro>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20527.38172.621130.368019@ipc1.ka-ro>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi Shawn, Lothar,

On 18/08/2012 at 15:14:04 +0200, Lothar Wa=C3=9Fmann wrote :
> Shawn Guo writes:
> > On Sat, Aug 18, 2012 at 10:10:08AM +0200, Lothar Wa=C3=9Fmann wrote:
> > > If snvs_rtc_enable() happens to be descheduled for a period longer
> > > than the timout period, a timeout may be indicated even if the RTC
> > > status has changed meanwhile. Force a status read at the end of the
> > > timeout period to prevent bogus timeout errors.
> > >=20
> > >=20
> > > Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
> > > ---
> > >  drivers/rtc/rtc-snvs.c |   22 +++++++++++++---------
> > >  1 files changed, 13 insertions(+), 9 deletions(-)
> > >=20
> > >  Compile tested only due to lack of HW.
> >=20
> > Tested-by: Shawn Guo <shawn.guo@linaro.org>
> >=20

It seems that patch never made it mainline. Can you check if it is still
needed?


> > A small nitpick below.
> >=20
> > >=20
> > > diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
> > > index 912f116..dc921b2 100644
> > > --- a/drivers/rtc/rtc-snvs.c
> > > +++ b/drivers/rtc/rtc-snvs.c
> > > @@ -81,6 +81,13 @@ static void rtc_write_sync_lp(void __iomem *ioaddr=
)
> > >  	}
> > >  }
> > > =20
> > > +static int snvs_rtc_enable_done(int enable, void __iomem *addr)
> >=20
> > Can we rename parameter "addr" to "ioaddr" and put it before "enable",
> > also change "enable" to bool?
> >=20
> OK. The resulting assembler code of the patch below is identical to
> the previous version of this patch.
>=20
>=20
> Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
> Tested-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/rtc/rtc-snvs.c |   22 +++++++++++++---------
>  1 files changed, 13 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
> index 912f116..a757cb9 100644
> --- a/drivers/rtc/rtc-snvs.c
> +++ b/drivers/rtc/rtc-snvs.c
> @@ -81,6 +81,13 @@ static void rtc_write_sync_lp(void __iomem *ioaddr)
>  	}
>  }
> =20
> +static int snvs_rtc_enable_done(void __iomem *ioaddr, bool enable)
> +{
> +	u32 lpcr =3D readl(ioaddr + SNVS_LPCR);
> +
> +	return enable ^ !(lpcr & SNVS_LPCR_SRTC_ENV);
> +}
> +
>  static int snvs_rtc_enable(struct snvs_rtc_data *data, bool enable)
>  {
>  	unsigned long timeout =3D jiffies + msecs_to_jiffies(1);
> @@ -99,18 +106,15 @@ static int snvs_rtc_enable(struct snvs_rtc_data *dat=
a, bool enable)
>  	spin_unlock_irqrestore(&data->lock, flags);
> =20
>  	while (1) {
> -		lpcr =3D readl(data->ioaddr + SNVS_LPCR);
> +		if (snvs_rtc_enable_done(data->ioaddr, enable))
> +			break;
> =20
> -		if (enable) {
> -			if (lpcr & SNVS_LPCR_SRTC_ENV)
> -				break;
> -		} else {
> -			if (!(lpcr & SNVS_LPCR_SRTC_ENV))
> +		if (time_after(jiffies, timeout)) {
> +			if (snvs_rtc_enable_done(data->ioaddr, enable))
>  				break;
> +			else
> +				return -ETIMEDOUT;
>  		}
> -
> -		if (time_after(jiffies, timeout))
> -			return -ETIMEDOUT;
>  	}
> =20
>  	return 0;

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
