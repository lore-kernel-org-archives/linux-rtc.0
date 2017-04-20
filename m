Return-Path: <rtc-linux+bncBC2IF264UIPRBEUN4LDQKGQEECQH52Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk. [2a00:1098:0:82:1000:25:2eeb:e3e3])
        by gmr-mx.google.com with ESMTPS id p10si1725046wmg.1.2017.04.20.02.59.46
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 02:59:46 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH v2 5/5] mfd: cros_ec: add RTC as mfd subdevice
To: Lee Jones <lee.jones@linaro.org>
References: <20170403163536.25634-1-enric.balletbo@collabora.com>
 <20170403163536.25634-6-enric.balletbo@collabora.com>
 <20170411094825.64kwe5uckdpc3n4q@dell>
Cc: Jonathan Cameron <jic23@kernel.org>, Olof Johansson <olof@lixom.net>,
 bleung@chromium.org, martinez.javier@gmail.com,
 Guenter Roeck <groeck@chromium.org>, Gwendal Grignou <gwendal@chromium.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 rtc-linux@googlegroups.com, Stephen Barber <smbarber@chromium.org>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <ecd78225-582d-92bd-deb3-34cf46bf922a@collabora.com>
Date: Thu, 20 Apr 2017 11:59:42 +0200
MIME-Version: 1.0
In-Reply-To: <20170411094825.64kwe5uckdpc3n4q@dell>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Lee,

On 11/04/17 11:48, Lee Jones wrote:
> On Mon, 03 Apr 2017, Enric Balletbo i Serra wrote:
> 
>> From: Stephen Barber <smbarber@chromium.org>
>>
>> If the EC supports RTC host commands, expose an RTC device.
> 
> This could be made nicer by checking RTC compatibility in the RTC
> driver.  So register it regardless, then check if the device is
> supported from within.  If it's not supported simply return -ENODEV
> from probe.
> 

Currently rtc-cros-ec and the other subdevices doesn't know how to check the
cros-ec MFD features, to do this I need to export cros_ec_check_features to a
public header and the rtc and other subdrivers should call the check function.

Seems to me more reasonable that the MFD checks the possible cells that can have
and only register the ones that really has (the cros-ec MFD can have different
cells depending on the device). Call every probe for all possible cells seems to
me a unnecessary step. The MFD is able to know which cells has, so IMHO then the
subdrivers are more independent of the MFD.

It's just an opinion so I'll let you the final decision.

Cheers,
 Enric

>> Signed-off-by: Stephen Barber <smbarber@chromium.org>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>> Changes since v1:
>>  - Use PLATFORM_DEVID_AUTO to add the subdevice.
>>
>>  drivers/mfd/cros_ec.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
>> index bbc17ab..76874be 100644
>> --- a/drivers/mfd/cros_ec.c
>> +++ b/drivers/mfd/cros_ec.c
>> @@ -51,6 +51,10 @@ static const struct mfd_cell ec_pd_cell = {
>>  	.pdata_size = sizeof(pd_p),
>>  };
>>  
>> +static const struct mfd_cell ec_rtc_cell = {
>> +	.name = "cros-ec-rtc",
>> +};
>> +
>>  static irqreturn_t ec_irq_thread(int irq, void *data)
>>  {
>>  	struct cros_ec_device *ec_dev = data;
>> @@ -238,6 +242,16 @@ static void cros_ec_sensors_register(struct cros_ec_device *ec_dev)
>>  	kfree(msg);
>>  }
>>  
>> +static void cros_ec_rtc_register(struct cros_ec_device *ec_dev)
>> +{
>> +	int ret;
>> +
>> +	ret = mfd_add_devices(ec_dev->dev, PLATFORM_DEVID_AUTO, &ec_rtc_cell,
>> +			      1, NULL, 0, NULL);
>> +	if (ret)
>> +		dev_err(ec_dev->dev, "failed to add EC RTC\n");
>> +}
>> +
>>  int cros_ec_register(struct cros_ec_device *ec_dev)
>>  {
>>  	struct device *dev = ec_dev->dev;
>> @@ -287,6 +301,10 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>>  	if (cros_ec_check_features(ec_dev, EC_FEATURE_MOTION_SENSE))
>>  		cros_ec_sensors_register(ec_dev);
>>  
>> +	/* Check whether this EC has RTC support */
>> +	if (cros_ec_check_features(ec_dev, EC_FEATURE_RTC))
>> +		cros_ec_rtc_register(ec_dev);
>> +
>>  	if (ec_dev->max_passthru) {
>>  		/*
>>  		 * Register a PD device as well on top of this device.
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
