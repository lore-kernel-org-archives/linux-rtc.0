Return-Path: <rtc-linux+bncBDAMN6NI5EERBDPI3G5AKGQE273GZBA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from Galois.linutronix.de (linutronix.de. [2001:470:1f0b:db:abcd:42:0:1])
        by gmr-mx.google.com with ESMTPS id j140si533552wmf.1.2016.06.06.07.14.50
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Jun 2016 07:14:50 -0700 (PDT)
Date: Mon, 6 Jun 2016 16:12:55 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
    linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
    Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
    x86@kernel.org
Subject: [rtc-linux] Re: [PATCH] x86: include linux/ratelimit.h in nmi.c
In-Reply-To: <1465222212-2579966-1-git-send-email-arnd@arndb.de>
Message-ID: <alpine.DEB.2.11.1606061612390.28031@nanos>
References: <1465222212-2579966-1-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Mon, 6 Jun 2016, Arnd Bergmann wrote:
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

Acked-by: Thomas Gleixner <tglx@linutronix.de>
