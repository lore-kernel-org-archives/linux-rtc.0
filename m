Return-Path: <rtc-linux+bncBDS7HNEFSALRBFEHVCXAKGQEMFDZOMA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id jv9si431218wid.0.2015.08.11.07.15.48
        for <rtc-linux@googlegroups.com>;
        Tue, 11 Aug 2015 07:15:48 -0700 (PDT)
Date: Tue, 11 Aug 2015 16:15:47 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Adrian Huang <ahuang12@lenovo.com>,
	Egbert Eich <eich@suse.de>,
	Diego Ercolani <diego.ercolani@gmail.com>,
	Borislav Petkov <bp@suse.de>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] drivers/rtc: fix compile warning introduced
 by 1s reboot fix
Message-ID: <20150811141547.GP3411@piout.net>
References: <1439301844-22710-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1439301844-22710-1-git-send-email-paul.gortmaker@windriver.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi Paul,

On 11/08/2015 at 10:04:04 -0400, Paul Gortmaker wrote :
> We currently see this warning:
> 
> drivers/rtc/rtc-cmos.c:851:7: warning: unused variable 'err'
> 
> introduced by commit 7b4a008088a28ea936fffbbfa770d0184468a0ce ("rtc-cmos:
> Cancel alarm timer if alarm time is equal to now+1 seconds").
> 
> Presumably some WIP version of the commit was doing error checking
> but then the variable was not removed prior to submission, and the
> pending commits weren't on kernel.org for kbuild bot to spot the new
> warning created.
> 
> Cc: Adrian Huang <ahuang12@lenovo.com>
> Cc: Egbert Eich <eich@suse.de>
> Cc: Diego Ercolani <diego.ercolani@gmail.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: rtc-linux@googlegroups.com
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> 
> [Note: patch is against linux-next, so if the rtc tree is rebased,
>  then the above commit ID reference will be stale.  Feel free to
>  adjust the commit log appropriately, if need be, or even squash
>  this into the original offending patch, if rebasing back that far.
>  Also ensuring your tree is on kernel.org will allow kbuild bot
>  to spot these on your behalf via the zero day builds.]
> 

I'm pretty sure my rtc-next branch on kernel.org already carry the fix.
I fixed it on monday: 2015-08-10 07:12:44 (GMT). It just seems that
linux-next has not been updated since then.

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
