Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBTXF2LFAKGQEJ5ME5QQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id t16si2539023wmt.3.2017.06.29.00.57.02
        for <rtc-linux@googlegroups.com>;
        Thu, 29 Jun 2017 00:57:02 -0700 (PDT)
Date: Thu, 29 Jun 2017 09:56:51 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 1/2] RTC: s35390a: handle invalid RTC time
Message-ID: <20170629075651.jqa3jvxfer56dvh5@piout.net>
References: <1484217818-27845-1-git-send-email-fabien.lahoudere@collabora.co.uk>
 <1484217818-27845-2-git-send-email-fabien.lahoudere@collabora.co.uk>
 <20170116175018.z74inrcapwqqtbcz@piout.net>
 <1484641457.20968.6.camel@collabora.co.uk>
 <20170117110016.ids6xheti242lxhe@piout.net>
 <1498470673.9477.3.camel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <1498470673.9477.3.camel@collabora.co.uk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 26/06/2017 at 11:51:13 +0200, Fabien Lahoudere wrote:
> > Actually, after reading the datasheet, I realize it is only POC that is
> > reset to 0 after reading so isinvalid is not needed. Just read status1
> > and look for BLD instead of caching it.
> > 
> 
> isinvalid is also used in s35390a_set_datetime. So if I remove it how can I detect that time setting
> failed?
> 

If it fails, simply don't reset BLD so it is still set when reading the
time.

> > I think it is probably worth separating s35390a_reset() into two
> > functions. One that does the initialization and another one that reads
> > status1 and immediately doest the initialization when POC is set. If BLD
> > is set, then we can wait for set_time to happen before initializing.
> > 

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
