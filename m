Return-Path: <rtc-linux+bncBAABBTEYRG2QKGQEZABVP3Y@googlegroups.com>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de. [2a01:238:20a:202:5300::10])
        by gmr-mx.google.com with ESMTPS id w129si242480wme.1.2016.01.22.07.35.39
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2016 07:35:39 -0800 (PST)
Subject: Re: [rtc-linux] [PATCH] rtc: ds1307.c: add support for the DT
 property 'wakeup-source'
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 rtc-linux@googlegroups.com
References: <1453396216-8367-1-git-send-email-linuxstuff@milaw.biz>
 <20160122000728.GE3608@piout.net>
From: Michael Lange <michaell@milaw.biz>
Message-ID: <56A24C4B.2030001@milaw.biz>
Date: Fri, 22 Jan 2016 16:35:39 +0100
MIME-Version: 1.0
In-Reply-To: <20160122000728.GE3608@piout.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


Hi,

> Hi,
>
> I don't think setting uie_unsupported is necessary because the alarm
> functions will fail anyway. What kind of issue did you have?
>

Tested today in the morning, before I had to go to work, the wakealarm
and the 'hwclock' binary with and without to set uie_unsupported in 
rtc-ds1307.


With uie_unsupported = 1:

The wakealarm is working, as expected:
   root@rbpi2 michael # echo +60 > /sys/class/rtc/rtc0/wakealarm
   root@rbpi2 michael # shutdown -h now
... wait, and the Raspberry comes up.

The hwclock binary is also working:
root@rbpi2 michael # LC_ALL=C hwclock -D -s
hwclock from util-linux 2.27.1
Using the /dev interface to the clock.
Last drift adjustment done at 1453438995 seconds after 1969
Last calibration done at 1453438995 seconds after 1969
Hardware clock is on UTC time
Assuming hardware clock is kept in UTC time.
Waiting for clock tick...
/dev/rtc does not have interrupt functions. Waiting in loop for time 
from /dev/rtc to change
...got clock tick
Time read from Hardware Clock: 2016/01/22 05:05:29
Hw clock time : 2016/01/22 05:05:29 = 1453439129 seconds since 1969
Time since last adjustment is 134 seconds
Calculated Hardware Clock drift is 0.000000 seconds
Calling settimeofday:
     tv.tv_sec = 1453439129, tv.tv_usec = 0
     tz.tz_minuteswest = -60

root@rbpi2 michael # LC_ALL=C hwclock -D -w
hwclock from util-linux 2.27.1
Using the /dev interface to the clock.
Last drift adjustment done at 1453438995 seconds after 1969
Last calibration done at 1453438995 seconds after 1969
Hardware clock is on UTC time
Assuming hardware clock is kept in UTC time.
Waiting for clock tick...
/dev/rtc does not have interrupt functions. Waiting in loop for time 
from /dev/rtc to change
...got clock tick
Time read from Hardware Clock: 2016/01/22 05:05:48
Hw clock time : 2016/01/22 05:05:48 = 1453439148 seconds since 1969
Time since last adjustment is 153 seconds
Calculated Hardware Clock drift is 0.000000 seconds
missed it - 1453439148.507319 is too far past 1453439148.500000 
(0.007319 > 0.001000)
1453439149.500000 is close enough to 1453439149.500000 (0.000000 < 
0.002000)
Set RTC to 1453439149 (1453439148 + 1; refsystime = 1453439148.000000)
Setting Hardware Clock to 05:05:49 = 1453439149 seconds since 1969
ioctl(RTC_SET_TIME) was successful.
Not adjusting drift factor because the --update-drift option was not used.



After that, the kernel was compiled without setting ui_unsupported in
rtc-ds1307.c, and I got the following:

root@rbpi2 michael # LC_ALL=C hwclock -D -s
hwclock from util-linux 2.27.1
Using the /dev interface to the clock.
Last drift adjustment done at 1453439148 seconds after 1969
Last calibration done at 1453439148 seconds after 1969
Hardware clock is on UTC time
Assuming hardware clock is kept in UTC time.
Waiting for clock tick...
select() to /dev/rtc to wait for clock tick timed out...synchronization 
failed

The wakealarm is still working fine.



The ds1337 on the Witty Pi extension board is connected to the i2c pins on
the Raspberry and the alarm pin is probably connected to a mosfet (F7319)
on this board, that powers up the Raspberry through the 5V-Pin on the
40pin-header.

But I'm not sure at all with the mosfet ... I'm not a electronics 
technician ...



An other example for a RTC and no IRQ to the CPU/Soc is in the rtc-isl12057
http://lxr.free-electrons.com/source/drivers/rtc/rtc-isl12057.c#L460
http://lxr.free-electrons.com/source/drivers/rtc/rtc-isl12057.c#L604

Without this patch the ds1337 got no wakealarm sysfs entry.



Regards
MichaeL

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
