Return-Path: <rtc-linux+bncBAABB44VVC6QKGQEKP6DHGI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mga11.intel.com (mga11.intel.com. [192.55.52.93])
        by gmr-mx.google.com with ESMTP id a133si5492534pfa.0.2016.08.09.09.55.15
        for <rtc-linux@googlegroups.com>;
        Tue, 09 Aug 2016 09:55:15 -0700 (PDT)
Date: Tue, 9 Aug 2016 19:55:10 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: rtc regression [463a86304cae ("char/genrtc: x86:
 remove remnants of asm/rtc.h")]
Message-ID: <20160809165510.GY4329@intel.com>
References: <20160809155649.GX4329@intel.com>
 <2994351.VXV5yQJT1N@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <2994351.VXV5yQJT1N@wuerfel>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, Aug 09, 2016 at 06:09:27PM +0200, Arnd Bergmann wrote:
> On Tuesday, August 9, 2016 6:56:49 PM CEST Ville Syrj=C3=A4l=C3=A4 wrote:
> > Hi,
> >=20
> > commit 463a86304cae ("char/genrtc: x86: remove remnants of asm/rtc.h")
> > broke rtc for me. Neither hwclock or rtcwake work anymore. This is just
> > a very standard x86-64 IVB box, and it was reported that machines in
> > our i915 test farm are having rtc related problems as well.
> >=20
> > The first time I run hwclock after rebooting I get this:
> >  open("/dev/rtc", O_RDONLY)              =3D 3
> >  ioctl(3, PHN_SET_REGS or RTC_UIE_ON, 0) =3D 0
> >  select(4, [3], NULL, NULL, {10, 0})     =3D 0 (Timeout)
> >  ioctl(3, PHN_NOT_OH or RTC_UIE_OFF, 0)  =3D 0
> >  close(3)                                =3D 0
> >=20
> > On all subsequent runs I get this:
> >  open("/dev/rtc", O_RDONLY)              =3D 3
> >  ioctl(3, PHN_SET_REGS or RTC_UIE_ON, 0) =3D -1 EINVAL (Invalid argumen=
t)
> >  ioctl(3, RTC_RD_TIME, 0x7ffd76b3ae70)   =3D -1 EINVAL (Invalid argumen=
t)
> >  close(3)                                =3D 0
> >=20
> > 463a86304cae^ gets me back to working condition:
> >  open("/dev/rtc", O_RDONLY)              =3D 3
> >  ioctl(3, PHN_SET_REGS or RTC_UIE_ON, 0) =3D 0
> >  select(4, [3], NULL, NULL, {10, 0})     =3D 1 (in [3], left {9, 530998=
})
> >  ioctl(3, PHN_NOT_OH or RTC_UIE_OFF, 0)  =3D 0
> >  ioctl(3, RTC_RD_TIME, {tm_sec=3D20, tm_min=3D17, tm_hour=3D15, tm_mday=
=3D9, tm_mon=3D7, tm_year=3D116, ...}) =3D 0
> >  close(3)                                =3D 0
>=20
> That commit was supposed to have no effect on the binary, but it
> seems I had a typo in one file. Can you try this patch on top
> of mainline?
>=20
> 	Arnd
>=20
> diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
> index ed16e58658a4..c6dfd801df97 100644
> --- a/arch/x86/kernel/hpet.c
> +++ b/arch/x86/kernel/hpet.c
> @@ -1242,7 +1242,7 @@ irqreturn_t hpet_rtc_interrupt(int irq, void *dev_i=
d)
>  	memset(&curr_time, 0, sizeof(struct rtc_time));
> =20
>  	if (hpet_rtc_flags & (RTC_UIE | RTC_AIE))
> -		mc146818_set_time(&curr_time);
> +		mc146818_get_time(&curr_time);

Heh. Pretty obvious once you see it :)

Works for me.
Tested-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>

> =20
>  	if (hpet_rtc_flags & RTC_UIE &&
>  	    curr_time.tm_sec !=3D hpet_prev_update_sec) {

--=20
Ville Syrj=C3=A4l=C3=A4
Intel OTC

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
