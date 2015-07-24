Return-Path: <rtc-linux+bncBDS7HNEFSALRB4MQZCWQKGQEPGQKLPI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id cj6si105311wib.1.2015.07.24.02.42.08
        for <rtc-linux@googlegroups.com>;
        Fri, 24 Jul 2015 02:42:08 -0700 (PDT)
Date: Fri, 24 Jul 2015 11:42:07 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Henri Roosen <henriroosen@gmail.com>
Cc: rtc-linux@googlegroups.com, a.zummo@towertech.it
Subject: [rtc-linux] Re: [PATCH v3] rtc: rtc-rx8025: remove obsolete
 local_irq_disable() and local_irq_enable() for rtc_update_irq()
Message-ID: <20150724094207.GH14893@piout.net>
References: <1437725766-4031-1-git-send-email-henriroosen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1437725766-4031-1-git-send-email-henriroosen@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 24/07/2015 at 10:16:06 +0200, Henri Roosen wrote :
> Since commit e6229bec25be ("rtc: make rtc_update_irq callable with irqs
> enabled") rtc_update_irq() is callable with irqs enabled.
> 
> Signed-off-by: Henri Roosen <henriroosen@gmail.com>
> ---
>  drivers/rtc/rtc-rx8025.c | 4 ----
>  1 file changed, 4 deletions(-)
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
