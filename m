Return-Path: <rtc-linux+bncBDDJNTW5VUMBBBF4UKZQKGQEDERBNNA@googlegroups.com>
Received: from mail-wm0-x22c.google.com (mail-wm0-x22c.google.com. [2a00:1450:400c:c09::22c])
        by gmr-mx.google.com with ESMTPS id b62si441660wmc.0.2015.12.09.13.32.52
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2015 13:32:52 -0800 (PST)
Received: by mail-wm0-x22c.google.com with SMTP id v187so4799932wmv.1
        for <rtc-linux@googlegroups.com>; Wed, 09 Dec 2015 13:32:52 -0800 (PST)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <CAD=FV=U+SYHVkgP1sAF4h3xmrQBhc7o=KpryAGAXjeYOYnNTcA@mail.gmail.com>
References: <CAODwPW-ZJ2HwrQohmfMYv2-jH2Ofq-O2H_HPfqYLXXnueVYYnA@mail.gmail.com>
	<1449552115-31256-1-git-send-email-jwerner@chromium.org>
	<CAD=FV=U+SYHVkgP1sAF4h3xmrQBhc7o=KpryAGAXjeYOYnNTcA@mail.gmail.com>
Date: Wed, 9 Dec 2015 13:32:52 -0800
Message-ID: <CAODwPW9M6gWXpUkT2A3k6jmj7sBzwjmScE+ZSAe209UDnAW6mg@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v2] RTC: RK808: Work around hardware bug on
 November 31st
From: Julius Werner <jwerner@chromium.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Julius Werner <jwerner@chromium.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Andrew Morton <akpm@linux-foundation.org>, Alessandro Zummo <a.zummo@towertech.it>,
	Sonny Rao <sonnyrao@chromium.org>, Chris Zhong <zyw@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

> Thinking about all this: these's actually a totally different
> alternative approach we could take if you wanted.  It would fix S5 and
> avoid all the anchor stuff, unless I'm crazy.
>
> Basically totally give up on the RTC time reflecting reality.  Add a
> "real time to rk808" and "rk808 time to real time" function.  Always
> use it when reading from rk808 and always use it when writing to
> rk808.  Choose 2015 as the "truth" year if you want (or pick another
> year).  In early 2016 the rk808 always contains 1 day back.  In 2017
> the rk808 always contains 2 days back.  Etc, etc, etc.
>
> The firmware would get confused, but ...

Well... other than that it's crazy and that I'd have to rewrite the
whole patch again, I can't come up with a good argument against this.
In Chromebook firmware the time is only needed for a debug log, so
we'd probably just be willing to accept it being wrong. If U-Boot ever
gets RK808 support, they'll probably just copy the Linux driver
wholesale anyway so they'll conform to the same system.

So if nobody else raises fundamental objections to this approach, I
guess I'll get started on another patch version. (Further replies
below for reference, but most of that stuff would then become moot.)

>> +       struct rtc_time anchor_time;    /* Last sync point with real world */
>
> Is this ever Nov 31st?  Looks like it never is...

No, it's always an already corrected date.

> Review will be significantly easier if we break this up into two patches:
>
> 1. Brain-dead code movement.  Move rk808_rtc_readtime() and
> rk808_rtc_set_time() with no functional changes.
>
> 2. This actual change.

Okay, I'll do that for the next rewrite.

>> +       extra_days = nov31st_transitions(&rk808_rtc->anchor_time, &alrm->time);
>> +       if (alrm->time.tm_mon == 10 && alrm->time.tm_mday == 31) {
>> +               dev_warn(dev, "read HW alarm date as Nov 31, compensating\n");
>> +               alrm->time.tm_mon = 11;
>> +               alrm->time.tm_mday = 1 + extra_days;
>
> But what is it's been 30+ years?!?!  :-P  Not that this is seriously a
> problem, but you already handle this in the "else" case.  Why not just
> set to 11/1 and get rid of the "else" below, so:
>
>    ...
>    alrm->time.tm_mon = 11;
>    alrm->time.tm_mday = 1;
>  }
>  if (extra_days) {
>    ...

Good point, that makes more sense.

>> +       extra_days = nov31st_transitions(&rk808_rtc->anchor_time, &alrm->time);
>> +       if (extra_days) {
>> +               unsigned long time;
>> +               dev_warn(dev, "writing HW alarm date adjusted for %d Nov31\n",
>> +                        extra_days);
>> +               rtc_tm_to_time(&alrm->time, &time);
>> +               rtc_time_to_tm(time - extra_days * 86400, &alrm->time);
>> +               /* Compensate in case the subtraction went back over Nov 31st */
>> +               if (alrm->time.tm_mon == 10 &&
>> +                   alrm->time.tm_mday == 31 - extra_days)
>> +                       alrm->time.tm_mday++;   /* This can result in 31! */
>
> Seems fishy somehow.  You should be able to come up with scenarios
> where you need an alarm on 11/31 on each future year.  Here I think
> you can only possibly get 11/31 if extra days == 1, right?
>
> So if it is Nov 30, 2015 and we want alarm on Dec 6, 2020
> extra days = 6:
>   Nov 31, 2015
>   Nov 31, 2016
>   Nov 31, 2017
>   Nov 31, 2018
>   Nov 31, 2019
>   Nov 31, 2020
>
> I think we need to set the alarm for Nov 31st 2020, right?  Your
> subtraction should get you to Nov 30th and you need to add an extra
> day for that, but I don't _think_ your if test will.  Did I mess up?
> As I said, I'm bad at this...

Hmm... right, I didn't think far enough here. I think I only
considered "what if it's Dec 1st in year X", but of course Dec 2nd and
so on may have the same issues. I think I really just need to change
that condition to (alrm->time.tm_mday >= 31 - extra_days) to get what
we need (at least up to 30 years in the future, after that it reaches
into October).

>> +       /*
>> +        * Try to initialize anchor point by reading "last read" shadow
>> +        * timestamp, to catch Nov 31st transitions that happened while shut
>> +        * down. This only works if no other code (e.g. firmware) has
>> +        * transitioned GET_TIME before this point.
>> +        */
>> +       ret = rk808_rtc_raw_read(&pdev->dev, &rk808_rtc->anchor_time);
>> +       if (ret || rtc_valid_tm(&rk808_rtc->anchor_time))
>> +               rk808_rtc->anchor_time.tm_mday = 0;     /* invalidate */
>
> Ah, the rtc_valid_tm() keeps the anchor from every being Nov 31st.  Got it.

At this point we cannot really get Nov 31st (in a way we'd want),
because we want the last time that was read by this driver before
shutdown. If that time was Nov 31st, it would have been immediately
corrected by the driver code (although, now that I think of it, there
is no further read() after that so the set() might not actually update
the shadow registers). So if this is Nov 31st it means that the RTC
was last read by some non-aware software and therefore there's no use
trying to recover the anchor date from it.

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
