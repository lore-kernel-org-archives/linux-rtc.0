Return-Path: <rtc-linux+bncBDS7HNEFSALRBI5AS2WQKGQELQ2OYUY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id gt9si154588wib.2.2015.07.14.15.41.39
        for <rtc-linux@googlegroups.com>;
        Tue, 14 Jul 2015 15:41:39 -0700 (PDT)
Date: Wed, 15 Jul 2015 00:41:38 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Maninder Singh <maninder1.s@samsung.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, pankaj.m@samsung.com
Subject: [rtc-linux] Re: [PATCH 1/1] drivers/rtc/rtc-bq32k.c: remove redundant check
Message-ID: <20150714224138.GG20482@piout.net>
References: <1436338607-43389-1-git-send-email-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1436338607-43389-1-git-send-email-maninder1.s@samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 08/07/2015 at 12:26:47 +0530, Maninder Singh wrote :
> removing below static analysis error:-

What tool did you use?

> (error) Possible null pointer dereference: client
> 
> if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> 							^^^^^^^
> Error comes beacause client is dereferenced before NULL check.
> So probabily NULL this check is not required.
> 
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> ---
>  drivers/rtc/rtc-bq32k.c |    2 +-
Applied, to rtc-next.

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
