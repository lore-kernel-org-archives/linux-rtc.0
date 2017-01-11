Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB5E43DBQKGQE67VQDXQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id h62si470436wme.2.2017.01.11.02.52.36
        for <rtc-linux@googlegroups.com>;
        Wed, 11 Jan 2017 02:52:36 -0800 (PST)
Date: Wed, 11 Jan 2017 11:52:36 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	linux-arm-kernel@lists.infradead.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] rtc: armada38x: make struct rtc_class_ops const
Message-ID: <20170111105236.5ucue6ybqvfulese@piout.net>
References: <E1cRFxi-00083n-FY@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <E1cRFxi-00083n-FY@rmk-PC.armlinux.org.uk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 11/01/2017 at 10:16:58 +0000, Russell King wrote :
> Armada38x wants to modify its rtc_class_ops to remove the interrupt
> handling when there is no usable interrupt, but this means we leave
> function pointers in writable memory.
> 
> Since rtc_class_ops is small, arrange to have two instances, one for
> when we have interrupts, and one for when we have none, both marked
> const.  This allows the compiler to place them in read-only memory,
> which is better than placing them in __ro_after_init.
> 
> Thanks to Bhumika Goyal <bhumirks@gmail.com> for pointing out that
> the structure was writable and submitting a patch to add
> __ro_after_init.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
> As the thread has gone quiet, I'm submitting the patch I sent within that
> thread.  No one appears to have raised an objection to it (other than what
> appears to be a misunderstanding.)
> 
>  drivers/rtc/rtc-armada38x.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
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
