Return-Path: <rtc-linux+bncBAABBWPFVXDAKGQENWSPZ7I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id c123si1240653pfa.4.2017.03.16.22.23.36
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Mar 2017 22:23:37 -0700 (PDT)
To: kernel test robot <fengguang.wu@intel.com>
References: <58cb6cce.GwD02K343UlZPrBA%fengguang.wu@intel.com>
Cc: LKP <lkp@01.org>, linux-kernel@vger.kernel.org,
 rtc-linux@googlegroups.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 wfg@linux.intel.com
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <72ddb00d-3eda-1a16-9c3b-10055dd4e730@deltatee.com>
Date: Thu, 16 Mar 2017 23:23:26 -0600
MIME-Version: 1.0
In-Reply-To: <58cb6cce.GwD02K343UlZPrBA%fengguang.wu@intel.com>
Content-Type: text/plain; charset=UTF-8
Subject: [rtc-linux] Re: [rtc] 4cd8adb100: WARNING: CPU: 0 PID: 1 at
 lib/kobject.c:690 kobject_put
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hey,

I think I see the issue here: in a couple of error conditions, the RTC
code will not initialize and ask for the cdev. However, my change will
always call cdev_add and cdev_del even though the rtc code did not call
cdev_init. I'll have to add a guard around dev->devt in the new
cdev_device functions. I'll prepare another patch tomorrow.

I also noticed that I neglected to remove the prototypes for the two RTC
function I removed. I'll fix that too.

Thanks,

Logan

