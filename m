Return-Path: <rtc-linux+bncBDS7HNEFSALRBVPU3K3AKGQECBA4K7Q@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id w197si138358wmw.3.2016.03.02.02.03.00
        for <rtc-linux@googlegroups.com>;
        Wed, 02 Mar 2016 02:03:00 -0800 (PST)
Date: Wed, 2 Mar 2016 11:03:00 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 1/2] char: PC rtc: replace blacklist with whitelist
Message-ID: <20160302100300.GL23985@piout.net>
References: <1456912137-1578635-1-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1456912137-1578635-1-git-send-email-arnd@arndb.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 02/03/2016 at 10:48:50 +0100, Arnd Bergmann wrote :
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
> index a043107da2af..9716bc36495a 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -279,8 +279,7 @@ if RTC_LIB=n
>  
>  config RTC
>  	tristate "Enhanced Real Time Clock Support (legacy PC RTC driver)"
> -	depends on !PPC && !PARISC && !IA64 && !M68K && !SPARC && !FRV \
> -			&& !ARM && !SUPERH && !S390 && !AVR32 && !BLACKFIN && !UML
> +	depends on ALPHA || M32R || M68K || MIPS || MN10300 || PPC || X86
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
