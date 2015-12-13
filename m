Return-Path: <rtc-linux+bncBDS7HNEFSALRBSHRWWZQKGQEJ23H2MA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id w79si480711wme.2.2015.12.13.05.55.20
        for <rtc-linux@googlegroups.com>;
        Sun, 13 Dec 2015 05:55:20 -0800 (PST)
Date: Sun, 13 Dec 2015 14:54:54 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] rtc: lpc32xx: remove irq > NR_IRQS check from probe()
Message-ID: <20151213135454.GE11209@piout.net>
References: <1449036628-20539-1-git-send-email-vz@mleia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1449036628-20539-1-git-send-email-vz@mleia.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 02/12/2015 at 08:10:28 +0200, Vladimir Zapolskiy wrote :
> If the driver is used on an ARM platform with SPARSE_IRQ defined,
> semantics of NR_IRQS is different (minimal value of virtual irqs)
> and by default it is set to 16, see arch/arm/include/asm/irq.h.
> 
> This value may be less than the actual number of virtual irqs, which
> may break the driver initialization. The check removal allows to use
> the driver on such a platform, and, if irq controller driver works
> correctly, the check is not needed on legacy platforms.
> 
> Fixes a runtime problem:
> 
>   rtc-lpc32xx 40024000.rtc: Can't get interrupt resource
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  drivers/rtc/rtc-lpc32xx.c | 2 +-
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
