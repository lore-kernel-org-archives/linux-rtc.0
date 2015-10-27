Return-Path: <rtc-linux+bncBDS7HNEFSALRB55QX2YQKGQE7LNAAAI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id h1si284213wiy.0.2015.10.27.08.29.59
        for <rtc-linux@googlegroups.com>;
        Tue, 27 Oct 2015 08:29:59 -0700 (PDT)
Date: Tue, 27 Oct 2015 16:29:58 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] Re: where in sysfs should I put the ability to power
 down a board for a specific time?
Message-ID: <20151027152958.GE22331@piout.net>
References: <CAJ+vNU3V-i2uJTpyE_swqjCvjVr+-j1+jjp+WuZLDA8Os74y=g@mail.gmail.com>
 <20151020212127.GA25882@earth>
 <20151024021211.GA8105@piout.net>
 <CAJ+vNU1vH2kr5snXiO2dCLcw=DViNLBtwxqsiAM4-xpMhu9w0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAJ+vNU1vH2kr5snXiO2dCLcw=DViNLBtwxqsiAM4-xpMhu9w0w@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 27/10/2015 at 07:55:28 -0700, Tim Harvey wrote :
> The power-off process is a discrete step from setting the wakeup time.
> By 'poweroff controller' I'm assuming you mean implement a
> pm_power_off hook which makes sense.
> 
> While I'm at it it seems like implementing arm_pm_restart makes a lot
> of sense as well as the device can toggle board power which should be
> preferred over a chip-level reset.
> 

Sure, then you can probably make an MFD which is the proper way of
register one device in multiple susbsytems. I just happened to give a
talk on that topic:

http://free-electrons.com/pub/conferences/2015/elce/belloni-mfd-regmap-syscon/belloni-mfd-regmap-syscon.pdf

> I was looking for a standard userspace sysfs API in (ie
> /sys/class/power?) that will call kernel_restart or kernel_power_off
> but the only thing I've found is either the reboot syscall or sysrq (o
> or b). Have I missed something or are these the expected userspace
> API's for power-off/reset?

Yeah, I'm guessing this is the correct API, people usually use
halt/poweroff/shutdown/reboot which should all end up calling the reboot
system call.


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
