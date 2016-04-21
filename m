Return-Path: <rtc-linux+bncBDS7HNEFSALRB6WD4W4AKGQEKXKN7UA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id a124si22596wme.0.2016.04.21.16.27.54
        for <rtc-linux@googlegroups.com>;
        Thu, 21 Apr 2016 16:27:54 -0700 (PDT)
Date: Fri, 22 Apr 2016 01:27:53 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Gong Qianyu <Qianyu.Gong@nxp.com>
Cc: rtc-linux@googlegroups.com, akinobu.mita@gmail.com, mingkai.hu@nxp.com
Subject: [rtc-linux] Re: [Patch v3] rtc: ds3232: fix call trace when
 rtc->ops_lock is used as NULL
Message-ID: <20160421232753.GF29844@piout.net>
References: <1461221740-10739-1-git-send-email-Qianyu.Gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1461221740-10739-1-git-send-email-Qianyu.Gong@nxp.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 21/04/2016 at 14:55:40 +0800, Gong Qianyu wrote :
> The rtc->ops_lock would be accessed in ds3232_irq() without being
> initialized as rtc_device_register() is called too late.
> 
> So move devm_rtc_device_register() just before registering irq handler
> to initialize rtc->ops_lock earlier.
> 
> Signed-off-by: Gong Qianyu <Qianyu.Gong@nxp.com>
> ---
> V3:
>  - revise the commit message.
> V2:
>  - fix the order of error check.
> 
>  drivers/rtc/rtc-ds3232.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
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
