Return-Path: <rtc-linux+bncBDI57DN47YOBBVEWQG6QKGQEINKD7VA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pf0-f175.google.com (mail-pf0-f175.google.com. [209.85.192.175])
        by gmr-mx.google.com with ESMTPS id i136si242363pfe.1.2016.08.02.00.27.16
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Aug 2016 00:27:16 -0700 (PDT)
Received: by mail-pf0-f175.google.com with SMTP id h186so63520029pfg.3
        for <rtc-linux@googlegroups.com>; Tue, 02 Aug 2016 00:27:16 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
To: mingo@kernel.org,
	alexandre.belloni@free-electrons.com,
	tglx@linutronix.de,
	hpa@zytor.com,
	x86@kernel.org
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	prarit@redhat.com,
	dyoung@redhat.com,
	a.zummo@towertech.it,
	Pratyush Anand <panand@redhat.com>
Subject: [rtc-linux] [PATCH V2 2/2] rtc/rtc-cmos: Initialize software counters
 before irq is registered
Date: Tue,  2 Aug 2016 12:57:00 +0530
Message-Id: <77692ba8903c3d1a5f377517d149f3c1d125f4e3.1470122380.git.panand@redhat.com>
In-Reply-To: <cover.1470122380.git.panand@redhat.com>
References: <cover.1470122380.git.panand@redhat.com>
In-Reply-To: <cover.1470122380.git.panand@redhat.com>
References: <cover.1470122380.git.panand@redhat.com>
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

Software counters are being initialized in this patch so that LOCKUP could
be avoided.

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
