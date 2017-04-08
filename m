Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBM7MUPDQKGQE5QC3SKI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id x188si458055wmx.0.2017.04.08.07.39.47
        for <rtc-linux@googlegroups.com>;
        Sat, 08 Apr 2017 07:39:47 -0700 (PDT)
Date: Sat, 8 Apr 2017 16:39:47 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Subject: [rtc-linux] Re: [PATCH] rtc: cpcap: fix improper use of IRQ_NONE for request_threaded_irq
Message-ID: <20170408143947.rlns2ggpq4m6cfao@piout.net>
References: <20170327033423.4536-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170327033423.4536-1-tony@atomide.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 26/03/2017 at 20:34:23 -0700, Tony Lindgren wrote:
> There's a funny typo where IRQ_NONE is used instead of IRQF_TRIGGER_NONE
> for request_threaded_irq(). Let's fix it before it gets copied elsewhere.
> 
> Fixes: dd3bf50b35e3 ("rtc: cpcap: new rtc driver")
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/rtc/rtc-cpcap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-cpcap.c b/drivers/rtc/rtc-cpcap.c
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
