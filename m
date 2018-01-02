Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:39542 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751719AbeABMQJ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 2 Jan 2018 07:16:09 -0500
Received: by mail-ot0-f193.google.com with SMTP id 37so15560475otv.6
        for <linux-rtc@vger.kernel.org>; Tue, 02 Jan 2018 04:16:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180102095044.GA2226@piout.net>
References: <9ab56bdcaeb52241e22b738d6babe7b01728f64c.1514869621.git.baolin.wang@linaro.org>
 <ffbbc85faa0ecb4e2343fcbc95ed4bfd8e8f6993.1514869622.git.baolin.wang@linaro.org>
 <20180102095044.GA2226@piout.net>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Tue, 2 Jan 2018 20:16:08 +0800
Message-ID: <CAMz4ku+vS79t97U7c5Zpw9Mjxos1xX0qzZYAnPMDgFHJmYVpZA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] rtc: Add one offset seconds to expand RTC range
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Jon Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>, linux-rtc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 2 January 2018 at 17:50, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 02/01/2018 at 13:10:07 +0800, Baolin Wang wrote:
>> From our investigation for all RTC drivers, 1 driver will be expired before
>> year 2017, 7 drivers will be expired before year 2038, 23 drivers will be
>> expired before year 2069, 72 drivers will be expired before 2100 and 104
>> drivers will be expired before 2106. Especially for these early expired
>> drivers, we need to expand the RTC range to make the RTC can still work
>> after the expired year.
>>
>> So we can expand the RTC range by adding one offset to the time when reading
>> from hardware, and subtracting it when writing back. For example, if you have
>> an RTC that can do 100 years, and currently is configured to be based in
>> Jan 1 1970, so it can represents times from 1970 to 2069. Then if you change
>> the start year from 1970 to 2000, which means it can represents times from
>> 2000 to 2099. By adding or subtracting the offset produced by moving the wrap
>> point, all times between 1970 and 1999 from RTC hardware could get interpreted
>> as times from 2070 to 2099, but the interpretation of dates between 2000 and
>> 2069 would not change.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>>  drivers/rtc/class.c     |   53 +++++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/rtc/interface.c |   53 +++++++++++++++++++++++++++++++++++++++++++++--
>>  include/linux/rtc.h     |    2 ++
>>  3 files changed, 106 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
>> index 31fc0f1..8e59cf0 100644
>> --- a/drivers/rtc/class.c
>> +++ b/drivers/rtc/class.c
>> @@ -211,6 +211,55 @@ static int rtc_device_get_id(struct device *dev)
>>       return id;
>>  }
>>
>> +static void rtc_device_get_offset(struct rtc_device *rtc)
>> +{
>> +     u32 start_year;
>> +     int ret;
>> +
>> +     rtc->offset_secs = 0;
>> +     rtc->start_secs = rtc->min_hw_secs;
>> +
>> +     /*
>> +      * If RTC driver did not implement the range of RTC hardware device,
>> +      * then we can not expand the RTC range by adding or subtracting one
>> +      * offset.
>> +      */
>> +     if (!rtc->max_hw_secs)
>> +             return;
>> +
>> +     ret = device_property_read_u32(rtc->dev.parent, "start-year",
>> +                                    &start_year);
>> +     if (ret)
>> +             return;
>> +
>
> I think we need to have a way for drivers to set the start_secs value
> because then we can fix all the drivers using a variation of
> if (tm->tm_year < 70)
>         tm->tm_year += 100;

Yes.

>
> The main issue is that they will want to set start_secs to 0 so we can't
> use start_secs != 0 to know whether it has already been set. Maybe we
> can rely on offset_secs being set.

Make sense.

>> +     /*
>> +      * Record the start time values in seconds, which are used to valid if
>> +      * the setting time values are in the new expanded range.
>> +      */
>> +     rtc->start_secs = max_t(time64_t, mktime64(start_year, 1, 1, 0, 0, 0),
>> +                             rtc->min_hw_secs);
>> +
>> +     /*
>> +      * If the start_secs is larger than the maximum seconds (max_hw_secs)
>> +      * support by RTC hardware, which means the minimum seconds
>> +      * (min_hw_secs) of RTC hardware will be mapped to start_secs by adding
>> +      * one offset, so the offset seconds calculation formula should be:
>> +      * rtc->offset_secs = rtc->start_secs - rtc->min_hw_secs;
>> +      *
>> +      * If the start_secs is less than max_hw_secs, then there is one region
>> +      * is overlapped between the original RTC hardware range and the new
>> +      * expanded range, and this overlapped region do not need to be mapped
>> +      * into the new expanded range due to it is valid for RTC device. So
>> +      * the minimum seconds of RTC hardware (min_hw_secs) should be mapped to
>> +      * max_hw_secs + 1, then the offset seconds formula should be:
>> +      * rtc->offset_secs = rtc->max_hw_secs - rtc->min_hw_secs + 1;
>> +      */
>> +     if (rtc->start_secs > rtc->max_hw_secs)
>> +             rtc->offset_secs = rtc->start_secs - rtc->min_hw_secs;
>> +     else
>> +             rtc->offset_secs = rtc->max_hw_secs - rtc->min_hw_secs + 1;
>
> And so we have the case where start_secs < rtc->min_hw_secs. Those are
> the RTC failing in 2069. Wee need to handle those drivers generically
> here.

I missed this case and I will check it. Thanks for your comments.

-- 
Baolin.wang
Best Regards
