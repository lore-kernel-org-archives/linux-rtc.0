Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBPGYUDBAKGQEKBP4C5A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id d199si1000716wmd.1.2016.12.07.07.35.24
        for <rtc-linux@googlegroups.com>;
        Wed, 07 Dec 2016 07:35:24 -0800 (PST)
Date: Wed, 7 Dec 2016 16:35:23 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Srikant Ritolia <s.ritolia@samsung.com>
Cc: "a.zummo@towertech.it" <a.zummo@towertech.it>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	Ram Reddy <ram.r@samsung.com>,
	Ashish Kalra <ashish.kalra@samsung.com>
Subject: [rtc-linux] Re: [PATCH] rtc: ds1374: Merge conditional + WARN_ON()
Message-ID: <20161207153523.h65hje4lzic5blhl@piout.net>
References: <CGME20161129110437epcms5p3214f832f54aedeed6d0d8e1c32109ce1@epcms5p3>
 <20161129110437epcms5p3214f832f54aedeed6d0d8e1c32109ce1@epcms5p3>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20161129110437epcms5p3214f832f54aedeed6d0d8e1c32109ce1@epcms5p3>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 29/11/2016 at 11:04:37 +0000, Srikant Ritolia wrote :
> WARN_ON does both these things in one statement.
> Using a better pattern with WARN_ON().
> 
> Signed-off-by: Srikant Ritolia <s.ritolia@samsung.com>
> ---
>  drivers/rtc/rtc-ds1374.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
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
