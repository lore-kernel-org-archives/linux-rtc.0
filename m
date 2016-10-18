Return-Path: <rtc-linux+bncBDKJVFPCVIJBBXW4THAAKGQE6RYPEHA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mx6-phx2.redhat.com (mx6-phx2.redhat.com. [209.132.183.39])
        by gmr-mx.google.com with ESMTPS id o13si303702itc.3.2016.10.18.11.47.58
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Oct 2016 11:47:58 -0700 (PDT)
Date: Tue, 18 Oct 2016 14:47:55 -0400 (EDT)
From: CAI Qian <caiqian@redhat.com>
To: Rob Herring <robh@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rtc-linux@googlegroups.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1882425827.361582.1476816475343.JavaMail.zimbra@redhat.com>
In-Reply-To: <2061831780.279821.1476797292640.JavaMail.zimbra@redhat.com>
References: <2061831780.279821.1476797292640.JavaMail.zimbra@redhat.com>
Subject: [rtc-linux] Re: [4.9-rc1] kernel panic from `cat /proc/driver/rtc`
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

It turns out this panic can only be reproduced with CONFIG_DEBUG_TEST_DRIVE=
R_REMOVE
enabled. There are some errors in dmesg when the config is enabled.

[ =C2=A0 71.215937] rtc_cmos 00:00: RTC can wake from S4
[ =C2=A0 71.218096] input: AT Translated Set 2 keyboard as /devices/platfor=
m/i8042/serio1/input/input2
[ =C2=A0 71.232591] rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
[ =C2=A0 71.239518] rtc_cmos 00:00: alarms up to one month, y3k, 114 bytes =
nvram, hpet irqs
[ =C2=A0 71.248160] rtc_cmos 00:00: RTC can wake from S4
[ =C2=A0 71.267680] rtc_cmos: probe of 00:00 failed with error -16

It works fine without it.

$ cat /proc/driver/rtc=20
rtc_time=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: 14:30:56
rtc_date=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: 2016-10-18
alrm_time=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: 19:48:53
alrm_date=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: 2016-10-18
alarm_IRQ=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: no
alrm_pending=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: no
update IRQ enabled=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: no
periodic IRQ enabled=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: no
periodic IRQ frequency=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: 102=
4
max user IRQ frequency=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: 64
24hr=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0: yes
periodic_IRQ=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: no
update_IRQ=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: no
HPET_emulated=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: yes
BCD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0: yes
DST_enable=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: no
periodic_freq=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: 1024
batt_status=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: okay

=C2=A0=C2=A0 CAI Qian

