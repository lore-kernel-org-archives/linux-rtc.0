Return-Path: <rtc-linux+bncBDS7HNEFSALRBOPJVG4AKGQEH7EDS6I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id a136si6138wma.0.2016.04.10.08.43.52
        for <rtc-linux@googlegroups.com>;
        Sun, 10 Apr 2016 08:43:52 -0700 (PDT)
Date: Sun, 10 Apr 2016 17:43:52 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [rtc-linux] Re: [PATCH 1/2] char: PC rtc: replace blacklist with whitelist
Message-ID: <20160410154352.GH5377@piout.net>
References: <1456912137-1578635-1-git-send-email-arnd@arndb.de>
 <CAMuHMdU26GkyUYxs3DJOFRB5LTdYCOaGTMUwFMd9YXYhkS1W3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAMuHMdU26GkyUYxs3DJOFRB5LTdYCOaGTMUwFMd9YXYhkS1W3g@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Arnd,

On 02/03/2016 at 11:22:04 +0100, Geert Uytterhoeven wrote :
> On Wed, Mar 2, 2016 at 10:48 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > Every new architecture has to add itself to the growing list of those
> > that do not support the legacy PC RTC driver.
> >
> > This replaces the long list of architectures that don't support it
> > with a shorter list of those that do.
> >
> > The list is taken from those architectures that have a non-empty
> > asm/mc146818rtc.h header file and were not explicitly blacklisted.
> 
> M68K was blacklisted...
> 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/char/Kconfig | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> > index a043107da2af..9716bc36495a 100644
> > --- a/drivers/char/Kconfig
> > +++ b/drivers/char/Kconfig
> > @@ -279,8 +279,7 @@ if RTC_LIB=n
> >
> >  config RTC
> >         tristate "Enhanced Real Time Clock Support (legacy PC RTC driver)"
> > -       depends on !PPC && !PARISC && !IA64 && !M68K && !SPARC && !FRV \
> > -                       && !ARM && !SUPERH && !S390 && !AVR32 && !BLACKFIN && !UML
> > +       depends on ALPHA || M32R || M68K || MIPS || MN10300 || PPC || X86
> 
> ... so please drop it here.
> 

Do you plan to resend that one?

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
