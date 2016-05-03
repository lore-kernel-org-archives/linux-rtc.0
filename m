Return-Path: <rtc-linux+bncBDS7HNEFSALRBXOUUK4QKGQE7BWXKKI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id e64si888819wmi.3.2016.05.03.06.40.45
        for <rtc-linux@googlegroups.com>;
        Tue, 03 May 2016 06:40:45 -0700 (PDT)
Date: Tue, 3 May 2016 15:40:34 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>, a.zummo@towertech.it,
	rtc-linux@googlegroups.com, linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 0/2] m68k RTC fixes
Message-ID: <20160503134034.GK2335@piout.net>
References: <1462178783-29294-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1462178783-29294-1-git-send-email-geert@linux-m68k.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 02/05/2016 at 10:46:21 +0200, Geert Uytterhoeven wrote :
> 	Hi Arnd, Alexandre,
>=20
> "[PATCH v3 02/16] rtc: cmos: move mc146818rtc code out of
> asm-generic/rtc.h" of Arnd's series "[PATCH v3 00/16] genrtc removal"
> caused two new build failures on m68k:
>=20
> bvme6000_defconfig:
>=20
>     In file included from arch/m68k/bvme6000/rtc.c:19:
>     include/linux/mc146818rtc.h: In function =E2=80=98mc146818_is_updatin=
g=E2=80=99:
>     include/linux/mc146818rtc.h:138: error: implicit declaration of funct=
ion =E2=80=98CMOS_READ=E2=80=99
>     include/linux/mc146818rtc.h: In function =E2=80=98mc146818_get_time=
=E2=80=99:
>     include/linux/mc146818rtc.h:189: error: =E2=80=98RTC_ALWAYS_BCD=E2=80=
=99 undeclared (first use in this function)
>     include/linux/mc146818rtc.h:189: error: (Each undeclared identifier i=
s reported only once
>     include/linux/mc146818rtc.h:189: error: for each function it appears =
in.)
>     include/linux/mc146818rtc.h: In function =E2=80=98mc146818_set_time=
=E2=80=99:
>     include/linux/mc146818rtc.h:279: error: =E2=80=98RTC_ALWAYS_BCD=E2=80=
=99 undeclared (first use in this function)
>     include/linux/mc146818rtc.h:290: error: implicit declaration of funct=
ion =E2=80=98CMOS_WRITE=E2=80=99
>=20
>=20
> mvme16x_defconfig:
>=20
>     In file included from arch/m68k/mvme16x/rtc.c:18:
>     include/linux/mc146818rtc.h: In function =E2=80=98mc146818_is_updatin=
g=E2=80=99:
>     include/linux/mc146818rtc.h:138: error: implicit declaration of funct=
ion =E2=80=98CMOS_READ=E2=80=99
>     include/linux/mc146818rtc.h: In function =E2=80=98mc146818_get_time=
=E2=80=99:
>     include/linux/mc146818rtc.h:189: error: =E2=80=98RTC_ALWAYS_BCD=E2=80=
=99 undeclared (first use in this function)
>     include/linux/mc146818rtc.h:189: error: (Each undeclared identifier i=
s reported only once
>     include/linux/mc146818rtc.h:189: error: for each function it appears =
in.)
>     include/linux/mc146818rtc.h: In function =E2=80=98mc146818_set_time=
=E2=80=99:
>     include/linux/mc146818rtc.h:279: error: =E2=80=98RTC_ALWAYS_BCD=E2=80=
=99 undeclared (first use in this function)
>     include/linux/mc146818rtc.h:290: error: implicit declaration of funct=
ion =E2=80=98CMOS_WRITE=E2=80=99
>=20
> These do not show up with a multi-platform config including Atari
> support, as arch/m68k/include/asm/mc146818rtc.h provides a definition of
> CMOS_READ() if CONFIG_ATARI=3Dy.
>=20
> Fortunately the fixes are simple: replace <linux/mc146818rtc.h> by
> <linux/rtc.h>.  This is safe to apply to current upstream, too.
>=20
> Queue strategy:
>   1. These are queued together with Arnd's series,
>   1. I queue them for v4.7 myself, but then the RTC tree must be mergest
>      after the m68k tree,
>   2. I queue them for v4.6.
>=20
> As I currently don't have any m68k patches queued for v4.7, perhaps it's
> easiest if these are included with Arnd's series?
>=20

I suggest you take them for 4.7 anyway. I don't think I am confident
enough to merge Arnd's series for 4.7. Also, I doubt I'll get many acks
from some architecture maintainers.

So, my plan is to apply it on top of 4.7-rc1 and let it sit in
linux-next for a while.

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
