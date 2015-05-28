Return-Path: <rtc-linux+bncBDS7HNEFSALRBA7CTWVQKGQEIKDH3SA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id gt9si184212wib.2.2015.05.28.12.48.19
        for <rtc-linux@googlegroups.com>;
        Thu, 28 May 2015 12:48:19 -0700 (PDT)
Date: Thu, 28 May 2015 21:48:12 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Russell King <linux@arm.linux.org.uk>, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] rtc: sa1100: drop mach/irqs.h include
Message-ID: <20150528194812.GX2185@piout.net>
References: <1432829862-13614-1-git-send-email-dbaryshkov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1432829862-13614-1-git-send-email-dbaryshkov@gmail.com>
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

On 28/05/2015 at 19:17:42 +0300, Dmitry Eremin-Solenikov wrote :
> There is no reason to include <mach/irqs.h> anymore - the driver gets
> IRQs via platform_get_irq_byname().
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  drivers/rtc/rtc-sa1100.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
> index b6e1ca0..c221527 100644
> --- a/drivers/rtc/rtc-sa1100.c
> +++ b/drivers/rtc/rtc-sa1100.c
> @@ -36,7 +36,6 @@
>  #include <linux/io.h>
>  
>  #include <mach/hardware.h>
> -#include <mach/irqs.h>
>  

This is already part of the following patch, in a set doing much more
cleanup:
http://patchwork.ozlabs.org/patch/471954/


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
