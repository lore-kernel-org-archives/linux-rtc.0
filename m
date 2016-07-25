Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB7HN3G6AKGQEQIY7DDQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id r197si1027982wmf.2.2016.07.25.13.30.52
        for <rtc-linux@googlegroups.com>;
        Mon, 25 Jul 2016 13:30:52 -0700 (PDT)
Date: Mon, 25 Jul 2016 22:30:52 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Stefan Christ <s.christ@phytec.de>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 2/2] rtc: m41t80: add suspend handlers for
 alarm IRQ
Message-ID: <20160725203052.GM11405@piout.net>
References: <1467719597-5593-1-git-send-email-s.christ@phytec.de>
 <1467719597-5593-2-git-send-email-s.christ@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1467719597-5593-2-git-send-email-s.christ@phytec.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 05/07/2016 at 13:53:17 +0200, Stefan Christ wrote :
> Allow the alarm IRQ of RTC to be used as a wakeup source for the system
> suspend.
> 
> Signed-off-by: Stefan Christ <s.christ@phytec.de>
> ---
>  drivers/rtc/rtc-m41t80.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
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
