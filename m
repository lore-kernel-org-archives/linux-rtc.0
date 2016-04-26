Return-Path: <rtc-linux+bncBDHPTCWTXEHRBBEF764AKGQEZS3VSFQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from gloria.sntech.de (gloria.sntech.de. [95.129.55.99])
        by gmr-mx.google.com with ESMTPS id a65si741579wma.0.2016.04.26.12.33.23
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Apr 2016 12:33:23 -0700 (PDT)
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>, Wadim Egorov <w.egorov@phytec.de>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, a.zummo@towertech.it, pawel.moll@arm.com, rtc-linux@googlegroups.com, ijc+devicetree@hellion.org.uk, mturquette@baylibre.com, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, lgirdwood@gmail.com, alexandre.belloni@free-electrons.com, dianders@chromium.org, galak@codeaurora.org, zyw@rock-chips.com, lee.jones@linaro.org, linux-clk@vger.kernel.org
Subject: [rtc-linux] Re: Applied "regulator: rk808: remove linear range
 definitions with a single range" to the regulator tree
Date: Tue, 26 Apr 2016 21:33:04 +0200
Message-ID: <2754883.PYP7KbpM33@diego>
In-Reply-To: <E1aukkg-0007km-6s@debutante>
References: <E1aukkg-0007km-6s@debutante>
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

Am Montag, 25. April 2016, 18:56:54 schrieb Mark Brown:
> The patch
> 
>    regulator: rk808: remove linear range definitions with a single range
> 
> has been applied to the regulator tree at
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git

with this patch applied, 4.6.0-rc5-next-20160426 fails to boot on 
rk3288-veyron devices with the bug below. Reverting this one patch
results in the system booting again:

