Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBUWP2DBQKGQEYYSSLZA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id 133si761055wmj.1.2017.01.09.16.16.17
        for <rtc-linux@googlegroups.com>;
        Mon, 09 Jan 2017 16:16:17 -0800 (PST)
Date: Tue, 10 Jan 2017 01:16:17 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
Cc: rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] Question about RTC validity mechanism
Message-ID: <20170110001617.whsc6repv4tdsbpp@piout.net>
References: <1483953931.11465.13.camel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1483953931.11465.13.camel@collabora.co.uk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 09/01/2017 at 10:25:31 +0100, Fabien Lahoudere wrote :
> I use a Seiko S35390A RTC that knows if the RTC has restarted when POC
> value is set to 1. (POC is bit 0 of register status1).
> In the current driver, the value is just ignored and lost in
> s35390a_probe by calling s35390a_reset.
> 
> I need this feature to check if the RTC time is valid or not at boot.
> Is there a standard mechanism to store this information and check at
> boot that the RTC is valid?
> 

With that RTC, there is no reliable way of knowing whether the time has
been set since reset. You could handle one case by storing that you saw
the POC bit high at some point and returning -EINVAL in read_time until
the time is set by set_time.

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
