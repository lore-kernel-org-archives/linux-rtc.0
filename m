Return-Path: <rtc-linux+bncBCL4FNGB7UHBBRXKSC7QKGQEL5DZCDI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-oi0-x243.google.com (mail-oi0-x243.google.com. [2607:f8b0:4003:c06::243])
        by gmr-mx.google.com with ESMTPS id d184si3641747itg.0.2016.09.22.12.47.18
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Sep 2016 12:47:18 -0700 (PDT)
Received: by mail-oi0-x243.google.com with SMTP id a62so7044720oib.1
        for <rtc-linux@googlegroups.com>; Thu, 22 Sep 2016 12:47:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160921232903.lb43z3vzx33zenwq@piout.net>
References: <20160831225929.20336-1-gabriele.mzt@gmail.com>
 <20160902195516.7068-1-gabriele.mzt@gmail.com> <20160921232903.lb43z3vzx33zenwq@piout.net>
From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Date: Thu, 22 Sep 2016 21:47:17 +0200
Message-ID: <CABFtUbTjQfxEF1uk6OdVWsxsrUU5b9LqYSOV26hUM2_QTiQDtA@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v2] rtc-cmos: Reject unsupported alarm values
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

2016-09-22 1:29 GMT+02:00 Alexandre Belloni
<alexandre.belloni@free-electrons.com>:
> On 02/09/2016 at 21:55:16 +0200, Gabriele Mazzotta wrote :
>> Some platforms allows to specify the month and day of the month in
>> which an alarm should go off, some others the day of the month and
>> some others just the time.
>>
>> Currently any given value is accepted by the driver and only the
>> supported fields are used to program the hardware. As consequence,
>> alarms are potentially programmed to go off in the wrong moment.
>>
>> Fix this by rejecting any value not supported by the hardware.
>>
>> Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
>> ---
>>
>> I revisited the naive implementation of v1. I tested the new
>> algorithm using some dates that and verified that it behaved as
>> expected, but I might have missed some corner cases.
>>
>> I made some assumptions that maybe should be dropped, at least
>> two of them. They are commented in the code, but I didn't mention
>> that they are assumptions:
>>
>>  - If the day can't be specified, the alarm can only be set to go
>>    off 24 hours minus 1 second in the future. I'm worried things
>>    would go wrong if the current time is used to set an alarm that
>>    should go off the next day.
>>  - If the mday can be specified and the next month has more days
>>    than the current month, the alarm can be set to go off in the
>>    extra days of the next month.
>
> Hum, you are actually not allowing them in the code below (which I think
> is the right thing to do).

I do, unfortunately. If it's "2015/02/28 01:23:45", then
"2015/03/31 01:23:44" is considered valid and yes, this is wrong.

>>  - If the month can be specified, it's the 28th of February and the
>>    next year is a leap year, the alarm can be set for the 29th of
>>    February of the next year.
>
> Is that really true? I would expect the opposite. If it is currently
> 28/02, the max date you can actually go to is 27/02. If you allow 29/02,
> at some time the RTC will have 28/02 and the alarm will fire.

What I thought here is that since we write MM/DD-hh:mm:ss, if it's
02/28-01:34:56 (A) and I set the alarm for 02/29-01:34:55 (B),
that alarm can only go off next year. What I realize now is
that allowing (B), for example, makes 02/28-01:34:57 ambiguous
as it appears twice between (A) and (B). So yes, this is wrong.

