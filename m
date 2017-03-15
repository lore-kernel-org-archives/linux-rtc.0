Return-Path: <rtc-linux+bncBC2IF264UIPRBDWIUTDAKGQEKSWYTNY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk. [46.235.227.227])
        by gmr-mx.google.com with ESMTPS id 82si5987wmg.3.2017.03.15.04.22.54
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Mar 2017 04:22:54 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH v3 4/4] mfd: cros_ec: add RTC as mfd subdevice
To: Lee Jones <lee.jones@linaro.org>
References: <20170214221529.6434-1-enric.balletbo@collabora.com>
 <20170214221529.6434-4-enric.balletbo@collabora.com>
 <20170314135932.ngn7uh67duzroy47@dell>
 <f934a89e-8f0b-5a74-1c6f-8b9f1d85ba72@collabora.com>
 <20170315102449.bqr3hezlrdovjyrq@dell>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
 Olof Johansson <olof@lixom.net>, Stephen Barber <smbarber@chromium.org>,
 Jonathan Cameron <jic23@cam.ac.uk>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <8af5c9ae-e00a-e841-6d1b-2271ce924703@collabora.com>
Date: Wed, 15 Mar 2017 12:22:50 +0100
MIME-Version: 1.0
In-Reply-To: <20170315102449.bqr3hezlrdovjyrq@dell>
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

On 15/03/17 11:24, Lee Jones wrote:
> On Tue, 14 Mar 2017, Enric Balletbo i Serra wrote:
>> On 14/03/17 14:59, Lee Jones wrote:
>>> On Tue, 14 Feb 2017, Enric Balletbo i Serra wrote:
>>>
>>>> From: Stephen Barber <smbarber@chromium.org>
>>>>
>>>> If the EC supports RTC host commands, expose an RTC device.
>>>>
>>>> Signed-off-by: Stephen Barber <smbarber@chromium.org>
>>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>>> Acked-by: Benson Leung <bleung@chromium.org>
>>>> ---
>>>> Changes since v2:
>>>>  - Acked by Benson Leung
>>>> Changes since v1:
>>>>  - none
>>>>
>>>>  drivers/platform/chrome/cros_ec_dev.c | 22 ++++++++++++++++++++++
>>>>  1 file changed, 22 insertions(+)
>>>>
>>>> diff --git a/drivers/platform/chrome/cros_ec_dev.c b/drivers/platform/chrome/cros_ec_dev.c
>>>> index 47268ec..ebe029d 100644
>>>> --- a/drivers/platform/chrome/cros_ec_dev.c
>>>> +++ b/drivers/platform/chrome/cros_ec_dev.c
>>>> @@ -383,6 +383,24 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
>>>>  	kfree(msg);
>>>>  }
>>>>  
>>>> +static const struct mfd_cell cros_ec_rtc_devs[] = {
>>>> +	{
>>>> +		.name = "cros-ec-rtc",
>>>> +		.id   = -1,
>>>> +	},
>>>> +};
>>>> +
>>>> +static void cros_ec_rtc_register(struct cros_ec_dev *ec)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	ret = mfd_add_devices(ec->dev, 0, cros_ec_rtc_devs,
>>>> +			      ARRAY_SIZE(cros_ec_rtc_devs),
>>>> +			      NULL, 0, NULL);
>>>> +	if (ret)
>>>> +		dev_err(ec->dev, "failed to add cros-ec-rtc device: %d\n", ret);
>>>> +}
>>>
>>> Holey poop!  Why are you using the MFD API outside of MFD?
>>>
>>> Why can't you register this from the MFD driver?
>>>
>>
>> Actually the MFD doesn't know how to check if this feature is available or not,
>> instead is the platform driver cros_ec_dev who knows how to check this and if it
>> exists adds the rtc device.
>>
>> if (cros_ec_check_features(ec, EC_FEATURE_RTC))
>> 	cros_ec_rtc_register(ec); /* add the mfd device */
>>
>> Same approach was used in the same file for the Sensors Hub (already upstream). See:
>>
>>   drivers/platform/chrome/cros_ec_dev.c:462
>>   drivers/platform/chrome/cros_ec_dev.c:372
>>
>> I didn't know that the MFD API was restricted outside MFD. In such case what I
>> need to do is let know the MFD driver about the cros_ec_check_features
>> (implemented in platform driver cros_ec_dev), this doesn't seems good to me but
>> I might be wrong. So please, let me know which option do you prefer and if it's
>> the case we will need to change I'll try to do it.
>>
>> Note that I think that a similar use case is used in
>> drivers/iio/common/ssp_sensors/ssp_dev.c:535, where the iio driver registers the
>> sensors to the mfd.
> 
> It would be advantageous to avoid a web of inter-subsystem calls to
> register devices.  I think I could bear calls to mfd_add_* from
> drivers/platform, as the two subsystems are fairly interchangeable,
> and it does have the added benefit of saving duplication of the device
> registering code.  Calling mfd_add_* from IIO seems plain wrong though.
> 
> A better solution however and one that we've utilised in the past is
> to have the MFD drivers call into the platform (i.e. drivers/platform)
> drivers to see if certain devices are available.  Is this possible in
> your use-case?
> 

So just to be clear before I start to work on it. What you want is I get rid of
the MFD stuff from drivers/platform/chrome/cros_ec_dev and move to
drivers/mfd/cros_ec.c. The platform/chrome driver should publish how to check
the features and leave the mfd/cros_ec driver add the MFD subdevices.

For this patch series this means get rid of:

drivers/platform/chrome/cros_ec_dev.c:412:static const struct mfd_cell
cros_ec_rtc_devs[] ...

drivers/platform/chrome/cros_ec_dev.c:404: ret = mfd_add_devices(ec->dev,
0,cros_ec_rtc_devs ...

As I said the sensors subdevice (which is already upstream) uses the same
approach, so I think you will also want do the same for the sensors subdevice?
Sounds good if first we try to land the RTC part and the I'll prepare a patch
series to fix the sensors hub part?

> NB: I've just had a look at the SSP IIO driver and I have a number of
> problems with it.  You should not be using that as a good example of
> why mfd_add_* should be used outside of MFD.
> 

Yeah, I did not try to use the SSP IIO driver as a good example to justify
myself, I just wasted let you know that the approach we used is also used in
other cases, thus if the approach is wrong we should have in mind that we should
also fix the SSP IIO driver. Just this.

Thanks,
 Enric

>>>>  static int ec_device_probe(struct platform_device *pdev)
>>>>  {
>>>>  	int retval = -ENOMEM;
>>>> @@ -441,6 +459,10 @@ static int ec_device_probe(struct platform_device *pdev)
>>>>  	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
>>>>  		cros_ec_sensors_register(ec);
>>>>  
>>>> +	/* check whether this EC instance has RTC host command support */
>>>> +	if (cros_ec_check_features(ec, EC_FEATURE_RTC))
>>>> +		cros_ec_rtc_register(ec);
>>>> +
>>>>  	return 0;
>>>>  
>>>>  dev_reg_failed:
>>>
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
