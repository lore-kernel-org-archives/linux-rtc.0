Return-Path: <rtc-linux+bncBDJ6H2FGZ4FBBYHDV7BAKGQEQUTJZ6I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from hel-mailgw-01.vaisala.com (hel-mailgw-01.vaisala.com. [193.143.230.17])
        by gmr-mx.google.com with ESMTPS id f71si1935408wmf.2.2016.12.10.04.15.27
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Dec 2016 04:15:27 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH 1/2] drivers: rtc: rtc-tps65910: Add RTC
 calibration support
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1480067538-64415-1-git-send-email-vesa.jaaskelainen@vaisala.com>
 <1480067538-64415-2-git-send-email-vesa.jaaskelainen@vaisala.com>
 <20161125103254.7p7p4frk2cudwfwt@piout.net>
 <05f0a84b-00a1-5fe4-2f92-a58b0a87422c@vaisala.com>
 <20161125153711.ueervgro35xqy3ec@piout.net>
 <92675f10-b2ee-d8a0-c832-09b45d006881@vaisala.com>
 <20161201001243.aoxliubzg4sz7hsr@piout.net>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Lee Jones
 <lee.jones@linaro.org>, rtc-linux@googlegroups.com
From: =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <vesa.jaaskelainen@vaisala.com>
Message-ID: <9ced695c-47f5-f2b9-9fa7-89b57108f083@vaisala.com>
Date: Sat, 10 Dec 2016 14:15:11 +0200
MIME-Version: 1.0
In-Reply-To: <20161201001243.aoxliubzg4sz7hsr@piout.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 2016-12-01 02:12, Alexandre Belloni wrote:

> On 28/11/2016 at 16:42:05 +0200, Vesa J=C3=A4=C3=A4skel=C3=A4inen wrote :
>> On 2016-11-25 17:37, Alexandre Belloni wrote:
>>> On 25/11/2016 at 13:20:05 +0200, Vesa J=C3=A4=C3=A4skel=C3=A4inen wrote=
 :
>>>> On 2016-11-25 12:32, Alexandre Belloni wrote:
>>>>> Hi,
>>>>>
>>>>> On 25/11/2016 at 11:52:17 +0200, Vesa J=C3=A4=C3=A4skel=C3=A4inen wro=
te :
>>>>>> Texas Instrument's TPS65910 has support for compensating RTC crystal
>>>>>> inaccuracies. When enabled every hour RTC counter value will be comp=
ensated
>>>>>> with two's complement value.
>>>>>>
>>>>>> Signed-off-by: Vesa J=C3=A4=C3=A4skel=C3=A4inen <vesa.jaaskelainen@v=
aisala.com>
>>>>> There is already a sysfs attribute for that kind of calibration
>>>>> (offset, documented in Documentation/rtc.txt). Can you use that inste=
ad?
>>>> That documentation in rtc.txt states that compensation is per billion =
ticks.
>>>> This compensation happens every 32768*60*60  =3D=3D 117964800 ticks.
>>>>
>>>> I modeled this after similar functionality of rtc-ab8500.c which provi=
ded
>>>> similar sysfs file. But its time compensation happens also with differ=
ent
>>>> interval.
>>>>
>>>> Due to differences here in functionalities between different chips I d=
ecided
>>>> to go with driver specific compensation value.
>>>>
>>> The functionality is exactly the same, but if I understand correctly,
>>> your resolution is 8.477 ppb is that right ?
>> I suppose so. Compensation resolution is the differenting factor here an=
d
>> also at what point of time compensation is happening.
>>
>> If I would convert this to 1ppb then there would be theoretical accuracy
>> lost, not much but in year it sums up :).
>>
> Well, the best your RTC can do is 8.477 ppb so and the maximum drift
> you'd get over a year because of this resolution is 133.5ms.
> The precision loss by rounding to the closest ppb is 16ms over a year,
> way below what you can achieve.
>
> Also, remember that when setting the time, you are doing it at a one
> second resolution and you may as well be at the 999th millisecond of
> that second before even transferring any data to your RTC.
>
> The unit (ppb) is fine and the magic of it is that you don't actually
> care about when the correction happens as long as it happens regularly.
>
>> Keeping data in chips native format would enable best possible accuracy =
and
>> no-one could complain that it is not functioning in best possible way.
>>
> My point is that you don't lose any accuracy by using ppb and
> converting in the driver anyway.
> Using the native format will prevent anyone from writing a generic
> userspace application handling that compensation.

I started looking at the how it would change things but I am having a=20
bit hard time with this text:

|offset: The amount which the rtc clock has been adjusted in firmware.=20
Visible only if the driver supports clock offset adjustment. The unit is=20
parts per billion, i.e. The number of clock ticks which are added to or=20
removed from the rtc's base clock per billion ticks. A positive value=20
makes a day pass more slowly, longer, and a negative value makes a day=20
pass more quickly.|


Problem here is that I am having hard time understanding time scale=20
here. Or how it is defined in this text. Then I started to think if=20
using ppb unit then how it could be done.

If I look at in example accuracy calculator from Maxim:
https://www.maximintegrated.com/en/design/tools/calculators/product-design/=
rtc.cfm

This is kinda easy to understand; if you have error 100ppm it means that=20
this error (0.0001) happens in one second. Then you just multiply the=20
error for your time range you are interested in. Eg. 8.64s/day.

Or alternatively if you think in ticks then;

     realticks =3D ticks * (1+100ppm)
     seconds =3D realticks / expected rtc crystal

Based on commit messages I believe ppb usage instead of ppm is just for=20
giving possibility for better compensation factor in integers.

To calibrate RTC you need to measure exact crystal frequency. So lets=20
assume RTC crystal would be here 32768 Hz (which is not exported to user=20
space?). Let's assume measured crystal frequency would be 32771.28 Hz=20
(100ppm). So compensation would need to slow it down by 3.2768 Hz/s.

To calculate this compensation 'offset' value:

     offset =3D (32768 - 32771.28) / 32768 * 10^9    ; where offset is ppb=
=20
value
     offset =3D -100000    ; or -100 ppm

To compensate out this -100ppm one would need to write -100000 to=20
'offset' sysfs file.

Now assuming the error is +100 ppm and with compensation of -100 ppm=20
those would cancel each other out and we get "accurate" time.

Am I correct with this? If so then I suppose this text should be updated=20
to be clearer what it means. Problem I see is part "per billion ticks".=20
And perhaps the sign here?

|offset: The amount which the rtc clock has been adjusted in firmware.=20
Visible only if the driver supports clock offset adjustment. The unit is=20
parts per billion, i.e. The number of billionth seconds which are added=20
to or removed from the rtc's time once per second. A positive value=20
makes a day pass more quickly, faster, and a negative value makes a day=20
pass more slowly.|


In my case it would mean that every hour one would add ticks (negative=20
slows it down) by (32768 - 32771.28) * 3600 =3D=3D -11796.48.

or with 'offset' value with 64 bit signed integer math:

     comp =3D (offset * 32768 * 3600 + 10^9/2) / 10^9
     offset =3D (comp * 10^9 + (32768 * 3600)/2) / (32768 * 3600)

I will prepare next patch with this.

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
