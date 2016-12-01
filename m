Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBMHI7XAQKGQE5BTSALA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id h23si998650wmi.1.2016.11.30.16.51.59
        for <rtc-linux@googlegroups.com>;
        Wed, 30 Nov 2016 16:51:59 -0800 (PST)
Date: Thu, 1 Dec 2016 01:51:59 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, khilman@baylibre.com,
	carlo@caione.org, a.zummo@towertech.it,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] Re: [RFC PATCH 2/3] rtc: Add Amlogic Virtual Wake RTC
Message-ID: <20161201005159.l54yo4kspgrb75ev@piout.net>
References: <1478183365-23708-1-git-send-email-narmstrong@baylibre.com>
 <1478183365-23708-3-git-send-email-narmstrong@baylibre.com>
 <20161103153647.GD25852@remoulade>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20161103153647.GD25852@remoulade>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 03/11/2016 at 15:36:48 +0000, Mark Rutland wrote :
> > In order to be able to reuse the RTC wakealarm feature, this
> > driver implements a fake RTC device which uses the system time
> > to deduce a suspend delay.
> 
> This sounds like an always-on oneshot timer device, not an RTC.
> 
> > +static int meson_vrtc_read_time(struct device *dev, struct rtc_time *tm)
> > +{
> > +	unsigned long local_time;
> > +	struct timeval time;
> > +
> > +	do_gettimeofday(&time);
> > +	local_time = time.tv_sec - (sys_tz.tz_minuteswest * 60);
> > +	rtc_time_to_tm(local_time, tm);
> > +
> > +	return 0;
> > +}
> 
> ... if this were a timer, you wouldn't need this hack.
> 

The main issue I think is that the clockevents are not able to wakeup a
platform so it doesn't really fit as a timer inside the kernel.

I think it may be fine to handle that in the RTC subsystem for now.

The same issue can be seen with the flextimer on LS1021A:

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-August/365597.html

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
