Return-Path: <rtc-linux+bncBDKY3XOCXMIBBL6KTDCAKGQEHTZ5RXQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com. [2607:f8b0:4001:c0b::242])
        by gmr-mx.google.com with ESMTPS id n132si1623550ith.0.2017.01.23.07.45.51
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jan 2017 07:45:51 -0800 (PST)
Received: by mail-it0-x242.google.com with SMTP id o185so10576717itb.1
        for <rtc-linux@googlegroups.com>; Mon, 23 Jan 2017 07:45:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170123121412.GL16020@dell>
References: <20170119123032.24679-1-enric.balletbo@collabora.com>
 <20170119123032.24679-4-enric.balletbo@collabora.com> <20170123121412.GL16020@dell>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Mon, 23 Jan 2017 16:45:51 +0100
Message-ID: <CAFqH_537y+mP6rNorXS12wvxEeg8h_-Zz8jxex-4eqhy-weNyA@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v2 4/4] mfd: cros_ec: add RTC as mfd subdevice
To: Lee Jones <lee.jones@linaro.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, rtc-linux@googlegroups.com,
	Olof Johansson <olof@lixom.net>, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Stephen Barber <smbarber@chromium.org>, Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Guess I forget to add one of the platform/chrome maintainers, as only
his ack is pending for this series, cc'ing Benson Leung

Thanks,
 Enric


2017-01-23 13:14 GMT+01:00 Lee Jones <lee.jones@linaro.org>:
> On Thu, 19 Jan 2017, Enric Balletbo i Serra wrote:
>
>> From: Stephen Barber <smbarber@chromium.org>
>>
>> If the EC supports RTC host commands, expose an RTC device.
>>
>> Signed-off-by: Stephen Barber <smbarber@chromium.org>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>  drivers/platform/chrome/cros_ec_dev.c | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>
> This still needs an Ack.
>
>> diff --git a/drivers/platform/chrome/cros_ec_dev.c b/drivers/platform/ch=
rome/cros_ec_dev.c
>> index 47268ec..ebe029d 100644
>> --- a/drivers/platform/chrome/cros_ec_dev.c
>> +++ b/drivers/platform/chrome/cros_ec_dev.c
>> @@ -383,6 +383,24 @@ static void cros_ec_sensors_register(struct cros_ec=
_dev *ec)
>>       kfree(msg);
>>  }
>>
>> +static const struct mfd_cell cros_ec_rtc_devs[] =3D {
>> +     {
>> +             .name =3D "cros-ec-rtc",
>> +             .id   =3D -1,
>> +     },
>> +};
>> +
>> +static void cros_ec_rtc_register(struct cros_ec_dev *ec)
>> +{
>> +     int ret;
>> +
>> +     ret =3D mfd_add_devices(ec->dev, 0, cros_ec_rtc_devs,
>> +                           ARRAY_SIZE(cros_ec_rtc_devs),
>> +                           NULL, 0, NULL);
>> +     if (ret)
>> +             dev_err(ec->dev, "failed to add cros-ec-rtc device: %d\n",=
 ret);
>> +}
>> +
>>  static int ec_device_probe(struct platform_device *pdev)
>>  {
>>       int retval =3D -ENOMEM;
>> @@ -441,6 +459,10 @@ static int ec_device_probe(struct platform_device *=
pdev)
>>       if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
>>               cros_ec_sensors_register(ec);
>>
>> +     /* check whether this EC instance has RTC host command support */
>> +     if (cros_ec_check_features(ec, EC_FEATURE_RTC))
>> +             cros_ec_rtc_register(ec);
>> +
>>       return 0;
>>
>>  dev_reg_failed:
>
> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog

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
