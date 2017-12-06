Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:47374 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754697AbdLFKTH (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 6 Dec 2017 05:19:07 -0500
Date: Wed, 6 Dec 2017 11:19:06 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: David =?iso-8859-1?Q?M=FCller_=28ELSOFT_AG=29?=
        <d.mueller@elsoft.ch>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-rtc@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Subject: Re: rtc-pcf8563: circular locking dependency
Message-ID: <20171206101906.GN21780@piout.net>
References: <c8d6a60f-c574-9883-53ea-3b1c55275057@elsoft.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <c8d6a60f-c574-9883-53ea-3b1c55275057@elsoft.ch>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

Thanks for the report. This is actually a known issue (at least, I know
about it).

I'm adding the clock framework maintainers as this is actually an issue
that affects any device exposing clocks that are on a bus using clock
operations in its transfer operations. Here, an i2c RTC, exposing clocks
and connected on an imx6.

This has been solved by caching the registers for the m41t80 RTC, see:

http://patchwork.ozlabs.org/project/rtc-linux/list/?series=11636&state=*

But, I find that cumbersome and maybe something can be done in the clk
framework. I didn't check what the prepare_lock protects yet. But maybe
we can have another lock for get_rate and the like?

Stephen, Mike, any input?


On 05/12/2017 at 15:14:00 +0100, David Müller (ELSOFT AG) wrote:
> Hello
> 
> On my i.MX6Q based system, loading the rtc-pcf8563 module results in the
> following warning. This happens with Linux 4.14 and 4.13.
> 
> / # modprobe rtc-pcf8563
> 
> rtc-pcf8563 2-0051: low voltage detected, date/time is not reliable.
> 
> rtc-pcf8563 2-0051: rtc core: registered rtc-pcf8563 as rtc0
> 
> 
> ======================================================
> 
> WARNING: possible circular locking dependency detected
> 
> 4.14.0+ #20 Not tainted
> 
> ------------------------------------------------------
> 
> modprobe/460 is trying to acquire lock:
> 
>  (i2c_register_adapter){+.+.}, at: [<8045a4b4>]
> i2c_adapter_lock_bus+0x14/0x18
> 
> but task is already holding lock:
> 
>  (prepare_lock){+.+.}, at: [<80388254>] clk_prepare_lock+0x14/0xdc
> 
> 
> which lock already depends on the new lock.
> 
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> 
> -> #1 (prepare_lock){+.+.}:
> 
>        __mutex_lock+0x58/0x92c
> 
>        mutex_lock_nested+0x24/0x2c
> 
>        clk_prepare_lock+0x4c/0xdc
> 
>        clk_core_get_rate+0x14/0x4c
> 
>        clk_get_rate+0x1c/0x20
> 
>        i2c_imx_start+0x20/0x1bc [i2c_imx]
> 
>        i2c_imx_xfer+0x38/0x990 [i2c_imx]
> 
>        __i2c_transfer+0x1d0/0x220
> 
>        i2c_transfer+0x8c/0xbc
> 
>        i2c_smbus_xfer+0x3c8/0x514
> 
>        i2c_smbus_read_byte_data+0x3c/0x4c
> 
>        pca953x_read_single+0x4c/0x80 [gpio_pca953x]
> 
>        pca953x_gpio_get_direction+0x44/0x7c [gpio_pca953x]
> 
>        gpiochip_add_data+0x320/0x5d8
> 
>        devm_gpiochip_add_data+0x40/0x80
> 
>        pca953x_probe+0x354/0x454 [gpio_pca953x]
> 
>        i2c_device_probe+0x210/0x268
> 
>        driver_probe_device+0x160/0x2e0
> 
>        __driver_attach+0x90/0xb4
> 
>        bus_for_each_dev+0x74/0x98
> 
>        driver_attach+0x20/0x28
> 
>        bus_add_driver+0xd4/0x1e8
> 
>        driver_register+0xa4/0xe8
> 
>        i2c_register_driver+0x54/0x80
> 
>        0x7f068018
> 
>        do_one_initcall+0xb0/0x158
> 
>        do_init_module+0x60/0x1c8
> 
>        load_module+0x198c/0x1eac
> 
>        SyS_init_module+0x120/0x150
> 
>        ret_fast_syscall+0x0/0x28
> 
> 
> -> #0 (i2c_register_adapter){+.+.}:
> 
>        lock_acquire+0x78/0x98
> 
>        rt_mutex_lock+0x38/0x50
> 
>        i2c_adapter_lock_bus+0x14/0x18
> 
>        i2c_transfer+0x7c/0xbc
> 
>        pcf8563_read_block_data+0x68/0x98 [rtc_pcf8563]
> 
>        pcf8563_clkout_recalc_rate+0x24/0x44 [rtc_pcf8563]
> 
>        clk_register+0x344/0x538
> 
>        devm_clk_register+0x3c/0x7c
> 
>        pcf8563_probe+0x1a8/0x20c [rtc_pcf8563]
> 
>        i2c_device_probe+0x210/0x268
> 
>        driver_probe_device+0x160/0x2e0
> 
>        __driver_attach+0x90/0xb4
> 
>        bus_for_each_dev+0x74/0x98
> 
>        driver_attach+0x20/0x28
> 
>        bus_add_driver+0xd4/0x1e8
> 
>        driver_register+0xa4/0xe8
> 
>        i2c_register_driver+0x54/0x80
> 
>        pcf8563_driver_init+0x18/0x1000 [rtc_pcf8563]
> 
>        do_one_initcall+0xb0/0x158
> 
>        do_init_module+0x60/0x1c8
> 
>        load_module+0x198c/0x1eac
> 
>        SyS_init_module+0x120/0x150
> 
>        ret_fast_syscall+0x0/0x28
> 
> 
> other info that might help us debug this:
> 
> 
>  Possible unsafe locking scenario:
> 
> 
>        CPU0                    CPU1
> 
>        ----                    ----
> 
>   lock(prepare_lock);
> 
>                                lock(i2c_register_adapter);
> 
>                                lock(prepare_lock);
> 
>   lock(i2c_register_adapter);
> 
> 
>  *** DEADLOCK ***
> 
> 
> 3 locks held by modprobe/460:
> 
>  #0:  (&dev->mutex){....}, at: [<803ce808>] __driver_attach+0x68/0xb4
> 
>  #1:  (&dev->mutex){....}, at: [<803ce818>] __driver_attach+0x78/0xb4
> 
>  #2:  (prepare_lock){+.+.}, at: [<80388254>] clk_prepare_lock+0x14/0xdc
> 
> 
> stack backtrace:
> 
> CPU: 0 PID: 460 Comm: modprobe Not tainted 4.14.0+ #20
> 
> Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> 
> Backtrace:
> 
> [<8010b9f0>] (dump_backtrace) from [<8010bc58>] (show_stack+0x18/0x1c)
> 
>  r6:00000080 r5:600c0093 r4:00000000 r3:00400100
> 
> [<8010bc40>] (show_stack) from [<8056a664>] (dump_stack+0xa0/0xd8)
> 
> [<8056a5c4>] (dump_stack) from [<80164340>]
> (print_circular_bug+0x278/0x2cc)
>  r7:ae87e200 r6:80a7f254 r5:80a7f254 r4:80a62c24
> 
> [<801640c8>] (print_circular_bug) from [<80162d58>]
> (__lock_acquire+0x1104/0x182c)
> 
>  r10:ae87e7c0 r9:ae2a7aec r8:00000002 r7:ae87e7b8 r6:00000003
> r5:ae87e260
>  r4:ae87e200 r3:ae87e7b8
> 
> [<80161c54>] (__lock_acquire) from [<80163bc0>] (lock_acquire+0x78/0x98)
> 
>  r10:00000000 r9:0000002a r8:7f52662c r7:ae6071e0 r6:00000001
> r5:600c0013
>  r4:00000000
> 
> [<80163b48>] (lock_acquire) from [<80581fcc>] (rt_mutex_lock+0x38/0x50)
> 
>  r6:ae2a7be8 r5:aeaaf824 r4:00000000
> 
> [<80581f94>] (rt_mutex_lock) from [<8045a4b4>]
> (i2c_adapter_lock_bus+0x14/0x18)
>  r5:00000002 r4:aeaaf810
> 
> [<8045a4a0>] (i2c_adapter_lock_bus) from [<8045acb8>]
> (i2c_transfer+0x7c/0xbc)
> [<8045ac3c>] (i2c_transfer) from [<7f52624c>]
> (pcf8563_read_block_data+0x68/0x98
>  [rtc_pcf8563])
> 
>  r6:00000001 r5:ae2a7c27 r4:ae4a6400 r3:ae2a7be7
> 
> [<7f5261e4>] (pcf8563_read_block_data [rtc_pcf8563]) from [<7f526650>]
> (pcf8563_
> clkout_recalc_rate+0x24/0x44 [rtc_pcf8563])
> 
>  r6:00000000 r5:810d2800 r4:ae5e3800
> 
> [<7f52662c>] (pcf8563_clkout_recalc_rate [rtc_pcf8563]) from
> [<8038aff0>] (clk_r
> egister+0x344/0x538)
> 
> [<8038acac>] (clk_register) from [<8038b220>]
> (devm_clk_register+0x3c/0x7c)
>  r9:0000002a r8:7f528020 r7:af76e72c r6:ae4a6420 r5:ae676ad0 r4:ae6071e0
> 
> [<8038b1e4>] (devm_clk_register) from [<7f526aa8>]
> (pcf8563_probe+0x1a8/0x20c [r
> tc_pcf8563])
> 
>  r6:ae6071d0 r5:ae4a6400 r4:00000000 r3:7f52709c
> 
> [<7f526900>] (pcf8563_probe [rtc_pcf8563]) from [<8045b0e4>]
> (i2c_device_probe+0
> x210/0x268)
> 
>  r7:ae4a6420 r6:7f528020 r5:7f526900 r4:ae4a6400
> 
> [<8045aed4>] (i2c_device_probe) from [<803ce620>]
> (driver_probe_device+0x160/0x2
> e0)
> 
>  r8:7f528020 r7:00000000 r6:810d6560 r5:810d6554 r4:ae4a6420 r3:8045aed4
> 
> [<803ce4c0>] (driver_probe_device) from [<803ce830>]
> (__driver_attach+0x90/0xb4)
>  r10:810c5808 r9:ae607570 r8:00000000 r7:80929038 r6:7f528020
> r5:ae4a6454
>  r4:ae4a6420 r3:00000000
> 
> [<803ce7a0>] (__driver_attach) from [<803cca54>]
> (bus_for_each_dev+0x74/0x98)
>  r6:803ce7a0 r5:7f528020 r4:00000000 r3:00000001
> [<803cc9e0>] (bus_for_each_dev) from [<803ce04c>] (driver_attach+0x20/0x28)
>  r6:ae0e2480 r5:00000000 r4:7f528020
> [<803ce02c>] (driver_attach) from [<803cd75c>] (bus_add_driver+0xd4/0x1e8)
> [<803cd688>] (bus_add_driver) from [<803cf184>] (driver_register+0xa4/0xe8)
>  r7:ae607540 r6:ae6078c0 r5:7f52b000 r4:7f528020
> [<803cf0e0>] (driver_register) from [<8045a5f8>]
> (i2c_register_driver+0x54/0x80)
>  r5:7f52b000 r4:7f528000
> [<8045a5a4>] (i2c_register_driver) from [<7f52b018>]
> (pcf8563_driver_init+0x18/0
> x1000 [rtc_pcf8563])
>  r5:7f52b000 r4:7f528080
> [<7f52b000>] (pcf8563_driver_init [rtc_pcf8563]) from [<80101c38>]
> (do_one_initc
> all+0xb0/0x158)
> [<80101b88>] (do_one_initcall) from [<801a0e7c>] (do_init_module+0x60/0x1c8)
>  r8:00000001 r7:ae607540 r6:ae6078c0 r5:00000001 r4:7f528080
> [<801a0e1c>] (do_init_module) from [<8019fc7c>] (load_module+0x198c/0x1eac)
>  r6:7f528080 r5:00000001 r4:ae2a7f30
> [<8019e2f0>] (load_module) from [<801a02bc>] (SyS_init_module+0x120/0x150)
>  r10:00000051 r9:ae2a6000 r8:000c6eb9 r7:00000000 r6:019f8fdc r5:c12d982c
>  r4:0000582c
> [<801a019c>] (SyS_init_module) from [<80107720>] (ret_fast_syscall+0x0/0x28)
>  r10:00001000 r9:ae2a6000 r8:801078e4 r7:00000080 r6:76f876e0 r5:019f37b0
>  r4:019d3cf8

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
