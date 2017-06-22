Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-ua0-f194.google.com ([209.85.217.194]:35623 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbdFVMNN (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 22 Jun 2017 08:13:13 -0400
MIME-Version: 1.0
In-Reply-To: <20170621222421.GA23791@roeck-us.net>
References: <1498056583-16551-1-git-send-email-yesipov@gmail.com> <20170621222421.GA23791@roeck-us.net>
From: Kirill Esipov <yesipov@gmail.com>
Date: Thu, 22 Jun 2017 15:13:12 +0300
Message-ID: <CAJcpCzHsgrbh1xcBvNi+OMHXQNPGWz=Y3zhBtsTZ-Ccbdiio0Q@mail.gmail.com>
Subject: Re: rtc: ds3232: add temperature support
To: Guenter Roeck <linux@roeck-us.net>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        alexandre.belloni@free-electrons.com, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

2017-06-22 1:24 GMT+03:00 Guenter Roeck <linux@roeck-us.net>:
> On Wed, Jun 21, 2017 at 05:49:43PM +0300, Kirill Esipov wrote:
>> DS3232/DS3234 has the temperature registers with a resolution of
>> 0.25 degree celsius. This enables to get the value through hwmon.
>>
>>       # cat /sys/class/hwmon/hwmon0/temp1_input
>>       37250
>>
>> Signed-off-by: Kirill Esipov <yesipov@gmail.com>
>> ---
>>  drivers/rtc/Kconfig      |  9 ++++++
>>  drivers/rtc/rtc-ds3232.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 93 insertions(+)
>>
>> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
>> index 8d3b95728326..b4a6a916d4df 100644
>> --- a/drivers/rtc/Kconfig
>> +++ b/drivers/rtc/Kconfig
>> @@ -791,6 +791,15 @@ config RTC_DRV_DS3232
>>         This driver can also be built as a module.  If so, the module
>>         will be called rtc-ds3232.
>>
>> +config RTC_DRV_DS3232_HWMON
>> +     bool "HWMON support for Dallas/Maxim DS3232/DS3234"
>> +     depends on RTC_DRV_DS3232 && HWMON
>> +     depends on !(RTC_DRV_DS3232=y && HWMON=m)
>> +     default y
>> +     help
>> +       Say Y here if you want to expose temperature sensor data on
>> +       rtc-ds3232
>> +
>>  config RTC_DRV_PCF2127
>>       tristate "NXP PCF2127"
>>       depends on RTC_I2C_AND_SPI
>> diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
>> index deff431a37c4..f94ff0685942 100644
>> --- a/drivers/rtc/rtc-ds3232.c
>> +++ b/drivers/rtc/rtc-ds3232.c
>> @@ -22,6 +22,8 @@
>>  #include <linux/bcd.h>
>>  #include <linux/slab.h>
>>  #include <linux/regmap.h>
>> +#include <linux/hwmon.h>
>> +#include <linux/hwmon-sysfs.h>
>>
>>  #define DS3232_REG_SECONDS      0x00
>>  #define DS3232_REG_MINUTES      0x01
>> @@ -275,6 +277,86 @@ static int ds3232_update_alarm(struct device *dev, unsigned int enabled)
>>       return ret;
>>  }
>>
>> +/*----------------------------------------------------------------------*/
>> +
>> +#ifdef CONFIG_RTC_DRV_DS3232_HWMON
>> +
>> +/*
>> + * Temperature sensor support for ds3232/ds3234 devices.
>> + */
>> +
>> +#define DS3232_REG_TEMPERATURE       0x11
>> +
>> +/*
>> + * A user-initiated temperature conversion is not started by this function,
>> + * so the temperature is updated once every 64 seconds.
>> + */
>> +static int ds3232_hwmon_read_temp(struct device *dev, s32 *mC)
>> +{
>> +     struct ds3232 *ds3232 = dev_get_drvdata(dev);
>> +     u8 temp_buf[2];
>> +     s16 temp;
>> +     int ret;
>> +
>> +     ret = regmap_bulk_read(ds3232->regmap, DS3232_REG_TEMPERATURE, temp_buf,
>> +                             sizeof(temp_buf));
>> +
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     /*
>> +      * Temperature is represented as a 10-bit code with a resolution of
>> +      * 0.25 degree celsius and encoded in two's complement format.
>> +      */
>> +     temp = (temp_buf[0] << 8) | temp_buf[1];
>> +     temp >>= 6;
>> +     *mC = temp * 250;
>> +
>> +     return 0;
>> +}
>> +
>> +static ssize_t ds3232_hwmon_show_temp(struct device *dev,
>> +                             struct device_attribute *attr, char *buf)
>> +{
>> +     int ret;
>> +     s32 temp;
>> +
>> +     ret = ds3232_hwmon_read_temp(dev, &temp);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     return sprintf(buf, "%d\n", temp);
>> +}
>> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, ds3232_hwmon_show_temp,
>> +                     NULL, 0);
>> +
>> +static struct attribute *ds3232_hwmon_attrs[] = {
>> +     &sensor_dev_attr_temp1_input.dev_attr.attr,
>> +     NULL,
>> +};
>> +ATTRIBUTE_GROUPS(ds3232_hwmon);
>> +
>> +static void ds3232_hwmon_register(struct device *dev, const char *name)
>> +{
>> +     struct ds3232 *ds3232 = dev_get_drvdata(dev);
>> +     struct device *hwmon_dev;
>> +
>> +     hwmon_dev = devm_hwmon_device_register_with_groups(dev, name, ds3232,
>> +                                                        ds3232_hwmon_groups);
>
> Any reason for not using devm_hwmon_device_register_with_info() ?
>


Just to keep uniformity,  because other rtc drivers with hwmon
(rtc-ds1307, rtc-rv3029c2) use
devm_hwmon_device_register_with_groups().


> Guenter
>
>> +     if (IS_ERR(hwmon_dev)) {
>> +             dev_warn(dev, "unable to register hwmon device %ld\n",
>> +                      PTR_ERR(hwmon_dev));
>> +     }
>> +}
>> +
>> +#else
>> +
>> +static void ds3232_hwmon_register(struct ds3232 *ds3232)
>> +{
>> +}
>> +
>> +#endif
>> +
>>  static int ds3232_alarm_irq_enable(struct device *dev, unsigned int enabled)
>>  {
>>       struct ds3232 *ds3232 = dev_get_drvdata(dev);
>> @@ -366,6 +448,8 @@ static int ds3232_probe(struct device *dev, struct regmap *regmap, int irq,
>>       if (ds3232->irq > 0)
>>               device_init_wakeup(dev, 1);
>>
>> +     ds3232_hwmon_register(dev, name);
>> +
>>       ds3232->rtc = devm_rtc_device_register(dev, name, &ds3232_rtc_ops,
>>                                               THIS_MODULE);
>>       if (IS_ERR(ds3232->rtc))



-- 
Kirill Esipov
