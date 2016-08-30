Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBDVNTC7AKGQE4ZGRWZY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id i198si754025wmd.2.2016.08.30.16.28.13
        for <rtc-linux@googlegroups.com>;
        Tue, 30 Aug 2016 16:28:13 -0700 (PDT)
Date: Wed, 31 Aug 2016 01:28:13 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	matthew.garrett@nebula.com
Subject: [rtc-linux] Re: [PATCH 1/2] rtc-cmos: Clear expired alarm after resume
Message-ID: <20160830232813.fvbfyeltgwjwzqtv@piout.net>
References: <1464795615-7748-1-git-send-email-gabriele.mzt@gmail.com>
 <20160604144626.GM4594@piout.net>
 <CABFtUbQ7OWChggMPxYfpUeVCdTTtM74YpkqTF3--RT+wWkPoWQ@mail.gmail.com>
 <20160604174854.GN4594@piout.net>
 <8f29ddb1-aaf9-9769-536e-d748eb22ed67@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <8f29ddb1-aaf9-9769-536e-d748eb22ed67@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 25/08/2016 at 16:54:18 +0200, Gabriele Mazzotta wrote :
> Hi,
> 
> were you able to verify that no other driver is affect?
> 

I had a closer look at the issue. I think what is happening is that you
don't enter the do/while loop in cmos_resume twice. That is supposed to
handle then clear the RTC_AIE bit and that is why the alarm still seems
enabled.

Can you add some tracing there to understand why? It is probably also
useful to know the value of cmos->suspend_ctrl in cmos_suspend.

My guess is that is_intr(mask) is false and you break out of the loop at
the first pass, meaning that the RTC_AIE bit is never cleared from
RTC_CONTROL. That would also mean that your RTC is not setting RTC_AF
after waking your PC. Am I right?

Regards,

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
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
