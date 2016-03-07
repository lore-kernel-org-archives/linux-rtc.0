Return-Path: <rtc-linux+bncBC36JT6HRIDRBEHG663AKGQEF4GW2NY@googlegroups.com>
Received: from resqmta-ch2-11v.sys.comcast.net (resqmta-ch2-11v.sys.comcast.net. [2001:558:fe21:29:69:252:207:43])
        by gmr-mx.google.com with ESMTPS id nt4si882893igb.2.2016.03.07.13.30.56
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 07 Mar 2016 13:30:56 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH] rtc: ds1685: actually spin forever in
 poweroff error path
To: Josh Poimboeuf <jpoimboe@redhat.com>,
 Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <201603060005.PHCyifJr%fengguang.wu@intel.com>
 <25c2e99dc116c666a05e641082a2690c05c09a23.1457362965.git.jpoimboe@redhat.com>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
 kbuild test robot <fengguang.wu@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Linux/MIPS <linux-mips@linux-mips.org>
From: Joshua Kinard <kumba@gentoo.org>
Message-ID: <56DDF30A.70505@gentoo.org>
Date: Mon, 7 Mar 2016 16:30:50 -0500
MIME-Version: 1.0
In-Reply-To: <25c2e99dc116c666a05e641082a2690c05c09a23.1457362965.git.jpoimboe@redhat.com>
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

On 03/07/2016 10:03, Josh Poimboeuf wrote:
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

So this power down trick is used by both SGI O2 (IP32) and SGI Octane (IP30)
systems via this RTC chip, and I've noticed lately that the Octane has stopped
powering off via this function (it just sits and spins forever).  The O2 powers
off as expected.  When I initially wrote this driver from the original version
I found on LKML in '09, I hadn't gotten the Octane code back into a working
shape, and once that happened, I only tested the non-SMP case (fixed Octane SMP
in 4.1).  I suspect on the Octane, the use of SMP may be what is interfering
somehow, and this bug may partially explain it.  This patch doesn't fix
poweroff for me, but it's something to start from when I can get some time to
chase it down.

That said, I initially left the 'while (1);' clause out because at one point
during development, gcc yelled at me for using that at the end of the function,
so I looked at some other drivers and saw the use of 'unreachable();' and used
it instead.  Wasn't aware both of them are needed together in this instance.  I
thought 'unreachable()' evaluated out to a 'while (1)' at the end.  Seems to
actually be some kind of internal gcc trick.

How exactly did the kbuild bot trigger the above warnings?  I've only built and
tested this driver on a MIPS platform and haven't seen that particular warning
before.


> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  drivers/rtc/rtc-ds1685.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
> index 08e0ff8..1e6cfc8 100644
> --- a/drivers/rtc/rtc-ds1685.c
> +++ b/drivers/rtc/rtc-ds1685.c
> @@ -2161,6 +2161,7 @@ ds1685_rtc_poweroff(struct platform_device *pdev)
>  	/* Check for valid RTC data, else, spin forever. */
>  	if (unlikely(!pdev)) {
>  		pr_emerg("platform device data not available, spinning forever ...\n");
> +		while(1);
>  		unreachable();
>  	} else {
>  		/* Get the rtc data. */
> 


-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic

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
