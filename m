Return-Path: <rtc-linux+bncBAABBRX2U66QKGQECQBY7NA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mga04.intel.com (mga04.intel.com. [192.55.52.120])
        by gmr-mx.google.com with ESMTP id ph9si5468543pac.1.2016.08.09.08.56.54
        for <rtc-linux@googlegroups.com>;
        Tue, 09 Aug 2016 08:56:54 -0700 (PDT)
Date: Tue, 9 Aug 2016 18:56:49 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] rtc regression [463a86304cae ("char/genrtc: x86: remove
 remnants of asm/rtc.h")]
Message-ID: <20160809155649.GX4329@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

commit 463a86304cae ("char/genrtc: x86: remove remnants of asm/rtc.h")
broke rtc for me. Neither hwclock or rtcwake work anymore. This is just
a very standard x86-64 IVB box, and it was reported that machines in
our i915 test farm are having rtc related problems as well.

The first time I run hwclock after rebooting I get this:
 open("/dev/rtc", O_RDONLY)              =3D 3
 ioctl(3, PHN_SET_REGS or RTC_UIE_ON, 0) =3D 0
 select(4, [3], NULL, NULL, {10, 0})     =3D 0 (Timeout)
 ioctl(3, PHN_NOT_OH or RTC_UIE_OFF, 0)  =3D 0
 close(3)                                =3D 0

On all subsequent runs I get this:
 open("/dev/rtc", O_RDONLY)              =3D 3
 ioctl(3, PHN_SET_REGS or RTC_UIE_ON, 0) =3D -1 EINVAL (Invalid argument)
 ioctl(3, RTC_RD_TIME, 0x7ffd76b3ae70)   =3D -1 EINVAL (Invalid argument)
 close(3)                                =3D 0

463a86304cae^ gets me back to working condition:
 open("/dev/rtc", O_RDONLY)              =3D 3
 ioctl(3, PHN_SET_REGS or RTC_UIE_ON, 0) =3D 0
 select(4, [3], NULL, NULL, {10, 0})     =3D 1 (in [3], left {9, 530998})
 ioctl(3, PHN_NOT_OH or RTC_UIE_OFF, 0)  =3D 0
 ioctl(3, RTC_RD_TIME, {tm_sec=3D20, tm_min=3D17, tm_hour=3D15, tm_mday=3D9=
, tm_mon=3D7, tm_year=3D116, ...}) =3D 0
 close(3)                                =3D 0

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
