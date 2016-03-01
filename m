Return-Path: <rtc-linux+bncBDS7HNEFSALRB2443C3AKGQEUWUHWZY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id w197si55291wmw.3.2016.03.01.13.49.31
        for <rtc-linux@googlegroups.com>;
        Tue, 01 Mar 2016 13:49:31 -0800 (PST)
Date: Tue, 1 Mar 2016 22:49:20 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-mediatek@lists.infradead.org,
	Eddie Huang <eddie.huang@mediatek.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [rtc-linux] Re: [PATCH] rtc: mt6397: Remove plaform module alias
Message-ID: <20160301214920.GI23985@piout.net>
References: <1456334780-17380-1-git-send-email-javier@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1456334780-17380-1-git-send-email-javier@osg.samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 24/02/2016 at 14:26:20 -0300, Javier Martinez Canillas wrote :
> The driver uses the MODULE_ALIAS() macro to export a platform module alias
> to allow the module to be autoloaded if the device is registered using the
> legacy platform registration mechanism but the driver is always used by OF
> only machines so the alias is not needed and should just be removed.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> Hello,
> 
> This patch supersedes "rtc: mt6397: Add platform device ID table":
> https://lkml.org/lkml/2016/2/9/192.
> 
> Best regards,
> Javier
> 
>  drivers/rtc/rtc-mt6397.c | 1 -
>  1 file changed, 1 deletion(-)
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
