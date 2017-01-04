Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBLPTWXBQKGQEXQQDODQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id e134si5333313wmd.3.2017.01.04.14.39.41
        for <rtc-linux@googlegroups.com>;
        Wed, 04 Jan 2017 14:39:41 -0800 (PST)
Date: Wed, 4 Jan 2017 23:39:40 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v2 1/1] rtc: rx8010: change lock mechanism
Message-ID: <20170104223940.gscg6g2kclrobmwk@piout.net>
References: <20161219001734.ghsir573a45ksuxv@piout.net>
 <1482223364-25427-1-git-send-email-fabien.lahoudere@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1482223364-25427-1-git-send-email-fabien.lahoudere@collabora.co.uk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 20/12/2016 at 09:42:44 +0100, Fabien Lahoudere wrote :
> Remove spinlock and use the "rtc->ops_lock" from RTC subsystem instead.
> spin_lock_irqsave() is not needed here because we do not have hard IRQs.
> 
> This patch fixes the following issue:
> 
> root@GE004097290448 b850v3:~# hwclock --systohc
> root@GE004097290448 b850v3:~# hwclock --systohc
> root@GE004097290448 b850v3:~# hwclock --systohc
> root@GE004097290448 b850v3:~# hwclock --systohc
> root@GE004097290448 b850v3:~# hwclock --systohc
> [   82.108175] BUG: spinlock wrong CPU on CPU#0, hwclock/855
> [   82.113660]  lock: 0xedb4899c, .magic: dead4ead, .owner: hwclock/855, .owner_cpu: 1
> [   82.121329] CPU: 0 PID: 855 Comm: hwclock Not tainted 4.8.0-00042-g09d5410-dirty #20
> [   82.129078] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [   82.135609] Backtrace:
> [   82.138090] [<8010d378>] (dump_backtrace) from [<8010d5c0>] (show_stack+0x20/0x24)
> [   82.145664]  r7:ec936000 r6:600a0013 r5:00000000 r4:81031680
> [   82.151402] [<8010d5a0>] (show_stack) from [<80401518>] (dump_stack+0xb4/0xe8)
> [   82.158636] [<80401464>] (dump_stack) from [<8017b8b0>] (spin_dump+0x84/0xcc)
> [   82.165775]  r10:00000000 r9:ec936000 r8:81056090 r7:600a0013 r6:edb4899c r5:edb4899c
> [   82.173691]  r4:e5033e00 r3:00000000
> [   82.177308] [<8017b82c>] (spin_dump) from [<8017bcb0>] (do_raw_spin_unlock+0x108/0x130)
> [   82.185314]  r5:edb4899c r4:edb4899c
> [   82.188938] [<8017bba8>] (do_raw_spin_unlock) from [<8094b93c>] (_raw_spin_unlock_irqrestore+0x34/0x54)
> [   82.198333]  r5:edb4899c r4:600a0013
> [   82.201953] [<8094b908>] (_raw_spin_unlock_irqrestore) from [<8065b090>] (rx8010_set_time+0x14c/0x188)
> [   82.211261]  r5:00000020 r4:edb48990
> [   82.214882] [<8065af44>] (rx8010_set_time) from [<80653fe4>] (rtc_set_time+0x70/0x104)
> [   82.222801]  r7:00000051 r6:edb39da0 r5:edb39c00 r4:ec937e8c
> [   82.228535] [<80653f74>] (rtc_set_time) from [<80655774>] (rtc_dev_ioctl+0x3c4/0x674)
> [   82.236368]  r7:00000051 r6:7ecf1b74 r5:00000000 r4:edb39c00
> [   82.242106] [<806553b0>] (rtc_dev_ioctl) from [<80284034>] (do_vfs_ioctl+0xa4/0xa6c)
> [   82.249851]  r8:00000003 r7:80284a40 r6:ed1e9c80 r5:edb44e60 r4:7ecf1b74
> [   82.256642] [<80283f90>] (do_vfs_ioctl) from [<80284a40>] (SyS_ioctl+0x44/0x6c)
> [   82.263953]  r10:00000000 r9:ec936000 r8:7ecf1b74 r7:4024700a r6:ed1e9c80 r5:00000003
> [   82.271869]  r4:ed1e9c80
> [   82.274432] [<802849fc>] (SyS_ioctl) from [<80108520>] (ret_fast_syscall+0x0/0x1c)
> [   82.282005]  r9:ec936000 r8:801086c4 r7:00000036 r6:00000000 r5:00000003 r4:0008e1bc
> root@GE004097290448 b850v3:~#
> Message from syslogd@GE004097290448 at Dec  3 11:17:08 ...
>  kernel:[   82.108175] BUG: spinlock wrong CPU on CPU#0, hwclock/855
> 
> Message from syslogd@GE004097290448 at Dec  3 11:17:08 ...
>  kernel:[   82.113660]  lock: 0xedb4899c, .magic: dead4ead, .owner: hwclock/855, .owner_cpu: 1
> hwclock --systohc
> root@GE004097290448 b850v3:~#
> 
> Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
> ---
>  drivers/rtc/rtc-rx8010.c | 24 +++---------------------
>  1 file changed, 3 insertions(+), 21 deletions(-)
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
