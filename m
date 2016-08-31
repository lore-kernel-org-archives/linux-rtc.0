Return-Path: <rtc-linux+bncBCL4FNGB7UHBBWHETO7AKGQEKHSDFLI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x230.google.com (mail-wm0-x230.google.com. [2a00:1450:400c:c09::230])
        by gmr-mx.google.com with ESMTPS id w64si1265813wmf.3.2016.08.31.08.06.00
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2016 08:06:00 -0700 (PDT)
Received: by mail-wm0-x230.google.com with SMTP id w207so5090246wmw.1
        for <rtc-linux@googlegroups.com>; Wed, 31 Aug 2016 08:06:00 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH 1/2] rtc-cmos: Clear expired alarm after resume
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1464795615-7748-1-git-send-email-gabriele.mzt@gmail.com>
 <20160604144626.GM4594@piout.net>
 <CABFtUbQ7OWChggMPxYfpUeVCdTTtM74YpkqTF3--RT+wWkPoWQ@mail.gmail.com>
 <20160604174854.GN4594@piout.net>
 <8f29ddb1-aaf9-9769-536e-d748eb22ed67@gmail.com>
 <20160830232813.fvbfyeltgwjwzqtv@piout.net>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 matthew.garrett@nebula.com
From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Message-ID: <4b934eae-d887-343c-c560-72cc6887d368@gmail.com>
Date: Wed, 31 Aug 2016 17:05:58 +0200
MIME-Version: 1.0
In-Reply-To: <20160830232813.fvbfyeltgwjwzqtv@piout.net>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 31/08/2016 01:28, Alexandre Belloni wrote:
> Hi,
> 
> On 25/08/2016 at 16:54:18 +0200, Gabriele Mazzotta wrote :
>> Hi,
>>
>> were you able to verify that no other driver is affect?
>>
> 
> I had a closer look at the issue. I think what is happening is that you
> don't enter the do/while loop in cmos_resume twice. That is supposed to
> handle then clear the RTC_AIE bit and that is why the alarm still seems
> enabled.
> 
> Can you add some tracing there to understand why? It is probably also
> useful to know the value of cmos->suspend_ctrl in cmos_suspend.

cmos->suspend_ctrl is 0x2 when no alarm is set, 0x22 otherwise.
The only way to clear RTC_AIE is to set an alarm and wait for it to
expire while the system is awake.

> My guess is that is_intr(mask) is false and you break out of the loop at
> the first pass, meaning that the RTC_AIE bit is never cleared from
> RTC_CONTROL. That would also mean that your RTC is not setting RTC_AF
> after waking your PC. Am I right?

You are right, is_intr(mask) is false and now I see where the problem is.

I thought cmos_interrupt() was taking care of everything, but I've just
noticed that it's executed only when the system is awake. That's because
cmos->wake_on is not NULL, so enable_irq_wake() is not called.

However, not even rtc_handler() is called, so I guess the BIOS silently
wakes the system when an alarm expires while suspended. This means that
we can't update RTC_CONTROL from rtc_handler() and that we have to do it
from cmos_resume().

There's a problem with this. We don't know whether the system is waking up
because of an alarm or because the user resumed it. In both cases RTC_AIE
is set.

One way to solve this problem is to manually check from cmos_resume() if
any alarm expired while suspended. If we find such an alarm, we don't
break early out of the loop and let it clear the flags.

Is this reasonable?

> Regards,
> 

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
