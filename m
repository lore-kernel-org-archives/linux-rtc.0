Return-Path: <rtc-linux+bncBDS7HNEFSALRBZ5L22ZAKGQEADF72SQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id k189si142350wmg.2.2015.11.25.03.05.11
        for <rtc-linux@googlegroups.com>;
        Wed, 25 Nov 2015 03:05:11 -0800 (PST)
Date: Wed, 25 Nov 2015 12:05:10 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Felipe Balbi <balbi@ti.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
	Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>,
	Rob Herring <robh+dt@kernel.org>, rtc-linux@googlegroups.com,
	Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [rtc-linux] [PATCH] rtc: ds1307: fix kernel splat due to wakeup
 irq handling
Message-ID: <20151125110510.GM3950@piout.net>
References: <1447258261-2102-1-git-send-email-balbi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1447258261-2102-1-git-send-email-balbi@ti.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 11/11/2015 at 10:11:01 -0600, Felipe Balbi wrote :
> Since commit 3fffd1283927 ("i2c: allow specifying
> separate wakeup interrupt in device tree") we have
> automatic wakeup irq support for i2c devices. That
> commit missed the fact that rtc-1307 had its own
> wakeup irq handling and ended up introducing a
> kernel splat for at least Beagle x15 boards.
> 
> Fix that by reverting original commit _and_ passing
> correct interrupt names on DTS so i2c-core can
> choose correct IRQ as wakeup.
> 
> Now that we have automatic wakeirq support, we can
> revert the original commit which did it manually.
> 
> Fixes the following warning:
> 
> [   10.346582] WARNING: CPU: 1 PID: 263 at linux/drivers/base/power/wakeirq.c:43 dev_pm_attach_wake_irq+0xbc/0xd4()
> [   10.359244] rtc-ds1307 2-006f: wake irq already initialized
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Nishanth Menon <nm@ti.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  arch/arm/boot/dts/am57xx-beagle-x15.dts |  1 +
>  drivers/rtc/rtc-ds1307.c                | 36 +++------------------------------
>  2 files changed, 4 insertions(+), 33 deletions(-)
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
