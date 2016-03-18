Return-Path: <rtc-linux+bncBDS7HNEFSALRBTEUWK3QKGQEDXP737Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 185si61177wml.0.2016.03.18.16.07.56
        for <rtc-linux@googlegroups.com>;
        Fri, 18 Mar 2016 16:07:56 -0700 (PDT)
Date: Sat, 19 Mar 2016 00:07:55 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Stefan Christ <s.christ@phytec.de>
Cc: rtc-linux@googlegroups.com, a.zummo@towertech.it
Subject: [rtc-linux] Re: [PATCH v2] drivers/rtc/rtc-m41t80.c: avoid out of
 range year values
Message-ID: <20160318230755.GE2828@piout.net>
References: <1458048146-13820-1-git-send-email-s.christ@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1458048146-13820-1-git-send-email-s.christ@phytec.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 15/03/2016 at 14:22:26 +0100, Stefan Christ wrote :
> Avoid saving an out of range year value to the RTC. Reading that value
> from the RTC again returns a totally wrong time value. For Example
> 
>     $ timedatectl set-ntp no
>     $ timedatectl set-time "1990-01-01 12:12:00"
>     # Reboot
>     rtc-m41t80 0-0068: setting system clock to 2090-01-01 12:12:35 UTC (3786955955)
> 
> Signed-off-by: Stefan Christ <s.christ@phytec.de>
> ---
> v2: fix checkpatch warning in if
> v2: align arguments in dev_err call
> ---
>  drivers/rtc/rtc-m41t80.c | 6 ++++++
>  1 file changed, 6 insertions(+)
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
