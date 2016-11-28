Return-Path: <rtc-linux+bncBDJ6H2FGZ4FBBQUE6HAQKGQENG2432A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from hel-mailgw-01.vaisala.com (hel-mailgw-01.vaisala.com. [193.143.230.17])
        by gmr-mx.google.com with ESMTPS id l130si2190051wmf.0.2016.11.28.06.42.09
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2016 06:42:10 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH 1/2] drivers: rtc: rtc-tps65910: Add RTC
 calibration support
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1480067538-64415-1-git-send-email-vesa.jaaskelainen@vaisala.com>
 <1480067538-64415-2-git-send-email-vesa.jaaskelainen@vaisala.com>
 <20161125103254.7p7p4frk2cudwfwt@piout.net>
 <05f0a84b-00a1-5fe4-2f92-a58b0a87422c@vaisala.com>
 <20161125153711.ueervgro35xqy3ec@piout.net>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Lee Jones
 <lee.jones@linaro.org>, rtc-linux@googlegroups.com
From: =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <vesa.jaaskelainen@vaisala.com>
Message-ID: <92675f10-b2ee-d8a0-c832-09b45d006881@vaisala.com>
Date: Mon, 28 Nov 2016 16:42:05 +0200
MIME-Version: 1.0
In-Reply-To: <20161125153711.ueervgro35xqy3ec@piout.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 2016-11-25 17:37, Alexandre Belloni wrote:
> On 25/11/2016 at 13:20:05 +0200, Vesa J=C3=A4=C3=A4skel=C3=A4inen wrote :
>> On 2016-11-25 12:32, Alexandre Belloni wrote:
>>> Hi,
>>>
>>> On 25/11/2016 at 11:52:17 +0200, Vesa J=C3=A4=C3=A4skel=C3=A4inen wrote=
 :
>>>> Texas Instrument's TPS65910 has support for compensating RTC crystal
>>>> inaccuracies. When enabled every hour RTC counter value will be compen=
sated
>>>> with two's complement value.
>>>>
>>>> Signed-off-by: Vesa J=C3=A4=C3=A4skel=C3=A4inen <vesa.jaaskelainen@vai=
sala.com>
>>> There is already a sysfs attribute for that kind of calibration
>>> (offset, documented in Documentation/rtc.txt). Can you use that instead=
?
>> That documentation in rtc.txt states that compensation is per billion ti=
cks.
>> This compensation happens every 32768*60*60  =3D=3D 117964800 ticks.
>>
>> I modeled this after similar functionality of rtc-ab8500.c which provide=
d
>> similar sysfs file. But its time compensation happens also with differen=
t
>> interval.
>>
>> Due to differences here in functionalities between different chips I dec=
ided
>> to go with driver specific compensation value.
>>
> The functionality is exactly the same, but if I understand correctly,
> your resolution is 8.477 ppb is that right ?

I suppose so. Compensation resolution is the differenting factor here=20
and also at what point of time compensation is happening.

If I would convert this to 1ppb then there would be theoretical accuracy=20
lost, not much but in year it sums up :).

btw. is there existing RTC compensation daemon that would support also=20
temperature based calibration and would internally handle updating=20
'offset' or custom calibration fields?

If I spotted correctly this 'offset' property is only supported by=20
rtc-pcf2123.c. That driver seems to use some kind of dynamic scaling for=20
compensation.

Keeping data in chips native format would enable best possible accuracy=20
and no-one could complain that it is not functioning in best possible way.

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
