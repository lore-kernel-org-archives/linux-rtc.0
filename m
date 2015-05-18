Return-Path: <rtc-linux+bncBDS7HNEFSALRBOGE5GVAKGQE7NTWBYA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id q10si447329wiz.0.2015.05.18.15.05.44
        for <rtc-linux@googlegroups.com>;
        Mon, 18 May 2015 15:05:44 -0700 (PDT)
Date: Tue, 19 May 2015 00:05:42 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Adrian Huang <adrianhuang0701@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	Brecht Machiels <brecht@mos6581.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <john.stultz@linaro.org>,
	Rabin Vincent <rabin.vincent@stericsson.com>,
	Borislav Petkov <bp@suse.de>,
	Nagananda Chumbalkar <nchumbalkar@lenovo.com>,
	Adrian Huang <ahuang12@lenovo.com>
Subject: [rtc-linux] Re: [RFC PATCH 2/2] rtc: Restore the RTC alarm time to
 the configured alarm time in BIOS Setup
Message-ID: <20150518220542.GW3338@piout.net>
References: <1431077706-3560-1-git-send-email-adrianhuang0701@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1431077706-3560-1-git-send-email-adrianhuang0701@gmail.com>
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

On 08/05/2015 at 17:35:06 +0800, Adrian Huang wrote :
> Steps to reproduce the problem:
> 	1) Enable RTC wake-up option in BIOS Setup
> 	2) Issue one of these commands in the OS: "poweroff" 
> 	   or "shutdown -h now"
> 	3) System will shut down and then reboot automatically
> 
> Root-cause of the issue:
> 	1) During the shutdown process, the hwclock utility is used
> 	   to save the system clock to hardware clock (RTC).
> 	2) The hwclock utility invokes ioctl() with RTC_UIE_ON. The
> 	   kernel configures the RTC alarm for the periodic interrupt
> 	   (every 1 second).
> 	3) The hwclock uitlity closes the /dev/rtc0 device, and the
> 	   kernel disables the RTC alarm irq (AIE bit of Register B)
> 	   via ioctl() with RTC_UIE_OFF. But, the configured alarm
> 	   time is the current_time + 1.
> 	4) After the next 1 second is elapsed, the AF (alarm
> 	   interrupt flag) of Register C is set.
> 	5) The S5 handler in BIOS is invoked to configure alarm
> 	   registers (enable AIE bit and configure alarm date/time).
> 	   But, BIOS does not clear the previous interrupt status
> 	   during alarm configuration. Therefore, "AF=AIE=1" causes 
> 	   the rtc device to trigger an interrupt.  
> 	6) So, the machine reboots automatically right after shutdown.
> 
> This patch restores the configured alarm time (user configures the
> time in BIOS Setup) to rtc alarm registers. In some circumstances,
> the time of the rtc alarm registers is the past time because
> user-space programs (for example: hwclock) may invoke ioctl() with
> RTC_UIE_ON. In any case, this patch prevents the AF bit from getting
> set to 1. Note, AF=1 will cause the system to reboot after shut down.
> Therefore, this patch fixes the issue from occurring.
> 

Actually, I'm not sure that solves your issue. From what I
understand, what is happening in step 4 is the bug you want to work
around and it happens because AF gets set even if AIE is not set.

So, your rtc_alarm_restore() basically calls cmos_set_alarm() which
calls cmos_irq_disable() finally this one calls cmos_checkintr() which
does read register C and so clears AF.

What I'm not sure is why cmos_do_shutdown() isn't clearing AF properly.
Is it correctly called at shutdown?

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
