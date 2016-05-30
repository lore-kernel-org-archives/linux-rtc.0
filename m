Return-Path: <rtc-linux+bncBDJ4N37Q6EERBB5CV25AKGQEYT47VBY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mga04.intel.com (mga04.intel.com. [192.55.52.120])
        by gmr-mx.google.com with ESMTP id tp10si6398467pac.2.2016.05.29.18.01.58
        for <rtc-linux@googlegroups.com>;
        Sun, 29 May 2016 18:01:58 -0700 (PDT)
Date: Mon, 30 May 2016 09:06:03 +0800
From: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, rtc-linux@googlegroups.com,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [rtc-linux] [abelloni:rtc-testing 2/17] include/linux/printk.h:375:9:
 error: type defaults to 'int' in declaration of 'DEFINE_RATELIMIT_STATE'
Message-ID: <201605300959.yAdCexQ0%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nFreZHaLTZJo0R7j"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-testing
head:   1a4cab5badddc8b5e0c5bf7eaaddcb6296c8d926
commit: a3829b4602bb384f1d6c3b427c5b53c5b23c5ca0 [2/17] rtc: cmos: move mc146818rtc code out of asm-generic/rtc.h
config: i386-alldefconfig (attached as .config)
compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
reproduce:
        git checkout a3829b4602bb384f1d6c3b427c5b53c5b23c5ca0
        # save the attached .config to linux build tree
        make ARCH=i386 

Note: the abelloni/rtc-testing HEAD 1a4cab5badddc8b5e0c5bf7eaaddcb6296c8d926 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:13:0,
                    from include/linux/list.h:8,
                    from include/linux/preempt.h:10,
                    from include/linux/spinlock.h:50,
                    from arch/x86/kernel/nmi.c:13:
   arch/x86/kernel/nmi.c: In function 'nmi_max_handler':
>> include/linux/printk.h:375:9: error: type defaults to 'int' in declaration of 'DEFINE_RATELIMIT_STATE' [-Werror=implicit-int]
     static DEFINE_RATELIMIT_STATE(_rs,    \
            ^
   arch/x86/kernel/nmi.c:110:2: note: in expansion of macro 'printk_ratelimited'
     printk_ratelimited(KERN_INFO
     ^~~~~~~~~~~~~~~~~~
   arch/x86/kernel/nmi.c:110:2: warning: parameter names (without types) in function declaration
   In file included from include/linux/kernel.h:13:0,
                    from include/linux/list.h:8,
                    from include/linux/preempt.h:10,
                    from include/linux/spinlock.h:50,
                    from arch/x86/kernel/nmi.c:13:
>> include/linux/printk.h:375:9: error: invalid storage class for function 'DEFINE_RATELIMIT_STATE'
     static DEFINE_RATELIMIT_STATE(_rs,    \
            ^
   arch/x86/kernel/nmi.c:110:2: note: in expansion of macro 'printk_ratelimited'
     printk_ratelimited(KERN_INFO
     ^~~~~~~~~~~~~~~~~~
>> include/linux/printk.h:379:6: error: implicit declaration of function '__ratelimit' [-Werror=implicit-function-declaration]
     if (__ratelimit(&_rs))      \
         ^
   arch/x86/kernel/nmi.c:110:2: note: in expansion of macro 'printk_ratelimited'
     printk_ratelimited(KERN_INFO
     ^~~~~~~~~~~~~~~~~~
>> include/linux/printk.h:379:19: error: '_rs' undeclared (first use in this function)
     if (__ratelimit(&_rs))      \
                      ^
   arch/x86/kernel/nmi.c:110:2: note: in expansion of macro 'printk_ratelimited'
     printk_ratelimited(KERN_INFO
     ^~~~~~~~~~~~~~~~~~
   include/linux/printk.h:379:19: note: each undeclared identifier is reported only once for each function it appears in
     if (__ratelimit(&_rs))      \
                      ^
   arch/x86/kernel/nmi.c:110:2: note: in expansion of macro 'printk_ratelimited'
     printk_ratelimited(KERN_INFO
     ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +375 include/linux/printk.h

968ab1838 Linus Torvalds 2010-11-15  369   * ratelimited messages with local ratelimit_state,
968ab1838 Linus Torvalds 2010-11-15  370   * no local ratelimit_state used in the !PRINTK case
968ab1838 Linus Torvalds 2010-11-15  371   */
968ab1838 Linus Torvalds 2010-11-15  372  #ifdef CONFIG_PRINTK
6ec42a56e Joe Perches    2011-01-12  373  #define printk_ratelimited(fmt, ...)					\
6ec42a56e Joe Perches    2011-01-12  374  ({									\
968ab1838 Linus Torvalds 2010-11-15 @375  	static DEFINE_RATELIMIT_STATE(_rs,				\
968ab1838 Linus Torvalds 2010-11-15  376  				      DEFAULT_RATELIMIT_INTERVAL,	\
968ab1838 Linus Torvalds 2010-11-15  377  				      DEFAULT_RATELIMIT_BURST);		\
968ab1838 Linus Torvalds 2010-11-15  378  									\
968ab1838 Linus Torvalds 2010-11-15 @379  	if (__ratelimit(&_rs))						\
968ab1838 Linus Torvalds 2010-11-15  380  		printk(fmt, ##__VA_ARGS__);				\
968ab1838 Linus Torvalds 2010-11-15  381  })
968ab1838 Linus Torvalds 2010-11-15  382  #else

:::::: The code at line 375 was first introduced by commit
:::::: 968ab1838a5d48f02f5b471aa1d0e59e2cc2ccbc include/linux/kernel.h: Move logging bits to include/linux/printk.h

:::::: TO: Linus Torvalds <torvalds@linux-foundation.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--nFreZHaLTZJo0R7j
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
qDQY7fA/+Odg0t+SAAA=

--nFreZHaLTZJo0R7j--
