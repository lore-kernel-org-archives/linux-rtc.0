Return-Path: <rtc-linux+bncBCQJP74GSUDRBZPVQ24QKGQELKGKWPI@googlegroups.com>
Received: from mail-ig0-x242.google.com (mail-ig0-x242.google.com. [2607:f8b0:4001:c05::242])
        by gmr-mx.google.com with ESMTPS id gm17si229678igb.1.2016.04.28.00.25.25
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Apr 2016 00:25:25 -0700 (PDT)
Received: by mail-ig0-x242.google.com with SMTP id c3so9893091igl.3
        for <rtc-linux@googlegroups.com>; Thu, 28 Apr 2016 00:25:25 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1461796470-1291527-14-git-send-email-arnd@arndb.de>
References: <1461796470-1291527-1-git-send-email-arnd@arndb.de>
	<1461796470-1291527-14-git-send-email-arnd@arndb.de>
Date: Thu, 28 Apr 2016 09:25:25 +0200
Message-ID: <CAMuHMdUhydMDeQ=ciVFgjBcjnCD_q2qU0F0gUP28U9=EcH2ZRQ@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v3 13/16] char/genrtc: remove powerpc support
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

On Thu, Apr 28, 2016 at 12:34 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> --- a/arch/powerpc/platforms/Kconfig
> +++ b/arch/powerpc/platforms/Kconfig
> @@ -321,6 +321,17 @@ config OF_RTC
>           Uses information from the OF or flattened device tree to instantiate
>           platform devices for direct mapped RTC chips like the DS1742 or DS1743.
>
> +config GEN_RTC
> +       bool "Use the platform RTC operations from user space"
> +       select RTC_CLASS
> +       select RTC_DRV_GENERIC
> +       help
> +         This option provides backwards compatibility with the old gen_rtc.ko
> +         module that was traditionally used for old PowerPC machines.
> +         Platforms should migrate to enabling the RTC_DRV_GENERIC by hand
> +         replacing changing their get_rtc_time/set_rtc_time callbacks with

Drop "changing".

> +         a proper RTC device driver.

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
