Return-Path: <rtc-linux+bncBCN63E7T2ALBBR6PRG7QKGQEV6SVE2Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-yw0-f180.google.com (mail-yw0-f180.google.com. [209.85.161.180])
        by gmr-mx.google.com with ESMTPS id 63si1597787ywe.1.2016.09.21.03.58.15
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Sep 2016 03:58:15 -0700 (PDT)
Received: by mail-yw0-f180.google.com with SMTP id u82so45644788ywc.2
        for <rtc-linux@googlegroups.com>; Wed, 21 Sep 2016 03:58:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1609210919390.5573@nanos>
References: <8c570c152c95087faa75e397c667b6d5b8d98b3b.1474177609.git.baolin.wang@linaro.org>
 <0d5cedb2f4ad46aa7fb07b990072bacb33517102.1474177609.git.baolin.wang@linaro.org>
 <alpine.DEB.2.20.1609202340560.5476@nanos> <CAMz4kuLYkyZzs33VKmo9B3JxTFFDYun7AHBYUUmHz=424yiq8g@mail.gmail.com>
 <alpine.DEB.2.20.1609210919390.5573@nanos>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Wed, 21 Sep 2016 18:58:14 +0800
Message-ID: <CAMz4kuKfVjJw21TpaMFjH3=5=7jyzKc71VZDFdu68T1Nspfqng@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 2/2] time: alarmtimer: Add the trcepoints for alarmtimer
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>, John Stultz <john.stultz@linaro.org>,
	Mark Brown <broonie@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 21 September 2016 at 15:26, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Wed, 21 Sep 2016, Baolin Wang wrote:
>> On 21 September 2016 at 06:27, Thomas Gleixner <tglx@linutronix.de> wrote:
>> >> +     TP_fast_assign(
>> >> +             __entry->second = rtc_time->tm_sec;
>> >> +             __entry->minute = rtc_time->tm_min;
>> >> +             __entry->hour = rtc_time->tm_hour;
>> >> +             __entry->day = rtc_time->tm_mday;
>> >> +             __entry->mon = rtc_time->tm_mon;
>> >> +             __entry->year = rtc_time->tm_year;
>> >> +             __entry->alarm_type = flag;
>> >
>> > What's the value of storing the alarm time in RTC format?
>>
>> As suggested by Steven, change the type of RTC value to save trace buffer.
>
> A single u64 does not take more storage space than this and it's a single
> store.

OK.

>
>> > 2) You store the expiry time again in RTC format. Store the information in
>> >    a plain u64 and be done with it.
>>
>> But I still think the RTC format is more readable for debugging alarm timer.
>
> That's what post processing is for.
>
>> > What's the point of this conditional? Avoiding rtc_ktime_to_tm() ? Oh well...
>> >
>> >> +             tm_set = rtc_ktime_to_tm(now);
>> >> +             trace_alarmtimer_suspend(&tm_set, type);
>> >
>> > "now" is CLOCK_REALTIME based. You store the type of the alarm timer which
>> > is the first to expire and therefor is the one setting the RTC value, but
>> > we don't know which timer it is. Useful - NOT!
>>
>> We can know the timer by comparing the expire time.
>
> Please make it similar to the timer/hrtimer tracing so people can reuse
> their postprocessing scripts with minimial tweaks.

OK. Thanks.

-- 
Baolin.wang
Best Regards

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
