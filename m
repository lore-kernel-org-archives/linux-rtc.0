Return-Path: <rtc-linux+bncBC62JGFMSINRB2URY62QKGQEQRGIYHA@googlegroups.com>
Date: Wed, 3 Feb 2016 01:31:21 -0800 (PST)
From: dirk.behme@gmail.com
To: rtc-linux <rtc-linux@googlegroups.com>
Cc: Dirk Behme <dirk.behme@de.bosch.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Oleksij Rempel <linux@rempel-privat.de>
Message-Id: <460eec38-0a09-4faa-b601-de64803ed5f3@googlegroups.com>
Subject: [rtc-linux] rtc: RV8803: BUG: scheduling while atomic
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_8310_601012378.1454491881785"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

------=_Part_8310_601012378.1454491881785
Content-Type: multipart/alternative;
	boundary="----=_Part_8311_1270629460.1454491881785"

------=_Part_8311_1270629460.1454491881785
Content-Type: text/plain; charset=UTF-8

Testing the RV8803 driver [1] we are getting several "BUG: scheduling while 
atomic" [2].

Having a quick look this might be from rv8803_set_time() holding a spinlock 
during the call to i2c_smbus_read_byte_data()?

Any ideas?

Best regards

Dirk

[1] 
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/rtc/rtc-rv8803.c

[2] 

BUG: scheduling while atomic: dev_rtc_integra/309/0x00000002

Backtrace: 
[<80011bc8>] (dump_backtrace) from [<80011dd0>] (show_stack+0x18/0x1c)
 r6:00000000 r5:90431140 r4:00000000 r3:00400100
[<80011db8>] (show_stack) from [<80508bc0>] (dump_stack+0x74/0xc0)
[<80508b4c>] (dump_stack) from [<805065fc>] (__schedule_bug+0x60/0x7c)
 r4:90431140 r3:200f0093
[<8050659c>] (__schedule_bug) from [<80509dfc>] (__schedule+0x70/0x6d8)
 r4:9fa90440 r3:00000000
[<80509d8c>] (__schedule) from [<8050a4fc>] (schedule+0x98/0x9c)
 r10:92513810 r9:807220c0 r8:00000003 r7:807220c0 r6:ffff988c r5:92513810
 r4:00000001
[<8050a464>] (schedule) from [<803a0620>] (i2c_imx_bus_busy+0x7c/0x94)
[<803a05a4>] (i2c_imx_bus_busy) from [<803a0ce4>] (i2c_imx_xfer+0x200/0x750)
 r8:00000002 r7:00000080 r6:000000a0 r5:91bcfd58 r4:807284d0 r3:00000001
[<803a0ae4>] (i2c_imx_xfer) from [<8039cd2c>] (__i2c_transfer+0x50/0x7c)
 r10:00000002 r9:807220c0 r8:00000002 r7:91bcfd58 r6:ffff988c r5:92513810
 r4:00000000
[<8039ccdc>] (__i2c_transfer) from [<8039e138>] (i2c_transfer+0x74/0x98)
 r9:91bcfd73 r8:00000002 r7:00000000 r6:91bcfd58 r5:00000002 r4:92513810
[<8039e0c4>] (i2c_transfer) from [<8039e5ac>] (i2c_smbus_xfer+0x3a4/0x4f8)
 r6:92513810 r5:00000001 r4:91bcfdfe r3:00000000
[<8039e208>] (i2c_smbus_xfer) from [<8039eaac>] 
(i2c_smbus_read_byte_data+0x3c/0x4c)
 r10:00067674 r9:91bce000 r8:7f2b8c84 r7:90473580 r6:600f0013 r5:9196f290
 r4:9196f298
[<8039ea70>] (i2c_smbus_read_byte_data) from [<7f2b83c0>] 
(rv8803_set_time+0xc0/0x110 [rtc_rv8803])
[<7f2b8300>] (rv8803_set_time [rtc_rv8803]) from [<8039a1a4>] 
(rtc_set_time+0x64/0xd8)
 r7:90473580 r6:91bcfe8c r5:90473400 r4:90473400
[<8039a140>] (rtc_set_time) from [<8039b264>] (rtc_dev_ioctl+0x294/0x568)
 r7:90473580 r6:4024700a r5:90473400 r4:00067674
