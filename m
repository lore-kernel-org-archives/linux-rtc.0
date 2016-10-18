Return-Path: <rtc-linux+bncBD7YLCN32UNBB4U4TDAAKGQEZ6SABQY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
MIME-Version: 1.0
Received: from mail-qt0-x244.google.com (mail-qt0-x244.google.com. [2607:f8b0:400d:c0d::244])
        by gmr-mx.google.com with ESMTPS id 80si2283355ywv.5.2016.10.18.04.58.41
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Oct 2016 04:58:41 -0700 (PDT)
Received: by mail-qt0-x244.google.com with SMTP id m5so7230365qtb.0
        for <rtc-linux@googlegroups.com>; Tue, 18 Oct 2016 04:58:41 -0700 (PDT)
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com,
	lars@metafoo.de
Cc: rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [rtc-linux] [PATCH v2] rtc: cmos: remove all __exit_p annotations
Date: Tue, 18 Oct 2016 13:55:53 +0200
Message-Id: <1476791753-1837-1-git-send-email-clabbe.montjoie@gmail.com>
Reply-To: rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Change since v1:
- restored __exit for module_exit function

---8<---
>From c04a24acebee4b4432afa7a2a7d4cfe114cc9a40 Mon Sep 17 00:00:00 2001
From: Corentin Labbe <clabbe.montjoie@gmail.com>
Date: Mon, 17 Oct 2016 14:17:49 +0200
Subject: [PATCH v2] rtc: cmos: remove all __exit_p annotations

I got the following stack trace under qemu:
[    7.575243] BUG: unable to handle kernel NULL pointer dereference at 0000000000000010
[    7.596098] IP: [<ffffffff814f5b08>] cmos_set_alarm+0x38/0x280
[    7.615699] PGD 3ccbe067
[    7.615923] PUD 3daf2067
[    7.635156] PMD 0

[    7.654358] Oops: 0000 [#1] SMP
[    7.673869] Modules linked in:
[    7.693235] CPU: 0 PID: 1701 Comm: hwclock Tainted: G        W       4.9.0-rc1+ #24
[    7.712455] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.9.3-0-ge2fc41e-prebuilt.qemu-project.org 04/01/2014
[    7.753569] task: ffff88003d88dc40 task.stack: ffffc90000224000
[    7.773743] RIP: 0010:[<ffffffff814f5b08>]  [<ffffffff814f5b08>] cmos_set_alarm+0x38/0x280
[    7.794893] RSP: 0018:ffffc90000227c10  EFLAGS: 00010296
[    7.815890] RAX: 000000000000001d RBX: ffffc90000227d28 RCX: ffffffff8182be78
[    7.836057] RDX: 0000000000000001 RSI: 0000000000000202 RDI: 0000000000000202
[    7.856612] RBP: ffffc90000227c48 R08: 0000000000000000 R09: 0000000000000001
[    7.877561] R10: 00000000000001c0 R11: 00000000000001c0 R12: 0000000000000000
[    7.897072] R13: ffff88003d96f400 R14: ffff88003dac6410 R15: ffff88003dac6420
[    7.917403] FS:  00007f77f42d9700(0000) GS:ffff88003fc00000(0000) knlGS:0000000000000000
[    7.938293] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.958364] CR2: 0000000000000010 CR3: 000000003ccbb000 CR4: 00000000000006f0
[    7.978028] Stack:
[    7.997120]  ffff88003dac6000 ffff88003dac6410 0000000058049d01 ffffc90000227d28
[    8.016993]  ffff88003dac6000 ffff88003dac6410 ffff88003dac6420 ffffc90000227c98
[    8.039505]  ffffffff814f225d 0000001800227c98 000000090000002a 0000000900000011
[    8.059985] Call Trace:
[    8.080110]  [<ffffffff814f225d>] __rtc_set_alarm+0x8d/0xa0
[    8.099421]  [<ffffffff814f2389>] rtc_timer_enqueue+0x119/0x190
[    8.119925]  [<ffffffff814f2e6e>] rtc_update_irq_enable+0xbe/0x100
[    8.140583]  [<ffffffff814f3bb0>] rtc_dev_ioctl+0x3c0/0x480
[    8.161162]  [<ffffffff81146b6a>] ? user_path_at_empty+0x3a/0x50
[    8.182717]  [<ffffffff8114aa36>] do_vfs_ioctl+0x96/0x5c0
[    8.204624]  [<ffffffff8113e066>] ? vfs_stat+0x16/0x20
[    8.225994]  [<ffffffff8113e135>] ? SyS_newstat+0x15/0x30
[    8.247043]  [<ffffffff8114afa7>] SyS_ioctl+0x47/0x80
[    8.267191]  [<ffffffff815f5c77>] entry_SYSCALL_64_fastpath+0x1a/0xa9
[    8.288719] Code: 6a 81 48 89 e5 41 57 41 56 41 55 49 89 fd 41 54 53 48 89 f3 48 c7 c6 20 c4 78 81 48 83 ec 10 e8 8f 00 ef ff 4d 8b a5 a0 00 00 00 <41> 8b 44 24 10 85 c0 0f 8e 2b 02 00 00 4c 89 ef 31 c0 b9 53 01
[    8.335233] RIP  [<ffffffff814f5b08>] cmos_set_alarm+0x38/0x280
[    8.357096]  RSP <ffffc90000227c10>
[    8.379051] CR2: 0000000000000010
[    8.401736] ---[ end trace 5cbcd83a1f225ed3 ]---

