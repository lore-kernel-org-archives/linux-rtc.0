Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBSW5TDAAKGQEB2MWIJQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (up.free-electrons.com. [163.172.77.33])
        by gmr-mx.google.com with ESMTP id x14si5124833vkd.3.2016.10.18.07.16.41
        for <rtc-linux@googlegroups.com>;
        Tue, 18 Oct 2016 07:16:41 -0700 (PDT)
Date: Tue, 18 Oct 2016 16:16:39 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: a.zummo@towertech.it, lars@metafoo.de, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v2] rtc: cmos: remove all __exit_p annotations
Message-ID: <20161018141639.owhkvkn4k2rvgspr@piout.net>
References: <1476791753-1837-1-git-send-email-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1476791753-1837-1-git-send-email-clabbe.montjoie@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 18/10/2016 at 13:55:53 +0200, Corentin Labbe wrote :
> Change since v1:
> - restored __exit for module_exit function
> 
> ---8<---

I don't think this is the proper scissor symbol for git. At least, it is
no recognized by patchwork and messes your patch.

> From c04a24acebee4b4432afa7a2a7d4cfe114cc9a40 Mon Sep 17 00:00:00 2001
> From: Corentin Labbe <clabbe.montjoie@gmail.com>
> Date: Mon, 17 Oct 2016 14:17:49 +0200
> Subject: [PATCH v2] rtc: cmos: remove all __exit_p annotations
> 
> I got the following stack trace under qemu:

[...]
> When cmos_set_alarm() is called dev is NULL and so trigger the deref via
> cmos->irq
> 
> The problem comes from that the device is removed but no remove function
> are called due to _exit_p().
> 
> This patch remove all _exit_p() annotation.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---


The changelog should go here.

>  drivers/rtc/rtc-cmos.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

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
