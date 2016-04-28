Return-Path: <rtc-linux+bncBDEKVJM7XAHRB7NUQ64QKGQEZQH5Y5I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mout.kundenserver.de (mout.kundenserver.de. [217.72.192.75])
        by gmr-mx.google.com with ESMTPS id k143si539936wmg.1.2016.04.28.02.40.13
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Apr 2016 02:40:13 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Rich Felker <dalias@libc.org>, David Howells <dhowells@redhat.com>, alpha <linux-alpha@vger.kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Linux-sh list <linux-sh@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, RTCLINUX <rtc-linux@googlegroups.com>, Linux-Arch <linux-arch@vger.kernel.org>
Subject: [rtc-linux] Re: [PATCH v3 13/16] char/genrtc: remove powerpc support
Date: Thu, 28 Apr 2016 11:39:56 +0200
Message-ID: <2182936.7ADRRgWoa5@wuerfel>
In-Reply-To: <CAMuHMdUhydMDeQ=ciVFgjBcjnCD_q2qU0F0gUP28U9=EcH2ZRQ@mail.gmail.com>
References: <1461796470-1291527-1-git-send-email-arnd@arndb.de> <1461796470-1291527-14-git-send-email-arnd@arndb.de> <CAMuHMdUhydMDeQ=ciVFgjBcjnCD_q2qU0F0gUP28U9=EcH2ZRQ@mail.gmail.com>
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

On Thursday 28 April 2016 09:25:25 Geert Uytterhoeven wrote:
> On Thu, Apr 28, 2016 at 12:34 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > --- a/arch/powerpc/platforms/Kconfig
> > +++ b/arch/powerpc/platforms/Kconfig
> > @@ -321,6 +321,17 @@ config OF_RTC
> >           Uses information from the OF or flattened device tree to instantiate
> >           platform devices for direct mapped RTC chips like the DS1742 or DS1743.
> >
> > +config GEN_RTC
> > +       bool "Use the platform RTC operations from user space"
> > +       select RTC_CLASS
> > +       select RTC_DRV_GENERIC
> > +       help
> > +         This option provides backwards compatibility with the old gen_rtc.ko
> > +         module that was traditionally used for old PowerPC machines.
> > +         Platforms should migrate to enabling the RTC_DRV_GENERIC by hand
> > +         replacing changing their get_rtc_time/set_rtc_time callbacks with
> 
> Drop "changing".
> 
> 

done, thanks!

	Arnd

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
