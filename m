Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBV5NTTAAKGQESHXUB3Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (up.free-electrons.com. [163.172.77.33])
        by gmr-mx.google.com with ESMTP id 136si141212wmy.2.2016.10.18.23.46.47
        for <rtc-linux@googlegroups.com>;
        Tue, 18 Oct 2016 23:46:47 -0700 (PDT)
Date: Wed, 19 Oct 2016 08:46:46 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>
Subject: [rtc-linux] Re: [PATCH] rtc: asm9260: fix module autoload
Message-ID: <20161019064646.dlxjfil3amvgzsab@piout.net>
References: <1476450935-19105-1-git-send-email-javier@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1476450935-19105-1-git-send-email-javier@osg.samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 14/10/2016 at 10:15:35 -0300, Javier Martinez Canillas wrote :
> If the driver is built as a module, autoload won't work because the module
> alias information is not filled so user-space can't match the registered
> device with the corresponding module.
> 
> Export the module alias information using the MODULE_DEVICE_TABLE() macro.
> 
> Before this patch:
> 
> $ modinfo drivers/rtc/rtc-asm9260.ko | grep alias
> $
> 
> After this patch:
> 
> $ modinfo drivers/rtc/rtc-asm9260.ko | grep alias
> alias:          of:N*T*Calphascale,asm9260-rtcC*
> alias:          of:N*T*Calphascale,asm9260-rtc
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> 
>  drivers/rtc/rtc-asm9260.c | 1 +
>  1 file changed, 1 insertion(+)
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
