Return-Path: <rtc-linux+bncBDI57DN47YOBBGESUO5QKGQEWL5J42Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-qk0-f177.google.com (mail-qk0-f177.google.com. [209.85.220.177])
        by gmr-mx.google.com with ESMTPS id v70si125307ywc.2.2016.06.20.21.56.56
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jun 2016 21:56:56 -0700 (PDT)
Received: by mail-qk0-f177.google.com with SMTP id a186so6476880qkf.0
        for <rtc-linux@googlegroups.com>; Mon, 20 Jun 2016 21:56:56 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
To: mingo@kernel.org,
	alexandre.belloni@free-electrons.com
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	prarit@redhat.com,
	Pratyush Anand <panand@redhat.com>,
	Alessandro Zummo <a.zummo@towertech.it>
Subject: [rtc-linux] [PATCH RFC 2/2] rtc/rtc-cmos: Initialize software
 counters before irq is registered
Date: Tue, 21 Jun 2016 10:25:36 +0530
Message-Id: <26cd375a8d7ef97db5f8d12ecda6ee6676aca211.1466484019.git.panand@redhat.com>
In-Reply-To: <cover.1466484019.git.panand@redhat.com>
References: <cover.1466484019.git.panand@redhat.com>
In-Reply-To: <cover.1466484019.git.panand@redhat.com>
References: <cover.1466484019.git.panand@redhat.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

We have observed on few machines with rtc-cmos device that
hpet_rtc_interrupt() is called before cmos_do_probe() could call
hpet_rtc_timer_init(). It has not been observed during normal boot/reboot
of machines. It *sometime* happens when system is booted with kdump
secondary kernel. So, neither hpet_default_delta nor hpet_t1_cmp is
initialized by the time interrupt is raised in the given situation.
Therefore while loop of hpet_cnt_ahead() in hpet_rtc_timer_reinit() never
completes. This leads to "NMI watchdog: Watchdog detected hard LOCKUP on
cpu 0".

I am still clueless, how can an interrupt be raised before RTC is enabled.
But I do not have any idea about this device, so I am putting this patch as
RFC to get feedback from hpet/rtc-cmos developer.

I am initializing software counters in this patch so that LOCKUP could be
avoided. Even if it resolves the issue, I understand that proposed patch
may not be the best way to solve this issue.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/rtc/rtc-cmos.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index fbe9c72438e1..101dc948295f 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -129,6 +129,16 @@ static inline int hpet_rtc_dropped_irq(void)
 	return 0;
 }
 
+static inline int hpet_rtc_timer_counter_init(void)
+{
+	return 0;
+}
+
+static inline int hpet_rtc_timer_enable(void)
+{
+	return 0;
+}
+
 static inline int hpet_rtc_timer_init(void)
 {
 	return 0;
@@ -710,6 +720,7 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 		goto cleanup1;
 	}
 
+	hpet_rtc_timer_counter_init();
 	if (is_valid_irq(rtc_irq)) {
 		irq_handler_t rtc_cmos_int_handler;
 
@@ -732,7 +743,7 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 			goto cleanup1;
 		}
 	}
-	hpet_rtc_timer_init();
+	hpet_rtc_timer_enable();
 
 	/* export at least the first block of NVRAM */
 	nvram.size = address_space - NVRAM_OFFSET;
-- 
2.5.5

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
