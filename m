Return-Path: <rtc-linux+bncBDS7HNEFSALRB5U25KVQKGQETBHR3ZA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id bc3si44186wib.2.2015.06.12.00.42.46
        for <rtc-linux@googlegroups.com>;
        Fri, 12 Jun 2015 00:42:46 -0700 (PDT)
Date: Fri, 12 Jun 2015 09:42:45 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Andrea Scian <rnd4@dave-tech.it>
Cc: r.cerrato@til-technologies.fr, a.zummo@towertech.it,
	rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
	Andrea Scian <andrea.scian@dave.eu>
Subject: Re: [rtc-linux] [PATCH] driver: rtc: pcf2127: use OFS flag to detect
 unreliable date and warn the user
Message-ID: <20150612074245.GC3890@piout.net>
References: <1432628260-24652-1-git-send-email-rnd4@dave-tech.it>
 <20150608154251.GC5222@piout.net>
 <55785615.4050709@dave-tech.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <55785615.4050709@dave-tech.it>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 10/06/2015 at 17:21:57 +0200, Andrea Scian wrote :
> >I would return -EINVAL here because the result might still pass
> >rtc_valid_tm() but be outdated.
> 
> At first look I agree with you, but a bit later they say:
> 
> /* the clock can give out invalid datetime, but we cannot return
>  * -EINVAL otherwise hwclock will refuse to set the time on bootup.
>  */
> 
> http://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/tree/drivers/rtc/rtc-pcf2127.c#n91
> 
> so they don't actually return -EINVAL even if rtc_valid_tm() fails.
> WDYT? I'm not an RTC subsystem expert, so maybe I'm missing something..
> 

This has been copy pasted from other drivers and this is simply not
true.

> If the comment above is correct, so we can't return -EINVAL, I will reset
> the time to epoch, with something like
> 
> rtc_time64_to_tm((time64_t)0, tm);
> 

Doing that is worse. You really want userspace to know that the time is
invalid instead of giving an incorrect value. This allow userspace to
actually choose its policy when the time is invalid. For example, use
epoch or any other later date that probabyl makes more sense for the
product.

> >>@@ -144,7 +153,7 @@ static int pcf2127_rtc_ioctl(struct device *dev,
> >>  	switch (cmd) {
> >>  	case RTC_VL_READ:
> >>  		if (pcf2127->voltage_low)
> >>-			dev_info(dev, "low voltage detected, date/time is not reliable.\n");
> >>+			dev_info(dev, "low voltage detected, check/replace battery\n");
> >
> >I would also print a warning about OFS here.
> >
> 
> I'll do.
> Do you think is better to add another variable inside struct pcf2127 or is
> better to re-read the RTC registers?
> (for the former I have also to clear the variable inside
> pcf2127_set_datetime(), for the latter I have to issue another read in a
> function that, at the moment, does not read anything..)
> 

I don't really care. But since one of them is already cached, it is
probably better to cache OFS. Maybe you could also use voltage_low as a
bit field which would allow userspace to make the difference between a
simple low voltage and the time loss condition.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