[<8039afd0>] (rtc_dev_ioctl) from [<8010edfc>] (do_vfs_ioctl+0x4dc/0x598)
 r8:91bb8958 r7:4024700a r6:00067674 r5:91f9ef00 r4:91f9ef01
[<8010e920>] (do_vfs_ioctl) from [<8010eef4>] (SyS_ioctl+0x3c/0x64)
 r10:00000000 r9:91bce000 r8:0000000f r7:4024700a r6:00067674 r5:91f9ef00
 r4:91f9ef01
[<8010eeb8>] (SyS_ioctl) from [<8000e0a0>] (ret_fast_syscall+0x0/0x50)
 r8:8000e264 r7:00000036 r6:00000064 r5:00066f90 r4:00000014 r3:00067674
BUG: scheduling while atomic: dev_rtc_integra/309/0x00000002

Workqueue: events rtc_timer_do_work
Backtrace: 
[<80011bc8>] (dump_backtrace) from [<80011dd0>] (show_stack+0x18/0x1c)
 r6:00000000 r5:925e9700 r4:00000000 r3:9263c000
[<80011db8>] (show_stack) from [<80508bc0>] (dump_stack+0x74/0xc0)
[<80508b4c>] (dump_stack) from [<805065fc>] (__schedule_bug+0x60/0x7c)
 r4:925e9700 r3:20000013
[<8050659c>] (__schedule_bug) from [<80509dfc>] (__schedule+0x70/0x6d8)
 r4:9fa90440 r3:00000000
[<80509d8c>] (__schedule) from [<8050a4fc>] (schedule+0x98/0x9c)
 r10:92513810 r9:807284d0 r8:00000003 r7:807220c0 r6:ffff98aa r5:92513810
 r4:00000000
[<8050a464>] (schedule) from [<803a0620>] (i2c_imx_bus_busy+0x7c/0x94)
[<803a05a4>] (i2c_imx_bus_busy) from [<803a107c>] (i2c_imx_xfer+0x598/0x750)
 r8:00000001 r7:92513a3c r6:00000000 r5:9263dd1c r4:00000000 r3:00000001
[<803a0ae4>] (i2c_imx_xfer) from [<8039cd2c>] (__i2c_transfer+0x50/0x7c)
 r10:00000002 r9:807220c0 r8:00000002 r7:9263dd08 r6:ffff98a6 r5:92513810
 r4:00000000
[<8039ccdc>] (__i2c_transfer) from [<8039e138>] (i2c_transfer+0x74/0x98)
 r9:9263dd23 r8:00000002 r7:00000000 r6:9263dd08 r5:00000002 r4:92513810
[<8039e0c4>] (i2c_transfer) from [<8039e5ac>] (i2c_smbus_xfer+0x3a4/0x4f8)
 r6:92513810 r5:00000001 r4:9263ddae r3:00000000
[<8039e208>] (i2c_smbus_xfer) from [<8039eaac>] 
(i2c_smbus_read_byte_data+0x3c/0x4c)
 r10:00000000 r9:600f0113 r8:90473600 r7:9196f298 r6:925ab600 r5:9196f290
 r4:00000000
[<8039ea70>] (i2c_smbus_read_byte_data) from [<7f2b80f0>] 
(rv8803_alarm_irq_enable+0x78/0xe4 [rtc_rv8803])
[<7f2b8078>] (rv8803_alarm_irq_enable [rtc_rv8803]) from [<80399b80>] 
(rtc_alarm_disable+0x30/0x34)
 r9:00000000 r8:90473600 r7:90473580 r6:9263de6c r5:90473400 r4:9047369c
[<80399b50>] (rtc_alarm_disable) from [<8039ac74>] 
(rtc_timer_do_work+0xe8/0x148)
[<8039ab8c>] (rtc_timer_do_work) from [<8003ba8c>] 
(process_one_work+0x28c/0x43c)
 r10:92627500 r9:00000000 r8:807794c0 r7:9fa93300 r6:9263c028 r5:9fa90040
 r4:9047369c
[<8003b800>] (process_one_work) from [<8003ca68>] 
(worker_thread+0x238/0x370)
 r10:9fa90054 r9:92627518 r8:9263c028 r7:9263c000 r6:9fa90040 r5:9fa90040
 r4:92627500
