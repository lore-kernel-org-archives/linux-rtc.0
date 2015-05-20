Return-Path: <rtc-linux+bncBCAJFDXE4QGBBY436CVAKGQEEUBTZYI@googlegroups.com>
Received: from mail-wi0-x233.google.com (mail-wi0-x233.google.com. [2a00:1450:400c:c05::233])
        by gmr-mx.google.com with ESMTPS id p9si38713wiz.3.2015.05.19.21.30.27
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2015 21:30:27 -0700 (PDT)
Received: by mail-wi0-x233.google.com with SMTP id hy4so45434212wic.1
        for <rtc-linux@googlegroups.com>; Tue, 19 May 2015 21:30:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150518220542.GW3338@piout.net>
References: <1431077706-3560-1-git-send-email-adrianhuang0701@gmail.com>
	<20150518220542.GW3338@piout.net>
Date: Wed, 20 May 2015 12:30:27 +0800
Message-ID: <CAHKZfL2+PKCzYcmL-XHC-33aXQ0hjZqOYLbbgN8O0sTvOFTj0A@mail.gmail.com>
Subject: [rtc-linux] Re: [RFC PATCH 2/2] rtc: Restore the RTC alarm time to
 the configured alarm time in BIOS Setup
From: Huang Adrian <adrianhuang0701@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	Brecht Machiels <brecht@mos6581.org>, Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <john.stultz@linaro.org>, Rabin Vincent <rabin.vincent@stericsson.com>,
	Borislav Petkov <bp@suse.de>, Nagananda Chumbalkar <nchumbalkar@lenovo.com>, Adrian Huang <ahuang12@lenovo.com>
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

Hi,
> Hi,
>
> On 08/05/2015 at 17:35:06 +0800, Adrian Huang wrote :
>> Steps to reproduce the problem:
>>       1) Enable RTC wake-up option in BIOS Setup
>>       2) Issue one of these commands in the OS: "poweroff"
>>          or "shutdown -h now"
>>       3) System will shut down and then reboot automatically
>>
>> Root-cause of the issue:
>>       1) During the shutdown process, the hwclock utility is used
>>          to save the system clock to hardware clock (RTC).
>>       2) The hwclock utility invokes ioctl() with RTC_UIE_ON. The
>>          kernel configures the RTC alarm for the periodic interrupt
>>          (every 1 second).
>>       3) The hwclock uitlity closes the /dev/rtc0 device, and the
>>          kernel disables the RTC alarm irq (AIE bit of Register B)
>>          via ioctl() with RTC_UIE_OFF. But, the configured alarm
>>          time is the current_time + 1.
>>       4) After the next 1 second is elapsed, the AF (alarm
>>          interrupt flag) of Register C is set.
>>       5) The S5 handler in BIOS is invoked to configure alarm
>>          registers (enable AIE bit and configure alarm date/time).
>>          But, BIOS does not clear the previous interrupt status
>>          during alarm configuration. Therefore, "AF=AIE=1" causes
>>          the rtc device to trigger an interrupt.
>>       6) So, the machine reboots automatically right after shutdown.
>>
>> This patch restores the configured alarm time (user configures the
>> time in BIOS Setup) to rtc alarm registers. In some circumstances,
>> the time of the rtc alarm registers is the past time because
>> user-space programs (for example: hwclock) may invoke ioctl() with
>> RTC_UIE_ON. In any case, this patch prevents the AF bit from getting
>> set to 1. Note, AF=1 will cause the system to reboot after shut down.
>> Therefore, this patch fixes the issue from occurring.
>>
>
> Actually, I'm not sure that solves your issue. From what I
> understand, what is happening in step 4 is the bug you want to work
> around and it happens because AF gets set even if AIE is not set.
>

Yes.

> So, your rtc_alarm_restore() basically calls cmos_set_alarm() which
> calls cmos_irq_disable() finally this one calls cmos_checkintr() which
> does read register C and so clears AF.
>

The call path is correct. cmos_checkintr() did clear interrupt flags. But,
the problem is that AF is set in the next one second.

Assume 'n' is the current time.

1) The call path is finished at 'n' (current time). It clears the
interrupt flags.
2) At n + 1, AF is set because the HW alarm time is programmed at n +1.

This leads to the problem.

> What I'm not sure is why cmos_do_shutdown() isn't clearing AF properly.
> Is it correctly called at shutdown?
>

The function cmos_pnp_shutdown() simply returns because
cmos_poweroff() always returns 0 (CONFIG_PM and CONFIG_PNP are
set). The cmos_do_shutdown() is not invoked at shutdown. We did not
get a chance to clear interrupt flag. Here is the callpath:

kernel_restart_prepare() -> device_shutdown() -> cmos_pnp_shutdown()

[Experiment 1 - SLES11 SP3 with upstream kernel (without my patch)]
The revised code in cmos_pnp_shutdown() is shown as follows. It
ensures that cmos_do_shutdown() is invoked, which gets the last chance
to clear the interrupt flag before powering off the machine.

#if 0
        if (system_state == SYSTEM_POWER_OFF && !cmos_poweroff(dev))
                return;
#endif
        cmos_poweroff(dev);


The issue can be still reproduced. This implies that the time cost
between hwclock and cmos_do_shutdown() is within one second.
So, AF is not set yet.

[Experiment 2 - SLES11 SP3 with upstream kernel (without my patch)]
Still apply the code snippet in Experiment 1. The system stayed
power off when I intentionally added 'sleep 3' command in the end of
the 'stop' service of /etc/init.d/boot.clock (This script uses the
hwclock utility to set hardware clock
to the current system time). This proves that cmos_do_shutdown()
clears AF generated by RTC HW.

The system always stayed power off with 10-time shutdown tests.

[Experiment 3 - SLES11 SP3 with upstream kernel (without my patch)]
Do not apply the code snippet in Experiment 1. Also added 'sleep 3'
command in the end of the 'stop' service of /etc/init.d/boot.clock.
The issue can be reproduced. This proves that cmos_pnp_shutdown()
simply returns without invoking cmos_do_shutdown(). So, AF is not
cleared.

Experiments 1-3 show that the issue happens if the time cost
between hwclock and cmos_do_shutdown() is within one second.
If we want to clear the interrupt flag for every shutdown, we need
to re-write the cmos_pnp_shutdown() to ensure the
cmos_do_shutdown() is invoke for every shutdown.

Although my patch can work around the issue, kindly let me know
if you want to re-work cmos_pnp_shutdown(). We can come out a
better way to invoke cmos_do_shutdown() for every shutdown. But,
be remember, the issue still happens even though we make sure
cmos_do_shutdown() is invoked for every shutdown. The problem
is the one second interval.

-- Adrian

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
