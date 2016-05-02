Return-Path: <rtc-linux+bncBCQJP74GSUDRBEFMTS4QKGQE7SVIWKA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be. [2a02:1800:120:4::f00:13])
        by gmr-mx.google.com with ESMTPS id e64si611264wmi.3.2016.05.02.01.55.34
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 May 2016 01:55:43 -0700 (PDT)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Arnd Bergmann <arnd@arndb.de>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: a.zummo@towertech.it,
	rtc-linux@googlegroups.com,
	linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [rtc-linux] [PATCH 0/2] m68k RTC fixes
Date: Mon,  2 May 2016 10:46:21 +0200
Message-Id: <1462178783-29294-1-git-send-email-geert@linux-m68k.org>
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

	Hi Arnd, Alexandre,

"[PATCH v3 02/16] rtc: cmos: move mc146818rtc code out of
asm-generic/rtc.h" of Arnd's series "[PATCH v3 00/16] genrtc removal"
caused two new build failures on m68k:

bvme6000_defconfig:

    In file included from arch/m68k/bvme6000/rtc.c:19:
    include/linux/mc146818rtc.h: In function =E2=80=98mc146818_is_updating=
=E2=80=99:
    include/linux/mc146818rtc.h:138: error: implicit declaration of functio=
n =E2=80=98CMOS_READ=E2=80=99
    include/linux/mc146818rtc.h: In function =E2=80=98mc146818_get_time=E2=
=80=99:
    include/linux/mc146818rtc.h:189: error: =E2=80=98RTC_ALWAYS_BCD=E2=80=
=99 undeclared (first use in this function)
    include/linux/mc146818rtc.h:189: error: (Each undeclared identifier is =
reported only once
    include/linux/mc146818rtc.h:189: error: for each function it appears in=
.)
    include/linux/mc146818rtc.h: In function =E2=80=98mc146818_set_time=E2=
=80=99:
    include/linux/mc146818rtc.h:279: error: =E2=80=98RTC_ALWAYS_BCD=E2=80=
=99 undeclared (first use in this function)
    include/linux/mc146818rtc.h:290: error: implicit declaration of functio=
n =E2=80=98CMOS_WRITE=E2=80=99


mvme16x_defconfig:

    In file included from arch/m68k/mvme16x/rtc.c:18:
    include/linux/mc146818rtc.h: In function =E2=80=98mc146818_is_updating=
=E2=80=99:
    include/linux/mc146818rtc.h:138: error: implicit declaration of functio=
n =E2=80=98CMOS_READ=E2=80=99
    include/linux/mc146818rtc.h: In function =E2=80=98mc146818_get_time=E2=
=80=99:
    include/linux/mc146818rtc.h:189: error: =E2=80=98RTC_ALWAYS_BCD=E2=80=
=99 undeclared (first use in this function)
    include/linux/mc146818rtc.h:189: error: (Each undeclared identifier is =
reported only once
    include/linux/mc146818rtc.h:189: error: for each function it appears in=
.)
    include/linux/mc146818rtc.h: In function =E2=80=98mc146818_set_time=E2=
=80=99:
    include/linux/mc146818rtc.h:279: error: =E2=80=98RTC_ALWAYS_BCD=E2=80=
=99 undeclared (first use in this function)
    include/linux/mc146818rtc.h:290: error: implicit declaration of functio=
n =E2=80=98CMOS_WRITE=E2=80=99

These do not show up with a multi-platform config including Atari
support, as arch/m68k/include/asm/mc146818rtc.h provides a definition of
CMOS_READ() if CONFIG_ATARI=3Dy.

Fortunately the fixes are simple: replace <linux/mc146818rtc.h> by
<linux/rtc.h>.  This is safe to apply to current upstream, too.

Queue strategy:
  1. These are queued together with Arnd's series,
  1. I queue them for v4.7 myself, but then the RTC tree must be mergest
     after the m68k tree,
  2. I queue them for v4.6.

As I currently don't have any m68k patches queued for v4.7, perhaps it's
easiest if these are included with Arnd's series?

Thanks!

Geert Uytterhoeven (2):
  m68k/bvme6000: Include generic <linux/rtc.h>
  m68k/mvme16x: Include generic <linux/rtc.h>

 arch/m68k/bvme6000/rtc.c | 2 +-
 arch/m68k/mvme16x/rtc.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--=20
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
							    -- Linus Torvalds

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
