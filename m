Return-Path: <rtc-linux+bncBAABBNPKT3AAKGQE6FZK4HI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mga04.intel.com (mga04.intel.com. [192.55.52.120])
        by gmr-mx.google.com with ESMTPS id co10si6074118pad.1.2016.10.19.11.02.29
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 19 Oct 2016 11:02:29 -0700 (PDT)
From: ville.syrjala@linux.intel.com
To: rtc-linux@googlegroups.com
Cc: linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	Gabriele Mazzotta <gabriele.mzt@gmail.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Subject: [rtc-linux] [PATCH] rtc: cmos: Don't enable interrupts in the middle
 of the interrupt handler
Date: Wed, 19 Oct 2016 21:02:04 +0300
Message-Id: <1476900124-14405-1-git-send-email-ville.syrjala@linux.intel.com>
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

From: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>

Using spin_lock_irq()/spin_unlock_irq() from within the interrupt
handler is a no-no. Let's save/restore the flags to avoid turning on
interrupts prematurely.

We hit this in a bunch of our CI systems, but for whatever reason I
wasn't able to reproduce on my own machine, so this fix is just
based on the backtrace.

[  202.634918] WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:2729 trac=
e_hardirqs_on_caller+0x113/0x1b0
[  202.634919] DEBUG_LOCKS_WARN_ON(current->hardirq_context)
[  202.634929] Modules linked in: snd_hda_intel i915 x86_pkg_temp_thermal i=
ntel_powerclamp coretemp crct10dif_pclmul crc32_pclmul ghash_clmulni_intel =
lpc_ich snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi snd_=
hda_codec snd_hwdep i2c_designware_platform i2c_designware_core snd_hda_cor=
e mei_me mei snd_pcm r8169 mii sdhci_acpi sdhci mmc_core i2c_hid [last unlo=
aded: i915]
[  202.634930] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G     U          4.9.=
0-rc1-CI-CI_DRM_1734+ #1
[  202.634931] Hardware name: GIGABYTE M4HM87P-00/M4HM87P-00, BIOS F6 12/10=
/2014
[  202.634933]  ffff88011ea03d68 ffffffff8142dce5 ffff88011ea03db8 00000000=
00000000
[  202.634934]  ffff88011ea03da8 ffffffff8107e496 00000aa900000002 ffffffff=
81e249a0
[  202.634935]  ffffffff81815637 ffffffff82e7c280 0000000000000000 00000000=
00000004
[  202.634936] Call Trace:
[  202.634939]  <IRQ>
[  202.634939]  [<ffffffff8142dce5>] dump_stack+0x67/0x92
[  202.634941]  [<ffffffff8107e496>] __warn+0xc6/0xe0
[  202.634944]  [<ffffffff81815637>] ? _raw_spin_unlock_irq+0x27/0x50
[  202.634945]  [<ffffffff8107e4fa>] warn_slowpath_fmt+0x4a/0x50
[  202.634946]  [<ffffffff810d6d83>] trace_hardirqs_on_caller+0x113/0x1b0
[  202.634948]  [<ffffffff810d6e2d>] trace_hardirqs_on+0xd/0x10
[  202.634949]  [<ffffffff81815637>] _raw_spin_unlock_irq+0x27/0x50
[  202.634951]  [<ffffffff81672042>] rtc_handler+0x32/0xa0
[  202.634954]  [<ffffffff814c08a3>] acpi_ev_fixed_event_detect+0xd4/0xfb
[  202.634956]  [<ffffffff814c2ccb>] acpi_ev_sci_xrupt_handler+0xf/0x2d
[  202.634957]  [<ffffffff814ab3ee>] acpi_irq+0x11/0x2c
[  202.634960]  [<ffffffff810e5288>] __handle_irq_event_percpu+0x58/0x370
[  202.634961]  [<ffffffff810e55be>] handle_irq_event_percpu+0x1e/0x50
[  202.634962]  [<ffffffff810e5624>] handle_irq_event+0x34/0x60
[  202.634963]  [<ffffffff810e8906>] handle_fasteoi_irq+0xa6/0x170
[  202.634966]  [<ffffffff8101eef5>] handle_irq+0x15/0x20
[  202.634967]  [<ffffffff8101e548>] do_IRQ+0x68/0x130
[  202.634968]  [<ffffffff81816789>] common_interrupt+0x89/0x89
[  202.634970]  <EOI>
[  202.634970]  [<ffffffff81814c73>] ? mwait_idle+0x93/0x210
[  202.634971]  [<ffffffff81814c6a>] ? mwait_idle+0x8a/0x210
[  202.634972]  [<ffffffff81026b0a>] arch_cpu_idle+0xa/0x10
[  202.634973]  [<ffffffff8181509e>] default_idle_call+0x1e/0x30
[  202.634974]  [<ffffffff810cbf6c>] cpu_startup_entry+0x17c/0x1f0
[  202.634976]  [<ffffffff8180ca87>] rest_init+0x127/0x130
[  202.634978]  [<ffffffff81f77f08>] start_kernel+0x3f6/0x403
[  202.634980]  [<ffffffff81f7728f>] x86_64_start_reservations+0x2a/0x2c
[  202.634981]  [<ffffffff81f77404>] x86_64_start_kernel+0x173/0x186
[  202.634982] ---[ end trace 293c99618fa08d34 ]---

Cc: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Fixes: 983bf1256edb ("rtc: cmos: Clear ACPI-driven alarms upon resume")
Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
---
 drivers/rtc/rtc-cmos.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index dd3d59806ffa..19cd49ad92dc 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -996,8 +996,9 @@ static u32 rtc_handler(void *context)
 	struct cmos_rtc *cmos =3D dev_get_drvdata(dev);
 	unsigned char rtc_control =3D 0;
 	unsigned char rtc_intr;
+	unsigned long flags;
=20
-	spin_lock_irq(&rtc_lock);
+	spin_lock_irqsave(&rtc_lock, flags);
 	if (cmos_rtc.suspend_ctrl)
 		rtc_control =3D CMOS_READ(RTC_CONTROL);
 	if (rtc_control & RTC_AIE) {
@@ -1006,7 +1007,7 @@ static u32 rtc_handler(void *context)
 		rtc_intr =3D CMOS_READ(RTC_INTR_FLAGS);
 		rtc_update_irq(cmos->rtc, 1, rtc_intr);
 	}
-	spin_unlock_irq(&rtc_lock);
+	spin_unlock_irqrestore(&rtc_lock, flags);
=20
 	pm_wakeup_event(dev, 0);
 	acpi_clear_event(ACPI_EVENT_RTC);
--=20
2.7.4

--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
