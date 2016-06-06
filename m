Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBAVE225AKGQEAKOFDTA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id j140si539013wmf.1.2016.06.06.08.08.49
        for <rtc-linux@googlegroups.com>;
        Mon, 06 Jun 2016 08:08:49 -0700 (PDT)
Date: Mon, 6 Jun 2016 17:08:49 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org
Subject: [rtc-linux] Re: [PATCH] x86: include linux/ratelimit.h in nmi.c
Message-ID: <20160606150849.GC3363@piout.net>
References: <1465222212-2579966-1-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1465222212-2579966-1-git-send-email-arnd@arndb.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 06/06/2016 at 16:09:52 +0200, Arnd Bergmann wrote :
> When building random configurations, we now occasionally get a new
> build error:
> 
>    In file included from include/linux/kernel.h:13:0,
>                     from include/linux/list.h:8,
>                     from include/linux/preempt.h:10,
>                     from include/linux/spinlock.h:50,
>                     from arch/x86/kernel/nmi.c:13:
>    arch/x86/kernel/nmi.c: In function 'nmi_max_handler':
>    include/linux/printk.h:375:9: error: type defaults to 'int' in declaration of 'DEFINE_RATELIMIT_STATE' [-Werror=implicit-int]
>      static DEFINE_RATELIMIT_STATE(_rs,    \
>             ^
>    arch/x86/kernel/nmi.c:110:2: note: in expansion of macro 'printk_ratelimited'
>      printk_ratelimited(KERN_INFO
>      ^~~~~~~~~~~~~~~~~~
> 
> This was working before the rtc rework series because linux/ratelimit.h
> was included implictly through asm/mach_traps.h -> asm/mc146818rtc.h
> -> linux/mc146818rtc.h -> linux/rtc.h -> linux/device.h.
> 
> We clearly shouldn't rely on this indirect inclusion, so this adds
> an explicit #include in the file that needs it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Fixes: 5ab788d73832 ("rtc: cmos: move mc146818rtc code out of asm-generic/rtc.h")
> ---
> It's only broken in the linux-rtc git at the moment, so it makes sense
> to fix it there.
> 
>  arch/x86/kernel/nmi.c | 1 +
>  1 file changed, 1 insertion(+)
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
