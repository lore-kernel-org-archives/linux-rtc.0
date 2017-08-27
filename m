Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37428 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751152AbdH0Mjh (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 27 Aug 2017 08:39:37 -0400
Received: by mail-wr0-f193.google.com with SMTP id p14so2558581wrg.4
        for <linux-rtc@vger.kernel.org>; Sun, 27 Aug 2017 05:39:37 -0700 (PDT)
Subject: Re: [PATCH] rtc: core: let rtc_set_time properly populate element
 wday
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
References: <3b43da73-ff4e-4519-d1c7-266b17cc5d05@gmail.com>
 <20170826195607.s6p7u7vr3hxhwwqs@piout.net>
 <20170826195947.jnipgyuxg3ceqie4@piout.net>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <a6ccd0ab-a6f4-1122-233b-61e69b80aa54@gmail.com>
Date: Sun, 27 Aug 2017 14:39:26 +0200
MIME-Version: 1.0
In-Reply-To: <20170826195947.jnipgyuxg3ceqie4@piout.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Am 26.08.2017 um 21:59 schrieb Alexandre Belloni:
> On 26/08/2017 at 21:56:07 +0200, Alexandre Belloni wrote:
>> There is no point in fixing that. Nobody uses wday.
>>
> 
> And that was going to be my comment on your other patch. You may as well
> just remove the whole wday correction from ds1307.
> 
Actually I was wondering too when wday should ever be used, except
theoretically for an alarm, however commit e29385fab0bf
"rtc: ds1307: Fix relying on reset value for weekday" was added just
a year ago.

I think then we can remove the usage of wday in general, including
writing / reading wday in ds1307_get/set_time.

>> On 26/08/2017 at 21:16:34 +0200, Heiner Kallweit wrote:
>>> Some drivers use element wday of the struct rtc_time which is passed to
>>> callback set_time. However element wday may incorrectly or not be
>>> populated if struct rtc_time is coming from userspace via rtc_dev_ioctl.
>>> rtc_valid_tm() doesn't check element wday.
>>>
>>> Therefore convert struct rtc_time to time64_t and then use
>>> rtc_time64_to_tm to generate a struct rtc_time with all elements properly
>>> populated.
>>>
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>> ---
>>>  drivers/rtc/interface.c | 24 ++++++++++++++++--------
>>>  1 file changed, 16 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
>>> index 8cec9a02..5a53c590 100644
>>> --- a/drivers/rtc/interface.c
>>> +++ b/drivers/rtc/interface.c
>>> @@ -59,28 +59,36 @@ EXPORT_SYMBOL_GPL(rtc_read_time);
>>>  
>>>  int rtc_set_time(struct rtc_device *rtc, struct rtc_time *tm)
>>>  {
>>> +	time64_t secs64;
>>>  	int err;
>>>  
>>>  	err = rtc_valid_tm(tm);
>>>  	if (err != 0)
>>>  		return err;
>>>  
>>> +	secs64 = rtc_tm_to_time64(tm);
>>> +
>>>  	err = mutex_lock_interruptible(&rtc->ops_lock);
>>>  	if (err)
>>>  		return err;
>>>  
>>>  	if (!rtc->ops)
>>>  		err = -ENODEV;
>>> -	else if (rtc->ops->set_time)
>>> -		err = rtc->ops->set_time(rtc->dev.parent, tm);
>>> -	else if (rtc->ops->set_mmss64) {
>>> -		time64_t secs64 = rtc_tm_to_time64(tm);
>>> -
>>> +	else if (rtc->ops->set_time) {
>>> +		struct rtc_time tmp;
>>> +
>>> +		/*
>>> +		 * element wday of tm may not be set, therefore use
>>> +		 * rtc_time64_to_tm to generate a struct rtc_time
>>> +		 * with all elements being properly populated
>>> +		 */
>>> +		rtc_time64_to_tm(secs64, &tmp);
>>> +		err = rtc->ops->set_time(rtc->dev.parent, &tmp);
>>> +	} else if (rtc->ops->set_mmss64)
>>>  		err = rtc->ops->set_mmss64(rtc->dev.parent, secs64);
>>> -	} else if (rtc->ops->set_mmss) {
>>> -		time64_t secs64 = rtc_tm_to_time64(tm);
>>> +	else if (rtc->ops->set_mmss)
>>>  		err = rtc->ops->set_mmss(rtc->dev.parent, secs64);
>>> -	} else
>>> +	else
>>>  		err = -EINVAL;
>>>  
>>>  	pm_stay_awake(rtc->dev.parent);
>>> -- 
>>> 2.14.1
>>>
>>
>> -- 
>> Alexandre Belloni, Free Electrons
>> Embedded Linux and Kernel engineering
>> http://free-electrons.com
> 
