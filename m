Return-Path: <rtc-linux+bncBCKMZDW5VIHBBT6BR62QKGQEZK35RCQ@googlegroups.com>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net. [208.91.199.152])
        by gmr-mx.google.com with ESMTPS id s18si515083igr.3.2016.01.23.12.21.34
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 23 Jan 2016 12:21:34 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH v3] rtc: rtc-ds1307: add temperature sensor
 support for ds3231
To: Akinobu Mita <akinobu.mita@gmail.com>, rtc-linux@googlegroups.com
References: <1453574832-21908-1-git-send-email-akinobu.mita@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Jean Delvare <jdelvare@suse.com>, lm-sensors@lm-sensors.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56A3E0C9.609@roeck-us.net>
Date: Sat, 23 Jan 2016 12:21:29 -0800
MIME-Version: 1.0
In-Reply-To: <1453574832-21908-1-git-send-email-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 01/23/2016 10:47 AM, Akinobu Mita wrote:
> DS3231 has the temperature registers with a resolution of 0.25
> degree celsius.  This enables to get the value through hwmon.
>
> 	# cat /sys/class/i2c-adapter/i2c-2/2-0068/hwmon/hwmon0/temp1_input
> 	21000
>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: rtc-linux@googlegroups.com
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: lm-sensors@lm-sensors.org

[ I would suggest to drop the Cc: mailing lists for future submissions.
   Sure, you want to send the patch to the lists, but that doesn't mean
   that the lists should be in the commit log. ]

Much better. Couple of nitpicks below. Feel free to resubmit or not
with those changed. Either case,

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
> * v3 (all changes are suggested by Guenter Roeck)
> - add RTC_DRV_DS1307_HWMON config option to fix an issue when the ds1307
>    driver is built into the kernel but hwmon is built as module.
> - don't start user-initiated temperature conversion when reading temperature,
>    just relying on internal/automatic conversions.
>
>   drivers/rtc/Kconfig      |  9 +++++
>   drivers/rtc/rtc-ds1307.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 102 insertions(+)
>
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 2a52424..73a7e51 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -212,6 +212,15 @@ config RTC_DRV_DS1307
>   	  This driver can also be built as a module. If so, the module
>   	  will be called rtc-ds1307.
>
> +config RTC_DRV_DS1307_HWMON
> +	bool "HWMON support for rtc-ds1307"
> +	depends on RTC_DRV_DS1307 && HWMON
> +	depends on !(RTC_DRV_DS1307=y && HWMON=m)
> +	default y
> +	help
> +	  Say Y here if you want to expose temperature sensor data on
> +	  rtc-ds1307 (only DS3231)
> +
>   config RTC_DRV_DS1374
>   	tristate "Dallas/Maxim DS1374"
>   	help
> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
> index aa705bb..3712fb3 100644
> --- a/drivers/rtc/rtc-ds1307.c
> +++ b/drivers/rtc/rtc-ds1307.c
> @@ -19,6 +19,9 @@
>   #include <linux/rtc.h>
>   #include <linux/slab.h>
>   #include <linux/string.h>
> +#include <linux/delay.h>

Now unnecessary.

> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
>
>   /*
>    * We can't determine type by probing, but if we expect pre-Linux code
> @@ -851,6 +854,94 @@ out:
>   	return;
>   }
>
> +/*----------------------------------------------------------------------*/
> +
> +#ifdef CONFIG_RTC_DRV_DS1307_HWMON
> +
> +/*
> + * Temperature sensor support for ds3231 devices.
> + */
> +
> +#define DS3231_REG_TEMPERATURE	0x11
> +
> +/*
> + * A user-initiated temperature conversion is not started by this function,
> + * so the temperature is updated once every 64 seconds.
> + */
> +static int ds3231_hwmon_read_temp(struct device *dev, s16 *mC)
> +{
> +	struct ds1307 *ds1307 = dev_get_drvdata(dev);
> +	u8 temp_buf[2];
> +	s16 temp;
> +	s32 ret;

int ret ?

> +
> +	ret = ds1307->read_block_data(ds1307->client, DS3231_REG_TEMPERATURE,
> +					sizeof(temp_buf), temp_buf);
> +	if (ret < 0)
> +		return ret;
> +	if (ret != sizeof(temp_buf))
> +		return -EIO;
> +
> +	/*
> +	 * Temperature is represented as a 10-bit code with a resolution of
> +	 * 0.25 degree celsius and encoded in two's complement format.
> +	 */
> +	temp = (temp_buf[0] << 8) | temp_buf[1];
> +	temp >>= 6;
> +	*mC = temp * 250;
> +
> +	return 0;
> +}
> +
> +static ssize_t ds3231_hwmon_show_temp(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	int ret;
> +	s16 temp;
> +
> +	ret = ds3231_hwmon_read_temp(dev, &temp);
> +	if (ret)
> +		return ret;
> +
> +	return sprintf(buf, "%d\n", temp);
> +}
> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, ds3231_hwmon_show_temp,
> +			NULL, 0);
> +
> +static struct attribute *ds3231_hwmon_attrs[] = {
> +	&sensor_dev_attr_temp1_input.dev_attr.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(ds3231_hwmon);
> +
> +static int ds1307_hwmon_register(struct ds1307 *ds1307)

The return value is never used, so you might as well return void.

> +{
> +	struct device *dev;
> +
> +	if (ds1307->type != ds_3231)
> +		return 0;
> +
> +	dev = devm_hwmon_device_register_with_groups(&ds1307->client->dev,
> +						ds1307->client->name,
> +						ds1307, ds3231_hwmon_groups);
> +	if (IS_ERR(dev)) {
> +		dev_warn(&ds1307->client->dev,
> +			"unable to register hwmon device %ld\n", PTR_ERR(dev));
> +		return PTR_ERR(dev);
> +	}
> +
> +	return 0;
> +}
> +
> +#else
> +
> +static int ds1307_hwmon_register(struct ds1307 *ds1307)
> +{
> +	return 0;
> +}
> +
> +#endif
> +
>   static int ds1307_probe(struct i2c_client *client,
>   			const struct i2c_device_id *id)
>   {
> @@ -1191,6 +1282,8 @@ read_rtc:
>   		}
>   	}
>
> +	ds1307_hwmon_register(ds1307);
> +
>   	return 0;
>
>   exit:
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
