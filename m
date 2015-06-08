Return-Path: <rtc-linux+bncBDS7HNEFSALRBEXG26VQKGQECIYO2FY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id gt9si108612wib.2.2015.06.08.12.54.56
        for <rtc-linux@googlegroups.com>;
        Mon, 08 Jun 2015 12:54:56 -0700 (PDT)
Date: Mon, 8 Jun 2015 21:54:55 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [42/73] rtc: delete non-required instances of include <linux/init.h>
Message-ID: <20150608195455.GF5222@piout.net>
References: <1390339396-3479-43-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1390339396-3479-43-git-send-email-paul.gortmaker@windriver.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 21/01/2014 at 16:22:45 -0500, Paul Gortmaker wrote :
> None of these files are actually using any __init type directives
> and hence don't need to include <linux/init.h>.  Most are just a
> left over from __devinit and __cpuinit removal, or simply due to
> code getting copied from one driver to the next.
> 
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: rtc-linux@googlegroups.com
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

I've contemplated applying that patch but I'm not sure it is actually a
good idea because those 46 drivers are using a variant of module_driver
which actually uses __init and __exit. After your patch it is still
working simply because init.h gets included that way:

linux/module.h:9
linux/list.h:8
linux/kernel.h:13
linux/printk.h:5

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
