Return-Path: <rtc-linux+bncBCQPVKWLVAIRBYUYVKWAKGQE3G37MUA@googlegroups.com>
Received: from muru.com (muru.com. [72.249.23.125])
        by gmr-mx.google.com with ESMTP id rs3si127006igb.2.2015.06.24.03.54.26
        for <rtc-linux@googlegroups.com>;
        Wed, 24 Jun 2015 03:54:26 -0700 (PDT)
Date: Wed, 24 Jun 2015 03:54:21 -0700
From: Tony Lindgren <tony@atomide.com>
To: Nishanth Menon <nm@ti.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	balbi@ti.com, grygorii.strashko@ti.com
Subject: [rtc-linux] Re: [PATCH V2 4/5] drivers/rtc/rtc-ds1307.c: Support
 optional wakeup interrupt source
Message-ID: <20150624105421.GD4156@atomide.com>
References: <1435076114-12416-1-git-send-email-nm@ti.com>
 <1435076114-12416-5-git-send-email-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1435076114-12416-5-git-send-email-nm@ti.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

* Nishanth Menon <nm@ti.com> [150623 09:21]:
> With the recent pinctrl-single changes, SoCs such as Texas
> Instrument's OMAP processors can treat wake-up events from deeper idle
> states as interrupts.
> 
> Let's add support for the optional second interrupt for wake-up using
> the generic wakeirq support added in commit 4990d4fe327b ("PM /
> Wakeirq: Add automated device wake IRQ handling")
> 
> Finally, to pass the wake-up interrupt in the dts file,
> interrupts-extended property needs to be passed.
> 
> This is similar in approach to commit 2a0b965cfb6e ("serial: omap: Add
> support for optional wake-up") + ee83bd3b6483 ("serial: omap: Switch
> wake-up interrupt to generic wakeirq")

The wakeirq related changes look good to me:

Acked-by: Tony Lindgren <tony@atomide.com>

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
