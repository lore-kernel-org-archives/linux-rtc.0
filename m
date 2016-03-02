Return-Path: <rtc-linux+bncBDS7HNEFSALRB2XR3W3AKGQEL3FTZJA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id w128si226763wmd.0.2016.03.02.15.36.09
        for <rtc-linux@googlegroups.com>;
        Wed, 02 Mar 2016 15:36:09 -0800 (PST)
Date: Thu, 3 Mar 2016 00:36:09 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Joshua Kinard <kumba@gentoo.org>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [rtc-linux] Re: [patch] rtc: ds1685: passing bogus values to irq_restore
Message-ID: <20160302233609.GC2567@piout.net>
References: <20160302100745.GB5533@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160302100745.GB5533@mwanda>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 02/03/2016 at 13:07:45 +0300, Dan Carpenter wrote :
> We call spin_lock_irqrestore with "flags" set to zero instead of to the
> value from spin_lock_irqsave().
> 
> Fixes: aaaf5fbf56f1 ('rtc: add driver for DS1685 family of real time clocks')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
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
