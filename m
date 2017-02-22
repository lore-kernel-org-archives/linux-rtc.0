Return-Path: <rtc-linux+bncBCVK5RWD2QBRBZWUWPCQKGQEJLVVJCI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from anchovy.45ru.net.au (anchovy1.45ru.net.au. [203.30.46.145])
        by gmr-mx.google.com with ESMTPS id h130si3331559pfe.1.2017.02.21.17.33.24
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Feb 2017 17:33:25 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH 3/3] rtc: ds3232: Call device_init_wakeup
 before device_register
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1487295898-90177-1-git-send-email-preid@electromag.com.au>
 <1487295898-90177-4-git-send-email-preid@electromag.com.au>
 <20170221203305.mkcqv3g4wbbm5js6@piout.net>
Cc: a.zummo@towertech.it, akinobu.mita@gmail.com, rtc-linux@googlegroups.com
From: Phil Reid <preid@electromag.com.au>
Message-ID: <444215ad-ff7e-b5e2-85d8-58edf3ffddcf@electromag.com.au>
Date: Wed, 22 Feb 2017 09:33:14 +0800
MIME-Version: 1.0
In-Reply-To: <20170221203305.mkcqv3g4wbbm5js6@piout.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 22/02/2017 04:33, Alexandre Belloni wrote:
> On 17/02/2017 at 09:44:58 +0800, Phil Reid wrote:
>> The wakealarm attribute is currently not exposed in the sysfs interface
>> as the device has not been set as doing wakealarm when device_register
>> is called. Changing the order of the calls fixes that problem. Interrupts
>> are cleared in check_rtc_status prior to requesting the interrupt.
>>
>
> This basically revert b4b77f3c280e38cec178f81d7a4d7e65f4045913 So I'm
> not sure this is sufficient to ensure the IRQ will never fire.
>
> (I don't know whether this was a real bug or something reported by a
> static analysis tool).

G'day Alexandre,
Without this change the wakealarm sysfs is never created.
This is done in rtc_device_register, but a filter to wakealarm attribute effectively on
dev->power.can_wakeup flag. Which is set via the init wakeup call.

But looking at that commit and thinking about it some more I can see the problem
b4b77f3c280e38cec178f81d7a4d7e65f4045913 was try to solve.

Looking at other drivers some of them have similar order but use their own mutex.
eg rtc-rc8803 and don't use the ops_lock

Or others set device_init_wakeup and then fail if the irq fails to register.

Currently if the ds3232 has an irq set but fails to register the irq it falls back
to being a non wakeup source. To me it makes more sense to just fall if the config
has an irq defined.

Then we could set device_init_wakeup based on there being an irq prior to device_register
and then request the irq after device register. But fail the probe if the irq request fails.

Thoughts?

>
>> Signed-off-by: Phil Reid <preid@electromag.com.au>
>> ---
>>  drivers/rtc/rtc-ds3232.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
>> index 60de3a0..ce943d0 100644
>> --- a/drivers/rtc/rtc-ds3232.c
>> +++ b/drivers/rtc/rtc-ds3232.c
>> @@ -363,11 +363,6 @@ static int ds3232_probe(struct device *dev, struct regmap *regmap, int irq,
>>  	if (ret)
>>  		return ret;
>>
>> -	ds3232->rtc = devm_rtc_device_register(dev, name, &ds3232_rtc_ops,
>> -						THIS_MODULE);
>> -	if (IS_ERR(ds3232->rtc))
>> -		return PTR_ERR(ds3232->rtc);
>> -
>>  	if (ds3232->irq > 0) {
>>  		ret = devm_request_threaded_irq(dev, ds3232->irq, NULL,
>>  						ds3232_irq,
>> @@ -380,6 +375,11 @@ static int ds3232_probe(struct device *dev, struct regmap *regmap, int irq,
>>  			device_init_wakeup(dev, 1);
>>  	}
>>
>> +	ds3232->rtc = devm_rtc_device_register(dev, name, &ds3232_rtc_ops,
>> +		THIS_MODULE);
>> +	if (IS_ERR(ds3232->rtc))
>> +		return PTR_ERR(ds3232->rtc);
>> +
>>  	return 0;
>>  }
>>
>> --
>> 1.8.3.1
>>
>


-- 
Regards
Phil Reid

ElectroMagnetic Imaging Technology Pty Ltd
Development of Geophysical Instrumentation & Software
www.electromag.com.au

3 The Avenue, Midland WA 6056, AUSTRALIA
Ph: +61 8 9250 8100
Fax: +61 8 9250 7100
Email: preid@electromag.com.au

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
