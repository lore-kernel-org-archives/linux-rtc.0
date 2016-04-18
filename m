Return-Path: <rtc-linux+bncBDEKVJM7XAHRBZEP2O4AKGQEDDCAOYA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.17.13])
        by gmr-mx.google.com with ESMTPS id 69si297092wmn.1.2016.04.18.04.41.24
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Apr 2016 04:41:24 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, RTCLINUX <rtc-linux@googlegroups.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] Re: [PATCH 1/2] char: PC rtc: replace blacklist with whitelist
Date: Mon, 18 Apr 2016 13:41:20 +0200
Message-ID: <5528499.2P7TrvXfau@wuerfel>
In-Reply-To: <CAMuHMdWQiqNq7-fgn5NONovLQxhOoGD5s-TAYVYZOVRfEs52Zg@mail.gmail.com>
References: <1456912137-1578635-1-git-send-email-arnd@arndb.de> <4192558.Mh1hb3LCLb@wuerfel> <CAMuHMdWQiqNq7-fgn5NONovLQxhOoGD5s-TAYVYZOVRfEs52Zg@mail.gmail.com>
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

On Monday 18 April 2016 09:09:55 Geert Uytterhoeven wrote:
> Hi Arnd,
> 
> cc linux-m68k
> 
> On Sun, Apr 17, 2016 at 11:37 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday 02 March 2016 11:22:04 Geert Uytterhoeven wrote:
> >> On Wed, Mar 2, 2016 at 10:48 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> > Every new architecture has to add itself to the growing list of those
> >> > that do not support the legacy PC RTC driver.
> >> >
> >> > This replaces the long list of architectures that don't support it
> >> > with a shorter list of those that do.
> >> >
> >> > The list is taken from those architectures that have a non-empty
> >> > asm/mc146818rtc.h header file and were not explicitly blacklisted.
> >>
> >> M68K was blacklisted...
> >
> > I never got back to you on this topic, sorry about that. I've fixed
> > up the patch to leave out m68k now.
> >
> > On a semi-related note, I see that m68k is one of the few architectures
> > still using the (other) genrtc driver. It would be nice to reduce that
> > list and change m68k to use its own rtc driver (ideally one per
> 
> We do have hp_sdc_rtc (HP9000/300; why is that under drivers/input/misc/?),
> and rtc-msm6242 and rtc-rp5c01 (both for Amiga).

fwiw, the hp_sdc_rtc driver does not actually implement the RTC ioctls
(they are there, but commented out).

The other ones are good, you just have two incompatible ways of doing
it because the drivers/rtc subsystem is can not be built into the
kernel at the same time as the old gen_rtc driver for the q40.

> > platform), but the q40 platform is the only one providing
> > get_rtc_pll()/set_rtc_pll() for the RTC_PLL_GET/RTC_PLL_SET ioctl
> > commands.
> 
> Do you mean this is a problem?

Not a big one, assuming that either nobody actually needs these ioctls
(very likely), or they don't care about having a single kernel for
q40 and the other platforms.

The main issue I see is migrating architectures over from gen_rtc to
rtc-generic over time, but this effort has been going on for at least
a decade and there is no rush, but it would still be nice.

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