This occur only when CONFIG_DEBUG_TEST_DRIVER_REMOVE is enabled and
CONFIG_RTC_DRV_CMOS builtin.

When cmos_set_alarm() is called dev is NULL and so trigger the deref via
cmos->irq

The problem comes from that the device is removed but no remove function
are called due to _exit_p().

This patch remove all _exit_p() annotation.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/rtc/rtc-cmos.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index dd3d598..6f0e12e 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -776,7 +776,7 @@ static void cmos_do_shutdown(int rtc_irq)
 	spin_unlock_irq(&rtc_lock);
 }
 
-static void __exit cmos_do_remove(struct device *dev)
+static void cmos_do_remove(struct device *dev)
 {
 	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
 	struct resource *ports;
@@ -1129,7 +1129,7 @@ static int cmos_pnp_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 				pnp_irq(pnp, 0));
 }
 
-static void __exit cmos_pnp_remove(struct pnp_dev *pnp)
+static void cmos_pnp_remove(struct pnp_dev *pnp)
 {
 	cmos_do_remove(&pnp->dev);
 }
@@ -1161,7 +1161,7 @@ static struct pnp_driver cmos_pnp_driver = {
 	.name		= (char *) driver_name,
 	.id_table	= rtc_ids,
 	.probe		= cmos_pnp_probe,
-	.remove		= __exit_p(cmos_pnp_remove),
+	.remove		= cmos_pnp_remove,
 	.shutdown	= cmos_pnp_shutdown,
 
 	/* flag ensures resume() gets called, and stops syslog spam */
@@ -1238,7 +1238,7 @@ static int __init cmos_platform_probe(struct platform_device *pdev)
 	return cmos_do_probe(&pdev->dev, resource, irq);
 }
 
-static int __exit cmos_platform_remove(struct platform_device *pdev)
+static int cmos_platform_remove(struct platform_device *pdev)
 {
 	cmos_do_remove(&pdev->dev);
 	return 0;
@@ -1263,7 +1263,7 @@ static void cmos_platform_shutdown(struct platform_device *pdev)
 MODULE_ALIAS("platform:rtc_cmos");
 
 static struct platform_driver cmos_platform_driver = {
-	.remove		= __exit_p(cmos_platform_remove),
+	.remove		= cmos_platform_remove,
 	.shutdown	= cmos_platform_shutdown,
 	.driver = {
 		.name		= driver_name,
-- 
2.7.3

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
