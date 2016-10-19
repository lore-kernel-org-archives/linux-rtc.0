Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB6NNTTAAKGQE6ZIP74A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (up.free-electrons.com. [163.172.77.33])
        by gmr-mx.google.com with ESMTP id h64si124711wmg.2.2016.10.18.23.47.21
        for <rtc-linux@googlegroups.com>;
        Tue, 18 Oct 2016 23:47:21 -0700 (PDT)
Date: Wed, 19 Oct 2016 08:47:20 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH RESENT v2] rtc: cmos: remove all __exit_p annotations
Message-ID: <20161019064720.zbu2j7p56dmzf7p6@piout.net>
References: <1476801594-1194-1-git-send-email-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1476801594-1194-1-git-send-email-clabbe.montjoie@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 18/10/2016 at 16:39:54 +0200, Corentin Labbe wrote :
> I got the following stack trace under qemu:
> [    7.575243] BUG: unable to handle kernel NULL pointer dereference at 0000000000000010
> [    7.596098] IP: [<ffffffff814f5b08>] cmos_set_alarm+0x38/0x280
> [    7.615699] PGD 3ccbe067
> [    7.615923] PUD 3daf2067
> [    7.635156] PMD 0
> [    7.654358] Oops: 0000 [#1] SMP
> [    7.673869] Modules linked in:
> [    7.693235] CPU: 0 PID: 1701 Comm: hwclock Tainted: G        W       4.9.0-rc1+ #24
> [    7.712455] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.9.3-0-ge2fc41e-prebuilt.qemu-project.org 04/01/2014
> [    7.753569] task: ffff88003d88dc40 task.stack: ffffc90000224000
> [    7.773743] RIP: 0010:[<ffffffff814f5b08>]  [<ffffffff814f5b08>] cmos_set_alarm+0x38/0x280
> [    7.794893] RSP: 0018:ffffc90000227c10  EFLAGS: 00010296
> [    7.815890] RAX: 000000000000001d RBX: ffffc90000227d28 RCX: ffffffff8182be78
> [    7.836057] RDX: 0000000000000001 RSI: 0000000000000202 RDI: 0000000000000202
> [    7.856612] RBP: ffffc90000227c48 R08: 0000000000000000 R09: 0000000000000001
> [    7.877561] R10: 00000000000001c0 R11: 00000000000001c0 R12: 0000000000000000
> [    7.897072] R13: ffff88003d96f400 R14: ffff88003dac6410 R15: ffff88003dac6420
> [    7.917403] FS:  00007f77f42d9700(0000) GS:ffff88003fc00000(0000) knlGS:0000000000000000
> [    7.938293] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    7.958364] CR2: 0000000000000010 CR3: 000000003ccbb000 CR4: 00000000000006f0
> [    7.978028] Stack:
> [    7.997120]  ffff88003dac6000 ffff88003dac6410 0000000058049d01 ffffc90000227d28
> [    8.016993]  ffff88003dac6000 ffff88003dac6410 ffff88003dac6420 ffffc90000227c98
> [    8.039505]  ffffffff814f225d 0000001800227c98 000000090000002a 0000000900000011
> [    8.059985] Call Trace:
> [    8.080110]  [<ffffffff814f225d>] __rtc_set_alarm+0x8d/0xa0
> [    8.099421]  [<ffffffff814f2389>] rtc_timer_enqueue+0x119/0x190
> [    8.119925]  [<ffffffff814f2e6e>] rtc_update_irq_enable+0xbe/0x100
> [    8.140583]  [<ffffffff814f3bb0>] rtc_dev_ioctl+0x3c0/0x480
> [    8.161162]  [<ffffffff81146b6a>] ? user_path_at_empty+0x3a/0x50
> [    8.182717]  [<ffffffff8114aa36>] do_vfs_ioctl+0x96/0x5c0
> [    8.204624]  [<ffffffff8113e066>] ? vfs_stat+0x16/0x20
> [    8.225994]  [<ffffffff8113e135>] ? SyS_newstat+0x15/0x30
> [    8.247043]  [<ffffffff8114afa7>] SyS_ioctl+0x47/0x80
> [    8.267191]  [<ffffffff815f5c77>] entry_SYSCALL_64_fastpath+0x1a/0xa9
> [    8.288719] Code: 6a 81 48 89 e5 41 57 41 56 41 55 49 89 fd 41 54 53 48 89 f3 48 c7 c6 20 c4 78 81 48 83 ec 10 e8 8f 00 ef ff 4d 8b a5 a0 00 00 00 <41> 8b 44 24 10 85 c0 0f 8e 2b 02 00 00 4c 89 ef 31 c0 b9 53 01
> [    8.335233] RIP  [<ffffffff814f5b08>] cmos_set_alarm+0x38/0x280
> [    8.357096]  RSP <ffffc90000227c10>
> [    8.379051] CR2: 0000000000000010
> [    8.401736] ---[ end trace 5cbcd83a1f225ed3 ]---
> 
> This occur only when CONFIG_DEBUG_TEST_DRIVER_REMOVE is enabled and
> CONFIG_RTC_DRV_CMOS builtin.
> 
> When cmos_set_alarm() is called dev is NULL and so trigger the deref via
> cmos->irq
> 
> The problem comes from that the device is removed but no remove function
> are called due to _exit_p().
> 
> This patch remove all _exit_p() annotation.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
> 
> Change since v1:
> - restored __exit for module_exit function
> 
>  drivers/rtc/rtc-cmos.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
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
