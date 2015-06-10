Return-Path: <rtc-linux+bncBAABBFVM4GVQKGQE4O6DMGY@googlegroups.com>
Received: from mx.dave-tech.it (mx.dave-tech.it. [2.229.21.40])
        by gmr-mx.google.com with ESMTP id t6si281550wiz.0.2015.06.10.08.21.58
        for <rtc-linux@googlegroups.com>;
        Wed, 10 Jun 2015 08:21:58 -0700 (PDT)
Message-ID: <55785615.4050709@dave-tech.it>
Date: Wed, 10 Jun 2015 17:21:57 +0200
From: Andrea Scian <rnd4@dave-tech.it>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: r.cerrato@til-technologies.fr, a.zummo@towertech.it,
 rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
 Andrea Scian <andrea.scian@dave.eu>
Subject: Re: [rtc-linux] [PATCH] driver: rtc: pcf2127: use OFS flag to detect
 unreliable date and warn the user
References: <1432628260-24652-1-git-send-email-rnd4@dave-tech.it> <20150608154251.GC5222@piout.net>
In-Reply-To: <20150608154251.GC5222@piout.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>


Dear Alexandre,

On 08/06/2015 17:42, Alexandre Belloni wrote:
> Hi,
>
> This seems ok, a few comments below:
>
> On 26/05/2015 at 10:17:40 +0200, rnd4@dave-tech.it wrote :
>> From: Andrea Scian <andrea.scian@dave.eu>
>>
>> I'm using PCF2127 in a custom ARM-based board and, by looking into PCF2127 datasheet
>> I've found that, in my understanding, it's wrong to say that the date in unreliable
>> if BLF (battery low flag) is set but you should use OSF flag (seconds register) to
>> check if oscillator, for any reason, stopped.
>> Battery may be low (usually below 2V5 threshold) but the date may be anyway correct
>> (tipically date is unreliable when input voltage is below 1V2).
>
> typically -^


wooops.. thanks

>
>> diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
>> index 1ee514a..2365788 100644
>> --- a/drivers/rtc/rtc-pcf2127.c
>> +++ b/drivers/rtc/rtc-pcf2127.c
>> @@ -59,7 +59,16 @@ static int pcf2127_get_datetime(struct i2c_client *client, struct rtc_time *tm)
>>   	if (buf[PCF2127_REG_CTRL3] & 0x04) {
>>   		pcf2127->voltage_low = 1;
>>   		dev_info(&client->dev,
>> -			"low voltage detected, date/time is not reliable.\n");
>> +			"low voltage detected, check/replace RTC battery.\n");
>> +	}
>> +
>> +	if (buf[PCF2127_REG_SC] & 0x80) {
>
> Maybe use a define instead of 0x80, remember to use the BIT() macro.

I'll fix it

I'll also use BIT() for the 0x04 above (in a different commit)

>
>> +		dev_warn(&client->dev,
>> +			"oscillator stop detected, date/time is not reliable.\n");
>
> I would return -EINVAL here because the result might still pass
> rtc_valid_tm() but be outdated.

At first look I agree with you, but a bit later they say:

/* the clock can give out invalid datetime, but we cannot return
  * -EINVAL otherwise hwclock will refuse to set the time on bootup.
  */

http://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/tree/drivers/rtc/rtc-pcf2127.c#n91

so they don't actually return -EINVAL even if rtc_valid_tm() fails.
WDYT? I'm not an RTC subsystem expert, so maybe I'm missing something..

If the comment above is correct, so we can't return -EINVAL, I will 
reset the time to epoch, with something like

rtc_time64_to_tm((time64_t)0, tm);

and issue the warning.
Later userspace script usually reset the time to /etc/timestamp to avoid 
"back to future" problems ;-)

>
>> +		/*
>> +		 * no need clear the flag here,
>> +		 * it will be cleared once the new date is saved
>> +		 */
>>   	}
>>
>>   	dev_dbg(&client->dev,
>> @@ -112,7 +121,7 @@ static int pcf2127_set_datetime(struct i2c_client *client, struct rtc_time *tm)
>>   	buf[i++] = PCF2127_REG_SC;
>>
>>   	/* hours, minutes and seconds */
>> -	buf[i++] = bin2bcd(tm->tm_sec);
>> +	buf[i++] = bin2bcd(tm->tm_sec);	/* this will also clear OFS flag */
>>   	buf[i++] = bin2bcd(tm->tm_min);
>>   	buf[i++] = bin2bcd(tm->tm_hour);
>>   	buf[i++] = bin2bcd(tm->tm_mday);
>> @@ -144,7 +153,7 @@ static int pcf2127_rtc_ioctl(struct device *dev,
>>   	switch (cmd) {
>>   	case RTC_VL_READ:
>>   		if (pcf2127->voltage_low)
>> -			dev_info(dev, "low voltage detected, date/time is not reliable.\n");
>> +			dev_info(dev, "low voltage detected, check/replace battery\n");
>
> I would also print a warning about OFS here.
>

I'll do.
Do you think is better to add another variable inside struct pcf2127 or 
is better to re-read the RTC registers?
(for the former I have also to clear the variable inside 
pcf2127_set_datetime(), for the latter I have to issue another read in a 
function that, at the moment, does not read anything..)

Thanks for you feedback and kind regards,

-- 

Andrea SCIAN

DAVE Embedded Systems

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
