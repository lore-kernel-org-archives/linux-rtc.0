Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBNUPYDCQKGQEHECPYZQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id f7si101938wmg.3.2017.02.24.02.15.18
        for <rtc-linux@googlegroups.com>;
        Fri, 24 Feb 2017 02:15:18 -0800 (PST)
Date: Fri, 24 Feb 2017 11:15:17 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Phil Reid <preid@electromag.com.au>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v2 1/1] rtc: ds3232: Call device_init_wakeup
 before device_register
Message-ID: <20170224101517.3az76hehe75h3hb7@piout.net>
References: <1487905971-38303-1-git-send-email-preid@electromag.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1487905971-38303-1-git-send-email-preid@electromag.com.au>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 24/02/2017 at 11:12:51 +0800, Phil Reid wrote:
> The wakealarm attribute is currently not exposed in the sysfs interface
> as the device has not been set as doing wakealarm when device_register
> is called. Changing the order of the calls fixes that problem. Interrupts
> are cleared in check_rtc_status prior to requesting the interrupt.
> 
> This is only set if an irq is defined. If irq registration fails then
> set wakeup_capable to false. With this change the sysfs wakealarm
> attribute will be left visible but it is non functional. rtcwake
> still returns that the device is not enabled for wakeup.
> 
> Signed-off-by: Phil Reid <preid@electromag.com.au>
> ---
> 
> Notes:
>     Changes from v1:
>     - Don't register the irq before device_register call.
>       but set the capability if a irq is defined.
>       Unset wakeup capability if irq registration fails.
> 
>  drivers/rtc/rtc-ds3232.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
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
