Return-Path: <rtc-linux+bncBDS7HNEFSALRB2UAYCYQKGQEN2RXPXY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id q6si487245wiz.0.2015.10.27.15.53.30
        for <rtc-linux@googlegroups.com>;
        Tue, 27 Oct 2015 15:53:30 -0700 (PDT)
Date: Tue, 27 Oct 2015 23:53:29 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Tero Kristo <t-kristo@ti.com>
Cc: a.zummo@towertech.it, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com, linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: ds1307: Fix alarm programming for mcp794xx
Message-ID: <20151027225329.GK22331@piout.net>
References: <1445581797-19693-1-git-send-email-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1445581797-19693-1-git-send-email-t-kristo@ti.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 23/10/2015 at 09:29:57 +0300, Tero Kristo wrote :
> mcp794xx alarm registers must be written in BCD format. However, the
> alarm programming logic neglected this by adding one to the value
> after bin2bcd conversion has been already done, writing bad values
> to month register in case the alarm being set is in October. In this
> case, the alarm month value becomes 0x0a instead of the expected 0x10.
> 
> Fix by moving the +1 addition within the bin2bcd call also.
> 
> Fixes: 1d1945d261a2 ("drivers/rtc/rtc-ds1307.c: add alarm support for mcp7941x chips")
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  drivers/rtc/rtc-ds1307.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
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
