Return-Path: <rtc-linux+bncBDEKVJM7XAHRBXWFQK4QKGQERYX4GSI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.126.187])
        by gmr-mx.google.com with ESMTPS id c7si180702wmf.2.2016.04.27.04.30.38
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Apr 2016 04:30:38 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Luck <tony.luck@intel.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Rich Felker <dalias@libc.org>, David Howells <dhowells@redhat.com>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, alpha <linux-alpha@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Linux-sh list <linux-sh@vger.kernel.org>, RTCLINUX <rtc-linux@googlegroups.com>, Linux-Arch <linux-arch@vger.kernel.org>
Subject: [rtc-linux] Re: char: legacy RTC cleanups
Date: Wed, 27 Apr 2016 13:30:05 +0200
Message-ID: <13390963.BOLfm8tOYx@wuerfel>
In-Reply-To: <CAMuHMdW6AODmVwB59uTvMydbTNiDDxQWB3p-Dp9Dka+GVyP_iw@mail.gmail.com>
References: <1461707052-1337718-1-git-send-email-arnd@arndb.de> <4937900.aITlOE9vLo@wuerfel> <CAMuHMdW6AODmVwB59uTvMydbTNiDDxQWB3p-Dp9Dka+GVyP_iw@mail.gmail.com>
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

On Wednesday 27 April 2016 12:19:59 Geert Uytterhoeven wrote:
> >
> > Right, so we could skip patches 5 and 6, and instead remove the two
> > headers as we remove the driver. Let's see what the architecture
> > maintainers think about it, at least powerpc actually enables gen_rtc
> > in its defconfig, so it might take a while to move it over.
> 
> FWIW, all PPC defconfigs (except tqm8xx.dts, which is a more recent platform)
> enabling it did that long before my old commit to enable rtc-generic support
> on PPC:
> 
> commit bcd68a70cb0eee556d86d93133aa150319bd9f53
> Author: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> Date:   Thu Feb 19 16:50:46 2009 +0100
> 
>     powerpc: Hook up rtc-generic, and kill rtc-ppc

Ah, interesting. I have two observations about that patch:

- you were moving basically in the opposite direction that I am
  trying to bring it now. ;-)

- I see now that four defconfigs (gamecube, powernv, pseries and wii)
  do enable RTC_DRV_GENERIC. For some reason, ppc64_defconfig only
  enables RTC_DRV_DS1307, I assume that is not intentional.

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
