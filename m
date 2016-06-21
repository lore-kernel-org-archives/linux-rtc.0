Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBHGZU25QKGQE6UCSPLI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id f138si147019wmf.3.2016.06.21.14.07.40
        for <rtc-linux@googlegroups.com>;
        Tue, 21 Jun 2016 14:07:40 -0700 (PDT)
Date: Tue, 21 Jun 2016 23:07:39 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Rob Herring <robh@kernel.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 03/13] RTC: ds1307: Add DS1341 specific
 power-saving options
Message-ID: <20160621210739.GY5809@piout.net>
References: <1465970379-14703-1-git-send-email-andrew.smirnov@gmail.com>
 <1465970379-14703-4-git-send-email-andrew.smirnov@gmail.com>
 <20160619142934.GA8522@rob-hp-laptop>
 <CAHQ1cqFfFpLmMMr9itinha9rotG7Btr9UmWbO2_0VWxX_HeG1g@mail.gmail.com>
 <20160621204904.GA9779@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160621204904.GA9779@rob-hp-laptop>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 21/06/2016 at 15:49:04 -0500, Rob Herring wrote :
> So wouldn't you want to set one mode while running and the lower power 
> mode while suspended? I'm trying to understand the frequency of changing 
> this. If it is always one setting for a board, then yes it belongs in 
> DT. If it is a user decision, then it probably shouldn't be in DT.
> 
> Seeing as these are reused, I've probably already had this discussion...
> 

I would agree with Rob here. It may be better to provide a sysfs
interface to configure that particular behavior. This is usually ok
because the use case is:
 - the RTC is not configured, time has never been set
 - time is set for the first time
 - the user can set the oscillator mode/detection/...
 - on subsequent reboots, the mode is kept alongside the time and date

I would advise against trying to set a mode automatically in the driver
because you may have unexpected power cuts and it may then let the RTC
consume more power than what you really want.

> > > They should have vendor prefix and be explicit that they are boolean.
> > 
> > I was trying to be consistent with ds1339 and ds1390 bindings which do
> > not have vendor prefixes. Will fix in v2.
> 
> Okay, then they are fine if you are using existing properties. Perhaps 
> these should all be in a common binding doc though.
> 

I'll try to collect the existing common properties and write that doc
this week.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
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
