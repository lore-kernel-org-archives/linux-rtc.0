Return-Path: <rtc-linux+bncBDJ6H2FGZ4FBBVUR6TBAKGQEBPSPJCQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from hel-mailgw-01.vaisala.com (hel-mailgw-01.vaisala.com. [193.143.230.17])
        by gmr-mx.google.com with ESMTPS id d199si2409231wmd.1.2016.12.23.03.21.57
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Dec 2016 03:21:57 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH v2 0/2] drivers: rtc: rtc-tps65910: Add RTC
 calibration support
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1481406644-1614-1-git-send-email-vesa.jaaskelainen@vaisala.com>
 <a22c9180-61bf-e307-9ba1-e24e1453459b@vaisala.com>
 <20161219003854.e6hbobkwa3kanbjp@piout.net>
 <20161219005349.bgaoiczfy57ltad5@piout.net>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Lee Jones
 <lee.jones@linaro.org>, rtc-linux@googlegroups.com
From: =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <vesa.jaaskelainen@vaisala.com>
Message-ID: <6e2c3438-3c39-85a9-0525-359dd666a789@vaisala.com>
Date: Fri, 23 Dec 2016 13:21:56 +0200
MIME-Version: 1.0
In-Reply-To: <20161219005349.bgaoiczfy57ltad5@piout.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 2016-12-19 02:53, Alexandre Belloni wrote:
> On 19/12/2016 at 01:38:54 +0100, Alexandre Belloni wrote :
>> On 11/12/2016 at 00:21:02 +0200, Vesa J=C3=A4=C3=A4skel=C3=A4inen wrote =
:
>>> On 2016-12-10 23:50, Vesa J=C3=A4=C3=A4skel=C3=A4inen wrote:
>>> Due to RTC chip's implementation -- it loses RTC compensation enable bi=
t on
>>> reset, so compensation value must be written on every boot at least onc=
e to
>>> be active.
>>>
>>> When compensation is not enabled "cat offset" returns value. There is
>>> currently no way to know from users space (without i2cget -f) whether
>>> compensation is enabled or not. If this should not be the case it can b=
e
>>> easily fixed, -EINVAL might do the trick.
>>>
>> If compensation is not enabled, simply return 0 so userspace actually
>> has a way to know it is not currently in effect. Anyway, you'll have to
>> write a value to enable it again.
>> You are probably already able to calculate that value anyway so I'm not
>> sure of the benefit of using the RTC to remember it across resets.
>>
> After reviewing the patch, it is fine apart from that part.
>

Sent patch v3 to address that issue and improved commit message for=20
cleanup patch.

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
