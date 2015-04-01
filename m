Return-Path: <rtc-linux+bncBC36JT6HRIDRBIPW5WUAKGQECARYSHA@googlegroups.com>
Received: from resqmta-ch2-12v.sys.comcast.net (resqmta-ch2-12v.sys.comcast.net. [2001:558:fe21:29:69:252:207:44])
        by gmr-mx.google.com with ESMTPS id z1si119123qcn.2.2015.03.31.21.59.12
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 31 Mar 2015 21:59:12 -0700 (PDT)
Message-ID: <551B7B19.30305@gentoo.org>
Date: Wed, 01 Apr 2015 00:59:05 -0400
From: Joshua Kinard <kumba@gentoo.org>
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: Alessandro Zummo <a.zummo@towertech.it>,
 Linux/MIPS <linux-mips@linux-mips.org>,
 rtc-linux@googlegroups.com, LKML <linux-kernel@vger.kernel.org>
Subject: [rtc-linux] Re: [PATCH v2] MIPS: IP32: Add platform data hooks to use
 DS1685 driver
References: <54EFD536.2080508@gentoo.org> <20150331105650.GA28951@linux-mips.org>
In-Reply-To: <20150331105650.GA28951@linux-mips.org>
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

On 03/31/2015 06:56, Ralf Baechle wrote:
> On Thu, Feb 26, 2015 at 09:23:50PM -0500, Joshua Kinard wrote:
> 
>> This modifies the IP32 (SGI O2) platform and reset code to utilize the new
>> rtc-ds1685 driver.  The old mc146818rtc.h header is removed and ip32_defconfig
>> is updated as well.
> 
> In general - good cleanup.  But:
> 
>> index 511e9ff..ec9eb7f 100644
>> --- a/arch/mips/sgi-ip32/ip32-platform.c
>> +++ b/arch/mips/sgi-ip32/ip32-platform.c
> [...]
>>  MODULE_AUTHOR("Ralf Baechle <ralf@linux-mips.org>");
>>  MODULE_LICENSE("GPL");
>> -MODULE_DESCRIPTION("8250 UART probe driver for SGI IP32 aka O2");
>> +MODULE_DESCRIPTION("IP32 platform setup for SGI IP32 aka O2");
> 
> This isn't even a kernel module so I've just nuked all these MODULE_*
> calls.

Works for me, thanks!


>> diff --git a/arch/mips/sgi-ip32/ip32-reset.c b/arch/mips/sgi-ip32/ip32-reset.c
>> index 44b3470..ef21706 100644
>> --- a/arch/mips/sgi-ip32/ip32-reset.c
>> +++ b/arch/mips/sgi-ip32/ip32-reset.c
> [...]
>> -static void ip32_machine_restart(char *cmd)
>> +static __noreturn void ip32_poweroff(void *data)
>>  {
>> -	crime->control = CRIME_CONTROL_HARD_RESET;
>> -	while (1);
>> -}
>> +	void (*poweroff_func)(struct platform_device *) =
>> +		symbol_get(ds1685_rtc_poweroff);
>> +
>> +#ifdef CONFIG_MODULES
>> +	/* If the first __symbol_get failed, our module wasn't loaded. */
>> +	if (!poweroff_func) {
>> +		request_module("rtc-ds1685");
>> +		poweroff_func = symbol_get(ds1685_rtc_poweroff);
>> +	}
>> +#endif
> 
> symbol_get() calls are high on my list of items that indicate a piece of
> code is probably ill-structured.

That was the only function I could find that would attempt to fetch the
ds1685_rtc_poweroff() function from kernel memory and return an indication of
success or failure that could be checked.  If there's a better way to do that,
I'll be happy to re-write that section.  I looked through the docs back then
and couldn't find another way that worked with and without modules.


> While RTCs often deal with power the RTC really only wants to deal with
> time and so power stuff should rather go elsewhere.  I suggest to take a
> look at drivers/power/reset/.  A small driver there could set pm_power_off
> approriately.  drivers/power/reset/restart-poweroff.c is a very compact
> example.

Except this code is in a file called "ip32-reset.c", and the original code
there did the exact same thing -- powered off the machine.  The
ds1685_rtc_poweroff() function is defined in the core DS1685 driver
(drivers/rtc/rtc-ds1685.c) that got added to linux-next a few weeks ago (no one
had any complaints about that).  This code just checks to see if the RTC driver
is loaded and then calls that function to power the machine down.

IP30 uses a similar setup as well, since both machines share the same RTC
chip/family.


>> @@ -190,15 +141,12 @@ static __init int ip32_reboot_setup(void)
>>  
>>  	_machine_restart = ip32_machine_restart;
>>  	_machine_halt = ip32_machine_halt;
>> -	pm_power_off = ip32_machine_power_off;
>> +	pm_power_off = ip32_machine_halt;
> 
> So halt and power_off no do the same?
> 

They always did.  This is the original ip32_machine_halt function:

static inline void ip32_machine_halt(void)
{
       ip32_machine_power_off();
}

I just got rid of the added level of misdirection and set both _machine_halt
and pm_power_off to call the same function (especially since there's no
sleeping these kinds of machines -- maybe hibernate, but that'll still properly
poweroff).  Seemed the logical thing to do.  In either case, it'll lead to the
RTC driver handling the poweroff routine, which seems to be the only way SGI
designed these machines to power off.  I'll wager the ARCS firmware internally
does the same thing.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic

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
