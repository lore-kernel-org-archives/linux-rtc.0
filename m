Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBYVAX3CQKGQEQR3XZYA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id v70si26316wmf.0.2017.02.23.17.46.09
        for <rtc-linux@googlegroups.com>;
        Thu, 23 Feb 2017 17:46:09 -0800 (PST)
Date: Fri, 24 Feb 2017 02:46:09 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Phil Reid <preid@electromag.com.au>
Cc: a.zummo@towertech.it, akinobu.mita@gmail.com,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 3/3] rtc: ds3232: Call device_init_wakeup
 before device_register
Message-ID: <20170224014609.a3labrbe6bzwcztg@piout.net>
References: <1487295898-90177-1-git-send-email-preid@electromag.com.au>
 <1487295898-90177-4-git-send-email-preid@electromag.com.au>
 <20170221203305.mkcqv3g4wbbm5js6@piout.net>
 <444215ad-ff7e-b5e2-85d8-58edf3ffddcf@electromag.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <444215ad-ff7e-b5e2-85d8-58edf3ffddcf@electromag.com.au>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 22/02/2017 at 09:33:14 +0800, Phil Reid wrote:
> On 22/02/2017 04:33, Alexandre Belloni wrote:
> > On 17/02/2017 at 09:44:58 +0800, Phil Reid wrote:
> > > The wakealarm attribute is currently not exposed in the sysfs interface
> > > as the device has not been set as doing wakealarm when device_register
> > > is called. Changing the order of the calls fixes that problem. Interrupts
> > > are cleared in check_rtc_status prior to requesting the interrupt.
> > > 
> > 
> > This basically revert b4b77f3c280e38cec178f81d7a4d7e65f4045913 So I'm
> > not sure this is sufficient to ensure the IRQ will never fire.
> > 
> > (I don't know whether this was a real bug or something reported by a
> > static analysis tool).
> 
> G'day Alexandre,
> Without this change the wakealarm sysfs is never created.
> This is done in rtc_device_register, but a filter to wakealarm attribute effectively on
> dev->power.can_wakeup flag. Which is set via the init wakeup call.
> 
> But looking at that commit and thinking about it some more I can see the problem
> b4b77f3c280e38cec178f81d7a4d7e65f4045913 was try to solve.
> 
> Looking at other drivers some of them have similar order but use their own mutex.
> eg rtc-rc8803 and don't use the ops_lock
> 
> Or others set device_init_wakeup and then fail if the irq fails to register.
> 
> Currently if the ds3232 has an irq set but fails to register the irq it falls back
> to being a non wakeup source. To me it makes more sense to just fall if the config
> has an irq defined.
> 
> Then we could set device_init_wakeup based on there being an irq prior to device_register
> and then request the irq after device register. But fail the probe if the irq request fails.
> 
> Thoughts?
> 

I think you can use device_set_wakeup_capable() afterwards which would
fit this use case. Can you try that?

Anyway, I have a pending rework of the rtc registration that will solve
this issue (and the sysfs attribute creation race).

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