----- Original Message -----
> From: "CAI Qian" <caiqian@redhat.com>
> To: rtc-linux@googlegroups.com, "linux-kernel" <linux-kernel@vger.kernel.=
org>
> Cc: "Alessandro Zummo" <a.zummo@towertech.it>, "Alexandre Belloni" <alexa=
ndre.belloni@free-electrons.com>
> Sent: Tuesday, October 18, 2016 9:28:12 AM
> Subject: [4.9-rc1] kernel panic from `cat /proc/driver/rtc`
>=20
> This looks like new introduced in the 4.9 merge window. I have never saw =
any
> of
> those while testing v4.8.
> =C2=A0 =C2=A0CAI Qian
>=20
> $ cat /proc/driver/rtc
>=20
> [ 7890.728704] UBSAN: Undefined behaviour in drivers/rtc/rtc-cmos.c:433:1=
0
> [ 7890.736088] member access within null pointer of type 'struct cmos_rtc=
'
> [ 7890.743472] CPU: 81 PID: 32522 Comm: proc01 Tainted: G =C2=A0 =C2=A0 =
=C2=A0 =C2=A0W
> 4.9.0-rc1 #32
> [ 7890.752017] Hardware name: Intel Corporation S2600WTT/S2600WTT, BIOS
> GRRFSDP1.86B.0271.R00.1510301446 10/30/2015
> [ 7890.763373] =C2=A0ffff88080a54f868 ffffffff81d23184 0000000041b58ab3
> ffffffff8334713f
> [ 7890.771670] =C2=A0ffffffff81d230c4 ffff88080a54f890 ffff88080a54f840
> ffff88081f324900
> [ 7890.779966] =C2=A0ffffffff82ff7b40 ffffffff831279a0 00000000000001b1
> 00000000d3274681
> [ 7890.788262] Call Trace:
> [ 7890.790993] =C2=A0[<ffffffff81d23184>] dump_stack+0xc0/0x12c
> [ 7890.796825] =C2=A0[<ffffffff81d230c4>] ? _atomic_dec_and_lock+0xc4/0xc=
4
> [ 7890.803723] =C2=A0[<ffffffff81e46d55>] ubsan_epilogue+0xd/0x8a
> [ 7890.809748] =C2=A0[<ffffffff81e46f38>] __ubsan_handle_type_mismatch+0x=
166/0x434
> [ 7890.817421] =C2=A0[<ffffffff81e46dd2>] ? ubsan_epilogue+0x8a/0x8a
> [ 7890.823738] =C2=A0[<ffffffff81dce253>] ? __this_cpu_preempt_check+0x13=
/0x20
> [ 7890.831025] =C2=A0[<ffffffff8131c580>] ? trace_hardirqs_on_caller+0x52=
0/0x720
> [ 7890.838509] =C2=A0[<ffffffff8253b351>] cmos_procfs+0x1b1/0x1e0
> [ 7890.844535] =C2=A0[<ffffffff8253b1a0>] ? rtc_handler+0x140/0x140
> [ 7890.850754] =C2=A0[<ffffffff82538580>] rtc_proc_show+0x180/0x640
> [ 7890.856973] =C2=A0[<ffffffff82538400>] ? rtc_proc_open+0xd0/0xd0
> [ 7890.863196] =C2=A0[<ffffffff817eb26d>] ? kasan_kmalloc+0xad/0xe0
> [ 7890.869419] =C2=A0[<ffffffff81901d44>] seq_read+0x334/0x1400
> [ 7890.875252] =C2=A0[<ffffffff81901a10>] ? seq_hlist_start_percpu+0x4a0/=
0x4a0
> [ 7890.882538] =C2=A0[<ffffffff810952fb>] ? save_stack_trace+0x1b/0x20
> [ 7890.889050] =C2=A0[<ffffffff817eaff6>] ? save_stack+0x46/0xd0
> [ 7890.894979] =C2=A0[<ffffffff817eb821>] ? kasan_slab_free+0x71/0xb0
> [ 7890.901393] =C2=A0[<ffffffff817e3fd9>] ? kmem_cache_free+0xe9/0x660
> [ 7890.907905] =C2=A0[<ffffffff818affe0>] ? putname+0xe0/0x120
> [ 7890.913639] =C2=A0[<ffffffff81319fb0>] ? print_usage_bug+0x700/0x700
> [ 7890.920250] =C2=A0[<ffffffff81a27160>] proc_reg_read+0x110/0x270
> [ 7890.926470] =C2=A0[<ffffffff81870ff6>] __vfs_read+0x106/0x990
> [ 7890.932398] =C2=A0[<ffffffff81870ef0>] ? do_iter_readv_writev+0x840/0x=
840
> [ 7890.939490] =C2=A0[<ffffffff81b35ab5>] ? selinux_file_permission+0x3c5=
/0x550
> [ 7890.946874] =C2=A0[<ffffffff81b12ef6>] ? security_file_permission+0x17=
6/0x220
> [ 7890.954354] =C2=A0[<ffffffff81871ec8>] ? rw_verify_area+0xd8/0x380
> [ 7890.960767] =C2=A0[<ffffffff81872288>] vfs_read+0x118/0x400
> [ 7890.966500] =C2=A0[<ffffffff8187710f>] SyS_read+0xdf/0x1d0
> [ 7890.972137] =C2=A0[<ffffffff81877030>] ? vfs_copy_file_range+0x8f0/0x8=
f0
> [ 7890.979132] =C2=A0[<ffffffff81dce253>] ? __this_cpu_preempt_check+0x13=
/0x20
> [ 7890.986416] =C2=A0[<ffffffff81877030>] ? vfs_copy_file_range+0x8f0/0x8=
f0
> [ 7890.993412] =C2=A0[<ffffffff8100924d>] do_syscall_64+0x19d/0x540
> [ 7890.999631] =C2=A0[<ffffffff82c76f24>] entry_SYSCALL64_slow_path+0x25/=
0x25
> [ 7891.006820]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> [ 7891.016322] kasan: CONFIG_KASAN_INLINE enabled
> [ 7891.021292] kasan: GPF could be caused by NULL-ptr deref or user memor=
y
> access
> [ 7891.029371] general protection fault: 0000 [#1] PREEMPT SMP
> DEBUG_PAGEALLOC KASAN
> [ 7891.037722] Modules linked in: tun ext4 jbd2 mbcache loop veth
> ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_conntrack_ipv4
> nf_defrag_ipv4 nf_nat_ipv4 xt_addrtype iptable_filter xt_conntrack nf_nat
> nf_conntrack br_netfilter bridge stp llc overlay intel_rapl sb_edac
> edac_core x86_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul
> crc32_pclmul ghash_clmulni_intel aesni_intel lrw gf128mul glue_helper
> ablk_helper cryptd intel_uncore iTCO_wdt iTCO_vendor_support pcspkr i2c_i=
801
> i2c_smbus sg mei_me mei lpc_ich shpchp ipmi_ssif mxm_wmi ipmi_si
> ipmi_msghandler wmi acpi_power_meter acpi_pad nfsd auth_rpcgss nfs_acl lo=
ckd
> grace sunrpc ip_tables xfs libcrc32c sr_mod sd_mod cdrom mgag200
> i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops
> ttm crc32c_intel drm ixgbe serio_raw ahci libahci libata mdio ptp i2c_cor=
e
> pps_core dca fjes dm_mirror dm_region_hash dm_log dm_mod
> [ 7891.127218] CPU: 81 PID: 32522 Comm: proc01 Tainted: G =C2=A0 =C2=A0 =
=C2=A0 =C2=A0W
> 4.9.0-rc1 #32
> [ 7891.135764] Hardware name: Intel Corporation S2600WTT/S2600WTT, BIOS
> GRRFSDP1.86B.0271.R00.1510301446 10/30/2015
> [ 7891.147124] task: ffff88081f324900 task.stack: ffff88080a548000
> [ 7891.153731] RIP: 0010:[<ffffffff8253b250>] =C2=A0[<ffffffff8253b250>]
> cmos_procfs+0xb0/0x1e0
> [ 7891.162677] RSP: 0018:ffff88080a54f938 =C2=A0EFLAGS: 00010246
> [ 7891.168605] RAX: dffffc0000000000 RBX: 0000000000000000 RCX:
> 0000000000000000
> [ 7891.176569] RDX: 0000000000000000 RSI: ffffffff82e9a500 RDI:
> ffffed01014a9f20
> [ 7891.184534] RBP: ffff88080a54f990 R08: ffff88081f324900 R09:
> 0000000000000007
> [ 7891.192499] R10: ffff88080a54f780 R11: 0000000000000006 R12:
> 0000000000000002
> [ 7891.200463] R13: ffffffff831272e0 R14: 1ffff101014a9f39 R15:
> ffffffff83127d60
> [ 7891.208430] FS: =C2=A000007fe516b93800(0000) GS:ffff880e56800000(0000)
> knlGS:0000000000000000
> [ 7891.217461] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 7891.223873] CR2: 00007f153a7200a0 CR3: 0000000e48f80000 CR4:
> 00000000003406e0
> [ 7891.231838] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [ 7891.239802] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [ 7891.247765] Stack:
> [ 7891.250006] =C2=A00000012300000001 ffff880800000000 1ffff101014a9f39
> 00000000d3274681
> [ 7891.258299] =C2=A000000000d3274681 ffff880e108a9a40 ffff880e108a9a40
> ffff88084745b300
> [ 7891.266597] =C2=A0ffffffff8253b1a0 1ffff101014a9f39 ffffffff83127d60
> ffff88080a54fad0
> [ 7891.274891] Call Trace:
> [ 7891.277619] =C2=A0[<ffffffff8253b1a0>] ? rtc_handler+0x140/0x140
> [ 7891.283839] =C2=A0[<ffffffff82538580>] rtc_proc_show+0x180/0x640
> [ 7891.290058] =C2=A0[<ffffffff82538400>] ? rtc_proc_open+0xd0/0xd0
> [ 7891.296278] =C2=A0[<ffffffff817eb26d>] ? kasan_kmalloc+0xad/0xe0
> [ 7891.302497] =C2=A0[<ffffffff81901d44>] seq_read+0x334/0x1400
> [ 7891.308328] =C2=A0[<ffffffff81901a10>] ? seq_hlist_start_percpu+0x4a0/=
0x4a0
> [ 7891.315613] =C2=A0[<ffffffff810952fb>] ? save_stack_trace+0x1b/0x20
> [ 7891.322122] =C2=A0[<ffffffff817eaff6>] ? save_stack+0x46/0xd0
> [ 7891.328050] =C2=A0[<ffffffff817eb821>] ? kasan_slab_free+0x71/0xb0
> [ 7891.334463] =C2=A0[<ffffffff817e3fd9>] ? kmem_cache_free+0xe9/0x660
> [ 7891.340972] =C2=A0[<ffffffff818affe0>] ? putname+0xe0/0x120
> [ 7891.346707] =C2=A0[<ffffffff81319fb0>] ? print_usage_bug+0x700/0x700
> [ 7891.353313] =C2=A0[<ffffffff81a27160>] proc_reg_read+0x110/0x270
> [ 7891.359532] =C2=A0[<ffffffff81870ff6>] __vfs_read+0x106/0x990
> [ 7891.365459] =C2=A0[<ffffffff81870ef0>] ? do_iter_readv_writev+0x840/0x=
840
> [ 7891.372553] =C2=A0[<ffffffff81b35ab5>] ? selinux_file_permission+0x3c5=
/0x550
> [ 7891.379936] =C2=A0[<ffffffff81b12ef6>] ? security_file_permission+0x17=
6/0x220
> [ 7891.387415] =C2=A0[<ffffffff81871ec8>] ? rw_verify_area+0xd8/0x380
> [ 7891.393830] =C2=A0[<ffffffff81872288>] vfs_read+0x118/0x400
> [ 7891.399564] =C2=A0[<ffffffff8187710f>] SyS_read+0xdf/0x1d0
> [ 7891.405202] =C2=A0[<ffffffff81877030>] ? vfs_copy_file_range+0x8f0/0x8=
f0
> [ 7891.412197] =C2=A0[<ffffffff81dce253>] ? __this_cpu_preempt_check+0x13=
/0x20
> [ 7891.419483] =C2=A0[<ffffffff81877030>] ? vfs_copy_file_range+0x8f0/0x8=
f0
> [ 7891.426478] =C2=A0[<ffffffff8100924d>] do_syscall_64+0x19d/0x540
> [ 7891.432699] =C2=A0[<ffffffff82c76f24>] entry_SYSCALL64_slow_path+0x25/=
0x25
> [ 7891.439881] Code: c7 c0 20 73 12 83 49 c7 c5 e0 72 12 83 4c 0f 49 e8 4=
8 85
> db 0f 84 04 01 00 00 48 89 da 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <=
80>
> 3c 02 00 0f 85 dc 00 00 00 48 8b 1b 48 85 db 0f 84 bd 00 00
> [ 7891.461643] RIP =C2=A0[<ffffffff8253b250>] cmos_procfs+0xb0/0x1e0
> [ 7891.467970] =C2=A0RSP <ffff88080a54f938>
> [ 7891.478688] ---[ end trace 724fbd49872953c3 ]---
> [ 7891.483921] Kernel panic - not syncing: Fatal exception
> [ 7891.489875] Kernel Offset: disabled
> [ 7891.493787] ---[ end Kernel panic - not syncing: Fatal exception
> [ 7891.500491] ------------[ cut here ]------------
> [ 7891.505648] WARNING: CPU: 81 PID: 32522 at arch/x86/kernel/smp.c:127
> native_smp_send_reschedule+0x107/0x150
> [ 7891.516521] Modules linked in: tun ext4 jbd2 mbcache loop veth
> ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_conntrack_ipv4
> nf_defrag_ipv4 nf_nat_ipv4 xt_addrtype iptable_filter xt_conntrack nf_nat
> nf_conntrack br_netfilter bridge stp llc overlay intel_rapl sb_edac
> edac_core x86_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul
> crc32_pclmul ghash_clmulni_intel aesni_intel lrw gf128mul glue_helper
> ablk_helper cryptd intel_uncore iTCO_wdt iTCO_vendor_support pcspkr i2c_i=
801
> i2c_smbus sg mei_me mei lpc_ich shpchp ipmi_ssif mxm_wmi ipmi_si
> ipmi_msghandler wmi acpi_power_meter acpi_pad nfsd auth_rpcgss nfs_acl lo=
ckd
> grace sunrpc ip_tables xfs libcrc32c sr_mod sd_mod cdrom mgag200
> i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops
> ttm crc32c_intel drm ixgbe serio_raw ahci libahci libata mdio ptp i2c_cor=
e
> pps_core dca fjes dm_mirror dm_region_hash dm_log dm_mod
> [ 7891.605894] CPU: 81 PID: 32522 Comm: proc01 Tainted: G =C2=A0 =C2=A0 =
=C2=A0D W
> 4.9.0-rc1 #32
> [ 7891.614440] Hardware name: Intel Corporation S2600WTT/S2600WTT, BIOS
> GRRFSDP1.86B.0271.R00.1510301446 10/30/2015
> [ 7891.625798] =C2=A0ffff880e56807a00 ffffffff81d23184 0000000041b58ab3
> ffffffff8334713f
> [ 7891.634094] =C2=A0ffffffff81d230c4 000000000333a700 ffff880e568079c0
> ffffffff81293d7c
> [ 7891.642390] =C2=A000000000d3274681 ffff880e56807a78 0000000000000051
> 0000000000007f0a
> [ 7891.650686] Call Trace:
> [ 7891.653413] =C2=A0<IRQ> [ 7891.655561] =C2=A0[<ffffffff81d23184>]
> dump_stack+0xc0/0x12c
> [ 7891.661401] =C2=A0[<ffffffff81d230c4>] ? _atomic_dec_and_lock+0xc4/0xc=
4
> [ 7891.668302] =C2=A0[<ffffffff81293d7c>] ? rcu_read_unlock+0x3c/0x80
> [ 7891.674719] =C2=A0[<ffffffff811b06ee>] __warn+0x19e/0x1d0
> [ 7891.680259] =C2=A0[<ffffffff811b090d>] warn_slowpath_null+0x1d/0x20
> [ 7891.686769] =C2=A0[<ffffffff810dbe57>] native_smp_send_reschedule+0x10=
7/0x150
> [ 7891.694253] =C2=A0[<ffffffff8126cddb>] try_to_wake_up+0x9fb/0x10d0
> [ 7891.700665] =C2=A0[<ffffffff8126c3e0>] ? migrate_swap_stop+0xa70/0xa70
> [ 7891.707468] =C2=A0[<ffffffff8126d662>] default_wake_function+0x42/0x70
> [ 7891.714271] =C2=A0[<ffffffff812ed575>] __wake_up_common+0xe5/0x210
> [ 7891.720688] =C2=A0[<ffffffff8198d33f>] ? ep_poll_callback+0x5ef/0x9d0
> [ 7891.727391] =C2=A0[<ffffffff812ed703>] __wake_up_locked+0x13/0x20
> [ 7891.733707] =C2=A0[<ffffffff8198cfc1>] ep_poll_callback+0x271/0x9d0
> [ 7891.740218] =C2=A0[<ffffffff8198d230>] ? ep_poll_callback+0x4e0/0x9d0
> [ 7891.746921] =C2=A0[<ffffffff8198cd50>] ? ep_poll_safewake+0x60/0x60
> [ 7891.753433] =C2=A0[<ffffffff812ed6c3>] ? __wake_up+0x23/0x50
> [ 7891.759264] =C2=A0[<ffffffff812ed575>] __wake_up_common+0xe5/0x210
> [ 7891.765679] =C2=A0[<ffffffff812ed6d9>] __wake_up+0x39/0x50
> [ 7891.771320] =C2=A0[<ffffffff8135cb3c>] wake_up_klogd_work_func+0x4c/0x=
60
> [ 7891.778319] =C2=A0[<ffffffff815b249d>] irq_work_run_list+0xdd/0x1a0
> [ 7891.784829] =C2=A0[<ffffffff815b31a6>] irq_work_tick+0x166/0x240
> [ 7891.791051] =C2=A0[<ffffffff813d0682>] update_process_times+0x42/0x60
> [ 7891.797756] =C2=A0[<ffffffff81409412>] tick_sched_handle+0x92/0x170
> [ 7891.804267] =C2=A0[<ffffffff8140bf29>] tick_sched_timer+0x39/0xb0
> [ 7891.810584] =C2=A0[<ffffffff813d3ad7>] __hrtimer_run_queues+0x3d7/0x12=
e0
> [ 7891.817580] =C2=A0[<ffffffff813d704c>] ? hrtimer_interrupt+0x16c/0x5b0
> [ 7891.824381] =C2=A0[<ffffffff8140bef0>] ? tick_sched_do_timer+0x200/0x2=
00
> [ 7891.831378] =C2=A0[<ffffffff813d3700>] ? enqueue_hrtimer+0x5a0/0x5a0
> [ 7891.837983] =C2=A0[<ffffffff813d704c>] ? hrtimer_interrupt+0x16c/0x5b0
> [ 7891.844784] =C2=A0[<ffffffff813d711b>] hrtimer_interrupt+0x23b/0x5b0
> [ 7891.851393] =C2=A0[<ffffffff810e9f1d>] local_apic_timer_interrupt+0x9d=
/0x170
> [ 7891.858778] =C2=A0[<ffffffff82c79880>] smp_apic_timer_interrupt+0x80/0=
xb0
> [ 7891.865869] =C2=A0[<ffffffff82c788b3>] apic_timer_interrupt+0x93/0xa0
> [ 7891.872572] =C2=A0<EOI> [ 7891.874720] =C2=A0[<ffffffff81646e6d>] ?
> panic+0x354/0x3e1
> [ 7891.880364] =C2=A0[<ffffffff81646e6a>] ? panic+0x351/0x3e1
> [ 7891.886002] =C2=A0[<ffffffff81646b19>] ?
> percpu_up_read_preempt_enable.constprop.25+0xb9/0xb9
> [ 7891.895035] =C2=A0[<ffffffff81068822>] oops_end+0xe2/0xf0
> [ 7891.900574] =C2=A0[<ffffffff81068e50>] die+0x50/0x80
> [ 7891.905631] =C2=A0[<ffffffff8105e732>] do_general_protection+0x242/0x4=
30
> [ 7891.912627] =C2=A0[<ffffffff82c77fb2>] general_protection+0x22/0x30
> [ 7891.919139] =C2=A0[<ffffffff8253b250>] ? cmos_procfs+0xb0/0x1e0
> [ 7891.925261] =C2=A0[<ffffffff8253b351>] ? cmos_procfs+0x1b1/0x1e0
> [ 7891.931480] =C2=A0[<ffffffff8253b1a0>] ? rtc_handler+0x140/0x140
> [ 7891.937700] =C2=A0[<ffffffff82538580>] rtc_proc_show+0x180/0x640
> [ 7891.943919] =C2=A0[<ffffffff82538400>] ? rtc_proc_open+0xd0/0xd0
> [ 7891.950139] =C2=A0[<ffffffff817eb26d>] ? kasan_kmalloc+0xad/0xe0
> [ 7891.956359] =C2=A0[<ffffffff81901d44>] seq_read+0x334/0x1400
> [ 7891.962192] =C2=A0[<ffffffff81901a10>] ? seq_hlist_start_percpu+0x4a0/=
0x4a0
> [ 7891.969477] =C2=A0[<ffffffff810952fb>] ? save_stack_trace+0x1b/0x20
> [ 7891.975989] =C2=A0[<ffffffff817eaff6>] ? save_stack+0x46/0xd0
> [ 7891.981918] =C2=A0[<ffffffff817eb821>] ? kasan_slab_free+0x71/0xb0
> [ 7891.988332] =C2=A0[<ffffffff817e3fd9>] ? kmem_cache_free+0xe9/0x660
> [ 7891.994842] =C2=A0[<ffffffff818affe0>] ? putname+0xe0/0x120
> [ 7892.000577] =C2=A0[<ffffffff81319fb0>] ? print_usage_bug+0x700/0x700
> [ 7892.007185] =C2=A0[<ffffffff81a27160>] proc_reg_read+0x110/0x270
> [ 7892.013404] =C2=A0[<ffffffff81870ff6>] __vfs_read+0x106/0x990
> [ 7892.019332] =C2=A0[<ffffffff81870ef0>] ? do_iter_readv_writev+0x840/0x=
840
> [ 7892.026426] =C2=A0[<ffffffff81b35ab5>] ? selinux_file_permission+0x3c5=
/0x550
> [ 7892.033802] =C2=A0[<ffffffff81b12ef6>] ? security_file_permission+0x17=
6/0x220
> [ 7892.041282] =C2=A0[<ffffffff81871ec8>] ? rw_verify_area+0xd8/0x380
> [ 7892.047697] =C2=A0[<ffffffff81872288>] vfs_read+0x118/0x400
> [ 7892.053432] =C2=A0[<ffffffff8187710f>] SyS_read+0xdf/0x1d0
> [ 7892.059069] =C2=A0[<ffffffff81877030>] ? vfs_copy_file_range+0x8f0/0x8=
f0
> [ 7892.066066] =C2=A0[<ffffffff81dce253>] ? __this_cpu_preempt_check+0x13=
/0x20
> [ 7892.073352] =C2=A0[<ffffffff81877030>] ? vfs_copy_file_range+0x8f0/0x8=
f0
> [ 7892.080348] =C2=A0[<ffffffff8100924d>] do_syscall_64+0x19d/0x540
> [ 7892.086567] =C2=A0[<ffffffff82c76f24>] entry_SYSCALL64_slow_path+0x25/=
0x25
> [ 7892.093756] ---[ end trace 724fbd49872953c4 ]---

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
