Return-Path: <rtc-linux+bncBDJ4N37Q6EERB7NMV65AKGQEUMKMVJI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mga04.intel.com (mga04.intel.com. [192.55.52.120])
        by gmr-mx.google.com with ESMTP id f69si4656358pfc.1.2016.05.29.22.58.20
        for <rtc-linux@googlegroups.com>;
        Sun, 29 May 2016 22:58:20 -0700 (PDT)
Date: Mon, 30 May 2016 14:01:48 +0800
From: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, rtc-linux@googlegroups.com,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [rtc-linux] [abelloni:rtc-testing 6/17] arch/mn10300/proc-mn103e010/proc-init.c:54:2:
 error: implicit declaration of function 'mn10300_dcache_flush_inv'
Message-ID: <201605301445.EhAImtXf%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-testing
head:   1a4cab5badddc8b5e0c5bf7eaaddcb6296c8d926
commit: f8a0e3c24fd4764dd3bc46e2500cc308cb4b1056 [6/17] char/genrtc: remove mn10300 support
config: mn10300-allnoconfig (attached as .config)
compiler: am33_2.0-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout f8a0e3c24fd4764dd3bc46e2500cc308cb4b1056
        # save the attached .config to linux build tree
        make.cross ARCH=mn10300 

Note: the abelloni/rtc-testing HEAD 1a4cab5badddc8b5e0c5bf7eaaddcb6296c8d926 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   arch/mn10300/proc-mn103e010/proc-init.c: In function 'processor_init':
>> arch/mn10300/proc-mn103e010/proc-init.c:54:2: error: implicit declaration of function 'mn10300_dcache_flush_inv' [-Werror=implicit-function-declaration]
     mn10300_dcache_flush_inv();
     ^
>> arch/mn10300/proc-mn103e010/proc-init.c:55:2: error: implicit declaration of function 'mn10300_icache_inv' [-Werror=implicit-function-declaration]
     mn10300_icache_inv();
     ^
>> arch/mn10300/proc-mn103e010/proc-init.c:58:24: error: 'NR_IRQS' undeclared (first use in this function)
     for (loop = 0; loop < NR_IRQS; loop++)
                           ^
   arch/mn10300/proc-mn103e010/proc-init.c:58:24: note: each undeclared identifier is reported only once for each function it appears in
   cc1: some warnings being treated as errors

vim +/mn10300_dcache_flush_inv +54 arch/mn10300/proc-mn103e010/proc-init.c

b920de1b David Howells 2008-02-08  48  	IVAR2 = EXCEP_IRQ_LEVEL2;
b920de1b David Howells 2008-02-08  49  	IVAR3 = EXCEP_IRQ_LEVEL3;
b920de1b David Howells 2008-02-08  50  	IVAR4 = EXCEP_IRQ_LEVEL4;
b920de1b David Howells 2008-02-08  51  	IVAR5 = EXCEP_IRQ_LEVEL5;
b920de1b David Howells 2008-02-08  52  	IVAR6 = EXCEP_IRQ_LEVEL6;
b920de1b David Howells 2008-02-08  53  
b920de1b David Howells 2008-02-08 @54  	mn10300_dcache_flush_inv();
b920de1b David Howells 2008-02-08 @55  	mn10300_icache_inv();
b920de1b David Howells 2008-02-08  56  
b920de1b David Howells 2008-02-08  57  	/* disable all interrupts and set to priority 6 (lowest) */
b920de1b David Howells 2008-02-08 @58  	for (loop = 0; loop < NR_IRQS; loop++)
b920de1b David Howells 2008-02-08  59  		GxICR(loop) = GxICR_LEVEL_6 | GxICR_DETECT;
b920de1b David Howells 2008-02-08  60  
b920de1b David Howells 2008-02-08  61  	/* clear the timers */

:::::: The code at line 54 was first introduced by commit
:::::: b920de1b77b72ca9432ac3f97edb26541e65e5dd mn10300: add the MN10300/AM33 architecture to the kernel

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: Linus Torvalds <torvalds@woody.linux-foundation.org>

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

--cWoXeonUoKmBZSoM
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
X+p11sp87UV4zyn8HwYYmluJOwAA

--cWoXeonUoKmBZSoM--
