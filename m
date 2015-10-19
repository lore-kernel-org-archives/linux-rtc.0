Return-Path: <rtc-linux+bncBDS7HNEFSALRB4PTSCYQKGQEL7FYIIQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id m4si412703wib.0.2015.10.18.17.31.45
        for <rtc-linux@googlegroups.com>;
        Sun, 18 Oct 2015 17:31:45 -0700 (PDT)
Date: Mon, 19 Oct 2015 02:31:34 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: rtc-linux@googlegroups.com, Fabio Estevam <fabio.estevam@freescale.com>
Subject: [rtc-linux] Re: [PATCH] rtc: isl1208: Pass the IRQF_ONESHOT flag
Message-ID: <20151019003134.GB3421@piout.net>
References: <1445213182-5214-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1445213182-5214-1-git-send-email-festevam@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 18/10/2015 at 22:06:22 -0200, Fabio Estevam wrote :
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Since commit 1c6c69525b40eb76de8adf039409722015927dc3 ("genirq: Reject
> bogus threaded irq requests") threaded IRQs without a primary handler
> need to be requested with IRQF_ONESHOT, otherwise the request will fail.
> 
> So pass the IRQF_ONESHOT flag in this case.
> 
> The semantic patch that makes this change is available
> in scripts/coccinelle/misc/irqf_oneshot.cocci
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/rtc/rtc-isl1208.c | 2 +-
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
