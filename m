Return-Path: <rtc-linux+bncBDS7HNEFSALRBEV752VAKGQEI2LYPKY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id gt9si1843wib.2.2015.05.19.13.39.45
        for <rtc-linux@googlegroups.com>;
        Tue, 19 May 2015 13:39:45 -0700 (PDT)
Date: Tue, 19 May 2015 22:39:44 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: hartleys <hartleys@visionengravers.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, rtc-linux@googlegroups.com,
	a.zummo@towertech.it
Subject: [rtc-linux] Re: rtc: ep93xx: Use readl/writel for io
Message-ID: <20150519203944.GB3338@piout.net>
References: <201203211055.31653.hartleys@visionengravers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <201203211055.31653.hartleys@visionengravers.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 21/03/2012 at 10:55:31 -0700, hartleys wrote :
> Drivers should not be using the __raw_* io accessors.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> 

Rebased and applied, thanks!

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
