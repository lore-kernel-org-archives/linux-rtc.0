Return-Path: <rtc-linux+bncBDS7HNEFSALRBJ6B4W4AKGQE34MJKMA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id a124si21940wme.0.2016.04.21.16.22.14
        for <rtc-linux@googlegroups.com>;
        Thu, 21 Apr 2016 16:22:14 -0700 (PDT)
Date: Fri, 22 Apr 2016 01:22:14 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Stefan Agner <stefan@agner.ch>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: snvs: return error in case
 enable_irq_wake fails
Message-ID: <20160421232214.GE29844@piout.net>
References: <1461193797-18015-1-git-send-email-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1461193797-18015-1-git-send-email-stefan@agner.ch>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 20/04/2016 at 16:09:57 -0700, Stefan Agner wrote :
> If enable_irq_wake fails, we should return that error code so that
> entering suspend fails. Otherwise we will get a WARNING along with
> the hint of a unbalanced wake disable:
> Unbalanced IRQ 37 wake disable
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/rtc/rtc-snvs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
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
