Return-Path: <rtc-linux+bncBDJ6H2FGZ4FBB3N44DAQKGQE4D6WTWQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from hel-mailgw-01.vaisala.com (hel-mailgw-01.vaisala.com. [193.143.230.17])
        by gmr-mx.google.com with ESMTPS id 85si1265695wmb.3.2016.11.25.03.20.12
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Nov 2016 03:20:13 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH 1/2] drivers: rtc: rtc-tps65910: Add RTC
 calibration support
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1480067538-64415-1-git-send-email-vesa.jaaskelainen@vaisala.com>
 <1480067538-64415-2-git-send-email-vesa.jaaskelainen@vaisala.com>
 <20161125103254.7p7p4frk2cudwfwt@piout.net>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Lee Jones
 <lee.jones@linaro.org>, rtc-linux@googlegroups.com
From: =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <vesa.jaaskelainen@vaisala.com>
Message-ID: <05f0a84b-00a1-5fe4-2f92-a58b0a87422c@vaisala.com>
Date: Fri, 25 Nov 2016 13:20:05 +0200
MIME-Version: 1.0
In-Reply-To: <20161125103254.7p7p4frk2cudwfwt@piout.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 2016-11-25 12:32, Alexandre Belloni wrote:
> Hi,
>
> On 25/11/2016 at 11:52:17 +0200, Vesa J=C3=A4=C3=A4skel=C3=A4inen wrote :
>> Texas Instrument's TPS65910 has support for compensating RTC crystal
>> inaccuracies. When enabled every hour RTC counter value will be compensa=
ted
>> with two's complement value.
>>
>> Signed-off-by: Vesa J=C3=A4=C3=A4skel=C3=A4inen <vesa.jaaskelainen@vaisa=
la.com>
> There is already a sysfs attribute for that kind of calibration
> (offset, documented in Documentation/rtc.txt). Can you use that instead?

That documentation in rtc.txt states that compensation is per billion=20
ticks. This compensation happens every 32768*60*60  =3D=3D 117964800 ticks.

I modeled this after similar functionality of rtc-ab8500.c which=20
provided similar sysfs file. But its time compensation happens also with=20
different interval.

Due to differences here in functionalities between different chips I=20
decided to go with driver specific compensation value.

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
