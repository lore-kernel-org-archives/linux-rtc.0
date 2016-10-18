Return-Path: <rtc-linux+bncBDKJVFPCVIJBB4OGTDAAKGQEGWDSPAI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mx4-phx2.redhat.com (mx4-phx2.redhat.com. [209.132.183.25])
        by gmr-mx.google.com with ESMTPS id c24si181578itd.0.2016.10.18.06.28.16
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 18 Oct 2016 06:28:17 -0700 (PDT)
Date: Tue, 18 Oct 2016 09:28:12 -0400 (EDT)
From: CAI Qian <caiqian@redhat.com>
To: rtc-linux@googlegroups.com, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Message-ID: <2061831780.279821.1476797292640.JavaMail.zimbra@redhat.com>
In-Reply-To: <406701477.279464.1476797119876.JavaMail.zimbra@redhat.com>
Subject: [rtc-linux] [4.9-rc1] kernel panic from `cat /proc/driver/rtc`
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

This looks like new introduced in the 4.9 merge window. I have never saw an=
y of
those while testing v4.8.
   CAI Qian

$ cat /proc/driver/rtc

[ 7890.728704] UBSAN: Undefined behaviour in drivers/rtc/rtc-cmos.c:433:10
[ 7890.736088] member access within null pointer of type 'struct cmos_rtc'
[ 7890.743472] CPU: 81 PID: 32522 Comm: proc01 Tainted: G        W       4.=
9.0-rc1 #32
[ 7890.752017] Hardware name: Intel Corporation S2600WTT/S2600WTT, BIOS GRR=
FSDP1.86B.0271.R00.1510301446 10/30/2015
[ 7890.763373]  ffff88080a54f868 ffffffff81d23184 0000000041b58ab3 ffffffff=
8334713f
[ 7890.771670]  ffffffff81d230c4 ffff88080a54f890 ffff88080a54f840 ffff8808=
1f324900
[ 7890.779966]  ffffffff82ff7b40 ffffffff831279a0 00000000000001b1 00000000=
d3274681
[ 7890.788262] Call Trace:
[ 7890.790993]  [<ffffffff81d23184>] dump_stack+0xc0/0x12c
[ 7890.796825]  [<ffffffff81d230c4>] ? _atomic_dec_and_lock+0xc4/0xc4
[ 7890.803723]  [<ffffffff81e46d55>] ubsan_epilogue+0xd/0x8a
[ 7890.809748]  [<ffffffff81e46f38>] __ubsan_handle_type_mismatch+0x166/0x4=
34
[ 7890.817421]  [<ffffffff81e46dd2>] ? ubsan_epilogue+0x8a/0x8a
[ 7890.823738]  [<ffffffff81dce253>] ? __this_cpu_preempt_check+0x13/0x20
[ 7890.831025]  [<ffffffff8131c580>] ? trace_hardirqs_on_caller+0x520/0x720
[ 7890.838509]  [<ffffffff8253b351>] cmos_procfs+0x1b1/0x1e0
[ 7890.844535]  [<ffffffff8253b1a0>] ? rtc_handler+0x140/0x140
[ 7890.850754]  [<ffffffff82538580>] rtc_proc_show+0x180/0x640
[ 7890.856973]  [<ffffffff82538400>] ? rtc_proc_open+0xd0/0xd0
[ 7890.863196]  [<ffffffff817eb26d>] ? kasan_kmalloc+0xad/0xe0
[ 7890.869419]  [<ffffffff81901d44>] seq_read+0x334/0x1400
[ 7890.875252]  [<ffffffff81901a10>] ? seq_hlist_start_percpu+0x4a0/0x4a0
[ 7890.882538]  [<ffffffff810952fb>] ? save_stack_trace+0x1b/0x20
[ 7890.889050]  [<ffffffff817eaff6>] ? save_stack+0x46/0xd0
[ 7890.894979]  [<ffffffff817eb821>] ? kasan_slab_free+0x71/0xb0
[ 7890.901393]  [<ffffffff817e3fd9>] ? kmem_cache_free+0xe9/0x660
[ 7890.907905]  [<ffffffff818affe0>] ? putname+0xe0/0x120
[ 7890.913639]  [<ffffffff81319fb0>] ? print_usage_bug+0x700/0x700
[ 7890.920250]  [<ffffffff81a27160>] proc_reg_read+0x110/0x270
[ 7890.926470]  [<ffffffff81870ff6>] __vfs_read+0x106/0x990
[ 7890.932398]  [<ffffffff81870ef0>] ? do_iter_readv_writev+0x840/0x840
[ 7890.939490]  [<ffffffff81b35ab5>] ? selinux_file_permission+0x3c5/0x550
[ 7890.946874]  [<ffffffff81b12ef6>] ? security_file_permission+0x176/0x220
[ 7890.954354]  [<ffffffff81871ec8>] ? rw_verify_area+0xd8/0x380
[ 7890.960767]  [<ffffffff81872288>] vfs_read+0x118/0x400
[ 7890.966500]  [<ffffffff8187710f>] SyS_read+0xdf/0x1d0
[ 7890.972137]  [<ffffffff81877030>] ? vfs_copy_file_range+0x8f0/0x8f0
[ 7890.979132]  [<ffffffff81dce253>] ? __this_cpu_preempt_check+0x13/0x20
[ 7890.986416]  [<ffffffff81877030>] ? vfs_copy_file_range+0x8f0/0x8f0
[ 7890.993412]  [<ffffffff8100924d>] do_syscall_64+0x19d/0x540
[ 7890.999631]  [<ffffffff82c76f24>] entry_SYSCALL64_slow_path+0x25/0x25
[ 7891.006820] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 7891.016322] kasan: CONFIG_KASAN_INLINE enabled
[ 7891.021292] kasan: GPF could be caused by NULL-ptr deref or user memory =
access
[ 7891.029371] general protection fault: 0000 [#1] PREEMPT SMP DEBUG_PAGEAL=
LOC KASAN
[ 7891.037722] Modules linked in: tun ext4 jbd2 mbcache loop veth ipt_MASQU=
ERADE nf_nat_masquerade_ipv4 iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 n=
f_nat_ipv4 xt_addrtype iptable_filter xt_conntrack nf_nat nf_conntrack br_n=
etfilter bridge stp llc overlay intel_rapl sb_edac edac_core x86_pkg_temp_t=
hermal intel_powerclamp coretemp crct10dif_pclmul crc32_pclmul ghash_clmuln=
i_intel aesni_intel lrw gf128mul glue_helper ablk_helper cryptd intel_uncor=
e iTCO_wdt iTCO_vendor_support pcspkr i2c_i801 i2c_smbus sg mei_me mei lpc_=
ich shpchp ipmi_ssif mxm_wmi ipmi_si ipmi_msghandler wmi acpi_power_meter a=
cpi_pad nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables xfs libcrc32c=
 sr_mod sd_mod cdrom mgag200 i2c_algo_bit drm_kms_helper syscopyarea sysfil=
lrect sysimgblt fb_sys_fops ttm crc32c_intel drm ixgbe serio_raw ahci libah=
ci libata mdio ptp i2c_core pps_core dca fjes dm_mirror dm_region_hash dm_l=
og dm_mod
[ 7891.127218] CPU: 81 PID: 32522 Comm: proc01 Tainted: G        W       4.=
9.0-rc1 #32
[ 7891.135764] Hardware name: Intel Corporation S2600WTT/S2600WTT, BIOS GRR=
FSDP1.86B.0271.R00.1510301446 10/30/2015
[ 7891.147124] task: ffff88081f324900 task.stack: ffff88080a548000
[ 7891.153731] RIP: 0010:[<ffffffff8253b250>]  [<ffffffff8253b250>] cmos_pr=
ocfs+0xb0/0x1e0
[ 7891.162677] RSP: 0018:ffff88080a54f938  EFLAGS: 00010246
[ 7891.168605] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 00000000000=
00000
[ 7891.176569] RDX: 0000000000000000 RSI: ffffffff82e9a500 RDI: ffffed01014=
a9f20
[ 7891.184534] RBP: ffff88080a54f990 R08: ffff88081f324900 R09: 00000000000=
00007
[ 7891.192499] R10: ffff88080a54f780 R11: 0000000000000006 R12: 00000000000=
00002
[ 7891.200463] R13: ffffffff831272e0 R14: 1ffff101014a9f39 R15: ffffffff831=
27d60
[ 7891.208430] FS:  00007fe516b93800(0000) GS:ffff880e56800000(0000) knlGS:=
0000000000000000
[ 7891.217461] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 7891.223873] CR2: 00007f153a7200a0 CR3: 0000000e48f80000 CR4: 00000000003=
406e0
[ 7891.231838] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 7891.239802] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 7891.247765] Stack:
[ 7891.250006]  0000012300000001 ffff880800000000 1ffff101014a9f39 00000000=
d3274681
[ 7891.258299]  00000000d3274681 ffff880e108a9a40 ffff880e108a9a40 ffff8808=
4745b300
[ 7891.266597]  ffffffff8253b1a0 1ffff101014a9f39 ffffffff83127d60 ffff8808=
0a54fad0
[ 7891.274891] Call Trace:
[ 7891.277619]  [<ffffffff8253b1a0>] ? rtc_handler+0x140/0x140
[ 7891.283839]  [<ffffffff82538580>] rtc_proc_show+0x180/0x640
[ 7891.290058]  [<ffffffff82538400>] ? rtc_proc_open+0xd0/0xd0
[ 7891.296278]  [<ffffffff817eb26d>] ? kasan_kmalloc+0xad/0xe0
[ 7891.302497]  [<ffffffff81901d44>] seq_read+0x334/0x1400
[ 7891.308328]  [<ffffffff81901a10>] ? seq_hlist_start_percpu+0x4a0/0x4a0
[ 7891.315613]  [<ffffffff810952fb>] ? save_stack_trace+0x1b/0x20
[ 7891.322122]  [<ffffffff817eaff6>] ? save_stack+0x46/0xd0
[ 7891.328050]  [<ffffffff817eb821>] ? kasan_slab_free+0x71/0xb0
[ 7891.334463]  [<ffffffff817e3fd9>] ? kmem_cache_free+0xe9/0x660
[ 7891.340972]  [<ffffffff818affe0>] ? putname+0xe0/0x120
[ 7891.346707]  [<ffffffff81319fb0>] ? print_usage_bug+0x700/0x700
[ 7891.353313]  [<ffffffff81a27160>] proc_reg_read+0x110/0x270
[ 7891.359532]  [<ffffffff81870ff6>] __vfs_read+0x106/0x990
[ 7891.365459]  [<ffffffff81870ef0>] ? do_iter_readv_writev+0x840/0x840
[ 7891.372553]  [<ffffffff81b35ab5>] ? selinux_file_permission+0x3c5/0x550
[ 7891.379936]  [<ffffffff81b12ef6>] ? security_file_permission+0x176/0x220
[ 7891.387415]  [<ffffffff81871ec8>] ? rw_verify_area+0xd8/0x380
[ 7891.393830]  [<ffffffff81872288>] vfs_read+0x118/0x400
[ 7891.399564]  [<ffffffff8187710f>] SyS_read+0xdf/0x1d0
[ 7891.405202]  [<ffffffff81877030>] ? vfs_copy_file_range+0x8f0/0x8f0
[ 7891.412197]  [<ffffffff81dce253>] ? __this_cpu_preempt_check+0x13/0x20
[ 7891.419483]  [<ffffffff81877030>] ? vfs_copy_file_range+0x8f0/0x8f0
[ 7891.426478]  [<ffffffff8100924d>] do_syscall_64+0x19d/0x540
[ 7891.432699]  [<ffffffff82c76f24>] entry_SYSCALL64_slow_path+0x25/0x25
[ 7891.439881] Code: c7 c0 20 73 12 83 49 c7 c5 e0 72 12 83 4c 0f 49 e8 48 =
85 db 0f 84 04 01 00 00 48 89 da 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 =
<80> 3c 02 00 0f 85 dc 00 00 00 48 8b 1b 48 85 db 0f 84 bd 00 00=20
[ 7891.461643] RIP  [<ffffffff8253b250>] cmos_procfs+0xb0/0x1e0
[ 7891.467970]  RSP <ffff88080a54f938>
[ 7891.478688] ---[ end trace 724fbd49872953c3 ]---
[ 7891.483921] Kernel panic - not syncing: Fatal exception
[ 7891.489875] Kernel Offset: disabled
[ 7891.493787] ---[ end Kernel panic - not syncing: Fatal exception
[ 7891.500491] ------------[ cut here ]------------
[ 7891.505648] WARNING: CPU: 81 PID: 32522 at arch/x86/kernel/smp.c:127 nat=
ive_smp_send_reschedule+0x107/0x150
[ 7891.516521] Modules linked in: tun ext4 jbd2 mbcache loop veth ipt_MASQU=
ERADE nf_nat_masquerade_ipv4 iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 n=
f_nat_ipv4 xt_addrtype iptable_filter xt_conntrack nf_nat nf_conntrack br_n=
etfilter bridge stp llc overlay intel_rapl sb_edac edac_core x86_pkg_temp_t=
hermal intel_powerclamp coretemp crct10dif_pclmul crc32_pclmul ghash_clmuln=
i_intel aesni_intel lrw gf128mul glue_helper ablk_helper cryptd intel_uncor=
e iTCO_wdt iTCO_vendor_support pcspkr i2c_i801 i2c_smbus sg mei_me mei lpc_=
ich shpchp ipmi_ssif mxm_wmi ipmi_si ipmi_msghandler wmi acpi_power_meter a=
cpi_pad nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables xfs libcrc32c=
 sr_mod sd_mod cdrom mgag200 i2c_algo_bit drm_kms_helper syscopyarea sysfil=
lrect sysimgblt fb_sys_fops ttm crc32c_intel drm ixgbe serio_raw ahci libah=
ci libata mdio ptp i2c_core pps_core dca fjes dm_mirror dm_region_hash dm_l=
og dm_mod
[ 7891.605894] CPU: 81 PID: 32522 Comm: proc01 Tainted: G      D W       4.=
9.0-rc1 #32
[ 7891.614440] Hardware name: Intel Corporation S2600WTT/S2600WTT, BIOS GRR=
FSDP1.86B.0271.R00.1510301446 10/30/2015
[ 7891.625798]  ffff880e56807a00 ffffffff81d23184 0000000041b58ab3 ffffffff=
8334713f
[ 7891.634094]  ffffffff81d230c4 000000000333a700 ffff880e568079c0 ffffffff=
81293d7c
[ 7891.642390]  00000000d3274681 ffff880e56807a78 0000000000000051 00000000=
00007f0a
[ 7891.650686] Call Trace:
[ 7891.653413]  <IRQ> [ 7891.655561]  [<ffffffff81d23184>] dump_stack+0xc0/=
0x12c
[ 7891.661401]  [<ffffffff81d230c4>] ? _atomic_dec_and_lock+0xc4/0xc4
[ 7891.668302]  [<ffffffff81293d7c>] ? rcu_read_unlock+0x3c/0x80
[ 7891.674719]  [<ffffffff811b06ee>] __warn+0x19e/0x1d0
[ 7891.680259]  [<ffffffff811b090d>] warn_slowpath_null+0x1d/0x20
[ 7891.686769]  [<ffffffff810dbe57>] native_smp_send_reschedule+0x107/0x150
[ 7891.694253]  [<ffffffff8126cddb>] try_to_wake_up+0x9fb/0x10d0
[ 7891.700665]  [<ffffffff8126c3e0>] ? migrate_swap_stop+0xa70/0xa70
[ 7891.707468]  [<ffffffff8126d662>] default_wake_function+0x42/0x70
[ 7891.714271]  [<ffffffff812ed575>] __wake_up_common+0xe5/0x210
[ 7891.720688]  [<ffffffff8198d33f>] ? ep_poll_callback+0x5ef/0x9d0
[ 7891.727391]  [<ffffffff812ed703>] __wake_up_locked+0x13/0x20
[ 7891.733707]  [<ffffffff8198cfc1>] ep_poll_callback+0x271/0x9d0
[ 7891.740218]  [<ffffffff8198d230>] ? ep_poll_callback+0x4e0/0x9d0
[ 7891.746921]  [<ffffffff8198cd50>] ? ep_poll_safewake+0x60/0x60
[ 7891.753433]  [<ffffffff812ed6c3>] ? __wake_up+0x23/0x50
[ 7891.759264]  [<ffffffff812ed575>] __wake_up_common+0xe5/0x210
[ 7891.765679]  [<ffffffff812ed6d9>] __wake_up+0x39/0x50
[ 7891.771320]  [<ffffffff8135cb3c>] wake_up_klogd_work_func+0x4c/0x60
[ 7891.778319]  [<ffffffff815b249d>] irq_work_run_list+0xdd/0x1a0
[ 7891.784829]  [<ffffffff815b31a6>] irq_work_tick+0x166/0x240
[ 7891.791051]  [<ffffffff813d0682>] update_process_times+0x42/0x60
[ 7891.797756]  [<ffffffff81409412>] tick_sched_handle+0x92/0x170
[ 7891.804267]  [<ffffffff8140bf29>] tick_sched_timer+0x39/0xb0
[ 7891.810584]  [<ffffffff813d3ad7>] __hrtimer_run_queues+0x3d7/0x12e0
[ 7891.817580]  [<ffffffff813d704c>] ? hrtimer_interrupt+0x16c/0x5b0
[ 7891.824381]  [<ffffffff8140bef0>] ? tick_sched_do_timer+0x200/0x200
[ 7891.831378]  [<ffffffff813d3700>] ? enqueue_hrtimer+0x5a0/0x5a0
[ 7891.837983]  [<ffffffff813d704c>] ? hrtimer_interrupt+0x16c/0x5b0
[ 7891.844784]  [<ffffffff813d711b>] hrtimer_interrupt+0x23b/0x5b0
[ 7891.851393]  [<ffffffff810e9f1d>] local_apic_timer_interrupt+0x9d/0x170
[ 7891.858778]  [<ffffffff82c79880>] smp_apic_timer_interrupt+0x80/0xb0
[ 7891.865869]  [<ffffffff82c788b3>] apic_timer_interrupt+0x93/0xa0
[ 7891.872572]  <EOI> [ 7891.874720]  [<ffffffff81646e6d>] ? panic+0x354/0x=
3e1
[ 7891.880364]  [<ffffffff81646e6a>] ? panic+0x351/0x3e1
[ 7891.886002]  [<ffffffff81646b19>] ? percpu_up_read_preempt_enable.constp=
rop.25+0xb9/0xb9
[ 7891.895035]  [<ffffffff81068822>] oops_end+0xe2/0xf0
[ 7891.900574]  [<ffffffff81068e50>] die+0x50/0x80
[ 7891.905631]  [<ffffffff8105e732>] do_general_protection+0x242/0x430
[ 7891.912627]  [<ffffffff82c77fb2>] general_protection+0x22/0x30
[ 7891.919139]  [<ffffffff8253b250>] ? cmos_procfs+0xb0/0x1e0
[ 7891.925261]  [<ffffffff8253b351>] ? cmos_procfs+0x1b1/0x1e0
[ 7891.931480]  [<ffffffff8253b1a0>] ? rtc_handler+0x140/0x140
[ 7891.937700]  [<ffffffff82538580>] rtc_proc_show+0x180/0x640
[ 7891.943919]  [<ffffffff82538400>] ? rtc_proc_open+0xd0/0xd0
[ 7891.950139]  [<ffffffff817eb26d>] ? kasan_kmalloc+0xad/0xe0
[ 7891.956359]  [<ffffffff81901d44>] seq_read+0x334/0x1400
[ 7891.962192]  [<ffffffff81901a10>] ? seq_hlist_start_percpu+0x4a0/0x4a0
[ 7891.969477]  [<ffffffff810952fb>] ? save_stack_trace+0x1b/0x20
[ 7891.975989]  [<ffffffff817eaff6>] ? save_stack+0x46/0xd0
[ 7891.981918]  [<ffffffff817eb821>] ? kasan_slab_free+0x71/0xb0
[ 7891.988332]  [<ffffffff817e3fd9>] ? kmem_cache_free+0xe9/0x660
[ 7891.994842]  [<ffffffff818affe0>] ? putname+0xe0/0x120
[ 7892.000577]  [<ffffffff81319fb0>] ? print_usage_bug+0x700/0x700
[ 7892.007185]  [<ffffffff81a27160>] proc_reg_read+0x110/0x270
[ 7892.013404]  [<ffffffff81870ff6>] __vfs_read+0x106/0x990
[ 7892.019332]  [<ffffffff81870ef0>] ? do_iter_readv_writev+0x840/0x840
[ 7892.026426]  [<ffffffff81b35ab5>] ? selinux_file_permission+0x3c5/0x550
[ 7892.033802]  [<ffffffff81b12ef6>] ? security_file_permission+0x176/0x220
[ 7892.041282]  [<ffffffff81871ec8>] ? rw_verify_area+0xd8/0x380
[ 7892.047697]  [<ffffffff81872288>] vfs_read+0x118/0x400
[ 7892.053432]  [<ffffffff8187710f>] SyS_read+0xdf/0x1d0
[ 7892.059069]  [<ffffffff81877030>] ? vfs_copy_file_range+0x8f0/0x8f0
[ 7892.066066]  [<ffffffff81dce253>] ? __this_cpu_preempt_check+0x13/0x20
[ 7892.073352]  [<ffffffff81877030>] ? vfs_copy_file_range+0x8f0/0x8f0
[ 7892.080348]  [<ffffffff8100924d>] do_syscall_64+0x19d/0x540
[ 7892.086567]  [<ffffffff82c76f24>] entry_SYSCALL64_slow_path+0x25/0x25
[ 7892.093756] ---[ end trace 724fbd49872953c4 ]---

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
