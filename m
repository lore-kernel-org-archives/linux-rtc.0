Return-Path: <rtc-linux+bncBDJ6H2FGZ4FBBU77WHBAKGQESK2ZWGA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from hel-mailgw-01.vaisala.com (hel-mailgw-01.vaisala.com. [193.143.230.17])
        by gmr-mx.google.com with ESMTPS id p138si2356636wme.1.2016.12.10.14.21.06
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Dec 2016 14:21:07 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH v2 0/2] drivers: rtc: rtc-tps65910: Add RTC
 calibration support
To: Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Lee Jones <lee.jones@linaro.org>
References: <1481406644-1614-1-git-send-email-vesa.jaaskelainen@vaisala.com>
Cc: rtc-linux@googlegroups.com
From: =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <vesa.jaaskelainen@vaisala.com>
Message-ID: <a22c9180-61bf-e307-9ba1-e24e1453459b@vaisala.com>
Date: Sun, 11 Dec 2016 00:21:02 +0200
MIME-Version: 1.0
In-Reply-To: <1481406644-1614-1-git-send-email-vesa.jaaskelainen@vaisala.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


On 2016-12-10 23:50, Vesa J=C3=A4=C3=A4skel=C3=A4inen wrote:
> Texas Instrument's TPS65910 has support for compensating RTC crystal
> inaccuracies. When enabled every hour RTC counter value will be compensat=
ed
> with two's complement value.
>
> Vesa J=C3=A4=C3=A4skel=C3=A4inen (2):
>    drivers: rtc: rtc-tps65910: Add RTC calibration support
>    drivers: rtc: rtc-tps65910: use 'unsigned int' instead of 'unsigned'
>      in arguments
>
>   drivers/rtc/rtc-tps65910.c   | 135 ++++++++++++++++++++++++++++++++++++=
++++++-
>   include/linux/mfd/tps65910.h |   1 +
>   2 files changed, 135 insertions(+), 1 deletion(-)
>
This version now uses 'offset' sysfs file for calibration purposes.

It supports rounding so if one calculates absolute 'offset' compensation=20
value then it should give "optimal" calibration.

I believe one should calculate compensation value like:

offset =3D ((measured_freq/32768)-1)*10^9

So if meaured_freq =3D=3D 32771.2768, then matching offset =3D=3D 100000.
Or if mesured_freq =3D=3D 32764.7232, then matching offset =3D=3D -100000.

'offset' compensation value is following existing rtc.txt definition=20
meaning positive values causes time to slowdown and negative values to=20
fasten up. Which I believe should be other way around to be more=20
logical. This is easy to swap if I just understood it wrongly.

'offset' value calculation assumes "common" understanding how ppm values=20
are used, eg. it is negated compensation value (expect now positive).

Eg. if RTC crystal is off by +100ppm then 'offset' value must be 100ppm=20
(write 100000 to 'offset').

I believe offset documentation in rtc.txt should be clarified on what=20
value means.

'offset' value has limits due to RTC chip itself, if out-of-limits value=20
is given -ERANGE is returned.

Due to RTC chip's implementation -- it loses RTC compensation enable bit=20
on reset, so compensation value must be written on every boot at least=20
once to be active.

When compensation is not enabled "cat offset" returns value. There is=20
currently no way to know from users space (without i2cget -f) whether=20
compensation is enabled or not. If this should not be the case it can be=20
easily fixed, -EINVAL might do the trick.

Thanks,
Vesa J=C3=A4=C3=A4skel=C3=A4inen

--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
