Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37965 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751277AbdH0Tfl (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 27 Aug 2017 15:35:41 -0400
Received: by mail-wm0-f66.google.com with SMTP id t201so1792120wmt.5
        for <linux-rtc@vger.kernel.org>; Sun, 27 Aug 2017 12:35:41 -0700 (PDT)
Subject: Re: [PATCH] rtc: core: let rtc_set_time properly populate element
 wday
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
References: <3b43da73-ff4e-4519-d1c7-266b17cc5d05@gmail.com>
 <20170826195607.s6p7u7vr3hxhwwqs@piout.net>
 <20170826195947.jnipgyuxg3ceqie4@piout.net>
 <a6ccd0ab-a6f4-1122-233b-61e69b80aa54@gmail.com>
Message-ID: <7da740e6-b1e0-0a58-8b54-2e5e3e2f6c54@gmail.com>
Date: Sun, 27 Aug 2017 21:35:34 +0200
MIME-Version: 1.0
In-Reply-To: <a6ccd0ab-a6f4-1122-233b-61e69b80aa54@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Am 27.08.2017 um 14:39 schrieb Heiner Kallweit:
> Am 26.08.2017 um 21:59 schrieb Alexandre Belloni:
>> On 26/08/2017 at 21:56:07 +0200, Alexandre Belloni wrote:
>>> There is no point in fixing that. Nobody uses wday.
>>>
>>
>> And that was going to be my comment on your other patch. You may as well
>> just remove the whole wday correction from ds1307.
>>
> Actually I was wondering too when wday should ever be used, except
> theoretically for an alarm, however commit e29385fab0bf
> "rtc: ds1307: Fix relying on reset value for weekday" was added just
> a year ago.
> 
When having a look at the MCP794XX datasheet it became clear why the
mentioned weekday-related patch was submitted. This chip is quite
strange regarding the possible alarm match conditions:

ALMxMSK<2:0>: Alarm Mask bits
000 = Seconds match
001 = Minutes match
010 = Hours match (logic takes into account 12-/24-hour operation)
011 = Day of week match
100 = Date match
101 = Reserved; do not use
110 = Reserved; do not use
111 = Seconds, Minutes, Hour, Day of Week, Date and Month

When not having a proper weekday you get only either seconds or
minutes or hours or date match.

So it's best to ensure that the weekday is properly populated.
However we can do this in the driver and don't have to touch the core.

> I think then we can remove the usage of wday in general, including
> writing / reading wday in ds1307_get/set_time.
> 
>>> On 26/08/2017 at 21:16:34 +0200, Heiner Kallweit wrote:
>>>> Some drivers use element wday of the struct rtc_time which is passed to
>>>> callback set_time. However element wday may incorrectly or not be
>>>> populated if struct rtc_time is coming from userspace via rtc_dev_ioctl.
>>>> rtc_valid_tm() doesn't check element wday.
>>>>
>>>> Therefore convert struct rtc_time to time64_t and then use
>>>> rtc_time64_to_tm to generate a struct rtc_time with all elements properly
>>>> populated.
>>>>
>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>> ---
>>>>  drivers/rtc/interface.c | 24 ++++++++++++++++--------
>>>>  1 file changed, 16 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
>>>> index 8cec9a02..5a53c590 100644
>>>> --- a/drivers/rtc/interface.c
>>>> +++ b/drivers/rtc/interface.c
>>>> @@ -59,28 +59,36 @@ EXPORT_SYMBOL_GPL(rtc_read_time);
>>>>  
>>>>  int rtc_set_time(struct rtc_device *rtc, struct rtc_time *tm)
>>>>  {
>>>> +	time64_t secs64;
>>>>  	int err;
>>>>  
>>>>  	err = rtc_valid_tm(tm);
>>>>  	if (err != 0)
>>>>  		return err;
>>>>  
>>>> +	secs64 = rtc_tm_to_time64(tm);
>>>> +
>>>>  	err = mutex_lock_interruptible(&rtc->ops_lock);
>>>>  	if (err)
>>>>  		return err;
>>>>  
>>>>  	if (!rtc->ops)
>>>>  		err = -ENODEV;
>>>> -	else if (rtc->ops->set_time)
>>>> -		err = rtc->ops->set_time(rtc->dev.parent, tm);
>>>> -	else if (rtc->ops->set_mmss64) {
>>>> -		time64_t secs64 = rtc_tm_to_time64(tm);
>>>> -
>>>> +	else if (rtc->ops->set_time) {
>>>> +		struct rtc_time tmp;
>>>> +
>>>> +		/*
>>>> +		 * element wday of tm may not be set, therefore use
>>>> +		 * rtc_time64_to_tm to generate a struct rtc_time
>>>> +		 * with all elements being properly populated
>>>> +		 */
>>>> +		rtc_time64_to_tm(secs64, &tmp);
>>>> +		err = rtc->ops->set_time(rtc->dev.parent, &tmp);
>>>> +	} else if (rtc->ops->set_mmss64)
>>>>  		err = rtc->ops->set_mmss64(rtc->dev.parent, secs64);
>>>> -	} else if (rtc->ops->set_mmss) {
>>>> -		time64_t secs64 = rtc_tm_to_time64(tm);
>>>> +	else if (rtc->ops->set_mmss)
>>>>  		err = rtc->ops->set_mmss(rtc->dev.parent, secs64);
>>>> -	} else
>>>> +	else
>>>>  		err = -EINVAL;
>>>>  
>>>>  	pm_stay_awake(rtc->dev.parent);
>>>> -- 
>>>> 2.14.1
>>>>
>>>
>>> -- 
>>> Alexandre Belloni, Free Electrons
>>> Embedded Linux and Kernel engineering
>>> http://free-electrons.com
>>
> 
