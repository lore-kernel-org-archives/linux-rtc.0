Return-Path: <rtc-linux+bncBDEKVJM7XAHRBQPKVC6QKGQEXTTLODQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.126.131])
        by gmr-mx.google.com with ESMTPS id l195si2690214vki.2.2016.08.09.12.55.44
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Aug 2016 12:55:44 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org
Cc: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com,
	Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] [PATCH] x86/hpet: fix typo from rtc cleanup
Date: Tue,  9 Aug 2016 21:54:53 +0200
Message-Id: <20160809195528.1604312-1-arnd@arndb.de>
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

Ville Syrj=C3=A4l=C3=A4 reports "The first time I run hwclock after rebooti=
ng
I get this:

 open("/dev/rtc", O_RDONLY)              =3D 3
 ioctl(3, PHN_SET_REGS or RTC_UIE_ON, 0) =3D 0
 select(4, [3], NULL, NULL, {10, 0})     =3D 0 (Timeout)
 ioctl(3, PHN_NOT_OH or RTC_UIE_OFF, 0)  =3D 0
 close(3)                                =3D 0

On all subsequent runs I get this:
 open("/dev/rtc", O_RDONLY)              =3D 3
 ioctl(3, PHN_SET_REGS or RTC_UIE_ON, 0) =3D -1 EINVAL (Invalid argument)
 ioctl(3, RTC_RD_TIME, 0x7ffd76b3ae70)   =3D -1 EINVAL (Invalid argument)
 close(3)                                =3D 0"

This was caused by a stupid typo in a patch that should have been
a simple rename to move around contents of a header file, but
accidentally wrote zeroes into the rtc rather than reading from
it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reported-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
Tested-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
Fixes: 463a86304cae ("char/genrtc: x86: remove remnants of asm/rtc.h")
---
 arch/x86/kernel/hpet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index ed16e58658a4..c6dfd801df97 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -1242,7 +1242,7 @@ irqreturn_t hpet_rtc_interrupt(int irq, void *dev_id)
 	memset(&curr_time, 0, sizeof(struct rtc_time));
=20
 	if (hpet_rtc_flags & (RTC_UIE | RTC_AIE))
-		mc146818_set_time(&curr_time);
+		mc146818_get_time(&curr_time);
=20
 	if (hpet_rtc_flags & RTC_UIE &&
 	    curr_time.tm_sec !=3D hpet_prev_update_sec) {
--=20
2.9.0

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
