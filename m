Return-Path: <rtc-linux+bncBDS7HNEFSALRB3UM32UQKGQE45FLLFY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id q10si305695wiz.0.2015.04.22.04.30.54
        for <rtc-linux@googlegroups.com>;
        Wed, 22 Apr 2015 04:30:54 -0700 (PDT)
Date: Wed, 22 Apr 2015 13:30:53 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Nishanth Menon <nm@ti.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH V2] drivers/rtc/rtc-ds1307.c: Enable the
 mcp794xx alarm after programming time
Message-ID: <20150422113053.GI8539@piout.net>
References: <1429577494-15087-1-git-send-email-nm@ti.com>
 <20150421234139.GF8539@piout.net>
 <5536E433.90103@ti.com>
 <20150422010925.GH8539@piout.net>
 <55370073.3060809@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <55370073.3060809@ti.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 21/04/2015 at 20:59:15 -0500, Nishanth Menon wrote :
> >> Why is that so? when set alarm is requested for time X, you want
> >> interrupt at time X, not an interrupt for previous configured RTC
> >> alarm time!
> >>
> > 
> > You expect at least an interrupt.
> 
> And you will get an interrupt if the event occurs before the i2c burst
> starts. Once the i2cburst does start, you are committing to the new time.
> 

You mean that even if ALM0EN is set after ALM0IF was set to 1, it will
trigger the interrupt? I had a look at the MFP output block diagram
would let me think that this is the case. I was thinking otherwise
before. If that is so, then indeed, your patch is OK.

My concern was about the time between ds1307->write_block_data() and
i2c_smbus_write_byte_data() which actually calls cond_sched().

I fully agree that your patch doesn't change the behaviour for the other
cases you presented and further clean up is to be done in a separate set
of patches.

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
