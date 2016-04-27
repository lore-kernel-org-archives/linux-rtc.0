Return-Path: <rtc-linux+bncBCQJP74GSUDRBT5EQK4QKGQER3E7KSI@googlegroups.com>
Received: from mail-ig0-x244.google.com (mail-ig0-x244.google.com. [2607:f8b0:4001:c05::244])
        by gmr-mx.google.com with ESMTPS id cs5si1483676igb.0.2016.04.27.03.19.59
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Apr 2016 03:19:59 -0700 (PDT)
Received: by mail-ig0-x244.google.com with SMTP id fn8so5945257igb.2
        for <rtc-linux@googlegroups.com>; Wed, 27 Apr 2016 03:19:59 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <4937900.aITlOE9vLo@wuerfel>
References: <1461707052-1337718-1-git-send-email-arnd@arndb.de>
	<20160427094410.GJ3264@piout.net>
	<4937900.aITlOE9vLo@wuerfel>
Date: Wed, 27 Apr 2016 12:19:59 +0200
Message-ID: <CAMuHMdW6AODmVwB59uTvMydbTNiDDxQWB3p-Dp9Dka+GVyP_iw@mail.gmail.com>
Subject: [rtc-linux] Re: char: legacy RTC cleanups
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Luck <tony.luck@intel.com>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>,
	Rich Felker <dalias@libc.org>, David Howells <dhowells@redhat.com>,
	Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, Richard Henderson <rth@twiddle.net>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, alpha <linux-alpha@vger.kernel.org>,
	"the arch/x86 maintainers" <x86@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Linux-sh list <linux-sh@vger.kernel.org>,
	RTCLINUX <rtc-linux@googlegroups.com>, Linux-Arch <linux-arch@vger.kernel.org>
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

On Wed, Apr 27, 2016 at 12:07 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 27 April 2016 11:44:10 Alexandre Belloni wrote:
>> On 26/04/2016 at 23:44:04 +0200, Arnd Bergmann wrote :
>> > I've had these patches in my tree for a while, after the first one
>> > had a few issues that are fixed in this new version. The old-style
>> > PC RTC driver is now also disabled on m68k (as pointed out by
>> > Geert), ppc (it was also blacklisted), and m32r (I showed that
>> > it did not build).
>> >
>> > For the genrtc driver, rearranging the headers makes it simpler
>> > to use and reduces duplication. In case of alpha and mn10300,
>> > I've shown that the genrtc and rtc drivers are doing the same
>> > thing, so we don't need them both. The remaining three
>> > architectures (m68k, parisc, powerpc) actually all support
>> > the newer rtc-generic driver, so we could remove genrtc completely
>> > if we want to.
>> >
>>
>> Personally, I'd go for the kill and remove genrtc instead of cleaning it up.
>
> Right, so we could skip patches 5 and 6, and instead remove the two
> headers as we remove the driver. Let's see what the architecture
> maintainers think about it, at least powerpc actually enables gen_rtc
> in its defconfig, so it might take a while to move it over.

FWIW, all PPC defconfigs (except tqm8xx.dts, which is a more recent platform)
enabling it did that long before my old commit to enable rtc-generic support
on PPC:

commit bcd68a70cb0eee556d86d93133aa150319bd9f53
Author: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Date:   Thu Feb 19 16:50:46 2009 +0100

    powerpc: Hook up rtc-generic, and kill rtc-ppc

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
