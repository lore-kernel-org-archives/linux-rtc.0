Return-Path: <rtc-linux+bncBCSJ7B6JQALRBQ4I7C3AKGQEI444WDI@googlegroups.com>
Received: from mx1.redhat.com (mx1.redhat.com. [209.132.183.28])
        by gmr-mx.google.com with ESMTPS id y131si1179992ywc.0.2016.03.07.14.44.19
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Mar 2016 14:44:19 -0800 (PST)
Date: Mon, 7 Mar 2016 16:44:15 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Joshua Kinard <kumba@gentoo.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        kbuild test robot <fengguang.wu@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Linux/MIPS <linux-mips@linux-mips.org>
Subject: [rtc-linux] Re: [PATCH] rtc: ds1685: actually spin forever in
 poweroff error path
Message-ID: <20160307224415.GA8500@treble.redhat.com>
References: <201603060005.PHCyifJr%fengguang.wu@intel.com>
 <25c2e99dc116c666a05e641082a2690c05c09a23.1457362965.git.jpoimboe@redhat.com>
 <56DDF30A.70505@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <56DDF30A.70505@gentoo.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Mon, Mar 07, 2016 at 04:30:50PM -0500, Joshua Kinard wrote:
> On 03/07/2016 10:03, Josh Poimboeuf wrote:
> > objtool reports the following warnings:
> > 
> >   drivers/rtc/rtc-ds1685.o: warning: objtool: ds1685_rtc_work_queue()+0x0: duplicate frame pointer save
> >   drivers/rtc/rtc-ds1685.o: warning: objtool: ds1685_rtc_work_queue()+0x3: duplicate frame pointer setup
> >   drivers/rtc/rtc-ds1685.o: warning: objtool: ds1685_rtc_work_queue()+0x0: frame pointer state mismatch
> > 
> > The warning message needs to be improved, but what it really means in
> > this case is that ds1685_rtc_poweroff() has a possible code path where
> > it can actually fall through to the next function in the object code,
> > ds1685_rtc_work_queue().
> > 
> > The bug is caused by the use of the unreachable() macro in a place which
> > is actually reachable.  That causes gcc to assume that the printk()
> > immediately before the unreachable() macro never returns, when in fact
> > it does.  So gcc places the printk() at the very end of the function's
> > object code.  When the printk() returns, the next function starts
> > executing.
> > 
> > The surrounding comment and printk message state that the code should
> > spin forever, which explains the unreachable() statement.  However the
> > actual spin code is missing.
> 
> So this power down trick is used by both SGI O2 (IP32) and SGI Octane (IP30)
> systems via this RTC chip, and I've noticed lately that the Octane has stopped
> powering off via this function (it just sits and spins forever).  The O2 powers
> off as expected.  When I initially wrote this driver from the original version
> I found on LKML in '09, I hadn't gotten the Octane code back into a working
> shape, and once that happened, I only tested the non-SMP case (fixed Octane SMP
> in 4.1).  I suspect on the Octane, the use of SMP may be what is interfering
> somehow, and this bug may partially explain it.  This patch doesn't fix
> poweroff for me, but it's something to start from when I can get some time to
> chase it down.
> 
> That said, I initially left the 'while (1);' clause out because at one point
> during development, gcc yelled at me for using that at the end of the function,
> so I looked at some other drivers and saw the use of 'unreachable();' and used
> it instead.  Wasn't aware both of them are needed together in this instance.  I
> thought 'unreachable()' evaluated out to a 'while (1)' at the end.  Seems to
> actually be some kind of internal gcc trick.
> 
> How exactly did the kbuild bot trigger the above warnings?  I've only built and
> tested this driver on a MIPS platform and haven't seen that particular warning
> before.

Hi Joshua,

The warning was emitted by a brand new tool named objtool which does
some static object code analysis. It's currently only in linux-next, not
yet in Linus's tree.  To get the warning, you'd need to build the
linux-next tree for x86_64 with CONFIG_STACK_VALIDATION enabled.

Here's the kbuild bot warning:

  https://lkml.kernel.org/r/201603060005.PHCyifJr%fengguang.wu@intel.com


-- 
Josh

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
