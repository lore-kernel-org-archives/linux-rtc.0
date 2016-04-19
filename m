Return-Path: <rtc-linux+bncBDS7HNEFSALRBOHP3K4AKGQEN7W5E2Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id a80si308266wma.0.2016.04.19.15.56.55
        for <rtc-linux@googlegroups.com>;
        Tue, 19 Apr 2016 15:56:55 -0700 (PDT)
Date: Wed, 20 Apr 2016 00:56:55 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Nishanth Menon <nm@ti.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Michael Lange <linuxstuff@milaw.biz>
Subject: [rtc-linux] Re: [PATCH] rtc: ds1307: Use irq when available for
 wakeup-source device
Message-ID: <20160419225655.GJ29844@piout.net>
References: <1461083034-9227-1-git-send-email-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1461083034-9227-1-git-send-email-nm@ti.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 19/04/2016 at 11:23:54 -0500, Nishanth Menon wrote :
> With commit 8bc2a40730ec ("rtc: ds1307: add support for the
> DT property 'wakeup-source'") we lost the ability for rtc irq
> functionality for devices that are actually hooked on a real IRQ
> line and have capability to wakeup as well. This is not an expected
> behavior. So, instead of just not requesting IRQ, skip the IRQ
> requirement only if interrupts are not defined for the device.
> 
> Fixes: 8bc2a40730ec ("rtc: ds1307: add support for the DT property 'wakeup-source'")
> Reported-by: Tony Lindgren <tony@atomide.com>
> Cc: Michael Lange <linuxstuff@milaw.biz>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
>  drivers/rtc/rtc-ds1307.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
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
