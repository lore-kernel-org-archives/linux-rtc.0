Return-Path: <rtc-linux+bncBCQJP74GSUDRBH7WQG4QKGQEDPAT7YI@googlegroups.com>
Received: from mail-io0-x243.google.com (mail-io0-x243.google.com. [2607:f8b0:4001:c06::243])
        by gmr-mx.google.com with ESMTPS id au10si1303837igc.3.2016.04.27.01.41.02
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Apr 2016 01:41:02 -0700 (PDT)
Received: by mail-io0-x243.google.com with SMTP id x35so5320810ioi.0
        for <rtc-linux@googlegroups.com>; Wed, 27 Apr 2016 01:41:02 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <6883809.SRgmlLMdyd@wuerfel>
References: <1461707052-1337718-1-git-send-email-arnd@arndb.de>
	<CAMuHMdV=R3ad33vPdMZNvZZ8A_DF+F2C8nyAmXOmFiiP50D_UQ@mail.gmail.com>
	<6883809.SRgmlLMdyd@wuerfel>
Date: Wed, 27 Apr 2016 10:41:02 +0200
Message-ID: <CAMuHMdU8WGkosaC7wK8Jp9D7DGjUjBEHURYkp9GppTz2wxRe_A@mail.gmail.com>
Subject: [rtc-linux] Re: char: legacy RTC cleanups
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Luck <tony.luck@intel.com>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>,
	Rich Felker <dalias@libc.org>, David Howells <dhowells@redhat.com>,
	Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, Richard Henderson <rth@twiddle.net>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, alpha <linux-alpha@vger.kernel.org>,
	"the arch/x86 maintainers" <x86@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
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

On Wed, Apr 27, 2016 at 10:33 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 27 April 2016 09:54:41 Geert Uytterhoeven wrote:
>> On Tue, Apr 26, 2016 at 11:44 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > For the genrtc driver, rearranging the headers makes it simpler
>> > to use and reduces duplication. In case of alpha and mn10300,
>> > I've shown that the genrtc and rtc drivers are doing the same
>> > thing, so we don't need them both. The remaining three
>> > architectures (m68k, parisc, powerpc) actually all support
>> > the newer rtc-generic driver, so we could remove genrtc completely
>> > if we want to.
>>
>> CONFIG_GEN_RTC is not enabled in any of the m68k defconfigs, so I think genrtc
>> has been unused for a while.
>> All defconfigs either use CONFIG_RTC_DRV_GENERIC, or enable a more specific
>> RTC driver.
>
> Ok, good to know. I'm guessing the same is true for parisc, but there are
> also very few users.
>
> Regarding the Q40 specific ioctls, what do you think this means, is it
>
> a) nobody uses Q40 with modern kernels,
> b) nobody calls RTC_PLL_GET/RTC_PLL_SET on q40, or
> c) Q40 users have their own configurations and enable GEN_RTC?

To be honest, I have no idea. There have never been many Q40 users.
(old) http://www.linux-m68k.org/Registry/Statistics.html shows only 8.

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
