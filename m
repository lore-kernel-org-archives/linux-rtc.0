Return-Path: <rtc-linux+bncBD5JBXNRWUBRBYNAX2YQKGQE4O3JG2I@googlegroups.com>
Received: from mail-ob0-x22b.google.com (mail-ob0-x22b.google.com. [2607:f8b0:4003:c01::22b])
        by gmr-mx.google.com with ESMTPS id c8si112866igo.0.2015.10.27.07.55.28
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2015 07:55:28 -0700 (PDT)
Received: by mail-ob0-x22b.google.com with SMTP id za9so54365674obb.1
        for <rtc-linux@googlegroups.com>; Tue, 27 Oct 2015 07:55:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20151024021211.GA8105@piout.net>
References: <CAJ+vNU3V-i2uJTpyE_swqjCvjVr+-j1+jjp+WuZLDA8Os74y=g@mail.gmail.com>
	<20151020212127.GA25882@earth>
	<20151024021211.GA8105@piout.net>
Date: Tue, 27 Oct 2015 07:55:28 -0700
Message-ID: <CAJ+vNU1vH2kr5snXiO2dCLcw=DViNLBtwxqsiAM4-xpMhu9w0w@mail.gmail.com>
Subject: Re: [rtc-linux] Re: where in sysfs should I put the ability to power
 down a board for a specific time?
From: Tim Harvey <tharvey@gateworks.com>
To: Sebastian Reichel <sre@kernel.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-pm@vger.kernel.org, rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Fri, Oct 23, 2015 at 7:12 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Hi,
>
> On 20/10/2015 at 23:21:27 +0200, Sebastian Reichel wrote :
>> Hi,
>>
>> On Tue, Oct 20, 2015 at 08:12:09AM -0700, Tim Harvey wrote:
>> > There is a system controller [1] on a set of embedded boards I support
>> > that allows disabling the board's primary power supply. It can disable
>> > it (until a physical pushbutton event occurs) and/or disable it for a
>> > certain number of seconds (up to 2^16 seconds).
>> >
>> > I've been in the process of writing a mfd driver to fully support this
>> > device and I'm a bit stumped on how to handle the power management
>> > capabilities.
>> >
>> > What is the correct API for this type of device in sysfs? I'm thinking
>> > it needs a power-supply class driver, but after looking over the docs
>> > and code I'm not seeing examples of similar devices. Can anyone point
>> > me to an example or provide some suggestions?
>>
>> Usually this is an RTC feature exposed as wakealarm. See for example
>> this article for the description of the userspace interface:
>>
>> https://www.linux.com/learn/docs/672849-wake-up-linux-with-an-rtc-alarm-clock

Sebastian,

Thanks for the pointer - this device does have an RTC so the wakealarm
makes complete sense here.

>
> Indeed, if you can set the time, then shutdown in two discreet steps,
> then you can probably expose an alarm and a poweroff controller.
> If there is only one step involved, then this will not fit well in any
> subsystem but I guess it makes more sense to put it in the RTC
> subsystem as it has all the utilities to handle dates and times.
>
>

Alexandre,

The power-off process is a discrete step from setting the wakeup time.
By 'poweroff controller' I'm assuming you mean implement a
pm_power_off hook which makes sense.

While I'm at it it seems like implementing arm_pm_restart makes a lot
of sense as well as the device can toggle board power which should be
preferred over a chip-level reset.

I was looking for a standard userspace sysfs API in (ie
/sys/class/power?) that will call kernel_restart or kernel_power_off
but the only thing I've found is either the reboot syscall or sysrq (o
or b). Have I missed something or are these the expected userspace
API's for power-off/reset?

Thanks!

Tim

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
