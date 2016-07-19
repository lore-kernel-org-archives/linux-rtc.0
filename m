Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBTV2XG6AKGQEITRBJPQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id v14si1085480wmf.0.2016.07.19.10.03.10
        for <rtc-linux@googlegroups.com>;
        Tue, 19 Jul 2016 10:03:10 -0700 (PDT)
Date: Tue, 19 Jul 2016 19:03:09 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Chris DeBruin <cdeb5783@gmail.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] rtc: pcf85063: Add support for the PCF85063A device
Message-ID: <20160719170309.GN7132@piout.net>
References: <1468358146-18717-1-git-send-email-cdeb5783@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1468358146-18717-1-git-send-email-cdeb5783@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 12/07/2016 at 17:15:46 -0400, Chris DeBruin wrote :
> The current rtc-pcf85063 driver only supports the PCF85063TP device.
> Using the existing driver on a PCF85063A will result in the time being
> set correctly into the RTC, but the RTC is held in the stopped state.
> Therefore, the time will no longer advance and no error is indicated.
> 
> The PCF85063A device has a bigger memory map than the PCF85063TP.
> The existing driver make use of an address rollover condition,
> but the rollover point is different in the two devices.
> 
> Signed-off-by: Chris DeBruin <cdeb5783@gmail.com>
> ---
>  drivers/rtc/rtc-pcf85063.c | 48 +++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 39 insertions(+), 9 deletions(-)
> 
Applied after fixing some whitespace issues, thanks.

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