[    1.059661] ------------[ cut here ]------------
[    1.064272] kernel BUG at drivers/regulator/helpers.c:255!
[    1.069750] Internal error: Oops - BUG: 0 [#1] SMP ARM
[    1.074880] Modules linked in:
[    1.077943] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.6.0-rc5-next-20160426 #133
[    1.085504] Hardware name: Rockchip (Device Tree)
[    1.090201] task: ee078000 ti: ee066000 task.ti: ee066000
[    1.095597] PC is at regulator_map_voltage_linear+0xcc/0xd4
[    1.101163] LR is at regulator_map_voltage+0x1c/0x5c
[    1.106121] pc : [<c06aed10>]    lr : [<c06ab374>]    psr: 60000013
[    1.106121] sp : ee0679b0  ip : c13a05b8  fp : ee64a220
[    1.117583] r10: 000f4240  r9 : c13a05b8  r8 : 000f4240
[    1.122800] r7 : 000f4240  r6 : c0cdc768  r5 : ee5f7800  r4 : 000f4240
[    1.129317] r3 : 00000000  r2 : 000f4240  r1 : 000f4240  r0 : ee5f7800
[    1.135836] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[    1.142960] Control: 10c5387d  Table: 0020406a  DAC: 00000051
[    1.148697] Process swapper/0 (pid: 1, stack limit = 0xee066220)
[    1.154695] Stack: (0xee0679b0 to 0xee068000)
[    1.159046] 79a0:                                     ee5f7800 ffffffff 000f4240 000f4240
[    1.167217] 79c0: 000f4240 c06ab374 ee5f7800 c06ab4a4 c0f3386c ee0679f4 ee631580 c03cddd0
[    1.175386] 79e0: ee62ea10 ee5f7800 c0cdc768 ee631580 00000000 000f4240 000f4240 c06acab4
[    1.183557] 7a00: 000f4240 c0612e14 c0f13724 ee5f7800 c13a05b8 c1395f08 ee64a220 ee631480
[    1.191726] 7a20: ee62dc10 ee633900 ee5f7860 c0413184 ee62ef50 c06af210 ee067aac ee5f79fc
[    1.199897] 7a40: ee5f7814 ee5f781c ee62ef50 ee64a810 ee067aac c0cdc768 ee633750 ee62ea10
[    1.208066] 7a60: ee62ef50 ee067aac ee64a220 c06af258 ee64a810 c13a0428 00000006 c0cdc814
[    1.216236] 7a80: ee62ea10 c06b9704 ee03f000 80000001 00000004 00000000 ee6305f0 ee64a800
[    1.224406] 7aa0: eefd9f8c ee64a400 c145ad98 ee64a220 ee62dc10 ee62ef50 eefdb068 ee64a400
[    1.232576] 7ac0: 00000000 00000000 00000000 00000000 00000001 ee64a810 c06b9574 c13a0368
[    1.240746] 7ae0: c13a0354 00000000 00000000 c145ad98 00000000 c079eef0 ee64a810 c145ad90
[    1.248916] 7b00: 00000000 c13a0368 00000000 c079d77c 00000100 ef5bc901 ee64a96c 00000000
[    1.257085] 7b20: ee64a810 ee067b60 ee067b40 c079d8ec 00000000 00000000 00000000 c079bc78
[    1.265255] 7b40: ee04bf70 ee3af338 ee64a810 ee64a810 ee64a844 00000001 c145ad6c c079daa0
[    1.273425] 7b60: ee64a810 00000001 ee64a810 ee64a810 ee64a810 c13b15b8 c145ad6c c079c7bc
[    1.281595] 7b80: ee64a810 ee64a818 ee64a220 c079b334 00000000 c05a7b20 ee64a800 ee64a810
[    1.289765] 7ba0: ee64a800 ee64a810 00000000 00000010 ee64a810 ee62ed44 00000000 c079f140
[    1.297935] 7bc0: c0d22b00 ee64a220 ee64a800 00000010 ee64a810 c07ca2c4 00000000 00000042
[    1.306105] 7be0: ee64a220 c0413d60 00000009 ee62ed48 c0d22b44 00000001 00000003 ee64a220
[    1.314275] 7c00: 00000000 ffffffff ee62ca80 c07ca578 00000000 00000000 ee62ca80 c07ca4c8
[    1.322444] 7c20: 00000000 ee62ed40 ffffffff 00000000 c0d22ac4 ee64a220 ee62ed10 c0d22abc
[    1.330614] 7c40: ffffffff 00000003 c0d22ac4 00000000 ee64a220 c07ca62c 00000000 00000000
[    1.338784] 7c60: ee62ca80 ee64a200 c0d22ac4 00000000 ee64a200 00000021 ee62ea10 c07d8fb0
[    1.346954] 7c80: 00000000 00000000 ee62ca80 c07a7c24 00000042 eefd9a34 ee62e9c0 c0d22d10
[    1.355124] 7ca0: ee64a204 ee64a200 ee64a220 c07d8e90 00000000 c145ad98 0000011e c099b888
[    1.363294] 7cc0: ee64a220 c145ad90 00000000 c13b5fa8 00000000 c079d77c c13b5fa8 00000000
[    1.371464] 7ce0: ee64a37c 00000000 ee64a220 ee067d28 ee067d08 c079d8ec 00000000 00000000
[    1.379634] 7d00: 00000000 c079bc78 ee166870 ee59fd38 ee64a220 ee64a220 ee64a254 00000001
[    1.387804] 7d20: c145ad6c c079daa0 ee64a220 00000001 ee64a220 ee64a220 ee64a220 c13c8ca0
[    1.395974] 7d40: c145ad6c c079c7bc ee64a220 ee64a228 ee5f6038 c079b334 c145ad6c c079a5b8
[    1.404144] 7d60: ee64a200 ee067db0 ee64a200 ee067db0 ee5f6010 ee64a220 ee64a200 00000000
[    1.412314] 7d80: ee64a204 c099c95c eefd9a34 c0a29e9c eefd9a34 eefd9a34 ee067db0 ee067ddc
[    1.420483] 7da0: ee5f6010 00000000 c145ad98 c099ccac 30386b72 00000038 00000000 00000000
[    1.428653] 7dc0: 00000000 001b0080 00000000 ee067ddc eefd9a34 00000000 00000000 00000000
[    1.436823] 7de0: 00000000 00000000 00000000 00000004 eefd9a34 00000000 ee5f6010 eefd9a34
[    1.444993] 7e00: ee5f6038 c099d090 00000000 ee5f621c ee5f6010 ee193010 ee5f6240 00000000
[    1.453162] 7e20: 00000000 c09a917c 00000000 ee178680 ee5f6010 ee193010 ee193010 c09a8f68
[    1.461333] 7e40: c13c9344 c13c9330 00000000 c079eef0 ee193010 c145ad90 00000000 c13c9344
[    1.469502] 7e60: 00000000 c079d77c c11a6034 c0a29d84 ee19316c 00000000 ee193000 ee193010
[    1.477672] 7e80: c13c9344 ee193044 00000000 c110072c c11a6034 c079d8e8 c13c9344 c079d844
[    1.485842] 7ea0: ee067ea8 c079bd18 ee04bf5c ee1756b4 00000007 c13c9344 ee624e80 c13b15b8
[    1.494012] 7ec0: 00000000 c079c58c c0f8a70c c11437f0 c13c9344 c13c9344 00000000 c1143800
[    1.502182] 7ee0: 00000007 c079df40 c11a602c 00000000 c1143800 c0301ecc 00000023 c1010978
[    1.510352] 7f00: 0000002d ee067f20 c035cf00 c05ab5dc 20000013 ffffffff 00000051 c1336720
[    1.518521] 7f20: efffcc0b efffcbfc efffcc0b c035d574 00000000 c0f833e0 c10106bc 00000000
[    1.526692] 7f40: 00000006 00000006 c13366e8 c11a602c c120ec4c c141b000 00000007 c110072c
[    1.534861] 7f60: 00000000 c11a6034 0000011e c1100654 00000006 00000006 00000000 c110072c
[    1.543031] 7f80: c0b99714 00000000 c0b99714 00000000 00000000 00000000 00000000 00000000
[    1.551201] 7fa0: 00000000 c0b9971c 00000000 c03083f8 00000000 00000000 00000000 00000000
[    1.559371] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    1.567540] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[    1.575716] [<c06aed10>] (regulator_map_voltage_linear) from [<c06ab374>] (regulator_map_voltage+0x1c/0x5c)
[    1.585447] [<c06ab374>] (regulator_map_voltage) from [<c06ab4a4>] (_regulator_do_set_voltage+0xf0/0x368)
[    1.595005] [<c06ab4a4>] (_regulator_do_set_voltage) from [<c06acab4>] (regulator_register+0xb10/0x1038)
[    1.604476] [<c06acab4>] (regulator_register) from [<c06af258>] (devm_regulator_register+0x40/0x74)
[    1.613515] [<c06af258>] (devm_regulator_register) from [<c06b9704>] (rk808_regulator_probe+0x190/0x228)
[    1.622988] [<c06b9704>] (rk808_regulator_probe) from [<c079eef0>] (platform_drv_probe+0x54/0xa4)
[    1.631853] [<c079eef0>] (platform_drv_probe) from [<c079d77c>] (driver_probe_device+0x1f8/0x2c0)
[    1.640718] [<c079d77c>] (driver_probe_device) from [<c079bc78>] (bus_for_each_drv+0x60/0x8c)
[    1.649235] [<c079bc78>] (bus_for_each_drv) from [<c079daa0>] (__device_attach+0x9c/0xfc)
[    1.657406] [<c079daa0>] (__device_attach) from [<c079c7bc>] (bus_probe_device+0x84/0x8c)
[    1.665577] [<c079c7bc>] (bus_probe_device) from [<c079b334>] (device_add+0x34c/0x514)
[    1.673489] [<c079b334>] (device_add) from [<c079f140>] (platform_device_add+0x170/0x218)
[    1.681661] [<c079f140>] (platform_device_add) from [<c07ca2c4>] (mfd_add_device+0x25c/0x32c)
[    1.690180] [<c07ca2c4>] (mfd_add_device) from [<c07ca578>] (mfd_add_devices+0xac/0xf8)
[    1.698177] [<c07ca578>] (mfd_add_devices) from [<c07ca62c>] (devm_mfd_add_devices+0x68/0x9c)
[    1.706695] [<c07ca62c>] (devm_mfd_add_devices) from [<c07d8fb0>] (rk808_probe+0x120/0x1f0)
[    1.715040] [<c07d8fb0>] (rk808_probe) from [<c099b888>] (i2c_device_probe+0x19c/0x21c)
[    1.723038] [<c099b888>] (i2c_device_probe) from [<c079d77c>] (driver_probe_device+0x1f8/0x2c0)
[    1.731728] [<c079d77c>] (driver_probe_device) from [<c079bc78>] (bus_for_each_drv+0x60/0x8c)
[    1.740246] [<c079bc78>] (bus_for_each_drv) from [<c079daa0>] (__device_attach+0x9c/0xfc)
[    1.748416] [<c079daa0>] (__device_attach) from [<c079c7bc>] (bus_probe_device+0x84/0x8c)
[    1.756587] [<c079c7bc>] (bus_probe_device) from [<c079b334>] (device_add+0x34c/0x514)
[    1.764498] [<c079b334>] (device_add) from [<c099c95c>] (i2c_new_device+0x11c/0x190)
[    1.772236] [<c099c95c>] (i2c_new_device) from [<c099ccac>] (of_i2c_register_device+0x120/0x1bc)
[    1.781013] [<c099ccac>] (of_i2c_register_device) from [<c099d090>] (i2c_register_adapter+0x19c/0x354)
[    1.790312] [<c099d090>] (i2c_register_adapter) from [<c09a917c>] (rk3x_i2c_probe+0x214/0x314)
[    1.798915] [<c09a917c>] (rk3x_i2c_probe) from [<c079eef0>] (platform_drv_probe+0x54/0xa4)
[    1.807172] [<c079eef0>] (platform_drv_probe) from [<c079d77c>] (driver_probe_device+0x1f8/0x2c0)
[    1.816035] [<c079d77c>] (driver_probe_device) from [<c079d8e8>] (__driver_attach+0xa4/0xa8)
[    1.824465] [<c079d8e8>] (__driver_attach) from [<c079bd18>] (bus_for_each_dev+0x74/0x98)
[    1.832637] [<c079bd18>] (bus_for_each_dev) from [<c079c58c>] (bus_add_driver+0x170/0x1f4)
[    1.840894] [<c079c58c>] (bus_add_driver) from [<c079df40>] (driver_register+0x78/0xf8)
[    1.848892] [<c079df40>] (driver_register) from [<c0301ecc>] (do_one_initcall+0x40/0x178)
[    1.857065] [<c0301ecc>] (do_one_initcall) from [<c1100654>] (kernel_init_freeable+0x114/0x1ec)
[    1.865758] [<c1100654>] (kernel_init_freeable) from [<c0b9971c>] (kernel_init+0x8/0x118)
[    1.873930] [<c0b9971c>] (kernel_init) from [<c03083f8>] (ret_from_fork+0x14/0x3c)
[    1.881494] Code: e3540000 01a03005 0affffe4 eaffffed (e7f001f2) 
[    1.887587] ---[ end trace 5b1e9b1610f54a8c ]---

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
