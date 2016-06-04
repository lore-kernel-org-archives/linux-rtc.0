Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBV7FZK5AKGQEY4UVQJQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id j140si153404wmf.1.2016.06.04.03.52.06
        for <rtc-linux@googlegroups.com>;
        Sat, 04 Jun 2016 03:52:06 -0700 (PDT)
Date: Sat, 4 Jun 2016 12:52:03 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
	rtc-linux@googlegroups.com, "David S. Miller" <davem@davemloft.net>,
	sparclinux@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] sparc32: remove stale RTC_PORT definition
Message-ID: <20160604105203.GH4594@piout.net>
References: <1465033041-2512569-1-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1465033041-2512569-1-git-send-email-arnd@arndb.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 04/06/2016 at 11:36:44 +0200, Arnd Bergmann wrote :
> sparc32:allmodconfig fails to build in next-20160602 as follows.
> 
> In file included from drivers/block/floppy.c:185:0:
> include/linux/mc146818rtc.h: In function 'mc146818_is_updating':
> include/linux/mc146818rtc.h:138:9: error: 'rtc_port' undeclared (first use in this function)
> include/linux/mc146818rtc.h:138:9: note: each undeclared identifier is reported only once for each function it appears in
> include/linux/mc146818rtc.h: In function 'mc146818_get_time':
> include/linux/mc146818rtc.h:172:17: error: 'rtc_port' undeclared (first use in this function)
> include/linux/mc146818rtc.h: In function 'mc146818_set_time':
> include/linux/mc146818rtc.h:278:8: error: 'rtc_port' undeclared (first use in this function)
> scripts/Makefile.build:295: recipe for target 'drivers/block/floppy.o' failed
> 
> The reason is a duplicate definition of the RTC_PORT macro. The
> one in arch/sparc/include/asm/io_32.h was apparently used a long time
> ago for the drivers/char/rtc.c driver that is not available on SPARC
> any more, since we now select 'RTC_CLASS' unconditionally.
> 
> Removing the macro fixes the build problem, and for consistency,
> this also removes the RTC_ALWAYS_BCD macro and the comment for both.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: fd09cc80165c ("rtc: cmos: move mc146818rtc code out of asm-generic/rtc.h")
> ---
> I thought I'd sent this out yesterday, but cannot find an indication of
> that now, and Alexandre didn't seem to get it. This should probably
> go through the rtc tree that introduced the build failure after my
> earlier patches
> 
>  arch/sparc/include/asm/io_32.h | 10 ----------
>  1 file changed, 10 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
