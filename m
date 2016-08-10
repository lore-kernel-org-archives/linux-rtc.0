Return-Path: <rtc-linux+bncBAABBWWIVO6QKGQEZ55CMRI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mga04.intel.com (mga04.intel.com. [192.55.52.120])
        by gmr-mx.google.com with ESMTP id a133si5927919pfa.0.2016.08.10.01.22.50
        for <rtc-linux@googlegroups.com>;
        Wed, 10 Aug 2016 01:22:50 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH] x86/hpet: fix typo from rtc cleanup
To: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org
References: <20160809195528.1604312-1-arnd@arndb.de>
Cc: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
 Borislav Petkov <bp@suse.de>, linux-kernel@vger.kernel.org
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <adba492a-ad23-1376-4383-b819e43f786e@linux.intel.com>
Date: Wed, 10 Aug 2016 11:22:46 +0300
MIME-Version: 1.0
In-Reply-To: <20160809195528.1604312-1-arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi

On 08/09/2016 10:54 PM, Arnd Bergmann wrote:
> Ville Syrj=C3=A4l=C3=A4 reports "The first time I run hwclock after reboo=
ting
> I get this:
>
>  open("/dev/rtc", O_RDONLY)              =3D 3
>  ioctl(3, PHN_SET_REGS or RTC_UIE_ON, 0) =3D 0
>  select(4, [3], NULL, NULL, {10, 0})     =3D 0 (Timeout)
>  ioctl(3, PHN_NOT_OH or RTC_UIE_OFF, 0)  =3D 0
>  close(3)                                =3D 0
>
> On all subsequent runs I get this:
>  open("/dev/rtc", O_RDONLY)              =3D 3
>  ioctl(3, PHN_SET_REGS or RTC_UIE_ON, 0) =3D -1 EINVAL (Invalid argument)
>  ioctl(3, RTC_RD_TIME, 0x7ffd76b3ae70)   =3D -1 EINVAL (Invalid argument)
>  close(3)                                =3D 0"
>
> This was caused by a stupid typo in a patch that should have been
> a simple rename to move around contents of a header file, but
> accidentally wrote zeroes into the rtc rather than reading from
> it.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reported-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> Tested-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> Fixes: 463a86304cae ("char/genrtc: x86: remove remnants of asm/rtc.h")
> ---
>  arch/x86/kernel/hpet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
I started seeing system reboots and lockups during kernel boot on a=20
prototype HW this week using v4.8-rc1 and bisected to this same commit.

This patch fixes the issue.

Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

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
