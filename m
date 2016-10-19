Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB5WHTTAAKGQEKI46FXY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (up.free-electrons.com. [163.172.77.33])
        by gmr-mx.google.com with ESMTP id i129si140967wmg.3.2016.10.19.00.42.45
        for <rtc-linux@googlegroups.com>;
        Wed, 19 Oct 2016 00:42:45 -0700 (PDT)
Date: Wed, 19 Oct 2016 09:42:34 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Christoph Hellwig <hch@lst.de>
Cc: a.zummo@towertech.it, arnd@arndb.de, david-b@pacbell.net,
	rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc-cmos: don't refer to asm-generic/rtc.h
Message-ID: <20161019074234.gidrm6tstrw7doxz@piout.net>
References: <1476279053-27967-1-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1476279053-27967-1-git-send-email-hch@lst.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 12/10/2016 at 15:30:53 +0200, Christoph Hellwig wrote :
> That header has been gone for a while.  I've fixed up the Kconfig
> comment, but the one in rtc-cmos.c doesn't make any sense to me
> even looking at its history.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/rtc/Kconfig    | 4 ++--
>  drivers/rtc/rtc-cmos.c | 3 ---
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
Applied, thanks.

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
