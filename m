Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:33483 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751514AbdLVMub (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 22 Dec 2017 07:50:31 -0500
Message-ID: <1513947027.1940.13.camel@googlemail.com>
Subject: rtc: m41t80rtc: recent v4.15 changes ready for stable branch 4.14 ?
From: Christoph Fritz <chf.fritz@googlemail.com>
Reply-To: chf.fritz@googlemail.com
To: Troy Kisky <troy.kisky@boundarydevices.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org, stable@vger.kernel.org,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 22 Dec 2017 13:50:27 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hey Troy and Alexandre,

 any objections asking Greg to add following recent v4.15 changes into
stable branch 4.14?

05a03bf rtc: m41t80: remove unneeded checks from m41t80_sqw_set_rate
13bb1d7 rtc: m41t80: avoid i2c read in m41t80_sqw_is_prepared
2cb90ed rtc: m41t80: avoid i2c read in m41t80_sqw_recalc_rate
c8384bb rtc: m41t80: fix m41t80_sqw_round_rate return value
de6042d rtc: m41t80: m41t80_sqw_set_rate should return 0 on success

Without these patches, deadlock warnings showing up in 4.14:

======================================================
WARNING: possible circular locking dependency detected
4.14.8-00011-gd203938 #11 Not tainted
------------------------------------------------------
kworker/1:2/133 is trying to acquire lock:
 (prepare_lock){+.+.}, at: [<c04951d0>] clk_prepare_lock+0x80/0xf4

but task is already holding lock:
 (i2c_register_adapter){+.+.}, at: [<c069305c>] i2c_adapter_lock_bus+0x14/0x18

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (i2c_register_adapter){+.+.}:
       rt_mutex_lock+0x44/0x5c
       i2c_adapter_lock_bus+0x14/0x18
       i2c_transfer+0xa8/0xbc
       i2c_smbus_xfer+0x214/0x5cc
       i2c_smbus_read_byte_data+0x3c/0x4c
       m41t80_sqw_recalc_rate+0x24/0x58
       clk_register+0x3c8/0x638
       m41t80_probe+0x224/0x378
       i2c_device_probe+0x1dc/0x26c
       driver_probe_device+0x278/0x300
       __driver_attach+0xbc/0xc0
       bus_for_each_dev+0x74/0xa8
       driver_attach+0x20/0x28
       bus_add_driver+0x188/0x210
       driver_register+0x80/0x100
       i2c_register_driver+0x40/0x8c
       m41t80_driver_init+0x18/0x20
       do_one_initcall+0x44/0x17c
       kernel_init_freeable+0x11c/0x1dc
       kernel_init+0x10/0x11c
       ret_from_fork+0x14/0x20

-> #0 (prepare_lock){+.+.}:
       lock_acquire+0x78/0x98
       __mutex_lock+0x54/0x988
       mutex_lock_nested+0x24/0x2c
       clk_prepare_lock+0x80/0xf4
       clk_core_get_rate+0x14/0x64
       clk_get_rate+0x1c/0x20
       i2c_imx_start+0x20/0x1cc
       i2c_imx_xfer+0x38/0xb84
       __i2c_transfer+0x138/0x27c
       i2c_transfer+0x78/0xbc
       i2c_master_send+0x44/0x54
       regmap_i2c_write+0x18/0x34
       _regmap_raw_write+0x56c/0x668
       _regmap_bus_raw_write+0x74/0x94
       _regmap_write+0x60/0x9c
       _regmap_update_bits+0xc8/0xcc
       regmap_update_bits_base+0x58/0x7c
       regulator_set_voltage_sel_regmap+0x50/0xa0
       _regulator_do_set_voltage+0x280/0x35c
       regulator_set_voltage_unlocked+0xec/0x254
       regulator_set_voltage_unlocked+0x1e8/0x254
       regulator_set_voltage+0x30/0x5c
       imx6q_set_target+0xb8/0x4e0
       __cpufreq_driver_target+0x224/0x540
       od_dbs_update+0xa0/0x168
       dbs_work_handler+0x34/0x60
       process_one_work+0x194/0x41c
       worker_thread+0x34/0x538
       kthread+0x11c/0x158
       ret_from_fork+0x14/0x20

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(i2c_register_adapter);
                               lock(prepare_lock);
                               lock(i2c_register_adapter);
  lock(prepare_lock);

 *** DEADLOCK ***

7 locks held by kworker/1:2/133:
 #0:  ("events"){+.+.}, at: [<c014144c>] process_one_work+0x128/0x41c
 #1:  ((&policy_dbs->work)){+.+.}, at: [<c014144c>] process_one_work+0x128/0x41c
 #2:  (&policy_dbs->update_mutex){+.+.}, at: [<c06da1a0>] dbs_work_handler+0x28/0x60
 #3:  (&rdev->mutex){+.+.}, at: [<c04a8cac>] regulator_lock_supply+0x24/0x44
 #4:  (&rdev->mutex/1){+.+.}, at: [<c04a8cac>] regulator_lock_supply+0x24/0x44
 #5:  (da9062_core:870:(config)->lock){+.+.}, at: [<c055f2c8>] regmap_lock_mutex+0x14/0x18
 #6:  (i2c_register_adapter){+.+.}, at: [<c069305c>] i2c_adapter_lock_bus+0x14/0x18

Thanks
 -- Christoph
