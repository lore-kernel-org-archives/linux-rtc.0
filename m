Return-Path: <rtc-linux+bncBDI57DN47YOBBUUWQG6QKGQEJ2QAL7I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-pf0-f182.google.com (mail-pf0-f182.google.com. [209.85.192.182])
        by gmr-mx.google.com with ESMTPS id z4si229184pam.0.2016.08.02.00.27.13
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Aug 2016 00:27:13 -0700 (PDT)
Received: by mail-pf0-f182.google.com with SMTP id x72so63743638pfd.2
        for <rtc-linux@googlegroups.com>; Tue, 02 Aug 2016 00:27:13 -0700 (PDT)
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
	Pratyush Anand <panand@redhat.com>,
	Borislav Petkov <bp@suse.de>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jan Beulich <JBeulich@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [rtc-linux] [PATCH V2 1/2] rtc/hpet: Factorize hpet_rtc_timer_init()
Date: Tue,  2 Aug 2016 12:56:59 +0530
Message-Id: <c722d5058b543b2878ed88dcd4569541a62cf353.1470122380.git.panand@redhat.com>
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

This patch factorize hpet_rtc_timer_init(), so that counter can be
initialized before irq is registered.

No functional change in this patch.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/x86/include/asm/hpet.h |  2 ++
 arch/x86/kernel/hpet.c      | 41 +++++++++++++++++++++++++++++++++++------
 2 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index cc285ec4b2c1..8eecb31bebcb 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -96,6 +96,8 @@ extern int hpet_set_alarm_time(unsigned char hrs, unsigned char min,
 			       unsigned char sec);
 extern int hpet_set_periodic_freq(unsigned long freq);
 extern int hpet_rtc_dropped_irq(void);
+extern int hpet_rtc_timer_counter_init(void);
+extern int hpet_rtc_timer_enable(void);
 extern int hpet_rtc_timer_init(void);
 extern irqreturn_t hpet_rtc_interrupt(int irq, void *dev_id);
 extern int hpet_register_irq_handler(rtc_irq_handler handler);
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 3d747070fe67..c9da694ff236 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -1075,14 +1075,12 @@ void hpet_unregister_irq_handler(rtc_irq_handler handler)
 EXPORT_SYMBOL_GPL(hpet_unregister_irq_handler);
 
 /*
- * Timer 1 for RTC emulation. We use one shot mode, as periodic mode
- * is not supported by all HPET implementations for timer 1.
- *
- * hpet_rtc_timer_init() is called when the rtc is initialized.
+ * hpet_rtc_timer_counter_init() is called before interrupt can be
+ * registered
  */
-int hpet_rtc_timer_init(void)
+int hpet_rtc_timer_counter_init(void)
 {
-	unsigned int cfg, cnt, delta;
+	unsigned int cnt, delta;
 	unsigned long flags;
 
 	if (!is_hpet_enabled())
@@ -1107,6 +1105,22 @@ int hpet_rtc_timer_init(void)
 	hpet_writel(cnt, HPET_T1_CMP);
 	hpet_t1_cmp = cnt;
 
+	local_irq_restore(flags);
+
+	return 1;
+}
+EXPORT_SYMBOL_GPL(hpet_rtc_timer_counter_init);
+
+/*
+ * hpet_rtc_timer_enable() is called during RTC initialization
+ */
+int hpet_rtc_timer_enable(void)
+{
+	unsigned int cfg;
+	unsigned long flags;
+
+	local_irq_save(flags);
+
 	cfg = hpet_readl(HPET_T1_CFG);
 	cfg &= ~HPET_TN_PERIODIC;
 	cfg |= HPET_TN_ENABLE | HPET_TN_32BIT;
@@ -1116,6 +1130,21 @@ int hpet_rtc_timer_init(void)
 
 	return 1;
 }
+EXPORT_SYMBOL_GPL(hpet_rtc_timer_enable);
+
+/*
+ * Timer 1 for RTC emulation. We use one shot mode, as periodic mode
+ * is not supported by all HPET implementations for timer 1.
+ *
+ * hpet_rtc_timer_init() is called when the rtc is initialized.
+ */
+int hpet_rtc_timer_init(void)
+{
+	if (!hpet_rtc_timer_counter_init())
+		return 0;
+
+	return hpet_rtc_timer_enable();
+}
 EXPORT_SYMBOL_GPL(hpet_rtc_timer_init);
 
 static void hpet_disable_rtc_channel(void)
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