>>
>> Basically I'm assuming that the hardware decides when an alarm should
>> go off comparing the current date with the one programmed. If they
>> match, the alarm goes off. This seemed reasonable to me, but it's
>> not easy to verify.
>>
>>  drivers/rtc/rtc-cmos.c | 104 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 104 insertions(+)
>>
>> diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
>> index 4cdb335..37cb7c1 100644
>> --- a/drivers/rtc/rtc-cmos.c
>> +++ b/drivers/rtc/rtc-cmos.c
>> @@ -328,14 +328,118 @@ static void cmos_irq_disable(struct cmos_rtc *cmos, unsigned char mask)
>>       cmos_checkintr(cmos, rtc_control);
>>  }
>>
>> +static int cmos_validate_alarm(struct device *dev, struct rtc_wkalrm *t)
>> +{
>> +     struct cmos_rtc *cmos = dev_get_drvdata(dev);
>> +     struct rtc_time now;
>> +
>> +     cmos_read_time(dev, &now);
>> +
>> +     if (!cmos->day_alrm) {
>> +             time64_t t_max_date;
>> +             time64_t t_alrm;
>> +
>> +             t_alrm = rtc_tm_to_time64(&t->time);
>> +             t_max_date = rtc_tm_to_time64(&now);
>> +             /*
>> +              * Subtract 1 second to ensure that the alarm time is
>> +              * different from the current time.
>> +              */
>> +             t_max_date += 24 * 60 * 60 - 1;
>> +             if (t_alrm > t_max_date) {
>> +                     dev_err(dev,
>> +                             "Alarms can be up to one day in the future\n");
>> +                     return -EINVAL;
>> +             }
>> +     } else if (!cmos->mon_alrm) {
>> +             struct rtc_time max_date = now;
>> +             time64_t t_max_date;
>> +             time64_t t_alrm;
>> +             int max_mday;
>> +             bool is_max_mday = false;
>> +
>> +             /*
>> +              * If the next month has more days than the current month
>> +              * and we are at the max mday of this month, we can program
>> +              * the alarm to go off the max mday of the next month without
>> +              * it going off sooner than expected.
>> +              */
>> +             max_mday = rtc_month_days(now.tm_mon, now.tm_year);
>> +             if (now.tm_mday == max_mday)
>> +                     is_max_mday = true;
>> +
>> +             if (max_date.tm_mon == 11) {
>> +                     max_date.tm_mon = 0;
>> +                     max_date.tm_year += 1;
>> +             } else {
>> +                     max_date.tm_mon += 1;
>> +             }
>> +             max_mday = rtc_month_days(max_date.tm_mon, max_date.tm_year);
>> +             if (max_date.tm_mday > max_mday || is_max_mday)
>> +                     max_date.tm_mday = max_mday;
>> +
>> +             max_date.tm_hour = 23;
>> +             max_date.tm_min = 59;
>> +             max_date.tm_sec = 59;
>> +
>
> Actually, this is wrong.
>
> If it is currently 1:23:45 on 22/09, you can go up to 1:23:44 on 22/10.
> trying to set a time after 1:23:45 will actually match on the same day
> instead of a month later.

Sorry, you are right, I initially did "current time - 1s", but then
for some reason I thought that in this case I'm also writing mday,
so I changed it to this. Obviously, if mday was also written, we
would be in the case here below...

>> +             t_max_date = rtc_tm_to_time64(&max_date);
>> +             t_alrm = rtc_tm_to_time64(&t->time);
>> +             if (t_alrm > t_max_date) {
>> +                     dev_err(dev,
>> +                             "Alarms can be up to one month in the future\n");
>> +                     return -EINVAL;
>> +             }
>> +     } else {
>> +             struct rtc_time max_date = now;
>> +             time64_t t_max_date;
>> +             time64_t t_alrm;
>> +             int max_mday;
>> +             bool allow_leap_day = false;
>> +
>> +             /*
>> +              * If it's the 28th of February and the next year is a leap
>> +              * year, allow to set alarms for the 29th of February.
>> +              */
>> +             if (now.tm_mon == 1) {
>> +                     max_mday = rtc_month_days(now.tm_mon, now.tm_year);
>> +                     if (now.tm_mday == max_mday)
>> +                             allow_leap_day = true;
>> +             }
>> +
>> +             max_date.tm_year += 1;
>> +             max_mday = rtc_month_days(max_date.tm_mon, max_date.tm_year);
>> +             if (max_date.tm_mday > max_mday || allow_leap_day)
>> +                     max_date.tm_mday = max_mday;
>> +
>> +             max_date.tm_hour = 23;
>> +             max_date.tm_min = 59;
>> +             max_date.tm_sec = 59;
>> +
>
> Ditto, 1:23:45 on 22/09/2016 can go up to 1:23:44 on 22/09/2017.

The errors are obvious now, I guess I should have looked at it
again with a fresh mind before submitting.

I think that if I remove all exceptional cases (leap years, longer
months) and go back to 'now - 1s' for the time, this should be fine.
I'll have a better look at it.

Gabriele

> Regards,
>
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
