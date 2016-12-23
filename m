Return-Path: <rtc-linux+bncBDJ6H2FGZ4FBBT4P6TBAKGQEBXDMJ6A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from hel-mailgw-01.vaisala.com (hel-mailgw-01.vaisala.com. [193.143.230.17])
        by gmr-mx.google.com with ESMTPS id a19si267215wme.0.2016.12.23.03.17.35
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Dec 2016 03:17:35 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH v2 1/2] drivers: rtc: rtc-tps65910: Add RTC
 calibration support
To: Lee Jones <lee.jones@linaro.org>
References: <1481406644-1614-1-git-send-email-vesa.jaaskelainen@vaisala.com>
 <1481406644-1614-2-git-send-email-vesa.jaaskelainen@vaisala.com>
 <20161212074416.GN3625@dell.home>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 rtc-linux@googlegroups.com
From: =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <vesa.jaaskelainen@vaisala.com>
Message-ID: <b8dbfb0d-041c-c6b0-c07d-6294925220ff@vaisala.com>
Date: Fri, 23 Dec 2016 13:17:26 +0200
MIME-Version: 1.0
In-Reply-To: <20161212074416.GN3625@dell.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 2016-12-12 09:44, Lee Jones wrote:
> On Sat, 10 Dec 2016, Vesa J=C3=A4=C3=A4skel=C3=A4inen wrote:
>
>> Texas Instrument's TPS65910 has support for compensating RTC crystal
>> inaccuracies. When enabled every hour RTC counter value will be compensa=
ted
>> with two's complement value.
>>
>> Signed-off-by: Vesa J=C3=A4=C3=A4skel=C3=A4inen <vesa.jaaskelainen@vaisa=
la.com>
>> ---
>>   drivers/rtc/rtc-tps65910.c   | 132 +++++++++++++++++++++++++++++++++++=
++++++++
>>   include/linux/mfd/tps65910.h |   1 +
> For the MFD change:
>
> Acked-by: Lee Jones <lee.jones@linaro.org>

Thanks for the review. Added Acked-by to v3.

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
