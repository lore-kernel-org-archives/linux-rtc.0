Return-Path: <rtc-linux+bncBDI57DN47YOBBYUPZK6QKGQESZONZAI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-yb0-f182.google.com (mail-yb0-f182.google.com. [209.85.213.182])
        by gmr-mx.google.com with ESMTPS id c75si819345ywh.0.2016.08.15.20.26.26
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Aug 2016 20:26:26 -0700 (PDT)
Received: by mail-yb0-f182.google.com with SMTP id d10so20450549ybi.1
        for <rtc-linux@googlegroups.com>; Mon, 15 Aug 2016 20:26:26 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
To: mingo@kernel.org,
	alexandre.belloni@free-electrons.com,
	tglx@linutronix.de,
	hpa@zytor.com,
	x86@kernel.org
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	prarit@redhat.com,
	dzickus@redhat.com,
	dyoung@redhat.com,
	a.zummo@towertech.it,
	Pratyush Anand <panand@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@suse.de>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jan Beulich <JBeulich@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [rtc-linux] [PATCH V3 1/2] rtc/hpet: Factorize hpet_rtc_timer_init()
Date: Tue, 16 Aug 2016 08:55:43 +0530
Message-Id: <544824d55b9a72759705e8757e6f22274f0651e2.1470985727.git.panand@redhat.com>
In-Reply-To: <cover.1470985727.git.panand@redhat.com>
References: <cover.1470985727.git.panand@redhat.com>
In-Reply-To: <cover.1470985727.git.panand@redhat.com>
References: <cover.1470985727.git.panand@redhat.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

We need the ability to support initialization of hpet_default_delta and
hpet_t1_cmp counters before irq can be enabled.

This patch splits hpet_rtc_timer_init() into two functions:
hpet_rtc_timer_counter_init() and hpet_rtc_timer_enable, so that the above
functionality can be achieved.

Next patch explains it's need in detail.

No functional change in this patch.

Signed-off-by: Pratyush Anand <panand@redhat.com>
[dzickus@redhat.com: edited the patch's summary]
Signed-off-by: Don Zickus <dzickus@redhat.com>
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
index ed16e58658a4..6f6d21059b1b 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -1074,14 +1074,12 @@ void hpet_unregister_irq_handler(rtc_irq_handler handler)
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
@@ -1106,6 +1104,22 @@ int hpet_rtc_timer_init(void)
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
@@ -1115,6 +1129,21 @@ int hpet_rtc_timer_init(void)
 
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