On 16/03/17 10:57 PM, kernel test robot wrote:
> Greetings,
> 
> 0day kernel testing robot got the below dmesg and the first bad commit is
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git char-misc-testing
> 
> commit 4cd8adb100107dc44e63615040ca2bde43de6167
> Author:     Logan Gunthorpe <logang@deltatee.com>
> AuthorDate: Mon Mar 6 00:04:30 2017 -0700
> Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CommitDate: Fri Mar 17 09:20:18 2017 +0900
> 
>     rtc: utilize new cdev_device_add helper function
>     
>     Mostly straightforward, but we had to remove the rtc_dev_add/del_device
>     functions as they split up the cdev_add and the device_add.
>     
>     Doing this also revealed that there was likely another subtle bug:
>     seeing cdev_add was done after device_register, the cdev probably
>     was not ready before device_add when the uevent occurs. This would
>     race with userspace, if it tried to use the device directly after
>     the uevent. This is fixed just by using the new helper function.
>     
>     Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>     Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> c65bbfc122  rapidio: utilize new cdev_device_add helper function
> 4cd8adb100  rtc: utilize new cdev_device_add helper function
> 64d77f61c0  auxdisplay: Add HD44780 Character LCD support
> +-----------------------------------------------------+------------+------------+------------+
> |                                                     | c65bbfc122 | 4cd8adb100 | 64d77f61c0 |
> +-----------------------------------------------------+------------+------------+------------+
> | boot_successes                                      | 4          | 0          | 0          |
> | boot_failures                                       | 55         | 26         | 30         |
> | WARNING:at_arch/x86/mm/dump_pagetables.c:#note_page | 55         | 22         | 24         |
> | WARNING:at_lib/kobject.c:#kobject_put               | 0          | 26         | 30         |
> | WARNING:at_lib/refcount.c:#refcount_sub_and_test    | 0          | 26         | 30         |
> +-----------------------------------------------------+------------+------------+------------+
> 
> [    1.261325] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
> [    1.263029] wistron_btns: System unknown
> [    1.263411] usbcore: registered new interface driver yealink
> [    1.264581] rtc-test rtc-test.0: rtc core: registered test as rtc0
> [    1.265355] ------------[ cut here ]------------
> [    1.265798] WARNING: CPU: 0 PID: 1 at lib/kobject.c:690 kobject_put+0x39/0x60
> [    1.266539] kobject: '(null)' (cea81ab4): is not initialized, yet kobject_put() is being called.
> [    1.267291] Modules linked in:
> [    1.267562] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.11.0-rc2-00049-g4cd8adb #834
> [    1.268236] Call Trace:
> [    1.268453]  dump_stack+0x76/0xa9
> [    1.268740]  __warn+0xdb/0x100
> [    1.269005]  ? kobject_put+0x39/0x60
> [    1.269318]  warn_slowpath_fmt+0x36/0x40
> [    1.269653]  kobject_put+0x39/0x60
> [    1.269948]  cdev_del+0x1d/0x20
> [    1.270224]  cdev_device_del+0x14/0x20
> [    1.270548]  rtc_device_unregister+0x2a/0x50
> [    1.270913]  devm_rtc_device_release+0xa/0x10
> [    1.271291]  release_nodes+0x1e4/0x210
> [    1.271613]  devres_release_all+0x51/0x60
> [    1.271962]  driver_probe_device+0x237/0x480
> [    1.272332]  ? klist_next+0x1b/0xc0
> [    1.272633]  ? acpi_driver_match_device+0x49/0x62
> [    1.273034]  __device_attach_driver+0xe8/0x110
> [    1.273418]  ? klist_next+0x9d/0xc0
> [    1.273718]  ? __driver_attach+0xf0/0xf0
> [    1.274053]  bus_for_each_drv+0x44/0x80
> [    1.274389]  __device_attach+0x9d/0x140
> [    1.274718]  ? __driver_attach+0xf0/0xf0
> [    1.275054]  device_initial_probe+0xd/0x10
> [    1.275409]  bus_probe_device+0x25/0x80
> [    1.275738]  device_add+0x3fc/0x5c0
> [    1.276038]  ? kobject_set_name_vargs+0x7f/0xa0
> [    1.276428]  platform_device_add+0x1d9/0x250
> [    1.276793]  test_init+0x52/0xa6
> [    1.277085]  ? stk17ta8_rtc_driver_init+0x11/0x11
> [    1.277504]  do_one_initcall+0x92/0x160
> [    1.277844]  ? parameq+0x13/0x70
> [    1.278138]  ? repair_env_string+0x12/0x51
> [    1.278500]  ? parse_args+0x325/0x470
> [    1.278826]  ? __usermodehelper_set_disable_depth+0x3e/0x50
> [    1.279318]  kernel_init_freeable+0xfb/0x19a
> [    1.279696]  ? do_early_param+0x7a/0x7a
> [    1.280036]  ? rest_init+0x130/0x130
> [    1.280359]  kernel_init+0xb/0x100
> [    1.280665]  ? schedule_tail+0xc/0x60
> [    1.280991]  ? rest_init+0x130/0x130
> [    1.281314]  ret_from_fork+0x21/0x2c
> [    1.281706] ---[ end trace e98f47d52e9cf212 ]---
> [    1.282142] ------------[ cut here ]------------
> [    1.282142] ------------[ cut here ]------------
> [    1.282555] WARNING: CPU: 0 PID: 1 at lib/refcount.c:128 refcount_sub_and_test+0x55/0xa0
> [    1.283396] refcount_t: underflow; use-after-free.
> [    1.283829] Modules linked in:
> [    1.284110] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.11.0-rc2-00049-g4cd8adb #834
> [    1.284904] Call Trace:
> [    1.285120]  dump_stack+0x76/0xa9
> [    1.285412]  __warn+0xdb/0x100
> [    1.285678]  ? refcount_sub_and_test+0x55/0xa0
> [    1.286071]  warn_slowpath_fmt+0x36/0x40
> [    1.286423]  refcount_sub_and_test+0x55/0xa0
> [    1.286801]  refcount_dec_and_test+0xf/0x20
> [    1.287177]  kobject_put+0x41/0x60
> [    1.287480]  cdev_del+0x1d/0x20
> [    1.287760]  cdev_device_del+0x14/0x20
> [    1.288101]  rtc_device_unregister+0x2a/0x50
> [    1.288474]  devm_rtc_device_release+0xa/0x10
> [    1.288848]  release_nodes+0x1e4/0x210
> [    1.289174]  devres_release_all+0x51/0x60
> [    1.289518]  driver_probe_device+0x237/0x480
> [    1.289898]  ? klist_next+0x1b/0xc0
> [    1.290214]  ? acpi_driver_match_device+0x49/0x62
> [    1.290628]  __device_attach_driver+0xe8/0x110
> [    1.291021]  ? klist_next+0x9d/0xc0
> [    1.291336]  ? __driver_attach+0xf0/0xf0
> [    1.291684]  bus_for_each_drv+0x44/0x80
> [    1.292024]  __device_attach+0x9d/0x140
> [    1.292369]  ? __driver_attach+0xf0/0xf0
> [    1.292717]  device_initial_probe+0xd/0x10
> [    1.293086]  bus_probe_device+0x25/0x80
> [    1.293421]  device_add+0x3fc/0x5c0
> [    1.293722]  ? kobject_set_name_vargs+0x7f/0xa0
> [    1.294129]  platform_device_add+0x1d9/0x250
> [    1.294510]  test_init+0x52/0xa6
> [    1.294799]  ? stk17ta8_rtc_driver_init+0x11/0x11
> [    1.295217]  do_one_initcall+0x92/0x160
> [    1.295559]  ? parameq+0x13/0x70
> [    1.295859]  ? repair_env_string+0x12/0x51
> [    1.296215]  ? parse_args+0x325/0x470
> [    1.296532]  ? __usermodehelper_set_disable_depth+0x3e/0x50
> [    1.297006]  kernel_init_freeable+0xfb/0x19a
> [    1.297378]  ? do_early_param+0x7a/0x7a
> [    1.297708]  ? rest_init+0x130/0x130
> [    1.298030]  kernel_init+0xb/0x100
> [    1.298342]  ? schedule_tail+0xc/0x60
> [    1.298668]  ? rest_init+0x130/0x130
> [    1.298987]  ret_from_fork+0x21/0x2c
> [    1.299379] ---[ end trace e98f47d52e9cf213 ]---
> [    1.299887] rtc-test rtc-test.0: rtc core: registered test as rtc1
> 
>                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
> git bisect start 472b8db0e353bce9af369f566db55ab626922906 4495c08e84729385774601b5146d51d9e5849f81 --
> git bisect good 83f311c4f0a8a406485c034038d1eebb61467e06  # 10:15  G     11     0   11  11  Merge 'pm/linux-next' into devel-catchup-201703170914
> git bisect good dba0cafd19396fe23ef3688ce9f18e9a6cf12d11  # 10:28  G     11     0   11  11  Merge 'linux-review/Michael-Davidson/crypto-x86-aesni-fix-token-pasting-for-clang/20170317-082713' into devel-catchup-201703170914
> git bisect  bad 533e610f1350246901b978d58268816bbbedee83  # 10:42  B      0    11   22   0  Merge 'linux-review/John-Keeping/Bluetooth-hci_bcm-Fix-clock-un-prepare/20170317-081003' into devel-catchup-201703170914
> git bisect  bad a44dae33e154bb3727f7758ffe858a69c42e8ecb  # 10:57  B      0    11   22   0  Merge 'char-misc/char-misc-testing' into devel-catchup-201703170914
> git bisect good def32a359b666d8d577e4c5884e0918f7ff5ba2e  # 11:09  G     11     0   11  11  docs: Update VME documentation to include kerneldoc comments
> git bisect good f51de2acbb7facde8fb855c73fb9edd60cf3055e  # 11:20  G     11     0   11  11  platform/chrome: cros_ec_dev - utilize new cdev_device_add helper function
> git bisect  bad 4cd8adb100107dc44e63615040ca2bde43de6167  # 11:29  B      0    11   32  10  rtc: utilize new cdev_device_add helper function
> git bisect good dafa63cd90cd13262cb995a27c3c79eb3fda4655  # 11:49  G     11     0   11  11  iio:core: utilize new cdev_device_add helper function
> git bisect good cb7e71b95d29c72d1f8a2a2a0a34328bde10c3d8  # 11:56  G     11     0   11  22  mtd: utilize new cdev_device_add helper function
> git bisect good c65bbfc122b7229dacfb0e9cb208857a48eab87b  # 12:02  G     11     0   11  22  rapidio: utilize new cdev_device_add helper function
> # first bad commit: [4cd8adb100107dc44e63615040ca2bde43de6167] rtc: utilize new cdev_device_add helper function
> git bisect good c65bbfc122b7229dacfb0e9cb208857a48eab87b  # 12:05  G     33     0   33  55  rapidio: utilize new cdev_device_add helper function
> # extra tests with CONFIG_DEBUG_INFO_REDUCED
> git bisect  bad 4cd8adb100107dc44e63615040ca2bde43de6167  # 12:16  B      0     7   18   0  rtc: utilize new cdev_device_add helper function
> # extra tests on HEAD of linux-devel/devel-catchup-201703170914
> git bisect  bad 472b8db0e353bce9af369f566db55ab626922906  # 12:16  B      0    33   47   0  0day head guard for 'devel-catchup-201703170914'
> # extra tests on tree/branch char-misc/char-misc-testing
> git bisect  bad 64d77f61c0c2fa6b1aa4820261943fc136a1b31e  # 12:26  B      0     7   29  11  auxdisplay: Add HD44780 Character LCD support
> # extra tests with first bad commit reverted
> git bisect good 44b1351793f770c1c1f10b827a70605b996a4f73  # 12:57  G     11     0   11  11  Revert "rtc: utilize new cdev_device_add helper function"
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/lkp                          Intel Corporation
> 

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
