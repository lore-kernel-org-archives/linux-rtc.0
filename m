Return-Path: <rtc-linux+bncBDS7HNEFSALRBXVH223AKGQEOCM35DA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id w197si781057wmw.3.2016.03.01.05.06.37
        for <rtc-linux@googlegroups.com>;
        Tue, 01 Mar 2016 05:06:37 -0800 (PST)
Date: Tue, 1 Mar 2016 14:06:37 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-kernel@vger.kernel.org,
	kernel-testers@vger.kernel.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] rtc: rtc-generic: use correct header file
Message-ID: <20160301130637.GG2627@piout.net>
References: <1456836400-10102-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1456836400-10102-1-git-send-email-sudipm.mukherjee@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 01/03/2016 at 18:16:40 +0530, Sudip Mukherjee wrote :
> The allmodconfig build of m32r fails with errors like:
> 
> In file included from drivers/rtc/rtc-generic.c:12:0:
> arch/m32r/include/asm/rtc.h:46:8: error: redefinition of 'struct rtc_time'
> 
> drivers/rtc/rtc-generic.c: In function 'generic_get_time':
> drivers/rtc/rtc-generic.c:16:21: error: implicit declaration of function 'get_rtc_time'
> 
> drivers/rtc/rtc-generic.c:18:12: error: 'RTC_BATT_BAD' undeclared
> 
> drivers/rtc/rtc-generic.c: In function 'generic_set_time':
> drivers/rtc/rtc-generic.c:26:6: error: implicit declaration of function 'set_rtc_time'
> 
> Apart from m32r, many other arch like xtensa, sparc are failing with:
> drivers/rtc/rtc-generic.c:12:21: fatal error: asm/rtc.h: No such file or directory
> 
> Other rtc drivers are using asm-generic/rtc.h, so use it here.
> 
> Fixes: 2a32c792f1c9 ("rtc: enable COMPILE_TEST")
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> ---
> 
> m32r allmodconfig build log is at:
> https://travis-ci.org/sudipm-mukherjee/parport/jobs/112780210
> 
> failure with sparc and xtensa needs more work as after this patch also
> they fail with error about missing file "mc146818rtc.h".
> 

Yeah I'll remove COMPILE_TEST for that driver.


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