[<8003c830>] (worker_thread) from [<800420d0>] (kthread+0xec/0x100)

CPU: 0 PID: 309 Comm: dev_rtc_integra Tainted: G        W    
3.14.57-03945-gf331d92 #1
Backtrace: 
[<80011bc8>] (dump_backtrace) from [<80011dd0>] (show_stack+0x18/0x1c)
 r6:00000000 r5:90431140 r4:00000000 r3:00400100
[<80011db8>] (show_stack) from [<80508bc0>] (dump_stack+0x74/0xc0)
[<80508b4c>] (dump_stack) from [<805065fc>] (__schedule_bug+0x60/0x7c)
 r4:90431140 r3:200f0113
[<8050659c>] (__schedule_bug) from [<80509dfc>] (__schedule+0x70/
[<8039a140>] (rtc_set_time) from [<8039b264>] (rtc_dev_ioctl+0x294/0x568)
 r7:90473580 r6:4024700a r5:90473400 r4:00067674
[<8039afd0>] (rtc_dev_ioctl) from [<8010edfc>] (do_vfs_ioctl+0x4dc/0x598)
 r8:91bb8958 r7:4024700a r6:00067674 r5:91b64900 r4:91b64901
[<8010e920>] (do_vfs_ioctl) from [<8010eef4>] (SyS_ioctl+0x3c/0x64)
 r10:00000000 r9:91bce000 r8:0000000f r7:4024700a r6:00067674 r5:91b64900
 r4:91b64901
[<8010eeb8>] (SyS_ioctl) from [<8000e0a0>] (ret_fast_syscall+0x0/0x50)
 r8:8000e264 r7:00000036 r6:0002a3d0 r5:00000000 r4:00067674 r3:0000000c
BUG: scheduling while atomic: kworker/0:1/26/0x00000002

Workqueue: events rtc_timer_do_work
Backtrace: 
[<80011bc8>] (dump_backtrace) from [<80011dd0>] (show_stack+0x18/0x1c)
 r6:00000000 r5:925e9700 r4:00000000 r3:9263c000
[<80011db8>] (show_stack) from [<80508bc0>] (dump_stack+0x74/0xc0)
[<80508b4c>] (dump_stack) from [<805065fc>] (__schedule_bug+0x60/0x7c)
 r4:925e9700 r3:200f0093
[<8050659c>] (__schedule_bug) from [<80509dfc>] (__schedule+0x70/0x6d8)
 r4:9fa90440 r3:00000000
[<80509d8c>] (__schedule) from [<8050a4fc>] (schedule+0x98/0x9c)
 r10:92513810 r9:807220c0 r8:00000003 r7:807220c0 r6:ffff98d0 r5:92513810
 r4:00000001
[<8050a464>] (schedule) from [<803a0620>] (i2c_imx_bus_busy+0x7c/0x94)
[<803a05a4>] (i2c_imx_bus_busy) from [<803a0ce4>] (i2c_imx_xfer+0x200/0x750)
 r8:00000002 r7:00000080 r6:000000a0 r5:9263dd08 r4:807284d0 r3:00000001
[<803a0ae4>] (i2c_imx_xfer) from [<8039cd2c>] (__i2c_transfer+0x50/0x7c)
 r10:00000002 r9:807220c0 r8:00000002 r7:9263dd08 r6:ffff98d0 r5:92513810
 r4:00000000
[<8039ccdc>] (__i2c_transfer) from [<8039e138>] (i2c_transfer+0x74/0x98)
 r9:9263dd23 r8:00000002 r7:00000000 r6:9263dd08 r5:00000002 r4:92513810
[<8039e0c4>] (i2c_transfer) from [<8039e5ac>] (i2c_smbus_xfer+0x3a4/0x4f8)
 r6:92513810 r5:00000001 r4:9263ddae r3:00000000
[<8039e208>] (i2c_smbus_xfer) from [<8039eaac>] 
(i2c_smbus_read_byte_data+0x3c/0x4c)
 r10:00000000 r9:600f0013 r8:90473600 r7:9196f298 r6:925ab600 r5:9196f290
 r4:00000000
[<8039ea70>] (i2c_smbus_read_byte_data) from [<7f2b80f0>] 
(rv8803_alarm_irq_enable+0x78/0xe4 [rtc_rv8803])
[<7f2b8078>] (rv[   37.941914] BUG: scheduling while atomic: 
kworker/0:1/26/0x00000002

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

------=_Part_8311_1270629460.1454491881785
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Testing the RV8803 driver [1] we are getting several &quot=
;BUG: scheduling while atomic&quot; [2].<br><br>Having a quick look this mi=
ght be from <span class=3D"blob-code-inner"><span class=3D"pl-en">rv8803_se=
t_time</span>() </span><span class=3D"blob-code-inner">holding a spinlock d=
uring the call to <code>i2c_smbus_read_byte_data()?</code></span><br> <br>A=
ny ideas?<br><br>Best regards<br><br>Dirk<br><br>[1] https://git.kernel.org=
/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/rtc/rtc-rv8803.c<br>=
<br>[2] <br><br>BUG: scheduling while atomic: dev_rtc_integra/309/0x0000000=
2<br><br>Backtrace: <br>[&lt;80011bc8&gt;] (dump_backtrace) from [&lt;80011=
dd0&gt;] (show_stack+0x18/0x1c)<br>=C2=A0r6:00000000 r5:90431140 r4:0000000=
0 r3:00400100<br>[&lt;80011db8&gt;] (show_stack) from [&lt;80508bc0&gt;] (d=
ump_stack+0x74/0xc0)<br>[&lt;80508b4c&gt;] (dump_stack) from [&lt;805065fc&=
gt;] (__schedule_bug+0x60/0x7c)<br>=C2=A0r4:90431140 r3:200f0093<br>[&lt;80=
50659c&gt;] (__schedule_bug) from [&lt;80509dfc&gt;] (__schedule+0x70/0x6d8=
)<br>=C2=A0r4:9fa90440 r3:00000000<br>[&lt;80509d8c&gt;] (__schedule) from =
[&lt;8050a4fc&gt;] (schedule+0x98/0x9c)<br>=C2=A0r10:92513810 r9:807220c0 r=
8:00000003 r7:807220c0 r6:ffff988c r5:92513810<br>=C2=A0r4:00000001<br>[&lt=
;8050a464&gt;] (schedule) from [&lt;803a0620&gt;] (i2c_imx_bus_busy+0x7c/0x=
94)<br>[&lt;803a05a4&gt;] (i2c_imx_bus_busy) from [&lt;803a0ce4&gt;] (i2c_i=
mx_xfer+0x200/0x750)<br>=C2=A0r8:00000002 r7:00000080 r6:000000a0 r5:91bcfd=
58 r4:807284d0 r3:00000001<br>[&lt;803a0ae4&gt;] (i2c_imx_xfer) from [&lt;8=
039cd2c&gt;] (__i2c_transfer+0x50/0x7c)<br>=C2=A0r10:00000002 r9:807220c0 r=
8:00000002 r7:91bcfd58 r6:ffff988c r5:92513810<br>=C2=A0r4:00000000<br>[&lt=
;8039ccdc&gt;] (__i2c_transfer) from [&lt;8039e138&gt;] (i2c_transfer+0x74/=
0x98)<br>=C2=A0r9:91bcfd73 r8:00000002 r7:00000000 r6:91bcfd58 r5:00000002 =
r4:92513810<br>[&lt;8039e0c4&gt;] (i2c_transfer) from [&lt;8039e5ac&gt;] (i=
2c_smbus_xfer+0x3a4/0x4f8)<br>=C2=A0r6:92513810 r5:00000001 r4:91bcfdfe r3:=
00000000<br>[&lt;8039e208&gt;] (i2c_smbus_xfer) from [&lt;8039eaac&gt;] (i2=
c_smbus_read_byte_data+0x3c/0x4c)<br>=C2=A0r10:00067674 r9:91bce000 r8:7f2b=
8c84 r7:90473580 r6:600f0013 r5:9196f290<br>=C2=A0r4:9196f298<br>[&lt;8039e=
a70&gt;] (i2c_smbus_read_byte_data) from [&lt;7f2b83c0&gt;] (rv8803_set_tim=
e+0xc0/0x110 [rtc_rv8803])<br>[&lt;7f2b8300&gt;] (rv8803_set_time [rtc_rv88=
03]) from [&lt;8039a1a4&gt;] (rtc_set_time+0x64/0xd8)<br>=C2=A0r7:90473580 =
r6:91bcfe8c r5:90473400 r4:90473400<br>[&lt;8039a140&gt;] (rtc_set_time) fr=
om [&lt;8039b264&gt;] (rtc_dev_ioctl+0x294/0x568)<br>=C2=A0r7:90473580 r6:4=
024700a r5:90473400 r4:00067674<br>[&lt;8039afd0&gt;] (rtc_dev_ioctl) from =
[&lt;8010edfc&gt;] (do_vfs_ioctl+0x4dc/0x598)<br>=C2=A0r8:91bb8958 r7:40247=
00a r6:00067674 r5:91f9ef00 r4:91f9ef01<br>[&lt;8010e920&gt;] (do_vfs_ioctl=
) from [&lt;8010eef4&gt;] (SyS_ioctl+0x3c/0x64)<br>=C2=A0r10:00000000 r9:91=
bce000 r8:0000000f r7:4024700a r6:00067674 r5:91f9ef00<br>=C2=A0r4:91f9ef01=
<br>[&lt;8010eeb8&gt;] (SyS_ioctl) from [&lt;8000e0a0&gt;] (ret_fast_syscal=
l+0x0/0x50)<br>=C2=A0r8:8000e264 r7:00000036 r6:00000064 r5:00066f90 r4:000=
00014 r3:00067674<br>BUG: scheduling while atomic: dev_rtc_integra/309/0x00=
000002<br><br>Workqueue: events rtc_timer_do_work<br>Backtrace: <br>[&lt;80=
011bc8&gt;] (dump_backtrace) from [&lt;80011dd0&gt;] (show_stack+0x18/0x1c)=
<br>=C2=A0r6:00000000 r5:925e9700 r4:00000000 r3:9263c000<br>[&lt;80011db8&=
gt;] (show_stack) from [&lt;80508bc0&gt;] (dump_stack+0x74/0xc0)<br>[&lt;80=
508b4c&gt;] (dump_stack) from [&lt;805065fc&gt;] (__schedule_bug+0x60/0x7c)=
<br>=C2=A0r4:925e9700 r3:20000013<br>[&lt;8050659c&gt;] (__schedule_bug) fr=
om [&lt;80509dfc&gt;] (__schedule+0x70/0x6d8)<br>=C2=A0r4:9fa90440 r3:00000=
000<br>[&lt;80509d8c&gt;] (__schedule) from [&lt;8050a4fc&gt;] (schedule+0x=
98/0x9c)<br>=C2=A0r10:92513810 r9:807284d0 r8:00000003 r7:807220c0 r6:ffff9=
8aa r5:92513810<br>=C2=A0r4:00000000<br>[&lt;8050a464&gt;] (schedule) from =
[&lt;803a0620&gt;] (i2c_imx_bus_busy+0x7c/0x94)<br>[&lt;803a05a4&gt;] (i2c_=
imx_bus_busy) from [&lt;803a107c&gt;] (i2c_imx_xfer+0x598/0x750)<br>=C2=A0r=
8:00000001 r7:92513a3c r6:00000000 r5:9263dd1c r4:00000000 r3:00000001<br>[=
&lt;803a0ae4&gt;] (i2c_imx_xfer) from [&lt;8039cd2c&gt;] (__i2c_transfer+0x=
50/0x7c)<br>=C2=A0r10:00000002 r9:807220c0 r8:00000002 r7:9263dd08 r6:ffff9=
8a6 r5:92513810<br>=C2=A0r4:00000000<br>[&lt;8039ccdc&gt;] (__i2c_transfer)=
 from [&lt;8039e138&gt;] (i2c_transfer+0x74/0x98)<br>=C2=A0r9:9263dd23 r8:0=
0000002 r7:00000000 r6:9263dd08 r5:00000002 r4:92513810<br>[&lt;8039e0c4&gt=
;] (i2c_transfer) from [&lt;8039e5ac&gt;] (i2c_smbus_xfer+0x3a4/0x4f8)<br>=
=C2=A0r6:92513810 r5:00000001 r4:9263ddae r3:00000000<br>[&lt;8039e208&gt;]=
 (i2c_smbus_xfer) from [&lt;8039eaac&gt;] (i2c_smbus_read_byte_data+0x3c/0x=
4c)<br>=C2=A0r10:00000000 r9:600f0113 r8:90473600 r7:9196f298 r6:925ab600 r=
5:9196f290<br>=C2=A0r4:00000000<br>[&lt;8039ea70&gt;] (i2c_smbus_read_byte_=
data) from [&lt;7f2b80f0&gt;] (rv8803_alarm_irq_enable+0x78/0xe4 [rtc_rv880=
3])<br>[&lt;7f2b8078&gt;] (rv8803_alarm_irq_enable [rtc_rv8803]) from [&lt;=
80399b80&gt;] (rtc_alarm_disable+0x30/0x34)<br>=C2=A0r9:00000000 r8:9047360=
0 r7:90473580 r6:9263de6c r5:90473400 r4:9047369c<br>[&lt;80399b50&gt;] (rt=
c_alarm_disable) from [&lt;8039ac74&gt;] (rtc_timer_do_work+0xe8/0x148)<br>=
[&lt;8039ab8c&gt;] (rtc_timer_do_work) from [&lt;8003ba8c&gt;] (process_one=
_work+0x28c/0x43c)<br>=C2=A0r10:92627500 r9:00000000 r8:807794c0 r7:9fa9330=
0 r6:9263c028 r5:9fa90040<br>=C2=A0r4:9047369c<br>[&lt;8003b800&gt;] (proce=
ss_one_work) from [&lt;8003ca68&gt;] (worker_thread+0x238/0x370)<br>=C2=A0r=
10:9fa90054 r9:92627518 r8:9263c028 r7:9263c000 r6:9fa90040 r5:9fa90040<br>=
=C2=A0r4:92627500<br>[&lt;8003c830&gt;] (worker_thread) from [&lt;800420d0&=
gt;] (kthread+0xec/0x100)<br><br>CPU: 0 PID: 309 Comm: dev_rtc_integra Tain=
ted: G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0=C2=A0 3.14.5=
7-03945-gf331d92 #1<br>Backtrace: <br>[&lt;80011bc8&gt;] (dump_backtrace) f=
rom [&lt;80011dd0&gt;] (show_stack+0x18/0x1c)<br>=C2=A0r6:00000000 r5:90431=
140 r4:00000000 r3:00400100<br>[&lt;80011db8&gt;] (show_stack) from [&lt;80=
508bc0&gt;] (dump_stack+0x74/0xc0)<br>[&lt;80508b4c&gt;] (dump_stack) from =
[&lt;805065fc&gt;] (__schedule_bug+0x60/0x7c)<br>=C2=A0r4:90431140 r3:200f0=
113<br>[&lt;8050659c&gt;] (__schedule_bug) from [&lt;80509dfc&gt;] (__sched=
ule+0x70/<br>[&lt;8039a140&gt;] (rtc_set_time) from [&lt;8039b264&gt;] (rtc=
_dev_ioctl+0x294/0x568)<br>=C2=A0r7:90473580 r6:4024700a r5:90473400 r4:000=
67674<br>[&lt;8039afd0&gt;] (rtc_dev_ioctl) from [&lt;8010edfc&gt;] (do_vfs=
_ioctl+0x4dc/0x598)<br>=C2=A0r8:91bb8958 r7:4024700a r6:00067674 r5:91b6490=
0 r4:91b64901<br>[&lt;8010e920&gt;] (do_vfs_ioctl) from [&lt;8010eef4&gt;] =
(SyS_ioctl+0x3c/0x64)<br>=C2=A0r10:00000000 r9:91bce000 r8:0000000f r7:4024=
700a r6:00067674 r5:91b64900<br>=C2=A0r4:91b64901<br>[&lt;8010eeb8&gt;] (Sy=
S_ioctl) from [&lt;8000e0a0&gt;] (ret_fast_syscall+0x0/0x50)<br>=C2=A0r8:80=
00e264 r7:00000036 r6:0002a3d0 r5:00000000 r4:00067674 r3:0000000c<br>BUG: =
scheduling while atomic: kworker/0:1/26/0x00000002<br><br>Workqueue: events=
 rtc_timer_do_work<br>Backtrace: <br>[&lt;80011bc8&gt;] (dump_backtrace) fr=
om [&lt;80011dd0&gt;] (show_stack+0x18/0x1c)<br>=C2=A0r6:00000000 r5:925e97=
00 r4:00000000 r3:9263c000<br>[&lt;80011db8&gt;] (show_stack) from [&lt;805=
08bc0&gt;] (dump_stack+0x74/0xc0)<br>[&lt;80508b4c&gt;] (dump_stack) from [=
&lt;805065fc&gt;] (__schedule_bug+0x60/0x7c)<br>=C2=A0r4:925e9700 r3:200f00=
93<br>[&lt;8050659c&gt;] (__schedule_bug) from [&lt;80509dfc&gt;] (__schedu=
le+0x70/0x6d8)<br>=C2=A0r4:9fa90440 r3:00000000<br>[&lt;80509d8c&gt;] (__sc=
hedule) from [&lt;8050a4fc&gt;] (schedule+0x98/0x9c)<br>=C2=A0r10:92513810 =
r9:807220c0 r8:00000003 r7:807220c0 r6:ffff98d0 r5:92513810<br>=C2=A0r4:000=
00001<br>[&lt;8050a464&gt;] (schedule) from [&lt;803a0620&gt;] (i2c_imx_bus=
_busy+0x7c/0x94)<br>[&lt;803a05a4&gt;] (i2c_imx_bus_busy) from [&lt;803a0ce=
4&gt;] (i2c_imx_xfer+0x200/0x750)<br>=C2=A0r8:00000002 r7:00000080 r6:00000=
0a0 r5:9263dd08 r4:807284d0 r3:00000001<br>[&lt;803a0ae4&gt;] (i2c_imx_xfer=
) from [&lt;8039cd2c&gt;] (__i2c_transfer+0x50/0x7c)<br>=C2=A0r10:00000002 =
r9:807220c0 r8:00000002 r7:9263dd08 r6:ffff98d0 r5:92513810<br>=C2=A0r4:000=
00000<br>[&lt;8039ccdc&gt;] (__i2c_transfer) from [&lt;8039e138&gt;] (i2c_t=
ransfer+0x74/0x98)<br>=C2=A0r9:9263dd23 r8:00000002 r7:00000000 r6:9263dd08=
 r5:00000002 r4:92513810<br>[&lt;8039e0c4&gt;] (i2c_transfer) from [&lt;803=
9e5ac&gt;] (i2c_smbus_xfer+0x3a4/0x4f8)<br>=C2=A0r6:92513810 r5:00000001 r4=
:9263ddae r3:00000000<br>[&lt;8039e208&gt;] (i2c_smbus_xfer) from [&lt;8039=
eaac&gt;] (i2c_smbus_read_byte_data+0x3c/0x4c)<br>=C2=A0r10:00000000 r9:600=
f0013 r8:90473600 r7:9196f298 r6:925ab600 r5:9196f290<br>=C2=A0r4:00000000<=
br>[&lt;8039ea70&gt;] (i2c_smbus_read_byte_data) from [&lt;7f2b80f0&gt;] (r=
v8803_alarm_irq_enable+0x78/0xe4 [rtc_rv8803])<br>[&lt;7f2b8078&gt;] (rv[=
=C2=A0=C2=A0 37.941914] BUG: scheduling while atomic: kworker/0:1/26/0x0000=
0002<br></div>

<p></p>

-- <br />
-- <br />
You received this message because you are subscribed to &quot;rtc-linux&quo=
t;.<br />
Membership options at <a href=3D"http://groups.google.com/group/rtc-linux">=
http://groups.google.com/group/rtc-linux</a> .<br />
Please read <a href=3D"http://groups.google.com/group/rtc-linux/web/checkli=
st">http://groups.google.com/group/rtc-linux/web/checklist</a><br />
before submitting a driver.<br />
--- <br />
You received this message because you are subscribed to the Google Groups &=
quot;rtc-linux&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:rtc-linux+unsubscribe@googlegroups.com">rtc-linux=
+unsubscribe@googlegroups.com</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

------=_Part_8311_1270629460.1454491881785--

------=_Part_8310_601012378.1454491881785--
