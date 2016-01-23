Return-Path: <rtc-linux+bncBCPM5SUWUYIRBM4LR22QKGQERCBYFOI@googlegroups.com>
Received: from mail-vk0-x242.google.com (mail-vk0-x242.google.com. [2607:f8b0:400c:c05::242])
        by gmr-mx.google.com with ESMTPS id b196si479017vkf.1.2016.01.23.05.52.50
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jan 2016 05:52:50 -0800 (PST)
Received: by mail-vk0-x242.google.com with SMTP id e6so4043802vkh.1
        for <rtc-linux@googlegroups.com>; Sat, 23 Jan 2016 05:52:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56A2CF6D.9040300@roeck-us.net>
References: <1453485441-11667-1-git-send-email-akinobu.mita@gmail.com>
	<56A2CF6D.9040300@roeck-us.net>
Date: Sat, 23 Jan 2016 22:52:50 +0900
Message-ID: <CAC5umyhVcZLHJBX38Tu4+qLRfJRg4W=A3Vj1n1OjMZ-P65aY_w@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v2] rtc: rtc-ds1307: add temperature sensor
 support for ds3231
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, Jean Delvare <jdelvare@suse.com>,
	lm-sensors@lm-sensors.org
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

2016-01-23 9:55 GMT+09:00 Guenter Roeck <linux@roeck-us.net>:
> On 01/22/2016 09:57 AM, Akinobu Mita wrote:
>>
>> DS3231 has the temperature registers with a resolution of 0.25
>> degree celsius.  This enables to get the value through hwmon.
>>
>>         # cat /sys/class/i2c-adapter/i2c-2/2-0068/hwmon/hwmon0/temp1_input
>>         21000
>>
>> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
>> Cc: Alessandro Zummo <a.zummo@towertech.it>
>> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>> Cc: rtc-linux@googlegroups.com
>> Cc: Jean Delvare <jdelvare@suse.com>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Cc: lm-sensors@lm-sensors.org
>> ---
>> * v2
>> - convert to use hwmon framework, suggested by Alexandre Belloni
>>
>>   drivers/rtc/rtc-ds1307.c | 122
>> +++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 122 insertions(+)
>>
>> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
>
>
> Something else, on top of my previous comments.
>
>> +#if IS_ENABLED(CONFIG_HWMON)
>
>
> I don't think this will work as intended. It will fail if the ds1307 driver
> is built into the kernel but hwmon is built as module.
>
> Check configurations such as BE2NET_HWMON or NET_DSA_HWMON for ideas
> on how to handle this problem.

OK.  I'll add CONFIG_RTC_DRV_DS1307_HWMON and do something similar.

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
