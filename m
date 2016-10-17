Return-Path: <rtc-linux+bncBCZ4DZNV3IDBB3MOSPAAKGQE6VI7LGA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from www381.your-server.de (www381.your-server.de. [78.46.137.84])
        by gmr-mx.google.com with ESMTPS id y17si1848809ywy.1.2016.10.17.05.43.25
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Oct 2016 05:43:25 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH] rtc: cmos: remove all __exit_p annotations
To: Corentin Labbe <clabbe.montjoie@gmail.com>, a.zummo@towertech.it,
 alexandre.belloni@free-electrons.com
References: <1476707763-9222-1-git-send-email-clabbe.montjoie@gmail.com>
Cc: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <fceeb689-8fd7-c09e-e6d2-cb8b8fe1648d@metafoo.de>
Date: Mon, 17 Oct 2016 14:43:20 +0200
MIME-Version: 1.0
In-Reply-To: <1476707763-9222-1-git-send-email-clabbe.montjoie@gmail.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


> -static void __exit cmos_exit(void)
> +static void cmos_exit(void)

This annotation is correct and should stay.

>  {
>  #ifdef	CONFIG_PNP
>  	if (pnp_driver_registered)
> 

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
