Return-Path: <rtc-linux+bncBDI57DN47YOBBEF2XK7AKGQE7VZGKKQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-yw0-f172.google.com (mail-yw0-f172.google.com. [209.85.161.172])
        by gmr-mx.google.com with ESMTPS id u193si1781190ywf.6.2016.09.06.03.40.16
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Sep 2016 03:40:16 -0700 (PDT)
Received: by mail-yw0-f172.google.com with SMTP id g192so61756719ywh.1
        for <rtc-linux@googlegroups.com>; Tue, 06 Sep 2016 03:40:16 -0700 (PDT)
Date: Tue, 6 Sep 2016 16:10:11 +0530
From: Pratyush Anand <panand@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: mingo@kernel.org, alexandre.belloni@free-electrons.com, hpa@zytor.com,
	x86@kernel.org, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, prarit@redhat.com, dzickus@redhat.com,
	dyoung@redhat.com, a.zummo@towertech.it
Subject: [rtc-linux] Re: [PATCH V3 2/2] rtc/rtc-cmos: Initialize software
 counters before irq is registered
Message-ID: <20160906104011.GE24688@localhost.localdomain>
References: <cover.1470985727.git.panand@redhat.com>
 <90426708da5934284839e6f23d23e265afcc779f.1470985727.git.panand@redhat.com>
 <alpine.DEB.2.20.1609061155390.5647@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <alpine.DEB.2.20.1609061155390.5647@nanos>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Thomas,

On 06/09/2016:11:58:08 AM, Thomas Gleixner wrote:
> On Tue, 16 Aug 2016, Pratyush Anand wrote:
> 
> That's a lot of churn to fix that simple problem. The two liner below
> should fix that as well, right?

Thanks a lot for your reply.

Yes, that should fix. I was n't sure if "setting HPET_TN_ENABLE before IRQ is
registered" would be a right step.
I can give it a try, however it is pretty obvious that these two liners should
be able to solve the issue. So, if this solution will not have any side effect
then, it is fine for me as well.

~Pratyush

> 
> Thanks,
> 
> 	tglx
> 
> diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
> index 43745cac0141..cb8dfc3ee012 100644
> --- a/drivers/rtc/rtc-cmos.c
> +++ b/drivers/rtc/rtc-cmos.c
> @@ -707,6 +707,7 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
>  		goto cleanup1;
>  	}
>  
> +	hpet_rtc_timer_init();
>  	if (is_valid_irq(rtc_irq)) {
>  		irq_handler_t rtc_cmos_int_handler;
>  
> @@ -714,6 +715,7 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
>  			rtc_cmos_int_handler = hpet_rtc_interrupt;
>  			retval = hpet_register_irq_handler(cmos_interrupt);
>  			if (retval) {
> +				hpet_mask_rtc_irq_bit(RTC_IRQMASK);
>  				dev_warn(dev, "hpet_register_irq_handler "
>  						" failed in rtc_init().");
>  				goto cleanup1;
> @@ -729,7 +731,6 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
>  			goto cleanup1;
>  		}
>  	}
> -	hpet_rtc_timer_init();
>  
>  	/* export at least the first block of NVRAM */
>  	nvram.size = address_space - NVRAM_OFFSET;
> 

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
