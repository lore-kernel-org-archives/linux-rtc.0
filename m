Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34125 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751157AbdFYQju (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 25 Jun 2017 12:39:50 -0400
MIME-Version: 1.0
In-Reply-To: <1498150704-21777-1-git-send-email-yesipov@gmail.com>
References: <1498150704-21777-1-git-send-email-yesipov@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 25 Jun 2017 19:39:48 +0300
Message-ID: <CAHp75Vd-CoKpt0dhXspCDLSoohEVRTHEEPn9jZtFqUwvAeB1bA@mail.gmail.com>
Subject: Re: [PATCH v2] rtc: ds3232: add temperature support
To: Kirill Esipov <yesipov@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, Jun 22, 2017 at 7:58 PM, Kirill Esipov <yesipov@gmail.com> wrote:
> DS3232/DS3234 has the temperature registers with a resolution of 0.25
> degree celsius. This enables to get the value through hwmon.
>
>         # cat /sys/class/hwmon/hwmon0/temp1_input
>         37250

> +config RTC_DRV_DS3232_HWMON
> +       bool "HWMON support for Dallas/Maxim DS3232/DS3234"

> +       depends on RTC_DRV_DS3232 && HWMON
> +       depends on !(RTC_DRV_DS3232=y && HWMON=m)

Perhaps it might be squeezed into one line (something like that logic
has been required by I2C related PMIC IIRC)

> +       default y

Is it really sane default?

> +#ifdef CONFIG_RTC_DRV_DS3232_HWMON

IS_BUILTIN() ?

> +static int ds3232_hwmon_read_temp(struct device *dev, long int *mC)
> +{
> +       struct ds3232 *ds3232 = dev_get_drvdata(dev);
> +       u8 temp_buf[2];
> +       s16 temp;
> +       int ret;
> +
> +       ret = regmap_bulk_read(ds3232->regmap, DS3232_REG_TEMPERATURE, temp_buf,
> +                               sizeof(temp_buf));

> +

Remove.

> +       if (ret < 0)
> +               return ret;

> +static umode_t ds3232_hwmon_is_visible(const void *data,
> +                                        enum hwmon_sensor_types type,
> +                                        u32 attr, int channel)
> +{
> +       if (type != hwmon_temp)
> +               return 0;
> +
> +       switch (attr) {
> +       case hwmon_temp_input:
> +               return 0444;
> +       default:
> +               return 0;
> +       }
> +}
> +
> +static int ds3232_hwmon_read(struct device *dev,
> +                              enum hwmon_sensor_types type,
> +                              u32 attr, int channel, long *temp)
> +{
> +       int err;
> +
> +       switch (attr) {
> +       case hwmon_temp_input:
> +               ds3232_hwmon_read_temp(dev, temp);
> +               err = 0;
> +               break;
> +       default:
> +               return -EOPNOTSUPP;
> +       }
> +
> +       return err;

You may do as in previous function. Or what did you mean here by
introducing an err variable?

> +}

> +
> +

Remove one of them.

> +static void ds3232_hwmon_register(struct device *dev, const char *name)
> +{
> +       struct ds3232 *ds3232 = dev_get_drvdata(dev);
> +       struct device *hwmon_dev;
> +
> +       hwmon_dev = devm_hwmon_device_register_with_info(dev, name, ds3232,
> +                                                       &ds3232_hwmon_chip_info,
> +                                                       NULL);

> +

Remove.

> +       if (IS_ERR(hwmon_dev)) {
> +               dev_warn(dev, "unable to register hwmon device %ld\n",
> +                        PTR_ERR(hwmon_dev));
> +       }
> +}
> +

> +#else

I dunno which style is preferred, though you may use
if (IS_BUILTIN(...))
 return;

at the beginning of the function and allow gcc optimizer to take care
of everything else.

> +
> +static void ds3232_hwmon_register(struct device *dev, const char *name)
> +{
> +}
> +
> +#endif

-- 
With Best Regards,
Andy Shevchenko
