Return-Path: <rtc-linux+bncBD66BCOYSQBBBOFMQO5QKGQE3AH4G5I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from devils.ext.ti.com (devils.ext.ti.com. [198.47.26.153])
        by gmr-mx.google.com with ESMTPS id d189si490527ith.1.2016.06.14.21.14.47
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 14 Jun 2016 21:14:47 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH] rtc: ds1307: Fix relying on reset value for weekday
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1464778147-22075-1-git-send-email-j-keerthy@ti.com>
 <20160601121802.GF4249@piout.net> <574ED6D1.70800@ti.com>
 <575693E1.2090302@ti.com> <20160614143948.GP3240@piout.net>
CC: Keerthy <j-keerthy@ti.com>, <a.zummo@towertech.it>, <nm@ti.com>,
        <rtc-linux@googlegroups.com>, <linux-kernel@vger.kernel.org>
From: Keerthy <a0393675@ti.com>
Message-ID: <5760D631.1050006@ti.com>
Date: Wed, 15 Jun 2016 09:44:41 +0530
MIME-Version: 1.0
In-Reply-To: <20160614143948.GP3240@piout.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>



On Tuesday 14 June 2016 08:09 PM, Alexandre Belloni wrote:
> On 07/06/2016 at 14:59:05 +0530, Keerthy wrote :
>> Hi Alexandre,
>>
>> On Wednesday 01 June 2016 06:06 PM, Keerthy wrote:
>>>
>>>
>>> On Wednesday 01 June 2016 05:48 PM, Alexandre Belloni wrote:
>>>> Hi,
>>>>
>>>> On 01/06/2016 at 16:19:07 +0530, Keerthy wrote :
>>>>> The reset value of weekday is 0x1. This is wrong since
>>>>> the reset values of the day/month/year make up to Jan 1 2001.
>>>>> When computed weekday comes out to be Monday. On a scale
>>>>> of 1-7(Sunday - Saturday) it should be 0x2. So we should not
>>>>> be relying on the reset value.
>>>>>
>>>>
>>>> Hum, what are the chances that the reset value is actually the correct
>>>> date/time?
>>>> Won't that be corrected after the first call to set_time? Until then,
>>>> the date is not correct so, do we care anyway?
>>>
>>> Yes if an alarm is programmed without set_time.
>>>
>>> ex: rtcwake -d /dev/rtc0 -s 5
>>>
>>> Even the basic rtctest under tools/testing/selftests/timers/rtctest.c fails
>>> as the wday is wrong and no alarm fires.
>>>
>>> Instead of relying on some one to call set_time before programming alarm
>>> its better to fix the wday to reflect the current day right?
>>>
>>>
>>>>
>>>> Maybe I'm missing something here.
>>
>> Let me know if you feel this is a valid fix.
>>
>
> Well, this is probably a valid fix and I'll take it as is if I don't
> find the time to make something more generic.

Okay Thanks.

>

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
