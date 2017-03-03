Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB4NH43CQKGQEDULX36Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id e72si102607wma.0.2017.03.03.08.04.01
        for <rtc-linux@googlegroups.com>;
        Fri, 03 Mar 2017 08:04:01 -0800 (PST)
Date: Fri, 3 Mar 2017 17:04:00 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>
Subject: [rtc-linux] Re: [PATCH 00/13] rtc: Add OF device table to I2C drivers
 that are missing it
Message-ID: <20170303160400.2n6vwbypxvt62nl4@piout.net>
References: <20170303142925.17915-1-javier@osg.samsung.com>
 <20170303150134.qacfd7ccemqxwq3p@piout.net>
 <abb5cd41-b904-1512-7520-e4a89f26d4b3@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <abb5cd41-b904-1512-7520-e4a89f26d4b3@osg.samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 03/03/2017 at 12:27:23 -0300, Javier Martinez Canillas wrote:
> On 03/03/2017 12:01 PM, Alexandre Belloni wrote:
> > On 03/03/2017 at 11:29:11 -0300, Javier Martinez Canillas wrote:
> >> This series add OF device ID tables to RTC I2C drivers whose devices are
> >> either used in Device Tree source files or are listed in binding docs as
> >> a compatible string.
> >>
> >> That's done because the plan is to change the I2C core to report proper OF
> >> modaliases instead of always reporting a MODALIAS=i2c:<foo> regardless if
> >> a device was registered via DT or using the legacy platform data.
> >>
> > 
> > Doesn't that break the DT ABI for all i2c devices? A lot of people are
> > getting the vendor wrong in the compatible string and because the i2c
> > core doesn't care, the driver is still probed. Dropping that will break
> > all those DTBs.
> > Or will that only affect module autoload?
> > 
> 
> The change will only be for module autoload. The I2C core will still attempt
> to match the I2C device ID table as a fallback if fails to match the OF one.
> So there's no change in the match logic for drivers that do the wrong thing.
> 

I'm probably not seeing the big picture here but then I don't understand
why you are reworking the id->driver_data handling and using
of_device_get_match_data instead.

If this is related to b8a1a4cd5a98a2adf8dfd6902cd98e57d910ee12, that is
a completely different issue (and that is probably the kind of changes
that should be notified to maintainers).

> If someone is using a wrong vendor prefix and the DT can't be changed, then
> an entry in the OF device ID table has to be added for "wrong_vendor,device"
> so the MODALIAS uevent can be "of:N*T*wrong_vendor,device".
> 

And then, we end up with a crap load of useless strings that are matched
against at boottime...
I'm saying that because all the rv3029 compatible strings are wrong.

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
