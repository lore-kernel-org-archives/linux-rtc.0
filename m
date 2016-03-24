Return-Path: <rtc-linux+bncBC4L3MVYV4CBBG6T2G3QKGQEZ4B2HGQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from smtp.natisbad.org (36.223.133.77.rev.sfr.net. [77.133.223.36])
        by gmr-mx.google.com with ESMTP id c7si13476wmf.2.2016.03.24.15.26.34
        for <rtc-linux@googlegroups.com>;
        Thu, 24 Mar 2016 15:26:34 -0700 (PDT)
From: arno@natisbad.org (Arnaud Ebalard)
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com,  Jason Cooper <jason@lakedaemon.net>, Sudeep Holla <Sudeep.Holla@arm.com>
Subject: [rtc-linux] Re: Intersil ISL12057 driver
References: <20160323171003.GE2570@piout.net> <878u18hp79.fsf@natisbad.org>
Date: Thu, 24 Mar 2016 23:26:24 +0100
In-Reply-To: <878u18hp79.fsf@natisbad.org> (Arnaud Ebalard's message of "Wed,
	23 Mar 2016 22:14:18 +0100")
Message-ID: <87lh57ldgv.fsf@natisbad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Alexandre,

arno@natisbad.org (Arnaud Ebalard) writes:

> Alexandre Belloni <alexandre.belloni@free-electrons.com> writes:
>
>> I know it has been a while that this driver has been submitted but
>> Intersil is claiming that ISL12057 is a drop in replacement for ds1337.
>> I don't think there are any features supported by rtc-isl12057.c
>> that are not supported by rtc-ds1307.c.  Could you confirm rtc-ds1307
>> works for you?  I'd like to reduce the number of duplicated drivers.
>
> Sure. I'll take some time tomorrow evening to test how ds1337 works on
> my platforms and report back.

With ds1307 driver compiled in and a simple adjustment to my .dts file
to use "dallas,ds1337" as compatible instead of "isil,isl12057":

	isl12057: isl12057@68 {
		compatible = "dallas,ds1337";
		reg = <0x68>;
		wakeup-source;
	};

the system gets a rtc0 after boot:

[    3.440856] rtc-ds1307 0-0068: SET TIME!
[    3.447093] rtc-ds1307 0-0068: rtc core: registered ds1337 as rtc0
[    3.806492] rtc-ds1307 0-0068: setting system clock to 2016-03-24 20:58:16 UTC (1458853096)

Then, hwclock -s, -r and -w options do work as expected. That's for the
good part. Now, two points that needs to be sorted out before switching
from isl12057 driver to ds1307 one and kill the former:

1) Handling of the century bit

in rtc-ds1307.c seems buggy. After rebooting my system on a kernel with
rtc-isl12057.c driver after the tests, the hardware clock was 100 years 
in the future. In rtc-ds1307.c, the logic is the following:

  set time:

    	/* assume 20YY not 19YY */
	tmp = t->tm_year - 100;
	buf[DS1307_REG_YEAR] = bin2bcd(tmp);

	switch (ds1307->type) {
	case ds_1337:
	case ds_1339:
	case ds_3231:
		buf[DS1307_REG_MONTH] |= DS1337_BIT_CENTURY;
		break;

  get time:

        /* assume 20YY not 19YY, and ignore DS1337_BIT_CENTURY */
	t->tm_year = bcd2bin(ds1307->regs[DS1307_REG_YEAR]) + 100;


So, when the driver reads from the rtc, it does not consider the century
bit (it is DS1307_REG_MONTH, notDS1307_REG_YEAR). But when it sets the
time, it blindly sets that bit. This is probably a non-issue because
this will not be seen until before the end of year 2099 ;-). But with
more care, it is possible to honor that century bit and have a driver
that work until 2199. After my hwclock tests with ds1307 driver, the
century bit was detected by isl12057 driver and handled as expected,
resulting in: 

root@sharp:~#  cat /proc/driver/rtc
rtc_time        : 21:28:59
rtc_date        : 2116-03-24
alrm_time       : 20:32:23
alrm_date       : ****-04-24
alarm_IRQ       : yes
alrm_pending    : no
update IRQ enabled      : no
periodic IRQ enabled    : no
periodic IRQ frequency  : 1
max user IRQ frequency  : 64
24hr                    : yes


2) Alarm:

On the devices supported by the kernel that use ISL12057 (Netgear
ReadyNAS 102, 104 and 2120), the interrupt pin of the RTC is not
connected to the SoC but to a PMIC. This means the RTC is capable of
waking up the device when an alarm has been set before the device is 
powered off (power off on evening, wake up in the morning).

But this also means the RTC is a wakeup source but does not have an IRQ
and an associated handler. This is something which is not well supported
by RTC framework (it is not possible to have alarm support w/o IRQ) and
the reason why I introduced the 298ff0122ab19 (rtc: rtc-isl12057: add
isil,irq2-can-wakeup-machine property for in-tree users). I just noticed
(I was not in the recipients when the patch was sent) f4b6722248e49
(rtc: isl12057: enable support for the standard "wakeup-source"
property) changed the property "wakeup-source". I have added the author
(Sudeep Holla) to the recipients; he might have some comments on the
discussion.

With ds1307 driver (and recognized ds1337 type),


	switch (ds1307->type) {
	case ds_1337:
	case ds_1339:
	case ds_3231:

                 <...SNIP...>
                 
		/*
		 * Using IRQ?  Disable the square wave and both alarms.
		 * For some variants, be sure alarms can trigger when we're
		 * running on Vbackup (BBSQI/BBSQW)
		 */
		if (ds1307->client->irq > 0 && chip->alarm) {
			ds1307->regs[0] |= DS1337_BIT_INTCN
					| bbsqi_bitpos[ds1307->type];
			ds1307->regs[0] &= ~(DS1337_BIT_A2IE | DS1337_BIT_A1IE);

			want_irq = true;
		}

                 <...SNIP...>


	if (want_irq) {
		device_set_wakeup_capable(&client->dev, true);
		set_bit(HAS_ALARM, &ds1307->flags);
	}

AFAICT, ds1307 driver does not honour wakeup-source property and only
makes its decision based on its ability to register an IRQ handler. For
that reason, the alarm mechanism is no more usable on my platforms:

# cat /sys/class/rtc/rtc0/wakealarm
# echo `date '+%s' -d '+ 1 minutes'` > /sys/class/rtc/rtc0/wakealarm
-bash: echo: write error: Invalid argument

Cheers,

a+

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
