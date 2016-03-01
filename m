Return-Path: <rtc-linux+bncBDEKVJM7XAHRBGXY263AKGQEMXDUCSA@googlegroups.com>
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.126.187])
        by gmr-mx.google.com with ESMTPS id e130si41032wme.2.2016.03.01.12.31.22
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Mar 2016 12:31:22 -0800 (PST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: kbuild test robot <lkp@intel.com>, Alessandro Zummo <a.zummo@towertech.it>, linux-parisc@vger.kernel.org, rtc-linux@googlegroups.com, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Kyle McMartin <kyle@mcmartin.ca>, linux-m68k@lists.linux-m68k.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, kbuild-all@01.org, Paul Mackerras <paulus@samba.org>, linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] Re: [PATCH 3/6] powerpc: rtc: provide rtc_class_ops directly
Date: Tue, 01 Mar 2016 21:31:09 +0100
Message-ID: <43764978.ST0U01oqaW@wuerfel>
In-Reply-To: <201603020228.jios50eU%fengguang.wu@intel.com>
References: <201603020228.jios50eU%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Wednesday 02 March 2016 02:37:14 kbuild test robot wrote:
> [auto build test ERROR on abelloni/rtc-next]
> [also build test ERROR on v4.5-rc6 next-20160301]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Arnd-Bergmann/rtc-generic-follow-up-for-COMPILE_TEST/20160302-011032
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
> config: powerpc-allnoconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=powerpc 
> 
> All errors (new ones prefixed by >>):
> 
>    arch/powerpc/kernel/built-in.o: In function `rtc_generic_get_time':
> >> time.c:(.text+0x4c58): undefined reference to `rtc_valid_tm'
> 

I fixed up the powerpc and parisc patches now, will resend them
after getting some feedback on the overall approach.

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
