Return-Path: <rtc-linux+bncBCQJP74GSUDRBYW6QG4QKGQEUOT2WPQ@googlegroups.com>
Received: from mail-ig0-x244.google.com (mail-ig0-x244.google.com. [2607:f8b0:4001:c05::244])
        by gmr-mx.google.com with ESMTPS id gm17si1801438igb.1.2016.04.27.00.50.58
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Apr 2016 00:50:58 -0700 (PDT)
Received: by mail-ig0-x244.google.com with SMTP id g8so5509266igr.0
        for <rtc-linux@googlegroups.com>; Wed, 27 Apr 2016 00:50:58 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1461707551-1337971-1-git-send-email-arnd@arndb.de>
References: <1461707551-1337971-1-git-send-email-arnd@arndb.de>
Date: Wed, 27 Apr 2016 09:50:58 +0200
Message-ID: <CAMuHMdWppdXFjoj-+YC137fgPYb4TE_Kp4fycitJdPaqMGn3VA@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v2 0/6] simplify rtc-generic driver
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Helge Deller <deller@gmx.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>,
	Rich Felker <dalias@libc.org>, David Howells <dhowells@redhat.com>,
	alpha <linux-alpha@vger.kernel.org>, Alessandro Zummo <a.zummo@towertech.it>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Linux-sh list <linux-sh@vger.kernel.org>,
	linux-m68k <linux-m68k@lists.linux-m68k.org>, RTCLINUX <rtc-linux@googlegroups.com>,
	Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Arnd,

On Tue, Apr 26, 2016 at 11:52 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> This is a resend of an earlier series, to clean up the rtc-generic
> driver by avoiding the dependency on the architecture specific
> include/asm/rtc.h header that after this series is only used
> for the deprecated "genrtc" driver. As I've shown in another
> series, only three architectures (m68k, powerpc, parisc)
> actually use the genrtc driver, and they all support rtc-generic
> as a replacement as well.
>
> The only missing piece appears to be the ioctl support for
> the m68k q40 machine that I'm adding in patch 2 here.

Apparently I had applied your previous version to my local tree, but I had
completely forgotten about it. So it has received quite some compile testing.

CONFIG_GEN_RTC is not enabled in any of the m68k defconfigs, so I think it's
been unused for a while.
CONFIG_RTC_DRV_GENERIC is modular, so I typically don't run-test it.
I just did that, and after fixing patch 1 to use IS_ENABLED() it worked fine
on ARAnyM.

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

I do not have a Q40, so I couldn't test that part.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
