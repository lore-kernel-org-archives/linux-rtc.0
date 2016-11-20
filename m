Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB35PZDAQKGQEJGKORSA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id m17si652937wma.1.2016.11.20.13.38.55
        for <rtc-linux@googlegroups.com>;
        Sun, 20 Nov 2016 13:38:55 -0800 (PST)
Date: Sun, 20 Nov 2016 22:38:54 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: David Miller <davem@davemloft.net>
Cc: paul.gortmaker@windriver.com, linux-kernel@vger.kernel.org,
	a.zummo@towertech.it, sparclinux@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 2/3] rtc: sparc: make starfire explicitly non-modular
Message-ID: <20161120213854.ailkekyemj4hhmbw@piout.net>
References: <20161031185527.20279-1-paul.gortmaker@windriver.com>
 <20161031185527.20279-3-paul.gortmaker@windriver.com>
 <20161120.162919.145900145134940393.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20161120.162919.145900145134940393.davem@davemloft.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Dave,

I already carry both patches in my tree but I would gladly add an ack.

On 20/11/2016 at 16:29:19 -0500, David Miller wrote :
> From: Paul Gortmaker <paul.gortmaker@windriver.com>
> Date: Mon, 31 Oct 2016 14:55:26 -0400
> 
> > The Kconfig currently controlling compilation of this code is:
> > 
> > drivers/rtc/Kconfig:config RTC_DRV_STARFIRE
> > drivers/rtc/Kconfig:    bool "Starfire RTC"
> > 
> > ...meaning that it currently is not being built as a module by anyone.
> > 
> > Lets remove the couple traces of modular infrastructure use, so that
> > when reading the driver there is no doubt it is builtin-only.
> > 
> > We delete the MODULE_LICENSE tag etc. since all that information
> > was (or is now) contained at the top of the file in the comments.
> > 
> > Cc: Alessandro Zummo <a.zummo@towertech.it>
> > Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: sparclinux@vger.kernel.org
> > Cc: rtc-linux@googlegroups.com
> > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> Applied.

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
