Return-Path: <rtc-linux+bncBDS7HNEFSALRBM4RZW4QKGQEP7DWFVQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id e64si1413809wmi.3.2016.05.11.07.58.58
        for <rtc-linux@googlegroups.com>;
        Wed, 11 May 2016 07:58:58 -0700 (PDT)
Date: Wed, 11 May 2016 16:58:58 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Nicolas Chauvet <kwizart@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: rename so the tps6586x-rtc module can be
 autoloaded at boot
Message-ID: <20160511145858.GE2890@piout.net>
References: <1462876002-6462-1-git-send-email-kwizart@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1462876002-6462-1-git-send-email-kwizart@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 10/05/2016 at 12:26:42 +0200, Nicolas Chauvet wrote :
> This module is loaded by the related mfd driver which has
> the needed MODULE_DEVICE_TABLE(i2c,...).
> 
> This patch fix the modalias when the rtc driver is built
> as a module, so the right name is used.
> Everything operates correctly when this module is builtin.
> 
> Signed-off-by: Nicolas Chauvet <kwizart@gmail.com>
> ---
>  drivers/rtc/rtc-tps6586x.c | 2 +-
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
