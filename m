Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBYWKQG7QKGQE3EO45CY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 185si2016119wmr.2.2016.09.19.15.23.30
        for <rtc-linux@googlegroups.com>;
        Mon, 19 Sep 2016 15:23:30 -0700 (PDT)
Date: Tue, 20 Sep 2016 00:23:19 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Pratyush Anand <panand@redhat.com>
Cc: mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com, x86@kernel.org,
	rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
	prarit@redhat.com, dzickus@redhat.com, dyoung@redhat.com,
	a.zummo@towertech.it
Subject: [rtc-linux] Re: [PATCH] rtc/rtc-cmos: Initialize hpet timer before
 irq is registered
Message-ID: <20160919222319.qvakrltsv52gu2hc@piout.net>
References: <19b150a2f1087b80757d62770d99833781e57b31.1473862685.git.panand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <19b150a2f1087b80757d62770d99833781e57b31.1473862685.git.panand@redhat.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 15/09/2016 at 09:38:16 +0530, Pratyush Anand wrote :
> We have observed on few x86 machines with rtc-cmos device that
> hpet_rtc_interrupt() is called just after irq registration and before
> cmos_do_probe() could call hpet_rtc_timer_init().
> 
> So, neither hpet_default_delta nor hpet_t1_cmp is initialized by the time
> interrupt is raised in the given situation, and this results in NMI
> watchdog LOCKUP.
> 
> It has only been observed sporadically on kdump secondary kernels.
> 
[...]
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Pratyush Anand <panand@redhat.com>
> ---
>  drivers/rtc/rtc-cmos.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
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
