Return-Path: <rtc-linux+bncBDS7HNEFSALRBJHTQ63QKGQE7YQKZXY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id a126si5273wmd.2.2016.03.10.14.48.03
        for <rtc-linux@googlegroups.com>;
        Thu, 10 Mar 2016 14:48:03 -0800 (PST)
Date: Thu, 10 Mar 2016 23:48:01 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Joshua Kinard <kumba@gentoo.org>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	kbuild test robot <fengguang.wu@intel.com>,
	Ingo Molnar <mingo@kernel.org>
Subject: [rtc-linux] Re: [PATCH] rtc: ds1685: actually spin forever in
 poweroff error path
Message-ID: <20160310224801.GP9868@piout.net>
References: <201603060005.PHCyifJr%fengguang.wu@intel.com>
 <25c2e99dc116c666a05e641082a2690c05c09a23.1457362965.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <25c2e99dc116c666a05e641082a2690c05c09a23.1457362965.git.jpoimboe@redhat.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 07/03/2016 at 09:03:02 -0600, Josh Poimboeuf wrote :
> objtool reports the following warnings:
> 
>   drivers/rtc/rtc-ds1685.o: warning: objtool: ds1685_rtc_work_queue()+0x0: duplicate frame pointer save
>   drivers/rtc/rtc-ds1685.o: warning: objtool: ds1685_rtc_work_queue()+0x3: duplicate frame pointer setup
>   drivers/rtc/rtc-ds1685.o: warning: objtool: ds1685_rtc_work_queue()+0x0: frame pointer state mismatch
> 
> The warning message needs to be improved, but what it really means in
> this case is that ds1685_rtc_poweroff() has a possible code path where
> it can actually fall through to the next function in the object code,
> ds1685_rtc_work_queue().
> 
> The bug is caused by the use of the unreachable() macro in a place which
> is actually reachable.  That causes gcc to assume that the printk()
> immediately before the unreachable() macro never returns, when in fact
> it does.  So gcc places the printk() at the very end of the function's
> object code.  When the printk() returns, the next function starts
> executing.
> 
> The surrounding comment and printk message state that the code should
> spin forever, which explains the unreachable() statement.  However the
> actual spin code is missing.
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  drivers/rtc/rtc-ds1685.c | 1 +
>  1 file changed, 1 insertion(+)
> 
Applied, thanks.

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
