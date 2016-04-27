Return-Path: <rtc-linux+bncBDEKVJM7XAHRBVPIQK4QKGQESLBCZWA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.17.13])
        by gmr-mx.google.com with ESMTPS id d2si449810igx.2.2016.04.27.05.45.08
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Apr 2016 05:45:08 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rolf Eike Beer <eike-kernel@sf-tec.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Luck <tony.luck@intel.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Rich Felker <dalias@libc.org>, David Howells <dhowells@redhat.com>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, alpha <linux-alpha@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Linux-sh list <linux-sh@vger.kernel.org>, RTCLINUX <rtc-linux@googlegroups.com>, Linux-Arch <linux-arch@vger.kernel.org>
Subject: [rtc-linux] Re: [PATCH 6/8] char/genrtc: parisc: use asm-generic/rtc.h
Date: Wed, 27 Apr 2016 14:44:34 +0200
Message-ID: <4737487.5iYaado825@wuerfel>
In-Reply-To: <CAMuHMdV0DwdMkJURBH05ntrJWz0eY_wT__vHG32sx-sjSp0m_w@mail.gmail.com>
References: <1461707052-1337718-1-git-send-email-arnd@arndb.de> <4599222.az1Zyv5Lrl@wuerfel> <CAMuHMdV0DwdMkJURBH05ntrJWz0eY_wT__vHG32sx-sjSp0m_w@mail.gmail.com>
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

On Wednesday 27 April 2016 13:55:43 Geert Uytterhoeven wrote:
> On Wed, Apr 27, 2016 at 1:35 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday 27 April 2016 13:21:16 Arnd Bergmann wrote:
> >> On Wednesday 27 April 2016 00:07:47 Rolf Eike Beer wrote:
> >> > Arnd Bergmann wrote:
> >> > > The asm-generic/rtc.h header can now be included by
> >> > > architectures that provide their own set_rtc_time/get_rtc_time
> >> > > macros, letting us remove most of the common contents in
> >> > > the powerpc implementation.
> >> >
> >> > parisc in this case.
> >> >
> >>
> >> Fixed, thanks!
> >
> > Actually, after the comment about just removing the gen_rtc driver
> > in the long run, I checked again and found that PARISC unconditionally
> > selects RTC_CLASS, so this driver can't even be built here.
> > We should just remove the header and drop PARISC from the list.
> >
> > If we also drop m68k, that just leaves powerpc.
> 
> I've just checked Debian's unofficial linux-image-4.5.0-1-m68k_4.5.1-1_m68k,
> and it also enables RTC_CLASS and CONFIG_RTC_DRV_GENERIC, so gen_rtc
> can be dropped on m68k for sure.

Ok, excellent. I'll try to rework the series then to completely eliminate
the driver (or leaving it ppc-only).

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
