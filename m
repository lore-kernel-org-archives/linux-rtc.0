Return-Path: <rtc-linux+bncBCPM5SUWUYIRBNXQSC3QKGQERJMDAWI@googlegroups.com>
Received: from mail-vk0-x244.google.com (mail-vk0-x244.google.com. [2607:f8b0:400c:c05::244])
        by gmr-mx.google.com with ESMTPS id v71si432535vkd.3.2016.03.12.07.39.34
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Mar 2016 07:39:34 -0800 (PST)
Received: by mail-vk0-x244.google.com with SMTP id e6so11284483vkh.1
        for <rtc-linux@googlegroups.com>; Sat, 12 Mar 2016 07:39:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20160311181111.GC4620@piout.net>
References: <1457713336-24262-1-git-send-email-akinobu.mita@gmail.com>
	<20160311181111.GC4620@piout.net>
Date: Sun, 13 Mar 2016 00:39:34 +0900
Message-ID: <CAC5umyiwEWMdjPs6iZCUT0cn6W=RrGHMjHL-gR74KcT=C+ECgA@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 1/3] rtc: pcf2127: conver to use regmap
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	Renaud Cerrato <r.cerrato@til-technologies.fr>
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

2016-03-12 3:11 GMT+09:00 Alexandre Belloni
<alexandre.belloni@free-electrons.com>:
> Hi,
>
> That is nice to see interest in those RTCs. Do you plan to submit more
> RTC drivers? How many do you have? :)

I have DS1302, DS1307, DS3231, DS3232, DS3234, PCF2129, RX8025.
I plan to submit patches for rtc-ds1302 to support controlling with
using GPIO lines like rtc-moxart.  PCF2127/29 has some interesting
features like timestamp and watchdog, so I'll try to integrate these
into rtc-pcf2127 driver.

> One small comment as I didn't have time to read the datasheet.
>
> On 12/03/2016 at 01:22:14 +0900, Akinobu Mita wrote :
>> @@ -228,16 +200,113 @@ static const struct of_device_id pcf2127_of_match[] = {
>>  MODULE_DEVICE_TABLE(of, pcf2127_of_match);
>>  #endif
>>
>> -static struct i2c_driver pcf2127_driver = {
>> +static int pcf2127_i2c_write(void *context, const void *data, size_t count)
>> +{
>> +     struct device *dev = context;
>> +     struct i2c_client *client = to_i2c_client(dev);
>> +     int ret;
>> +
>> +     ret = i2c_master_send(client, data, count);
>> +     if (ret != count)
>> +             return ret < 0 ? ret : -EIO;
>> +
>> +     return 0;
>> +}
>> +
>> +static int pcf2127_i2c_gather_write(void *context,
>> +                             const void *reg, size_t reg_size,
>> +                             const void *val, size_t val_size)
>> +{
>> +     struct device *dev = context;
>> +     struct i2c_client *client = to_i2c_client(dev);
>> +     int ret;
>> +     void *buf;
>> +
>> +     if (WARN_ON(reg_size != 1))
>> +             return -EINVAL;
>> +
>> +     buf = kmalloc(val_size + 1, GFP_KERNEL);
>> +     if (!buf)
>> +             return -ENOMEM;
>> +
>> +     memcpy(buf, reg, 1);
>> +     memcpy(buf + 1, val, val_size);
>> +
>> +     ret = i2c_master_send(client, buf, val_size + 1);
>> +     if (ret != val_size + 1)
>> +             return ret < 0 ? ret : -EIO;
>> +
>> +     return 0;
>> +}
>> +
>> +static int pcf2127_i2c_read(void *context, const void *reg, size_t reg_size,
>> +                             void *val, size_t val_size)
>> +{
>> +     struct device *dev = context;
>> +     struct i2c_client *client = to_i2c_client(dev);
>> +     int ret;
>> +
>> +     if (WARN_ON(reg_size != 1))
>> +             return -EINVAL;
>> +
>> +     ret = i2c_master_send(client, reg, 1);
>> +     if (ret != 1)
>> +             return ret < 0 ? ret : -EIO;
>> +
>> +     ret = i2c_master_recv(client, val, val_size);
>> +     if (ret != val_size)
>> +             return ret < 0 ? ret : -EIO;
>> +
>> +     return 0;
>> +}
>> +
>> +static const struct regmap_bus pcf2127_i2c_regmap = {
>> +     .write = pcf2127_i2c_write,
>> +     .gather_write = pcf2127_i2c_gather_write,
>> +     .read = pcf2127_i2c_read,
>> +};
>
> Do I understand correctly that you have to define that because
> regmap_i2c_gather_write doesn't do the right thing for this device?

The reason is regmap_i2c_read() doesn't work for this device because the
STOP condition is required between set register address and read register
data.  (Fig 45. Bus protocol, reading from registers in PCF2127.pdf)

I'll update this patch by adding that comment.

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
