Return-Path: <rtc-linux+bncBDAMN6NI5EERBQVHXK7AKGQET223BIY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from Galois.linutronix.de (Galois.linutronix.de. [2a01:7a0:2:106d:700::1])
        by gmr-mx.google.com with ESMTPS id 82si1044089wmg.3.2016.09.06.03.00.34
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 06 Sep 2016 03:00:34 -0700 (PDT)
Date: Tue, 6 Sep 2016 11:58:08 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Pratyush Anand <panand@redhat.com>
cc: mingo@kernel.org, alexandre.belloni@free-electrons.com, hpa@zytor.com,
    x86@kernel.org, rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
    prarit@redhat.com, dzickus@redhat.com, dyoung@redhat.com,
    a.zummo@towertech.it
Subject: [rtc-linux] Re: [PATCH V3 2/2] rtc/rtc-cmos: Initialize software
 counters before irq is registered
In-Reply-To: <90426708da5934284839e6f23d23e265afcc779f.1470985727.git.panand@redhat.com>
Message-ID: <alpine.DEB.2.20.1609061155390.5647@nanos>
References: <cover.1470985727.git.panand@redhat.com> <90426708da5934284839e6f23d23e265afcc779f.1470985727.git.panand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, 16 Aug 2016, Pratyush Anand wrote:

That's a lot of churn to fix that simple problem. The two liner below
should fix that as well, right?

Thanks,

	tglx

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 43745cac0141..cb8dfc3ee012 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -707,6 +707,7 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 		goto cleanup1;
 	}
 
+	hpet_rtc_timer_init();
 	if (is_valid_irq(rtc_irq)) {
 		irq_handler_t rtc_cmos_int_handler;
 
@@ -714,6 +715,7 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 			rtc_cmos_int_handler = hpet_rtc_interrupt;
 			retval = hpet_register_irq_handler(cmos_interrupt);
 			if (retval) {
+				hpet_mask_rtc_irq_bit(RTC_IRQMASK);
 				dev_warn(dev, "hpet_register_irq_handler "
 						" failed in rtc_init().");
 				goto cleanup1;
@@ -729,7 +731,6 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 			goto cleanup1;
 		}
 	}
-	hpet_rtc_timer_init();
 
 	/* export at least the first block of NVRAM */
 	nvram.size = address_space - NVRAM_OFFSET;


-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
