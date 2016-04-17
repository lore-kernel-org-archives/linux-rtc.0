Return-Path: <rtc-linux+bncBDEKVJM7XAHRB6HNZ24AKGQEEI7B7OY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.17.10])
        by gmr-mx.google.com with ESMTPS id d92si1138607wma.2.2016.04.17.09.16.56
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Apr 2016 09:16:56 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Geert Uytterhoeven <geert@linux-m68k.org>, RTCLINUX <rtc-linux@googlegroups.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [rtc-linux] Re: [PATCH 1/2] char: PC rtc: replace blacklist with whitelist
Date: Sun, 17 Apr 2016 18:16:51 +0200
Message-ID: <11356549.HIf78Z96bJ@wuerfel>
In-Reply-To: <20160410154352.GH5377@piout.net>
References: <1456912137-1578635-1-git-send-email-arnd@arndb.de> <CAMuHMdU26GkyUYxs3DJOFRB5LTdYCOaGTMUwFMd9YXYhkS1W3g@mail.gmail.com> <20160410154352.GH5377@piout.net>
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

On Sunday 10 April 2016 17:43:52 Alexandre Belloni wrote:
> > >  config RTC
> > >         tristate "Enhanced Real Time Clock Support (legacy PC RTC driver)"
> > > -       depends on !PPC && !PARISC && !IA64 && !M68K && !SPARC && !FRV \
> > > -                       && !ARM && !SUPERH && !S390 && !AVR32 && !BLACKFIN && !UML
> > > +       depends on ALPHA || M32R || M68K || MIPS || MN10300 || PPC || X86
> > 
> > ... so please drop it here.
> > 
> 
> Do you plan to resend that one?
> 

Yes, it's in my queue for resending, together with some other RTC patches.

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
