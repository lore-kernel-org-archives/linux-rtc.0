Return-Path: <rtc-linux+bncBDS7HNEFSALRBGOPWO3AKGQEMXBBMHY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id e130si1237666wme.2.2016.02.23.15.13.29
        for <rtc-linux@googlegroups.com>;
        Tue, 23 Feb 2016 15:13:29 -0800 (PST)
Date: Wed, 24 Feb 2016 00:13:28 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] drivers/rtc: make class.c explicitly non-modular
Message-ID: <20160223231328.GD10681@piout.net>
References: <1455480259-13433-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1455480259-13433-1-git-send-email-paul.gortmaker@windriver.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 14/02/2016 at 15:04:19 -0500, Paul Gortmaker wrote :
> The Makefile/Kconfig currently controlling compilation of this code is:
> 
> obj-$(CONFIG_RTC_CLASS)         += rtc-core.o
> rtc-core-y                      := class.o interface.o
> 
> drivers/rtc/Kconfig:menuconfig RTC_CLASS
> drivers/rtc/Kconfig:    bool "Real Time Clock"
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the modular code that is essentially orphaned, so that
> when reading the code there is no doubt it is builtin-only.
> 
> We don't replace module.h with init.h since the file does need
> to know what a struct module is.
> 
> We also delete the MODULE_LICENSE tag etc. since all that information
> is already contained at the top of the file in the comments.
> 
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: rtc-linux@googlegroups.com
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  drivers/rtc/class.c | 13 -------------
>  1 file changed, 13 deletions(-)
> 
Applied, thanks.

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
