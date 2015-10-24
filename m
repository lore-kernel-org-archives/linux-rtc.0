Return-Path: <rtc-linux+bncBDS7HNEFSALRB7GRVOYQKGQEPL7Y7PA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id c7si184306wiy.3.2015.10.23.19.12.11
        for <rtc-linux@googlegroups.com>;
        Fri, 23 Oct 2015 19:12:11 -0700 (PDT)
Date: Sat, 24 Oct 2015 04:12:11 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Tim Harvey <tharvey@gateworks.com>, linux-pm@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] Re: where in sysfs should I put the ability to power
 down a board for a specific time?
Message-ID: <20151024021211.GA8105@piout.net>
References: <CAJ+vNU3V-i2uJTpyE_swqjCvjVr+-j1+jjp+WuZLDA8Os74y=g@mail.gmail.com>
 <20151020212127.GA25882@earth>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20151020212127.GA25882@earth>
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

On 20/10/2015 at 23:21:27 +0200, Sebastian Reichel wrote :
> Hi,
> 
> On Tue, Oct 20, 2015 at 08:12:09AM -0700, Tim Harvey wrote:
> > There is a system controller [1] on a set of embedded boards I support
> > that allows disabling the board's primary power supply. It can disable
> > it (until a physical pushbutton event occurs) and/or disable it for a
> > certain number of seconds (up to 2^16 seconds).
> > 
> > I've been in the process of writing a mfd driver to fully support this
> > device and I'm a bit stumped on how to handle the power management
> > capabilities.
> > 
> > What is the correct API for this type of device in sysfs? I'm thinking
> > it needs a power-supply class driver, but after looking over the docs
> > and code I'm not seeing examples of similar devices. Can anyone point
> > me to an example or provide some suggestions?
> 
> Usually this is an RTC feature exposed as wakealarm. See for example
> this article for the description of the userspace interface:
> 
> https://www.linux.com/learn/docs/672849-wake-up-linux-with-an-rtc-alarm-clock

Indeed, if you can set the time, then shutdown in two discreet steps,
then you can probably expose an alarm and a poweroff controller.
If there is only one step involved, then this will not fit well in any
subsystem but I guess it makes more sense to put it in the RTC
subsystem as it has all the utilities to handle dates and times.



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
