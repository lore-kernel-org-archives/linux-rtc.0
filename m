Return-Path: <rtc-linux+bncBDS7HNEFSALRBSEPYK2QKGQEYKQBDAY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id w129si364446wme.1.2016.02.02.02.41.11
        for <rtc-linux@googlegroups.com>;
        Tue, 02 Feb 2016 02:41:11 -0800 (PST)
Date: Tue, 2 Feb 2016 11:41:11 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Joshua Clayton <stillcompiling@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v2 7/8] rtc: implement a sysfs interface for
 clock offset
Message-ID: <20160202104111.GU20165@piout.net>
References: <0000-cover-letter.patch>
 <8361752a4e0c524e15cbed36d03eb3eb9b187815.1451929910.git.stillcompiling@gmail.com>
 <20160131114115.GJ20165@piout.net>
 <20160201125648.37475997@jclayton-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160201125648.37475997@jclayton-pc>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 01/02/2016 at 12:56:48 -0800, Joshua Clayton wrote :
> > I'm fine with having parts per billion as the unit and I hope we won't
> > ever need anything more precise :)
> > 
> It is orders of magnitude more than needed at present

Yeah, until we get an RTC with an offset precision that has 4 decimals in ppm.

> ...and no will ever need more than 640k of memory... right?

Right :)

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
