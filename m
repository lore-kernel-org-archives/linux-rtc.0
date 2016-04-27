Return-Path: <rtc-linux+bncBDS7HNEFSALRB2HRQG4QKGQEFWFZJYI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id u137si550739wmd.1.2016.04.27.01.31.36
        for <rtc-linux@googlegroups.com>;
        Wed, 27 Apr 2016 01:31:36 -0700 (PDT)
Date: Wed, 27 Apr 2016 10:31:24 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, tony.luck@intel.com,
	geert@linux-m68k.org, jejb@parisc-linux.org, deller@gmx.de,
	benh@kernel.crashing.org, mpe@ellerman.id.au, dalias@libc.org,
	dhowells@redhat.com, yasutake.koichi@jp.panasonic.com,
	rth@twiddle.net, ink@jurassic.park.msu.ru,
	linux-alpha@vger.kernel.org, x86@kernel.org, a.zummo@towertech.it,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org, rtc-linux@googlegroups.com,
	linux-arch@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 1/8] char/rtc: replace blacklist with whitelist
Message-ID: <20160427083124.GF3264@piout.net>
References: <1461707052-1337718-1-git-send-email-arnd@arndb.de>
 <1461707052-1337718-2-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1461707052-1337718-2-git-send-email-arnd@arndb.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 26/04/2016 at 23:44:05 +0200, Arnd Bergmann wrote :
> Every new architecture has to add itself to the growing list of those
> that do not support the legacy PC RTC driver.
> 
> This replaces the long list of architectures that don't support it
> with a shorter list of those that do.
> 
> The list is taken from those architectures that have a non-empty
> asm/mc146818rtc.h header file and were not explicitly blacklisted.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  drivers/char/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index 3ec0766ed5e9..66b5d48f409a 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -279,8 +279,7 @@ if RTC_LIB=n
>  
>  config RTC
>  	tristate "Enhanced Real Time Clock Support (legacy PC RTC driver)"
> -	depends on !PPC && !PARISC && !IA64 && !M68K && !SPARC && !FRV \
> -			&& !ARM && !SUPERH && !S390 && !AVR32 && !BLACKFIN && !UML
> +	depends on ALPHA || (MIPS && MACH_LOONGSON64) || MN10300 || X86
>  	---help---
>  	  If you say Y here and create a character special file /dev/rtc with
>  	  major number 10 and minor number 135 using mknod ("man mknod"), you
> -- 
> 2.7.0
> 

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
