Return-Path: <rtc-linux+bncBDS7HNEFSALRBGMUS2WQKGQEOK757QQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id gt9si152218wib.2.2015.07.14.15.15.52
        for <rtc-linux@googlegroups.com>;
        Tue, 14 Jul 2015 15:15:52 -0700 (PDT)
Date: Wed, 15 Jul 2015 00:15:52 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Vaishali Thakkar <vthakkar1994@gmail.com>
Cc: Joshua Kinard <kumba@gentoo.org>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: rtc-ds1685: Use module_platform_driver
Message-ID: <20150714221552.GF20482@piout.net>
References: <20150707054614.GA9829@vaishali-Ideapad-Z570>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20150707054614.GA9829@vaishali-Ideapad-Z570>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 07/07/2015 at 11:16:14 +0530, Vaishali Thakkar wrote :
> Use module_platform_driver for drivers whose init and exit functions
> only register and unregister, respectively.
> 
> A simplified version of the Coccinelle semantic patch that performs
> this transformation is as follows:
> 
> @a@
> identifier f, x;
> @@
> -static f(...) { return platform_driver_register(&x); }
> 
> @b depends on a@
> identifier e, a.x;
> @@
> -static e(...) { platform_driver_unregister(&x); }
> 
> @c depends on a && b@
> identifier a.f;
> declarer name module_init;
> @@
> -module_init(f);
> 
> @d depends on a && b && c@
> identifier b.e, a.x;
> declarer name module_exit;
> declarer name module_platform_driver;
> @@
> -module_exit(e);
> +module_platform_driver(x);
> 
> Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
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
