Return-Path: <rtc-linux+bncBDS7HNEFSALRBUUGWG5AKGQEG3H6O2I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id a65si952021wma.3.2016.05.30.06.42.42
        for <rtc-linux@googlegroups.com>;
        Mon, 30 May 2016 06:42:42 -0700 (PDT)
Date: Mon, 30 May 2016 15:42:41 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [abelloni:rtc-testing 2/17] include/linux/printk.h:375:9:
 error: type defaults to 'int' in declaration of 'DEFINE_RATELIMIT_STATE'
Message-ID: <20160530134241.GX3451@piout.net>
References: <201605300959.yAdCexQ0%fengguang.wu@intel.com>
 <11302444.RbnVRHuxj4@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <11302444.RbnVRHuxj4@wuerfel>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 30/05/2016 at 15:30:58 +0200, Arnd Bergmann wrote :
> On Monday, May 30, 2016 9:06:03 AM CEST kbuild test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-testing
> > head:   1a4cab5badddc8b5e0c5bf7eaaddcb6296c8d926
> > commit: a3829b4602bb384f1d6c3b427c5b53c5b23c5ca0 [2/17] rtc: cmos: move mc146818rtc code out of asm-generic/rtc.h
> > config: i386-alldefconfig (attached as .config)
> > compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
> > reproduce:
> >         git checkout a3829b4602bb384f1d6c3b427c5b53c5b23c5ca0
> >         # save the attached .config to linux build tree
> >         make ARCH=i386 
> > 
> 
> I've run into the same one and fixed it up locally. I don't think there were
> any other issues I noticed, so see below for the replacement patch.
> 
> Alexandre, let me know if you'd prefer me to post the whole series
> again instead.
> 

Well, I think the plan was to send v4 and include GKH in the Cc list so
that he could maybe put some acks.

There is also the mn10300 one:
arch/mn10300/proc-mn103e010/proc-init.c:54:2: error: implicit
declaration of function 'mn10300_dcache_flush_inv'

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
