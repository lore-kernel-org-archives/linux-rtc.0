Return-Path: <rtc-linux+bncBDS7HNEFSALRB3VGQS3QKGQE4XWFZRI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id v68si80418wmd.1.2016.03.09.22.25.49
        for <rtc-linux@googlegroups.com>;
        Wed, 09 Mar 2016 22:25:49 -0800 (PST)
Date: Thu, 10 Mar 2016 07:25:47 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	Dennis Aberilla <denzzzhome@yahoo.com>
Subject: [rtc-linux] Re: [PATCH v4 3/7] rtc: ds3232: fix read on /dev/rtc
 after RTC_AIE_ON
Message-ID: <20160310062547.GG9868@piout.net>
References: <1457278073-11627-1-git-send-email-akinobu.mita@gmail.com>
 <1457278073-11627-3-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1457278073-11627-3-git-send-email-akinobu.mita@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 07/03/2016 at 00:27:49 +0900, Akinobu Mita wrote :
> The rtctest (tools/testing/selftests/timers/rtctest.c) found that
> reading ds3232 rtc device immediately return the value 0x20 (RTC_AF)
> without waiting alarm interrupt.
> 
> This is because alarm_irq_enable() of ds3232 driver changes RTC_AF
> flag in rtc->irq_data.  So calling ioctl with RTC_AIE_ON generates
> invalid value in rtc device.
> 
> The lower-level driver should not touch rtc->irq_data directly.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: Dennis Aberilla <denzzzhome@yahoo.com>
> ---
> * No changes from the previous version
> 
>  drivers/rtc/rtc-ds3232.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 

This patch and all the following are applied, thanks.

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
