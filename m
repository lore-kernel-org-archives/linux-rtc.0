Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBH53X3CQKGQEMQLYYTA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id v70si37394wmf.0.2017.02.23.18.42.39
        for <rtc-linux@googlegroups.com>;
        Thu, 23 Feb 2017 18:42:39 -0800 (PST)
Date: Fri, 24 Feb 2017 03:42:38 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Phil Reid <preid@electromag.com.au>
Cc: a.zummo@towertech.it, akinobu.mita@gmail.com,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 3/3] rtc: ds3232: Call device_init_wakeup
 before device_register
Message-ID: <20170224024238.qp52wunvvy66ra2z@piout.net>
References: <1487295898-90177-1-git-send-email-preid@electromag.com.au>
 <1487295898-90177-4-git-send-email-preid@electromag.com.au>
 <20170221203305.mkcqv3g4wbbm5js6@piout.net>
 <444215ad-ff7e-b5e2-85d8-58edf3ffddcf@electromag.com.au>
 <20170224014609.a3labrbe6bzwcztg@piout.net>
 <8bde3c28-d99d-07c6-1cdf-ff6a4db683b3@electromag.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <8bde3c28-d99d-07c6-1cdf-ff6a4db683b3@electromag.com.au>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 24/02/2017 at 10:32:40 +0800, Phil Reid wrote:
> On 24/02/2017 09:46, Alexandre Belloni wrote:
> > On 22/02/2017 at 09:33:14 +0800, Phil Reid wrote:
> > > On 22/02/2017 04:33, Alexandre Belloni wrote:
> > > > On 17/02/2017 at 09:44:58 +0800, Phil Reid wrote:
> > > > > The wakealarm attribute is currently not exposed in the sysfs interface
> > > > > as the device has not been set as doing wakealarm when device_register
> > > > > is called. Changing the order of the calls fixes that problem. Interrupts
> > > > > are cleared in check_rtc_status prior to requesting the interrupt.
> > > > > 
> > > > 
> > > > This basically revert b4b77f3c280e38cec178f81d7a4d7e65f4045913 So I'm
> > > > not sure this is sufficient to ensure the IRQ will never fire.
> > > > 
> > > > (I don't know whether this was a real bug or something reported by a
> > > > static analysis tool).
> > > 
> > > G'day Alexandre,
> > > Without this change the wakealarm sysfs is never created.
> > > This is done in rtc_device_register, but a filter to wakealarm attribute effectively on
> > > dev->power.can_wakeup flag. Which is set via the init wakeup call.
> > > 
> > > But looking at that commit and thinking about it some more I can see the problem
> > > b4b77f3c280e38cec178f81d7a4d7e65f4045913 was try to solve.
> > > 
> > > Looking at other drivers some of them have similar order but use their own mutex.
> > > eg rtc-rc8803 and don't use the ops_lock
> > > 
> > > Or others set device_init_wakeup and then fail if the irq fails to register.
> > > 
> > > Currently if the ds3232 has an irq set but fails to register the irq it falls back
> > > to being a non wakeup source. To me it makes more sense to just fall if the config
> > > has an irq defined.
> > > 
> > > Then we could set device_init_wakeup based on there being an irq prior to device_register
> > > and then request the irq after device register. But fail the probe if the irq request fails.
> > > 
> > > Thoughts?
> > > 
> > 
> > I think you can use device_set_wakeup_capable() afterwards which would
> > fit this use case. Can you try that?
> > 
> > Anyway, I have a pending rework of the rtc registration that will solve
> > this issue (and the sysfs attribute creation race).
> > 
> Nope, doesn't help.
> device_init_wakeup already calls device_set_wakeup_capable.
> 
> rtc_attr_groups is fetched via rtc_get_dev_attribute_groups
> and assigned to the rtc->dev.groups in rtc_device_register
> The is_visible callback checks device_can_wakeup.
> And this is not set until after device creation.
> 
> Is there a way to retrigger the sysfs groups creation after device
> registration? Thou this would result in sysfs attrib. races I guess.
> 
> Failing to probe when irq requested seems the easiest.
> Would anyone want the irq registration to fail but device creation succeed if requested?
> 

Yes because th RTC is still functional and can give the time (and that
may break userspace).

What you can do is call device_init_wakeup before registering the rtc
and then device_set_wakeup_capable(&client->dev, false); if the irq
request fails.


> -- 
> Regards
> Phil Reid
> 

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
