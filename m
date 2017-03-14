Return-Path: <rtc-linux+bncBC2IF264UIPRBN4DUDDAKGQE6OVFS7Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk. [46.235.227.227])
        by gmr-mx.google.com with ESMTPS id f7si979017wmg.3.2017.03.14.07.44.07
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Mar 2017 07:44:07 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH v3 4/4] mfd: cros_ec: add RTC as mfd subdevice
To: Lee Jones <lee.jones@linaro.org>
References: <20170214221529.6434-1-enric.balletbo@collabora.com>
 <20170214221529.6434-4-enric.balletbo@collabora.com>
 <20170314135932.ngn7uh67duzroy47@dell>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
 Olof Johansson <olof@lixom.net>, Stephen Barber <smbarber@chromium.org>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <f934a89e-8f0b-5a74-1c6f-8b9f1d85ba72@collabora.com>
Date: Tue, 14 Mar 2017 15:44:03 +0100
MIME-Version: 1.0
In-Reply-To: <20170314135932.ngn7uh67duzroy47@dell>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Lee,

On 14/03/17 14:59, Lee Jones wrote:
> On Tue, 14 Feb 2017, Enric Balletbo i Serra wrote:
> 
>> From: Stephen Barber <smbarber@chromium.org>
>>
>> If the EC supports RTC host commands, expose an RTC device.
>>
>> Signed-off-by: Stephen Barber <smbarber@chromium.org>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> Acked-by: Benson Leung <bleung@chromium.org>
>> ---
>> Changes since v2:
>>  - Acked by Benson Leung
>> Changes since v1:
>>  - none
>>
>>  drivers/platform/chrome/cros_ec_dev.c | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/drivers/platform/chrome/cros_ec_dev.c b/drivers/platform/chrome/cros_ec_dev.c
>> index 47268ec..ebe029d 100644
>> --- a/drivers/platform/chrome/cros_ec_dev.c
>> +++ b/drivers/platform/chrome/cros_ec_dev.c
>> @@ -383,6 +383,24 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
>>  	kfree(msg);
>>  }
>>  
>> +static const struct mfd_cell cros_ec_rtc_devs[] = {
>> +	{
>> +		.name = "cros-ec-rtc",
>> +		.id   = -1,
>> +	},
>> +};
>> +
>> +static void cros_ec_rtc_register(struct cros_ec_dev *ec)
>> +{
>> +	int ret;
>> +
>> +	ret = mfd_add_devices(ec->dev, 0, cros_ec_rtc_devs,
>> +			      ARRAY_SIZE(cros_ec_rtc_devs),
>> +			      NULL, 0, NULL);
>> +	if (ret)
>> +		dev_err(ec->dev, "failed to add cros-ec-rtc device: %d\n", ret);
>> +}
> 
> Holey poop!  Why are you using the MFD API outside of MFD?
> 
> Why can't you register this from the MFD driver?
> 

Actually the MFD doesn't know how to check if this feature is available or not,
instead is the platform driver cros_ec_dev who knows how to check this and if it
exists adds the rtc device.

if (cros_ec_check_features(ec, EC_FEATURE_RTC))
	cros_ec_rtc_register(ec); /* add the mfd device */

Same approach was used in the same file for the Sensors Hub (already upstream). See:

  drivers/platform/chrome/cros_ec_dev.c:462
  drivers/platform/chrome/cros_ec_dev.c:372

I didn't know that the MFD API was restricted outside MFD. In such case what I
need to do is let know the MFD driver about the cros_ec_check_features
(implemented in platform driver cros_ec_dev), this doesn't seems good to me but
I might be wrong. So please, let me know which option do you prefer and if it's
the case we will need to change I'll try to do it.

Note that I think that a similar use case is used in
drivers/iio/common/ssp_sensors/ssp_dev.c:535, where the iio driver registers the
sensors to the mfd.

Thanks,
  Enric

>>  static int ec_device_probe(struct platform_device *pdev)
>>  {
>>  	int retval = -ENOMEM;
>> @@ -441,6 +459,10 @@ static int ec_device_probe(struct platform_device *pdev)
>>  	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
>>  		cros_ec_sensors_register(ec);
>>  
>> +	/* check whether this EC instance has RTC host command support */
>> +	if (cros_ec_check_features(ec, EC_FEATURE_RTC))
>> +		cros_ec_rtc_register(ec);
>> +
>>  	return 0;
>>  
>>  dev_reg_failed:
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
