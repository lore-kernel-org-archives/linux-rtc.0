Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBZEBTS7AKGQEEIM76EQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id r74si2515438wme.3.2016.08.31.09.08.03
        for <rtc-linux@googlegroups.com>;
        Wed, 31 Aug 2016 09:08:03 -0700 (PDT)
Date: Wed, 31 Aug 2016 18:08:01 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	matthew.garrett@nebula.com
Subject: [rtc-linux] Re: [PATCH 1/2] rtc-cmos: Clear expired alarm after resume
Message-ID: <20160831160801.a4b7mrzkqbdfnsyp@piout.net>
References: <1464795615-7748-1-git-send-email-gabriele.mzt@gmail.com>
 <20160604144626.GM4594@piout.net>
 <CABFtUbQ7OWChggMPxYfpUeVCdTTtM74YpkqTF3--RT+wWkPoWQ@mail.gmail.com>
 <20160604174854.GN4594@piout.net>
 <8f29ddb1-aaf9-9769-536e-d748eb22ed67@gmail.com>
 <20160830232813.fvbfyeltgwjwzqtv@piout.net>
 <4b934eae-d887-343c-c560-72cc6887d368@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <4b934eae-d887-343c-c560-72cc6887d368@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 31/08/2016 at 17:05:58 +0200, Gabriele Mazzotta wrote :
> On 31/08/2016 01:28, Alexandre Belloni wrote:
> > Hi,
> > 
> > On 25/08/2016 at 16:54:18 +0200, Gabriele Mazzotta wrote :
> >> Hi,
> >>
> >> were you able to verify that no other driver is affect?
> >>
> > 
> > I had a closer look at the issue. I think what is happening is that you
> > don't enter the do/while loop in cmos_resume twice. That is supposed to
> > handle then clear the RTC_AIE bit and that is why the alarm still seems
> > enabled.
> > 
> > Can you add some tracing there to understand why? It is probably also
> > useful to know the value of cmos->suspend_ctrl in cmos_suspend.
> 
> cmos->suspend_ctrl is 0x2 when no alarm is set, 0x22 otherwise.
> The only way to clear RTC_AIE is to set an alarm and wait for it to
> expire while the system is awake.
> 
> > My guess is that is_intr(mask) is false and you break out of the loop at
> > the first pass, meaning that the RTC_AIE bit is never cleared from
> > RTC_CONTROL. That would also mean that your RTC is not setting RTC_AF
> > after waking your PC. Am I right?
> 
> You are right, is_intr(mask) is false and now I see where the problem is.
> 
> I thought cmos_interrupt() was taking care of everything, but I've just
> noticed that it's executed only when the system is awake. That's because
> cmos->wake_on is not NULL, so enable_irq_wake() is not called.
> 
> However, not even rtc_handler() is called, so I guess the BIOS silently
> wakes the system when an alarm expires while suspended. This means that
> we can't update RTC_CONTROL from rtc_handler() and that we have to do it
> from cmos_resume().
> 
> There's a problem with this. We don't know whether the system is waking up
> because of an alarm or because the user resumed it. In both cases RTC_AIE
> is set.
> 
> One way to solve this problem is to manually check from cmos_resume() if
> any alarm expired while suspended. If we find such an alarm, we don't
> break early out of the loop and let it clear the flags.
> 
> Is this reasonable?
> 

Yeah, I think the fix is to clear RTC_AIE in cmos_resume when now >
alarm (same check as in your original patch) after the do/while loop.
Also, you will need to properly handle the "missed" interrupt and call
rtc_update_irq

To be clear, something like:

if (mask & RTC_AIE) {
	...
	if (now > alarm) {
			rtc_update_irq(cmos->rtc, 1, mask);
			tmp &= ~RTC_AIE;
			CMOS_WRITE(tmp, RTC_CONTROL);
	}
}

This limits the impact of the patch as (mask & RTC_AIE) will be false in
the case of a properly functioning RTC.

Don't forget to comment that it is a quirk, possibly mentioning the
maker of the PC and the BIOS.

The other quirk is a bit more complicated than your second fix. You
actually have to read the alarm in cmos_suspend and then compare it with what
you have in cmos_resume. If it has changed and is not expired then you
have to set it back.

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
