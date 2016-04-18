Return-Path: <rtc-linux+bncBDVNH3HM2UDBBDWR2G4AKGQEJZD25FQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-oi0-x230.google.com (mail-oi0-x230.google.com. [2607:f8b0:4003:c06::230])
        by gmr-mx.google.com with ESMTPS id au10si2267766igc.3.2016.04.17.21.54.37
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Apr 2016 21:54:37 -0700 (PDT)
Received: by mail-oi0-x230.google.com with SMTP id r78so38859382oie.0
        for <rtc-linux@googlegroups.com>; Sun, 17 Apr 2016 21:54:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CABrG=Zz=OK3tbYFyT6VmCfebz-TnnDjC3x0aG-Mdau+TZdFqUw@mail.gmail.com>
References: <1460938902-3120-1-git-send-email-akinobu.mita@gmail.com>
	<CABrG=Zz=OK3tbYFyT6VmCfebz-TnnDjC3x0aG-Mdau+TZdFqUw@mail.gmail.com>
Date: Mon, 18 Apr 2016 08:54:37 +0400
Message-ID: <CABrG=Zzgo9CtD=WyvNyOmeb7_C4ZxoHiXVcA8tKMcz32K8BTXA@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH] rtc: ds1307: ds3231 temperature s16 overflow
From: Michael Tatarinov <kukabu@gmail.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: rtc-linux@googlegroups.com, Zhuang Yuyao <mlistz@gmail.com>,
	Zhuang Yuyao <zhuangyy@syan.com.cn>, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

sorry, I realized my mistake

2016-04-18 8:33 GMT+04:00, Michael Tatarinov <kukabu@gmail.com>:
> Hello
>
> Thanks!
> I haven't tested the patch yet but I already have a question. What
> about s16 in ds3231_hwmon_show_temp()?
>
>
> 2016-04-18 4:21 GMT+04:00, Akinobu Mita <akinobu.mita@gmail.com>:
>> From: Zhuang Yuyao <mlistz@gmail.com>
>>
>> while retrieving temperature from ds3231, the result may be overflow
>> since s16 is too small for a multiplication with 250.
>>
>> ie. if temp_buf[0] == 0x2d, the result (s16 temp) will be negative.
>>
>> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
>> Cc: Zhuang Yuyao <mlistz@gmail.com>
>> Cc: Zhuang Yuyao <zhuangyy@syan.com.cn>
>> Cc: Michael Tatarinov <kukabu@gmail.com>
>> Cc: Alessandro Zummo <a.zummo@towertech.it>
>> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>> ---
>>  drivers/rtc/rtc-ds1307.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
>> index cb0ffa8..90d1e5a 100644
>> --- a/drivers/rtc/rtc-ds1307.c
>> +++ b/drivers/rtc/rtc-ds1307.c
>> @@ -863,7 +863,7 @@ out:
>>   * A user-initiated temperature conversion is not started by this
>> function,
>>   * so the temperature is updated once every 64 seconds.
>>   */
>> -static int ds3231_hwmon_read_temp(struct device *dev, s16 *mC)
>> +static int ds3231_hwmon_read_temp(struct device *dev, s32 *mC)
>>  {
>>  	struct ds1307 *ds1307 = dev_get_drvdata(dev);
>>  	u8 temp_buf[2];
>> @@ -892,7 +892,7 @@ static ssize_t ds3231_hwmon_show_temp(struct device
>> *dev,
>>  				struct device_attribute *attr, char *buf)
>>  {
>>  	int ret;
>> -	s16 temp;
>> +	s32 temp;
>>
>>  	ret = ds3231_hwmon_read_temp(dev, &temp);
>>  	if (ret)
>> --
>> 2.5.0
>>
>>
>

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
