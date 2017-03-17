Return-Path: <rtc-linux+bncBDJ4N37Q6EERB3OZVXDAKGQESCCUXFY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mga07.intel.com (mga07.intel.com. [134.134.136.100])
        by gmr-mx.google.com with ESMTPS id a3si1271460pfb.2.2017.03.16.21.58.20
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Mar 2017 21:58:20 -0700 (PDT)
Date: Fri, 17 Mar 2017 12:57:50 +0800
From: kernel test robot <fengguang.wu@intel.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: LKP <lkp@01.org>, linux-kernel@vger.kernel.org,
 rtc-linux@googlegroups.com,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, wfg@linux.intel.com
Subject: [rtc-linux] [rtc] 4cd8adb100:  WARNING: CPU: 0 PID: 1 at
 lib/kobject.c:690 kobject_put
Message-ID: <58cb6cce.GwD02K343UlZPrBA%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_58cb6cce.FHOf4g3vGnR3ov+JjvcdmWpVmBsrNUYso8j8n9piE+6aaOwt"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

This is a multi-part message in MIME format.

--=_58cb6cce.FHOf4g3vGnR3ov+JjvcdmWpVmBsrNUYso8j8n9piE+6aaOwt
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git char-misc-testing

commit 4cd8adb100107dc44e63615040ca2bde43de6167
Author:     Logan Gunthorpe <logang@deltatee.com>
AuthorDate: Mon Mar 6 00:04:30 2017 -0700
Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CommitDate: Fri Mar 17 09:20:18 2017 +0900

    rtc: utilize new cdev_device_add helper function
    
    Mostly straightforward, but we had to remove the rtc_dev_add/del_device
    functions as they split up the cdev_add and the device_add.
    
    Doing this also revealed that there was likely another subtle bug:
    seeing cdev_add was done after device_register, the cdev probably
    was not ready before device_add when the uevent occurs. This would
    race with userspace, if it tried to use the device directly after
    the uevent. This is fixed just by using the new helper function.
    
    Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
    Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

c65bbfc122  rapidio: utilize new cdev_device_add helper function
4cd8adb100  rtc: utilize new cdev_device_add helper function
64d77f61c0  auxdisplay: Add HD44780 Character LCD support
+-----------------------------------------------------+------------+------------+------------+
|                                                     | c65bbfc122 | 4cd8adb100 | 64d77f61c0 |
+-----------------------------------------------------+------------+------------+------------+
| boot_successes                                      | 4          | 0          | 0          |
| boot_failures                                       | 55         | 26         | 30         |
| WARNING:at_arch/x86/mm/dump_pagetables.c:#note_page | 55         | 22         | 24         |
| WARNING:at_lib/kobject.c:#kobject_put               | 0          | 26         | 30         |
| WARNING:at_lib/refcount.c:#refcount_sub_and_test    | 0          | 26         | 30         |
+-----------------------------------------------------+------------+------------+------------+

[    1.261325] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    1.263029] wistron_btns: System unknown
[    1.263411] usbcore: registered new interface driver yealink
[    1.264581] rtc-test rtc-test.0: rtc core: registered test as rtc0
[    1.265355] ------------[ cut here ]------------
[    1.265798] WARNING: CPU: 0 PID: 1 at lib/kobject.c:690 kobject_put+0x39/0x60
[    1.266539] kobject: '(null)' (cea81ab4): is not initialized, yet kobject_put() is being called.
[    1.267291] Modules linked in:
[    1.267562] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.11.0-rc2-00049-g4cd8adb #834
[    1.268236] Call Trace:
[    1.268453]  dump_stack+0x76/0xa9
[    1.268740]  __warn+0xdb/0x100
[    1.269005]  ? kobject_put+0x39/0x60
[    1.269318]  warn_slowpath_fmt+0x36/0x40
[    1.269653]  kobject_put+0x39/0x60
[    1.269948]  cdev_del+0x1d/0x20
[    1.270224]  cdev_device_del+0x14/0x20
[    1.270548]  rtc_device_unregister+0x2a/0x50
[    1.270913]  devm_rtc_device_release+0xa/0x10
[    1.271291]  release_nodes+0x1e4/0x210
[    1.271613]  devres_release_all+0x51/0x60
[    1.271962]  driver_probe_device+0x237/0x480
[    1.272332]  ? klist_next+0x1b/0xc0
[    1.272633]  ? acpi_driver_match_device+0x49/0x62
[    1.273034]  __device_attach_driver+0xe8/0x110
[    1.273418]  ? klist_next+0x9d/0xc0
[    1.273718]  ? __driver_attach+0xf0/0xf0
[    1.274053]  bus_for_each_drv+0x44/0x80
[    1.274389]  __device_attach+0x9d/0x140
[    1.274718]  ? __driver_attach+0xf0/0xf0
[    1.275054]  device_initial_probe+0xd/0x10
[    1.275409]  bus_probe_device+0x25/0x80
[    1.275738]  device_add+0x3fc/0x5c0
[    1.276038]  ? kobject_set_name_vargs+0x7f/0xa0
[    1.276428]  platform_device_add+0x1d9/0x250
[    1.276793]  test_init+0x52/0xa6
[    1.277085]  ? stk17ta8_rtc_driver_init+0x11/0x11
[    1.277504]  do_one_initcall+0x92/0x160
[    1.277844]  ? parameq+0x13/0x70
[    1.278138]  ? repair_env_string+0x12/0x51
[    1.278500]  ? parse_args+0x325/0x470
[    1.278826]  ? __usermodehelper_set_disable_depth+0x3e/0x50
[    1.279318]  kernel_init_freeable+0xfb/0x19a
[    1.279696]  ? do_early_param+0x7a/0x7a
[    1.280036]  ? rest_init+0x130/0x130
[    1.280359]  kernel_init+0xb/0x100
[    1.280665]  ? schedule_tail+0xc/0x60
[    1.280991]  ? rest_init+0x130/0x130
[    1.281314]  ret_from_fork+0x21/0x2c
[    1.281706] ---[ end trace e98f47d52e9cf212 ]---
[    1.282142] ------------[ cut here ]------------
[    1.282142] ------------[ cut here ]------------
[    1.282555] WARNING: CPU: 0 PID: 1 at lib/refcount.c:128 refcount_sub_and_test+0x55/0xa0
[    1.283396] refcount_t: underflow; use-after-free.
[    1.283829] Modules linked in:
[    1.284110] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.11.0-rc2-00049-g4cd8adb #834
[    1.284904] Call Trace:
[    1.285120]  dump_stack+0x76/0xa9
[    1.285412]  __warn+0xdb/0x100
[    1.285678]  ? refcount_sub_and_test+0x55/0xa0
[    1.286071]  warn_slowpath_fmt+0x36/0x40
[    1.286423]  refcount_sub_and_test+0x55/0xa0
[    1.286801]  refcount_dec_and_test+0xf/0x20
[    1.287177]  kobject_put+0x41/0x60
[    1.287480]  cdev_del+0x1d/0x20
[    1.287760]  cdev_device_del+0x14/0x20
[    1.288101]  rtc_device_unregister+0x2a/0x50
[    1.288474]  devm_rtc_device_release+0xa/0x10
[    1.288848]  release_nodes+0x1e4/0x210
[    1.289174]  devres_release_all+0x51/0x60
[    1.289518]  driver_probe_device+0x237/0x480
[    1.289898]  ? klist_next+0x1b/0xc0
[    1.290214]  ? acpi_driver_match_device+0x49/0x62
[    1.290628]  __device_attach_driver+0xe8/0x110
[    1.291021]  ? klist_next+0x9d/0xc0
[    1.291336]  ? __driver_attach+0xf0/0xf0
[    1.291684]  bus_for_each_drv+0x44/0x80
[    1.292024]  __device_attach+0x9d/0x140
[    1.292369]  ? __driver_attach+0xf0/0xf0
[    1.292717]  device_initial_probe+0xd/0x10
[    1.293086]  bus_probe_device+0x25/0x80
[    1.293421]  device_add+0x3fc/0x5c0
[    1.293722]  ? kobject_set_name_vargs+0x7f/0xa0
[    1.294129]  platform_device_add+0x1d9/0x250
[    1.294510]  test_init+0x52/0xa6
[    1.294799]  ? stk17ta8_rtc_driver_init+0x11/0x11
[    1.295217]  do_one_initcall+0x92/0x160
[    1.295559]  ? parameq+0x13/0x70
[    1.295859]  ? repair_env_string+0x12/0x51
[    1.296215]  ? parse_args+0x325/0x470
[    1.296532]  ? __usermodehelper_set_disable_depth+0x3e/0x50
[    1.297006]  kernel_init_freeable+0xfb/0x19a
[    1.297378]  ? do_early_param+0x7a/0x7a
[    1.297708]  ? rest_init+0x130/0x130
[    1.298030]  kernel_init+0xb/0x100
[    1.298342]  ? schedule_tail+0xc/0x60
[    1.298668]  ? rest_init+0x130/0x130
[    1.298987]  ret_from_fork+0x21/0x2c
[    1.299379] ---[ end trace e98f47d52e9cf213 ]---
[    1.299887] rtc-test rtc-test.0: rtc core: registered test as rtc1

                                                         # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start 472b8db0e353bce9af369f566db55ab626922906 4495c08e84729385774601b5146d51d9e5849f81 --
git bisect good 83f311c4f0a8a406485c034038d1eebb61467e06  # 10:15  G     11     0   11  11  Merge 'pm/linux-next' into devel-catchup-201703170914
git bisect good dba0cafd19396fe23ef3688ce9f18e9a6cf12d11  # 10:28  G     11     0   11  11  Merge 'linux-review/Michael-Davidson/crypto-x86-aesni-fix-token-pasting-for-clang/20170317-082713' into devel-catchup-201703170914
git bisect  bad 533e610f1350246901b978d58268816bbbedee83  # 10:42  B      0    11   22   0  Merge 'linux-review/John-Keeping/Bluetooth-hci_bcm-Fix-clock-un-prepare/20170317-081003' into devel-catchup-201703170914
git bisect  bad a44dae33e154bb3727f7758ffe858a69c42e8ecb  # 10:57  B      0    11   22   0  Merge 'char-misc/char-misc-testing' into devel-catchup-201703170914
git bisect good def32a359b666d8d577e4c5884e0918f7ff5ba2e  # 11:09  G     11     0   11  11  docs: Update VME documentation to include kerneldoc comments
git bisect good f51de2acbb7facde8fb855c73fb9edd60cf3055e  # 11:20  G     11     0   11  11  platform/chrome: cros_ec_dev - utilize new cdev_device_add helper function
git bisect  bad 4cd8adb100107dc44e63615040ca2bde43de6167  # 11:29  B      0    11   32  10  rtc: utilize new cdev_device_add helper function
git bisect good dafa63cd90cd13262cb995a27c3c79eb3fda4655  # 11:49  G     11     0   11  11  iio:core: utilize new cdev_device_add helper function
git bisect good cb7e71b95d29c72d1f8a2a2a0a34328bde10c3d8  # 11:56  G     11     0   11  22  mtd: utilize new cdev_device_add helper function
git bisect good c65bbfc122b7229dacfb0e9cb208857a48eab87b  # 12:02  G     11     0   11  22  rapidio: utilize new cdev_device_add helper function
# first bad commit: [4cd8adb100107dc44e63615040ca2bde43de6167] rtc: utilize new cdev_device_add helper function
git bisect good c65bbfc122b7229dacfb0e9cb208857a48eab87b  # 12:05  G     33     0   33  55  rapidio: utilize new cdev_device_add helper function
# extra tests with CONFIG_DEBUG_INFO_REDUCED
git bisect  bad 4cd8adb100107dc44e63615040ca2bde43de6167  # 12:16  B      0     7   18   0  rtc: utilize new cdev_device_add helper function
# extra tests on HEAD of linux-devel/devel-catchup-201703170914
git bisect  bad 472b8db0e353bce9af369f566db55ab626922906  # 12:16  B      0    33   47   0  0day head guard for 'devel-catchup-201703170914'
# extra tests on tree/branch char-misc/char-misc-testing
git bisect  bad 64d77f61c0c2fa6b1aa4820261943fc136a1b31e  # 12:26  B      0     7   29  11  auxdisplay: Add HD44780 Character LCD support
# extra tests with first bad commit reverted
git bisect good 44b1351793f770c1c1f10b827a70605b996a4f73  # 12:57  G     11     0   11  11  Revert "rtc: utilize new cdev_device_add helper function"

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--=_58cb6cce.FHOf4g3vGnR3ov+JjvcdmWpVmBsrNUYso8j8n9piE+6aaOwt
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-openwrt-lkp-hsw01-50:20170317112831:i386-randconfig-i0-201711:4.11.0-rc2-00049-g4cd8adb:834.gz"

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
aOfrazXiP335z45Hf5xfdu5hjBN513XdfpJvJJVxwFF8wbib25/fA+UwQrNxHuzV8cu7fx/9
R/ebo0Bkxb+dBjwmQl2/uR67eKtjWn+47Tz3rNPq+uZ87EvvvOy87nH900/rzfWznSdV1tYl
fOP9U/yUSl4p8+4PG09op+AohlSyaS/TbZ2sR2nvbz7k4EyrfNc3j+47Ha9fr+++Tfr6m9en
/amPAy5HXTtc35ecdFOPyzvv/h3ECGXtZ/FriRFGMtq83P56N19/9acvvvr86c7V1fzuR/vW
gvXz3fbONl7tnq+Wdz8X+Zvn9xO7/GsPx7h9Sf2H25fkd4Dqu+/DYn5067bwP8/86Gra8wLG
i/v2u0+++8u3Tz8774v32s/g+3sEH6q+9hXh0z9+8uc/fH703b998/nTcRJ55/vbiTF7vv/H
zz/503d/fPqHy8v7dxjD2m5i31e/+fPn337+1Xc7ZtftLjzgi999/ukfv/r6T1//4d+e/un8
UV807wFi2Pfmd27693/505+OPvv82y/+8NXTnZioo7Ty8Ec3UOavj3KyB3/9q6//9jTtfrnl
BzyCTz/55pNPv/ju36av5hje6Sbe/dWjP33+18//9PSrMZvo5Q5Iqw8wvDF/8+i7r48+//Kb
jvTJX//wdAy6u0cpazeDh6KsL2I8iBmkurHr/1MNpbrTJ9zo4fhmnaK5S9ial3e6uvn3fvn1
Z5//acu+70aESOxrLusVfwvzyVd/+f0nn373lz9//uduiRdvft5BSP4Br/Hbz//8xSf9Sv7y
5e86hJnw2YFt9UEE+fKbp/6tToujNPcB9/PXr//03Se3JhnCzptII1dwkD+fHXJy647lQ75v
r5hpO3DyYcFFcq290xE/NLhI23IW65LfuWqmUobfuLk+Gc3qnp9fdBsdY2Z32+h3qXv+bFsI
PkZ+tvB4nZf3x/+4R6muYAvxFRJnkhqzSX3KcTl+fnayHEM38b6eldaJ2X+Ff9tP3D0eo+NG
qU9fQ1L+uUNdvno1ru4vF7eF7qMx7DbuOz/dXsD9VztHf91Xx/jKeki56uuTn053X1H223Oh
x6c/HvfPnrz46bSrnL999t1uffcndz/cjArvl2ebbSVkv87Xb27Wbge3nS53ls7se3QYEHgn
Tfx4bS90+ebm6bZ10Og489PxL+Mv3G93UPJYQH/qr+KqP/Dwrsv72/jhZvz0oOvrCiMj8mh1
dXx6enW2nWvTV8LN8cu1Z94Yh7JT5t+/vlZ99Oeel59/PvTLaS2++WmkCU8vv+/C9m4M8d/e
/tXo6XZ5fzxi86qHJ90KxvibV+cXl1dPXVg2H55dXT195PJ9z6WOnUZWS2If3w3OuvvUXXem
0Xj76vJZFz+/jMFA190b7CB37I48Dn2tKNPLHH97dHE5miaPrtPjT9vmUHevd/2r18cX5yf9
5+9+17mNcqCtqT96teb273zSk512Rst9E5bsy1opA985vzy5ebk24kp9KVj/tDa4yY+W/MiH
395bxNgzOH31qH//7OV/76x5cXzzuNvNDv66VgD+GLz55G2HqJt+n2c3Oxfo3g4UGQh123zz
cnP+u993u13X350tkP6BNVDaKX/3mw+dz7r8vQb/jvL37Lsg7S77xfnp1fFP40J/2vzxi8/u
plvfkmZUbP+P86vzzf+87JR4mxQbJcr+wGMJ09mXDlBH5Pjq8vrmfgryh/dvOLi14fXJ1eX1
0dnJ0cvXQ6bteLlt39fHO5/PY1v5rQX/rzdnb84efXN8frUt0F6PFqxHOb767ncf3fervQfw
bmwmXHajHn1l72alfvXlF7fNzd52TNv5pT7WB8xkvo8M+jdqecA32v0XghsFWf/q05iK0EOe
zV/ftiD1O5+KQwe9PDt58vL44uxoy9HbFrX9bx+fvGMm9/q9ErbtXmOP9z7/dLR9Gn5y/U1P
Nn99PFpL5Xq92kFf4tMjvyzh9kJuP//N1eX/tT3DdnxPhjCyOP+4/Ui/1e0wog0Nobl8vs7h
3rYZvv5o49z/3Bk/tAKV+IAhO27nWaRlbMLtbWFbdr4RRxT7tiPt6cXYIrq+fPnjOzus9c+v
B+p6MPfq+OKoL1tPNr97/Mnj7x5/2f/3q8fbheyk/87uR8poiDyWlx6CPDt/OXr2vmV/+i2c
xMh9CRucHNN911myYwtz/ed2+kbHWnY4UsKo33r76b9+/udvv/j6q77uuyUti9sx7m1V+vJP
/nOPtz0//h7x8lhh/xms+7lyA6+FoYcu3rx61l9hN7Ivv9m2BV3ju9FyOu2wuK1FNPcf/uLr
R+vz/M/L27c/ZsPE+6/E/stue+feHWT74uv1JTx+9z8731zj3NtP919BP09DCq0Dnt8u6P95
zGShhzZSvX770fHp/k8PlF/8cj0m1G/R1xhw5wvOD+czfeGzs5fn6xDo77rlP9nsfjinCB/+
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
0+45Z5JLsvcLE+RMZiy2+yIOyyfImcxYbPdjdIjCMu2ecya5Numjk2n3nDPJTewzJciZzFhk
92XsuqscgGn3nDMpfSVS7zGbds85k+IWjWXaPedM+upod5FJkDOZsShnUrxoU5znRMc0bpIT
HcUnexszz4mOGYosooTFPr6X50THDMUGEaI9tS9DomMeQsoGEardwi9DomPGYoOIot1RhkTH
jEWOsMRqn+jMkOiYscgRliQaKGdIdMxY5AjH6T3T6DMkOmYscoQle3vDPUOiY8YiR1hysYNo
GJkLWGz1xdsnv2FiLmCx2RfR0wkG5gIW2311dk00zMudsTjRUWqykyYwLhew2O5H83eFZdo9
JzrG2qj46E2750RHac3uCJQh0TFjkd3XJdoBeYZEx4xFdl+XZovHDImOGYvsvpuEvXBkSHTM
WGT34zygxDLtnhMd1Qd7szBDomPGIruvXvucYNo9JzpqEO2YMyQ6Ziyy+xqKHeRkSHTMWGT3
o5upWjuCafec6KgjS66wTLvnREdNzu7qkCHRMWOx3ScRfGVIdMxYbPd5kWttMO2eEx21qzTl
74Np95zoqLnZm5gZEh0zFtt9DyjUdUXT7jnRUYuOc6Jp95zoqPVdM2N3sEy750RHrWJXLkOi
Y8Ziu2+ia0iGRMeMxXbfqvT30bR7TnS0pdnn2zIkOmYssvvmooxNomn3nOhoTrT6zJDomLHI
7psPMp6Ipt1zoqNbhF10lyHRMWFxoqMF0fMgQ6JjxiK7b6ojUIZEx4xFdt+iszcCMiQ6Ziyy
+xazvZmWIdExY5HdN9XpI0OiY8Ziu08iuZoh0TFjsd3nxT6HkSHRMWOx3WeRzMmQ6Jix2O6z
KHjMkOiYsdjuh+gTWNm0e050tNLsbl8ZEh0zFtt91foxm3bPiY42hsoqLNPuOdHRWrATHWXO
ThSdnWjjeQmoZkLhW3Tj+KRpXQWyExMWZSfcOConsZyJhW/RLU4cxSiQnZix0Ht1rGz3dSqQ
nZix0Hu5xS92WUGB7MSMhd6rYyVbwRTITsxY6L3cqGU2vVeB7MSMhd7LLSHaqegC2YkZC71X
x2p2FqBAdmLGQrN3XdTaXqJAdmLGYruPojdagezEhEXZCbck0c+sQHZixmK7T9U+DlAgOzFj
sd1nMaywQHZixmK7z8Uuby+QnZix2O6Lkxzypt1TdqJjicGtBbITMxbbfV3s7YkC2YkZi+2+
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
nl9evTq+Oe+/9uLyZnP843hqz16ePb7/dM3jaMfvr87Ozi++37y56Fd+eneNr85eXV798mTj
umTZeaZ1LXT429V5f1Svry5v+r2N7968OLv74s3Zz/15Nl/jD/df65o46K9d9Uf16PLi5S+b
0+Ob4yebmGu9B3D9sXf7/+pfH73729vvNBen76wEfLTzz983J29uNi/Ors42/9j9+/vvbDc+
//bJn7/64qs/PNl8+s1fnvSn/c0Xn/UnsTnuj/Hq5MXHP9f88atXH5++efX66PXx92c347le
Pz554kMaD/ts/dv/svzsFvfx8nMNy84vWM9ObxGebH4/Xl9/V91GupVt/vZf/nXz6vj163F3
45ednnbTu96cLMtx93RLx7r7z3tA7wdlvrw8fdOvYZjUD2cD8cnOJ+KQsPOtfHo5fv31T/2X
nV19vGy+Oz6/uDnrNv2Hze0/f7v9d3zs3OPl0dWJf9R/b2yPvo8np/X49NnmP9cQd37Leubl
0+OXLzffXR2fnO1cQFgG2zbr87q+OT75oT+akvvdHLedD60F65ujo5+Ory76B06ffTwe4M6d
hjgOqW3+275HHNY2opuBc3T98vKn18c3L46ev7rpnw7jt8bdz7bROm0fYnTjfOLm9c16Cz8d
v/zh6PX3p0cvz348e3l0cnm1fu1Z6l/zJ7tfW9dz62svzk5++Onn8c3x+/zu99apA90Srn44
uroctt3/9fbKnNv9aBvJpv5MroajPL84H3fZH/jH6//efy75QfVbutx9zgd8xCmOPg0d7rpf
3rCoo5vuNvpHT/on8+4Hc3EP+r11TDHqn7o5en51+eqoO6Xx9v16yyf3n8tuhIsrRc86I26G
BW3OWn0ey2nyZ+3kue9O8B8TV/MaSd9R6dPxPLvp73DouhPsky/+9PlnH21aXn8wXvGt03z8
QXclJ93iP728uL58ebY5v94cv+ze/O7vH3ULujl5cXr5/ebR/d+9vjobd7u5vw7f0jY6vTi9
7Nfx6oebs1evn3R3Oj533iH/o1/Vm+2PVze3+TBvnv3Sl5j1T/crS3C3I5/+aSCft3nzXwv0
zep2hn/9+/N/dKP5ZTOWqxf9tv9+1t3E1T82N5eb9b/WBfL6+PnZ5tXl6dnuF90/Ptr83Y//
6ZdyebX5ezSRrs9edpe+fu307Nmb7zcrQ7a3kx4v0a/GcfVq82Hn62836zL1fb/SsUpvVofS
v/f65sWTzZhBd3snL8+e33zwqr/pda34uC+YH19dXt5sUfPjJS1rj/KO87rjpqBxU2Tc/mTv
4N1Y3T9+dXGzPo/hR7/qt/Xm5MXtQv3Bqx97jHF88S83/QlfHL862/zL+PTH179cv3n9/dXx
6dnjm+//41/uv/a8o4yndnp+tYYPv3zw5vZ3blG2f1p/5ZPNFxc/9pd62hen79+86o/1/h5z
HhmS6xfjyXl9h6Hl3Tt8a/Bnx1d9UX6kWfHm2Zvr3T/fUuSbl2fH12PFH1bx+Wov/XUf9+X7
x34J/YV3zp1s6XcblpTHeemy1t9b74A+1cYbmQUd59aN/vM46fZs7j+Lk2+PF/2zOMXt+ptf
j1PLVqL/szjNbXcC/gkcVx8Hn9YzNteXJz88GUHiyTCa//PmauD88uhVD1D+ZfjoN9eDcJfP
htF0G7o+uxnfuHx9s/n266PfffvZp19/+c0n362ofnncoyM3fOEdXo/vlrr58A71ZPltD7SG
e+zBz+Z4883X337xr5ub81fdUjs3T0Y089OLwcVPv/7q91/84Wj9wNF3X3z5+Z+/HVczQut+
CW9/XcjrDMC//v7bJ5u/9QCkX2sXMW9/293Vvzwd7Lv58Leb8Sseb/58NgTI+D2/XL652jw7
vzi++uXxPWpZG9l21fB6Qvuw345LK6+vB5G7rzgeN3J11j95NHzIGtRc999zezePN9+enW0+
uzxZHcUqDz7+8dXH+IXHNz/f3P/6uKyHb97TTd06iS8u+ocv+ip/efri5PXpkyfnt3/hNtfd
f/SXcXJ13D3Xy8vL15u8/cNZ12T9xx334rSLrvPx9ZfH3ZWtPyXkNy9ubg5AXh6OfHpx/er4
+t/fB/R4yNk/jrFt26edvHnU/f1NlwNPNlc3J93h+3KSTuqy+fHsaoTuN89fno1I/mpIHjf+
9Xz7x9t/vXp2++O3//7h7j+u7v7j9qPPxr/GCuI2z46vrs7HL+gh3JNlc/Lseb+Hfsvu7QWO
aRcOLvDPncGdKt+cv+5/2PiORv+38/22HmB5x/d/N5aUDrC8C+IewIW16mEXYIjXR7972T3A
5tPz/pOXq0mvUNa11G7RLa2nmd6vRT/qC+2bm9PLny52l8Krs2c97NjGi12SPu6PIY39yb9c
XJ19f3491sTXP/ZvHl914m5Vdw9QrzYnr99sL3j9klu2icbde//LxV2Ufjro3b3Y/QWcng2V
fHa6AxBHUfvF5eb8+c9rsPZquxCf/df7z3SJNd7QesXj5fSbv1rjmy38zgfzuiVx+8FXxycv
zi/OVi3Qv/DBB5+/PH49Qo3hSLsJdcHywQ8/vnr64Qe/+fezV28ebdEe9cj9KMcPfvOoR0Rd
QD/qH+l/GPf9x+Prn85evvzov1y/Onvd/+5W5X/8+ofvP+4K983PH5+Hmh+NRaWz6vn594/O
l0d+GSvjx9+fnDyKj+vHtyq1P7geVp+exHiWQ1/Ll7icHPtnp2cxnJ6NNbm7vwH5H49Modsv
YBjG1enm48vr81fdP358+frs4qerm7t/P7oznXFZj0++/4/+lVcbn3L/9/Wr151Ev3m0DQQ3
Z+NNfnRxdtP//LT/a+k/2v5pePGrj85P7/52NZvLq86Ppxcn41OXj7YPvP/32xjsPIdlObt+
tvN3j8ZrvbzYhtL977sT6ey+PnvaWXL8cryS/pevz0/XEHONi69fvPr4h4H8cf/rR3f39PKH
149eXP+0uEdpXE6/uL6ar4HpE/jWu77x8fbzv+KLP7y6Hpd9ety5cNGjh/Hf59evXx7/0q33
Yvxx/H1nwebizcuXH/z2gw9GEuPidJjXiPCfbmP941f9ql+8ufi+S9jrLryPL85PnvYXcftY
jl/3P97+d7fHq38/On750/Ev10dbYzztWCdvXnftffa4/8dRt8qRunj58mg8wMs3N0+Hbv5N
f1WPz5+PgP76af/j624GNz887r9/3MTTy4v+V+vvfdR/8fXl85vhqN68vr+Yi1fnR3fv7en6
tx/8pi8d13f//fLy+PSo38rIgD714xd0/3Pz9m/6rzy9enb6+NX5xeXV0cmQBE/rej+dX6eP
X15+v002PD27uvrgN+ff90+dHfW/3eqr36yh/faan97c/PLt8pFbEwUf/OY2KLf/tv/px++P
n16MHGNHuvqpX+v5xQ9P+4t9c/7y9NGaQP346s3Fo39/c/bm7OPObcHZldODIWcvn6z/++hk
PJQ3r9cPdGFclubik4dS+smz85F0fbSFdenjx285/kCEt7+3R4851EfOPXk3LZ71+zl58XTn
Bj62b+CD3/zu66+/O/riy0/+8PnT/9+c2TsspnPoP/1v/3d/R3//7//4f/7T5tGWUJv+d9v/
+vv/3v/6g/8XO+UEKV8WBAA=

--=_58cb6cce.FHOf4g3vGnR3ov+JjvcdmWpVmBsrNUYso8j8n9piE+6aaOwt
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-quantal-lkp-hsw01-15:20170317120150:i386-randconfig-i0-201711:4.11.0-rc2-00048-gc65bbfc:841.gz"

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
UEFvQhKpiYRTExmsAJNKpCYSTk2kOIHaHRKpiYRTE6n1XrE9FJGaSDg1kaLzwKkQqYmEUxOp
9SqwX4BIzCKcmEXRe2A5isQswolZDJbtRockErMIJ2ZRK3q1X4BIzCKcmEUxTnZXHhKJWYQT
sxgsgfCNSMwinJhFkRzY0UViFuHELAZLwHcSiVmEE7MoJmfnOZJISyGclsJgoHUxibQUwmkp
1HJgMVg1wbRooJw9EmkphNNSKPK2aQutSEshnJbCYJTxnXkTTItGnez0JxJpKYTTUqi5m/YL
EIfyhA/lqR1w2o8pDuUJH8ozGIi6kziUJ3woT+TAgHoSh/KED+UZLNrHayQO5QkfyhOhomMS
h/KED+WJ/WpgIIsjSdpyJNkcAZsB4kiSthxJNgPNVtviSJK2HElS6/0BwbwJpl9AzHaFDIkj
SdpyJMlvAJih4kCGthzIEIGkSRIHMrTlQIaSBx6KOJChLQcylEBxO4kDGdpyIEPZ2WuWRDg6
bQlH85LZlmMS4ei0JRxNxdnmQRLh6LQlHE0l2XtAEsG4tCUYRxVMakkiGJe2BOOoJlvTJhGK
uLsXE4y3YGEgr/1KRhCPL95dni1uFrNPffS1f+31wWzq6LdXi+s/r65dJqi8PTmcnV/MTq5O
f1tcz64vF8enb04XJ7Mns9vrBf/22fEfZwdvF/OTg+vF8c3F1fXs4nz26+LqfHHWvuzd/Pxk
dnZ6vljhetdwP//m+59mL778kr/5+PTs9OaP2W/TU5dmfprik/9xe/7EU7uvk8Vvp8f8xW8u
bs9P1jCoZZW0y0/P31xcvZvfnPLXnl/czOa/tVV7fbZ4uvp0mx78z9lXV4vF6fkvs9tzvvOT
+3t8t3h3cfXH4czlVNbWNFI7sPnb1Skv1eXVxQ0/W7v25u3i/sKbxe+8ntWX+OvqspY6gC+7
4qV6cnF+9sfsZH4zP5y1Oq51gN7w/+W/Pdl89fKa6uL6NW3C2j9nT9b++8fs+PZm9nZxtZj9
c/3na9eEdoz9t+c/vvzm5deHsy9++JmXYPbDN1+2P+a8jFfHbz/7vaTP3r377OT23eXR5fyX
xU1b1+unx4c+UFvsRf/pf5t+d5P7bPq9hGntC3rRyhLhcPZVe338rlhGWMpmf/tv/zZ7N7+8
bE/XvuzkhEXvenY8TfOJ/2Os+7+uAHNotv53Fye3fA9NpH5dNMTDtU9QO8oaH+WLi/b11+/5
yxZXn02zlywiN/PT8xu+OD517un05OrYP+FviuXJL8eJXr9+czz7LyW6NdzeLfKL+dnZ7NXV
/Hix9pXFtSPfWV+h65v58a+8GDnx/c/r2od6ee/s6Oj9/OqcP3Dy+rO2ZGvPVqidts/+r22L
WnKblTNrOEfXZxfvL+c3b4/evLvhT4f2rXH9s71j6TZEFqX2qcub/gjv52e/Hl3+cnJ0tvht
cXZ0fHHVL3tNfJk/Xr+st8CwLnu7OP71/e/tyvZ9fv26vovxu7/69ejqokkz//FwZ86tf7Sn
tPGaXDXVeHp+2p7ShSYcbu0Jckuk488tCXL/OR/EEucptCNwhrvm22sydMRicMYfPeZPpvUP
9mY5O3xvP+3nT90cvbm6eHfEaqi9fd8f+Xj1uWUIu5NywRy4aRI0c/OYQohvYnjzxlXvO03X
rqHWRuKePF+09WR5XWPNNVPq+TffvvjyYFZT/0V7xXdqcqX52JpZlvScn1wwUHuYQ9Z/7c/T
+dnpfzDo7fKXXS/NPnV+9voP3hT6P1d7QVkOTnh7cX1zPn/Hm4cL+c+zrkZ/4U+2XWTWxZ/1
9eXN28MZC0i5QzpbvLlZAbneXpOV23EjvJt92u7lz6wEbhbvLhsp57Mfvv/pm3+b3Zy+W1zN
rv+4Pm68e//29Gwx++L7l1998/VR/8DRq2++e/HjT7PT6672rxdrX5J765i374/PLviWPnVx
wjebS9x4s7WnT1+e/fHu4vbmbVue6Lcgkd+EVMk3S+SWcc5vGIa23ZDfeEO13k2/XL7Om6u2
eH/gNxo3vdDEQpnXkPp98Tp/iHAkn6mFW5fC9RWTii+8uZgd90djFfEH2wps2fDe0dT92cUv
v7Q/mS6z/3XxeoVSem7nEuUVC8PF1fzqjwdJub6cvz+fLa6uLq4OWYnPrm+P387eNKFgnJPT
q257/PGAFlph1qPvKZTcpiV8pHtqs8kev05pObj6Y91ToFa989h7ir6NkfxI98TC31T19VuW
uJy2EMVt4htvy/F+qY9vzhinVIzjN6qrxGZ68o9enppq2yo+0vKwMdK00mPvqfbE+I9zT7wH
12YPPO6e8sSc/WhilKfYhxg/9p6WA1M+0j21o4xHq4DWxCCkj3dP1A3rB674ibZwJaQNXMn8
ZCsZuN8zn/AzsM1yev5wd4wf/8zO09W70/N52/Dfn968bd9wc8v2wAqt9lGaj12p2pXlLXuR
J/9oSQ6H7Zuuulf12+LqujmNLtPD53lX/HhMzd734WGPfIaWhvXRNsbs21n34++JDYiPd09s
73Y76+L94uro+vaShWcZD5kfs0HCLsX5zdpnuwm0+bM/fP+3Fz8e/fTzDz98+/ejl8+/e/Hs
7lery0tp5XWbL+fbv5x9//Lbb16+eLaSRKqu+fT6ktfNaG2hA3mLNYaN3/FwgXGfd79/AErL
DnwAqN/xT6+ev/r5p2dfnrJnM79q72sNoeYdEL74y/Mfv35x9OrvP7x49tX8evUoyaW88c2M
1//lxfNvX/3l2dcXFyerS/3UbIJtl/7w44ufXrx8tbberF+aj7jtwlcvvvjLy++//f7rvz/7
9vQJE3kFECaH13/9ob/6+dtvj7588dM3X798tuYwMkofUbAHiri8eCw165e//P5vz2jtYup1
AVsvfv7D8y++efX34dJlvsiulx59++KvL7599rKF0M5WINm7HW6+eWBHr74/evHdD4z0/K9f
P+OdZO1WmG1ud5T+ItpCjCA17CLB333/5Ytvl1R61XYsRaWaW1LUVpjnL3/+6vkXr37+8cWP
LFbnt78/ILDmTDss7E8vfvzmOd/Jz999zhBmhGkFy8K+w4294jV+5tPaZb2wdNtlf/3+21fP
7+QrhLVlbX14/Kbrb69fK4WWo6eN4tA/bCgz/t0aQJo23m0HGNXu3V4d6J/LAPhyf1r8vji+
5Q3qXz67fn16/tm7ixO+6vXiX+QPZk9e/za7PD49/K0FD8tU0kn7CzPzxXX/kXv+Vbxe/ox/
+Pp48tfH03Q6Tf+Cdqr7m8of86Y8Pf/cuKlyfVx2vSnvPvym5seXp4ffvvy3n/7+06vvDnda
Av8RlsD5EO8e1zljCcI+7+URS6DfC5uMk3FTiW/K7XpT08e9KWfdlOs3VXa7qfhRacWMACu1
6+uLj1ipLsH/88V3PzdC7STB8THCcja/acdNh1+d/s6Xf/flN9/PXt9e7/S19fE0/eFvP37+
cqeHpMcuaVcKn//8027f9gil0L/th5c/sHyH3b7sMSJ8//7u//LkzdX83eL17Zs3i6udvvwx
29LDlx9fX/6629d9FN2+82t8xPa2/2t8LB/alz3f8cvY9nv8l30xfbXbk6VHftnzL374ptks
d49Iuz3iYxm/zyOmx8rlXl/2MbTLzi/vEZJyvbg6vTi8+WNyl1e8+fF2uPh9tx0wPUKnnZ5f
3t4cvm47b9uK3WX7n8Xzz6N7spgO3EE8cO7AxYNfszvI/iCHgxwPMh3kdJDzQa4H+flB/vwg
f3GQvzzILw7yVwdlOihfHJQXB+Wrg/r5Qf3ioH55UF8c1K8OnoeD5/HgOR08TwfPvzh4/uXB
5/ng83LweT34sh688AesT+PBWftif3D95v1Oa17+v5Smx7KTVWpLMdjpuz6GQn0+pZ2+LH8M
BbDrl6WPo713/LJHbLr7vrL8WM22ly2aPobk77iM7P5/hC+L07Tbl32MHYImt9My1o8hjWGb
LXEXzSjEZllenZ2/mV/f9Ej47OTifPHw/I+V2XZLX7mdzJswfYwdcsfFDtMj9qqHL/t8VzH6
GIZb3vZl92+2UMwbg3H6III/mwI99iCloVT3sQ5SSklpc6Bup8ORUlru016HI3xJ3Bye3bRi
OUdzdXe4u2VL573urtDmo4RNd1fK9Ji7W05/2+Pu6uSngk9IxlusrKK2xPZ3O1iqU2zRqUcc
LDFCybufjqiDpTql5iZ9yMESX1rCDudD6mCpsh7I02MZ21q3ho+WpFBZAtIOp2TmYVedaom7
nPfAw656N139Aw+7qnOOdjjp2XjYxRfnXd7nhsMuppyvO6wePOyqbSTExqOQfQ67qgt90PGj
DruqW6asPPKwi2F6s+gPP+xqpQ6bj8kfddhVXQplh1MrcdhVW2bJDhJiHXZVl3Pd5wS/utKr
nR6vaF2pmw2KnRVt6xC3+zmyVrR+8rschm9StH7KZYdLtaL1Lux0fGwqNQaIj7atGkqtH01T
+xB2UlNY0fo4ud0TMpSi9XEfaRCKlt2W+mFZBXxpph3kGCtan+L0eEXLGnKzFbnh5Lp/eOPu
uOPJdQOgjWu24eT64Zri6q5n6/3D9tH4LndYen3BnncY4h53GOJGNbD7HYa4kTngDqPL0w5m
Dd5OG8gu++CW7ZRh3C67sr2dNoQd9r19t9MGu1Om1Lid8mV+B2vN3E6jK1v0iJCgdgH+wh23
0wa0Sw6OvZ02hMdsp5FV6A5rt2k7bZd+0HYal+0GP3w7ZYA9N51NW1dD2WUPMLaudvkOHNi8
dbWLP9BH4Et3kXa8dTWQPax7Y+tqKB9Bqe1kDG9XajXssCxQqdUtaa4fqNR6cvv+Sq2GHYht
KrVWptdy6i9nn7Khty0BflPRSet/HR5dc8Qovbflx7Ba49Opdcx/5D11lEIfKUrJaM658MgU
9I7y0YpFGtpyovVdgeTJ4rcnb+ZnZ6/5rT/55Wp++fb0+FqUMYTo7DIGn1fIeaqPLEPpKKl8
pDIURgtUVlLRouvX8zcL+XzB/3n26+lZu9/XfzDffvxudn36y/m9VmSYSGl6qG84X9y8v7j6
td28AKKwrd6DsXKp8fHLlGtyH6l+g9GKi4+tIGoovjdc+lj3RCk9si6moaTeh+5j3VPtI6cf
eU9sHdFHqilpaMvpHo+9J76lx8vTv943jLi+uT6cfX5xcTP7/l//k/XjV8uq3tlv7mm8vFrM
Zl/Of1vM/sfFOe83/8cJ//1//ferxcnb+c3T44t3/+cn/2if/ufsu/mSe/cF078sbo6uLl7f
8g54dso72KfBMZ/n120RXi/uHn1x8vSTLxl4djm/uu69GK5+uX3Hpvv100/uARvYHeh1u35x
fnfh3Rd/+bCID59q1f2tkvv64WuaBllvBjK7uGwNO67X754/tfXmTxbz45vT35oeebiBF8sb
mgWaHm7h6d1t8Y/d6oeffPn85dcvfjyc/fjzy9b2Yvb8p9mP33//6uknP5+ftff5x8UtL8Fi
dnV7ft6eiNXYfPbb6dXN7fyMn+r4Ld/6wezm7ek1P83t2cnseN6aoPS8H9Zm7ejxbPHueikH
fLsXvy2u3l+d9nKzL777/qdPWCyuT9+dns2vWkU7f2gJc3lxw4t+yjf5B3/Nr4vlV9x94ez2
/DXLRnuarjsvbm/4rt6cXr173+91cb24efrJJ8c3V2dPjmfnF+/5goenYXFvoL+2H79nmXl4
xJMLvqllowC3VCv+oaTw5uaPKJV4pi1KvKOkHpuxUBbnJ4uTg3bHjTf3blm/sPaDuocLSX19
3uHra0s+tFHsr6+B/PrXe/X1ZZevj2tFcRoFfH1LKVi7MMivL9MuX8/uWbRRwNfXurLu+MKk
vt5v/3p29SiQjaK//s3F5eIcqc0vGjfO/+Vm2X3g8vTk6N3891nrtdFR7/n/c9dc979+NuOd
LZX7X97p2PdN8d11fbk4X9aA3l4+nf2N7ZsZGzUXzIg3Z/Nf+FNve/ObBeu99rV/zDq77tB+
ate1FZjfHL89ufjl/ukOWreZ1onC5RI/+Ud78KbT+PFv3vab51/Nz05/az2Jlr/8aXFzfXH8
K6vBTx2bi7MynbA3Ms0yv2m+wTcnszz7hzvk//vn5ktOHi6J91eU2T/KYTxkH2TnS9zE3+L5
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
6eLkk9l/XTYpa+EDVqftu+5vobAN0Jzgn8+vFr+cXvMdzy5/m12/nV/xl79bvGPWdS4fX96u
7psvKn7Hi6bVRSyoQeikn8+vj98uTm7Plo0bbxbvGOb25qTFjk8WN53HawDU/JXzi9npm99b
CJU/vQye/O+rz+TQTJOrRWt32JRmf9q7zpIMv/ZBam0G7z943yfxfnk+eXE2v2wvoMWhD5s0
fPLrb++effrJn/598e72yRLsye8lHaX4yZ+eLBtaPuGP8D/aY/Pf+i9+XfaO++zy118+O2ut
rz87DSU9aXP/ji/O35z+8uR0esICm5377Jfj4yfxafnsrps122evs/f1ZH785vW0qMev/VQK
5Xksi/nrkl9/9tu7BvkfT+yG2H960qT26mT22cX16bv5L4vP/v12fn4zP7v/88nxxdXiSbun
p8e//Ad//t2MnOc/r99dztqfLJKnx6xUHSMfnC9u+N/P+I+Jf7X8V5PTq4PTk/uftvVkrc17
1bPzdgPnF0+Wi8x/f+h5d5rCNC2uX6/97El7lRfttb++/YV/zht6Pxx61jV9ew38w8vTk74r
tIOXz67fvvvs14b8Gf/4yf0Dnf16+eTt9fvJPXHUnmNxdTo/63vJobhq0xWfLT//ARf++u66
3fbJnOX//PQ/2t3ytnh5Nv+DJfa8/bP9nCV/dn57dvbJnz/5ZH55yTZOk6krRn3Wv+Rq/o4X
8e3t+S9HN/PrX48u5+enx8/cJ3+6W5b5Jf/z7u8shFf/fjQ/ez//4/rorqUqYx3fXp6wznjK
fzliUTxigT47O2oLyHqrt9P/E7+qp6dv+tHTM/7n5dXp+c2vT/n720M8uzjnH/XvfcJffH3x
5qaplNvL1c2cvzs9un9vz/pPP/nTxcXl9f3fzy7mJ0f8KLwAvz7z7Qsu3l3ePPyEv/Lk6vXJ
U1aOF1dHx01LPSv9eZhUJ7y1/3J0tvhtcfaM9/tP/rRsrXjEP+0//ORPi/nV2R/Le37GW8RP
04Fz5NtzMaWuL84W9k/5X7/9Mn92vuzM/6er93yvp+e/PuMXe3t6dvKk99FtWpTFaXG7+Ixp
DAjbCd0Ysjg77P/75Lgtyu1l/8AUWttuFw935fPh69Nr1nhPlrAsUk/vCb4rwsP3sm8zhfSk
HG5mxWt+nOO3z9bu/zP7/j/50+fff//q6Jvvnn/94tn/b4psg8Awhf7z//Z/8yv6x3//5//z
n2dPlnya8c+Wf/vHf+Uff/L/Aujw+YJzhgQA

--=_58cb6cce.FHOf4g3vGnR3ov+JjvcdmWpVmBsrNUYso8j8n9piE+6aaOwt
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="reproduce-openwrt-lkp-hsw01-50:20170317112831:i386-randconfig-i0-201711:4.11.0-rc2-00049-g4cd8adb:834"

#!/bin/bash

kernel=$1
initrd=openwrt-trinity-i386.cgz

wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/initrd/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu Haswell,+smep
	-kernel $kernel
	-initrd $initrd
	-m 256
	-smp 1
	-device e1000,netdev=net0
	-netdev user,id=net0
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-serial stdio
	-display none
	-monitor null
)

append=(
	root=/dev/ram0
	hung_task_panic=1
	debug
	apic=debug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=100
	net.ifnames=0
	printk.devkmsg=on
	panic=-1
	softlockup_panic=1
	nmi_watchdog=panic
	oops=panic
	load_ramdisk=2
	prompt_ramdisk=0
	drbd.minor_count=8
	systemd.log_level=err
	ignore_loglevel
	earlyprintk=ttyS0,115200
	console=ttyS0,115200
	console=tty0
	vga=normal
	rw
	drbd.minor_count=8
)

"${kvm[@]}" -append "${append[*]}"

--=_58cb6cce.FHOf4g3vGnR3ov+JjvcdmWpVmBsrNUYso8j8n9piE+6aaOwt
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="config-4.11.0-rc2-00049-g4cd8adb"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 4.11.0-rc2 Kernel Configuration
#
# CONFIG_64BIT is not set
CONFIG_X86_32=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/i386_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_X86_32_SMP=y
CONFIG_X86_32_LAZY_GS=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=3
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_CROSS_COMPILE=""
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
CONFIG_KERNEL_LZO=y
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
CONFIG_FHANDLE=y
CONFIG_USELIB=y
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
# CONFIG_IRQ_DOMAIN_DEBUG is not set
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
# CONFIG_TASK_XACCT is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
# CONFIG_TREE_RCU_TRACE is not set
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
# CONFIG_BLK_CGROUP is not set
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CPUSETS is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_DEBUG is not set
# CONFIG_SOCK_CGROUP_DATA is not set
# CONFIG_CHECKPOINT_RESTORE is not set
# CONFIG_NAMESPACES is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_INITRAMFS_COMPRESSION=".gz"
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
# CONFIG_UID16 is not set
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
# CONFIG_SYSFS_SYSCALL is not set
# CONFIG_POSIX_TIMERS is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
# CONFIG_KALLSYMS_ABSOLUTE_PERCPU is not set
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_BPF_SYSCALL=y
CONFIG_SHMEM=y
# CONFIG_AIO is not set
# CONFIG_ADVISE_SYSCALLS is not set
# CONFIG_USERFAULTFD is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_MEMBARRIER is not set
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_COMPAT_BRK=y
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLOB is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SYSTEM_DATA_VERIFICATION is not set
CONFIG_PROFILING=y
CONFIG_KEXEC_CORE=y
CONFIG_OPROFILE=y
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
# CONFIG_JUMP_LABEL is not set
# CONFIG_UPROBES is not set
# CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_DMA_API_DEBUG=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_HAVE_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR is not set
CONFIG_CC_STACKPROTECTOR_NONE=y
# CONFIG_CC_STACKPROTECTOR_REGULAR is not set
# CONFIG_CC_STACKPROTECTOR_STRONG is not set
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_HAVE_COPY_THREAD_TLS=y
# CONFIG_HAVE_ARCH_HASH is not set
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
# CONFIG_CPU_NO_EFFICIENT_FFS is not set
# CONFIG_HAVE_ARCH_VMAP_STACK is not set
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX is not set
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_SLABINFO=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
CONFIG_MODULE_COMPRESS_XZ=y
CONFIG_TRIM_UNUSED_KSYMS=y
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_LBDAF=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_CMDLINE_PARSER=y
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_SQ=y
# CONFIG_BLK_WBT_MQ is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_SED_OPAL=y

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=m
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_NOOP=y
CONFIG_DEFAULT_IOSCHED="noop"
CONFIG_MQ_IOSCHED_DEADLINE=m
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
# CONFIG_FREEZER is not set

#
# Processor type and features
#
# CONFIG_ZONE_DMA is not set
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_FAST_FEATURE_TESTS=y
CONFIG_X86_MPPARSE=y
# CONFIG_X86_BIGSMP is not set
CONFIG_GOLDFISH=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_LPSS is not set
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_RDC321X=y
# CONFIG_X86_32_NON_STANDARD is not set
CONFIG_X86_32_IRIS=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_LGUEST_GUEST is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
CONFIG_NO_BOOTMEM=y
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=7
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=5
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_PROCESSOR_SELECT=y
# CONFIG_CPU_SUP_INTEL is not set
# CONFIG_CPU_SUP_CYRIX_32 is not set
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_UMC_32=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
# CONFIG_DMI is not set
CONFIG_SWIOTLB=y
CONFIG_IOMMU_HELPER=y
CONFIG_NR_CPUS=8
CONFIG_SCHED_SMT=y
# CONFIG_SCHED_MC is not set
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_AMD_POWER=y
CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
# CONFIG_TOSHIBA is not set
CONFIG_I8K=y
CONFIG_X86_REBOOTFIXUPS=y
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=y
# CONFIG_NOHIGHMEM is not set
# CONFIG_HIGHMEM4G is not set
CONFIG_HIGHMEM64G=y
CONFIG_VMSPLIT_3G=y
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
CONFIG_X86_PAE=y
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_NEED_NODE_MEMMAP_SIZE=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
# CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
# CONFIG_COMPACTION is not set
CONFIG_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_CLEANCACHE=y
# CONFIG_FRONTSWAP is not set
# CONFIG_CMA is not set
# CONFIG_ZPOOL is not set
CONFIG_ZBUD=m
CONFIG_ZSMALLOC=m
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=y
# CONFIG_HIGHPTE is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
# CONFIG_ARCH_RANDOM is not set
CONFIG_X86_SMAP=y
# CONFIG_EFI is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
# CONFIG_SCHED_HRTICK is not set
CONFIG_KEXEC=y
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
# CONFIG_HOTPLUG_CPU is not set
# CONFIG_COMPAT_VDSO is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_HIBERNATION is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_DEBUGGER=y
# CONFIG_ACPI_DEBUGGER_USER is not set
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
# CONFIG_ACPI_AC is not set
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=y
# CONFIG_ACPI_THERMAL is not set
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=m
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=y
CONFIG_ACPI_NFIT_DEBUG=y
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
# CONFIG_ACPI_APEI_GHES is not set
CONFIG_ACPI_APEI_EINJ=y
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_DPTF_POWER is not set
CONFIG_PMIC_OPREGION=y
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_ONDEMAND=m
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=y
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_POWERNOW_K6 is not set
CONFIG_X86_POWERNOW_K7=m
CONFIG_X86_POWERNOW_K7_ACPI=y
CONFIG_X86_GX_SUSPMOD=m
CONFIG_X86_SPEEDSTEP_CENTRINO=m
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
# CONFIG_X86_SPEEDSTEP_ICH is not set
CONFIG_X86_SPEEDSTEP_SMI=y
CONFIG_X86_P4_CLOCKMOD=y
CONFIG_X86_CPUFREQ_NFORCE2=m
CONFIG_X86_LONGRUN=m
CONFIG_X86_LONGHAUL=y
CONFIG_X86_E_POWERSAVER=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
# CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK is not set

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_BUS_ADDR_T_64BIT=y
# CONFIG_PCI_MSI is not set
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
CONFIG_PCI_STUB=y
CONFIG_HT_IRQ=y
CONFIG_PCI_ATS=y
CONFIG_PCI_IOV=y
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# DesignWare PCI Core Support
#

#
# PCI host controller drivers
#
CONFIG_ISA_BUS=y
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
# CONFIG_EISA is not set
CONFIG_SCx200=m
CONFIG_SCx200HR_TIMER=m
CONFIG_ALIX=y
CONFIG_NET5501=y
CONFIG_AMD_NB=y
# CONFIG_PCCARD is not set
CONFIG_RAPIDIO=m
CONFIG_RAPIDIO_DISC_TIMEOUT=30
CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=y
CONFIG_RAPIDIO_DMA_ENGINE=y
# CONFIG_RAPIDIO_DEBUG is not set
CONFIG_RAPIDIO_ENUM_BASIC=m
# CONFIG_RAPIDIO_CHMAN is not set
# CONFIG_RAPIDIO_MPORT_CDEV is not set

#
# RapidIO Switch drivers
#
# CONFIG_RAPIDIO_TSI57X is not set
CONFIG_RAPIDIO_CPS_XX=m
CONFIG_RAPIDIO_TSI568=m
# CONFIG_RAPIDIO_CPS_GEN2 is not set
CONFIG_RAPIDIO_RXS_GEN3=m
# CONFIG_X86_SYSFB is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_HAVE_AOUT=y
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_MISC=m
# CONFIG_COREDUMP is not set
CONFIG_COMPAT_32=y
CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_NET=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
CONFIG_UNIX_DIAG=y
# CONFIG_NET_KEY is not set
# CONFIG_INET is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NET_PTP_CLASSIFY is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
CONFIG_NETFILTER=y
CONFIG_NETFILTER_DEBUG=y
CONFIG_NETFILTER_ADVANCED=y

#
# DECnet: Netfilter Configuration
#
CONFIG_DECNET_NF_GRABULATOR=y
CONFIG_ATM=y
CONFIG_ATM_LANE=y
CONFIG_STP=y
CONFIG_BRIDGE=y
# CONFIG_VLAN_8021Q is not set
CONFIG_DECNET=y
# CONFIG_DECNET_ROUTER is not set
CONFIG_LLC=y
CONFIG_LLC2=y
CONFIG_IPX=m
CONFIG_IPX_INTERN=y
# CONFIG_ATALK is not set
CONFIG_X25=y
CONFIG_LAPB=y
CONFIG_PHONET=m
CONFIG_IEEE802154=m
CONFIG_IEEE802154_NL802154_EXPERIMENTAL=y
# CONFIG_IEEE802154_SOCKET is not set
CONFIG_MAC802154=m
# CONFIG_NET_SCHED is not set
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=y
CONFIG_BATMAN_ADV=y
# CONFIG_BATMAN_ADV_BATMAN_V is not set
CONFIG_BATMAN_ADV_NC=y
CONFIG_BATMAN_ADV_DEBUGFS=y
# CONFIG_BATMAN_ADV_DEBUG is not set
# CONFIG_VSOCKETS is not set
CONFIG_NETLINK_DIAG=y
# CONFIG_MPLS is not set
# CONFIG_HSR is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
CONFIG_IRDA=m

#
# IrDA protocols
#
CONFIG_IRLAN=m
CONFIG_IRNET=m
CONFIG_IRCOMM=m
# CONFIG_IRDA_ULTRA is not set

#
# IrDA options
#
# CONFIG_IRDA_CACHE_LAST_LSAP is not set
CONFIG_IRDA_FAST_RR=y
CONFIG_IRDA_DEBUG=y

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=m

#
# Dongle support
#
CONFIG_DONGLE=y
CONFIG_ESI_DONGLE=m
CONFIG_ACTISYS_DONGLE=m
# CONFIG_TEKRAM_DONGLE is not set
CONFIG_TOIM3232_DONGLE=m
# CONFIG_LITELINK_DONGLE is not set
CONFIG_MA600_DONGLE=m
CONFIG_GIRBIL_DONGLE=m
# CONFIG_MCP2120_DONGLE is not set
# CONFIG_OLD_BELKIN_DONGLE is not set
CONFIG_ACT200L_DONGLE=m
CONFIG_KINGSUN_DONGLE=m
CONFIG_KSDAZZLE_DONGLE=m
CONFIG_KS959_DONGLE=m

#
# FIR device drivers
#
CONFIG_USB_IRDA=m
CONFIG_SIGMATEL_FIR=m
CONFIG_NSC_FIR=m
CONFIG_WINBOND_FIR=m
CONFIG_TOSHIBA_FIR=m
CONFIG_SMC_IRCC_FIR=m
# CONFIG_ALI_FIR is not set
CONFIG_VLSI_FIR=m
# CONFIG_VIA_FIR is not set
# CONFIG_MCS_FIR is not set
# CONFIG_BT is not set
# CONFIG_STREAM_PARSER is not set
# CONFIG_WIRELESS is not set
CONFIG_WIMAX=m
CONFIG_WIMAX_DEBUG_LEVEL=8
# CONFIG_RFKILL is not set
CONFIG_NET_9P=m
CONFIG_NET_9P_VIRTIO=m
# CONFIG_NET_9P_DEBUG is not set
CONFIG_CAIF=y
# CONFIG_CAIF_DEBUG is not set
# CONFIG_CAIF_NETDEV is not set
CONFIG_CAIF_USB=m
CONFIG_NFC=y
# CONFIG_NFC_DIGITAL is not set
CONFIG_NFC_NCI=m
CONFIG_NFC_NCI_SPI=m
CONFIG_NFC_NCI_UART=m
CONFIG_NFC_HCI=y
# CONFIG_NFC_SHDLC is not set

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_WILINK=m
CONFIG_NFC_MEI_PHY=y
# CONFIG_NFC_FDP is not set
# CONFIG_NFC_PN544_MEI is not set
CONFIG_NFC_PN533=m
CONFIG_NFC_PN533_USB=m
# CONFIG_NFC_PN533_I2C is not set
CONFIG_NFC_MICROREAD=y
CONFIG_NFC_MICROREAD_MEI=y
CONFIG_NFC_MRVL=m
CONFIG_NFC_MRVL_USB=m
CONFIG_NFC_MRVL_UART=m
CONFIG_NFC_MRVL_I2C=m
CONFIG_NFC_MRVL_SPI=m
# CONFIG_NFC_ST_NCI_I2C is not set
# CONFIG_NFC_ST_NCI_SPI is not set
CONFIG_NFC_NXP_NCI=m
# CONFIG_NFC_NXP_NCI_I2C is not set
CONFIG_NFC_S3FWRN5=m
CONFIG_NFC_S3FWRN5_I2C=m
CONFIG_PSAMPLE=y
CONFIG_NET_IFE=m
# CONFIG_LWTUNNEL is not set
# CONFIG_DST_CACHE is not set
CONFIG_GRO_CELLS=y
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=y

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
CONFIG_FIRMWARE_IN_KERNEL=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
CONFIG_DEBUG_TEST_DRIVER_REMOVE=y
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y

#
# Bus devices
#
CONFIG_CONNECTOR=m
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_AX88796=y
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y
# CONFIG_PNPBIOS_PROC_FS is not set
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
# CONFIG_ZRAM is not set
CONFIG_BLK_CPQ_CISS_DA=y
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_UMEM=y
# CONFIG_BLK_DEV_COW_COMMON is not set
# CONFIG_BLK_DEV_LOOP is not set

#
# DRBD disabled because PROC_FS or INET not selected
#
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_SX8=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=m
CONFIG_VIRTIO_BLK=m
CONFIG_VIRTIO_BLK_SCSI=y
CONFIG_BLK_DEV_HD=y
CONFIG_BLK_DEV_RSXX=m
CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=m
# CONFIG_BLK_DEV_NVME_SCSI is not set
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=m
# CONFIG_AD525X_DPOT_I2C is not set
CONFIG_AD525X_DPOT_SPI=m
# CONFIG_DUMMY_IRQ is not set
CONFIG_IBM_ASM=m
CONFIG_PHANTOM=m
CONFIG_SGI_IOC4=y
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
# CONFIG_ENCLOSURE_SERVICES is not set
CONFIG_CS5535_MFGPT=m
CONFIG_CS5535_MFGPT_DEFAULT_IRQ=7
CONFIG_CS5535_CLOCK_EVENT_SRC=m
CONFIG_HP_ILO=m
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=m
# CONFIG_ISL29020 is not set
CONFIG_SENSORS_TSL2550=y
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=m
CONFIG_HMC6352=y
# CONFIG_DS1682 is not set
CONFIG_TI_DAC7512=y
CONFIG_PCH_PHUB=m
CONFIG_USB_SWITCH_FSA9480=y
CONFIG_LATTICE_ECP3_CONFIG=y
CONFIG_SRAM=y
# CONFIG_PANEL is not set
CONFIG_C2PORT=m
CONFIG_C2PORT_DURAMAR_2150=m

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=y
CONFIG_EEPROM_MAX6875=y
CONFIG_EEPROM_93CX6=y
# CONFIG_EEPROM_93XX46 is not set
CONFIG_EEPROM_IDT_89HPESX=m
CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
CONFIG_TI_ST=y
CONFIG_SENSORS_LIS3_I2C=y

#
# Altera FPGA firmware download module
#
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
CONFIG_INTEL_MEI_TXE=y
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC Bus Driver
#

#
# SCIF Bus Driver
#

#
# VOP Bus Driver
#

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
CONFIG_ECHO=y
# CONFIG_CXL_BASE is not set
# CONFIG_CXL_AFU_DRIVER_OPS is not set
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_MQ_DEFAULT=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
CONFIG_CHR_DEV_ST=m
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=y
# CONFIG_SCSI_CONSTANTS is not set
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=y
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
# CONFIG_SCSI_SAS_ATA is not set
# CONFIG_SCSI_SAS_HOST_SMP is not set
# CONFIG_SCSI_SRP_ATTRS is not set
CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_BOOT_SYSFS=y
CONFIG_SCSI_BNX2_ISCSI=m
CONFIG_BE2ISCSI=m
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_HPSA=m
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
CONFIG_SCSI_ACARD=y
CONFIG_SCSI_AHA152X=m
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
CONFIG_SCSI_AIC94XX=m
# CONFIG_AIC94XX_DEBUG is not set
CONFIG_SCSI_MVSAS=y
# CONFIG_SCSI_MVSAS_DEBUG is not set
CONFIG_SCSI_MVSAS_TASKLET=y
# CONFIG_SCSI_MVUMI is not set
CONFIG_SCSI_DPT_I2O=m
CONFIG_SCSI_ADVANSYS=y
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
CONFIG_MEGARAID_NEWGEN=y
# CONFIG_MEGARAID_MM is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
CONFIG_SCSI_SMARTPQI=y
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFSHCD_PCI=m
CONFIG_SCSI_UFS_DWC_TC_PCI=m
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
# CONFIG_SCSI_HPTIOP is not set
CONFIG_SCSI_BUSLOGIC=y
# CONFIG_SCSI_FLASHPOINT is not set
CONFIG_VMWARE_PVSCSI=m
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
CONFIG_SCSI_DMX3191D=y
# CONFIG_SCSI_EATA is not set
CONFIG_SCSI_FUTURE_DOMAIN=y
CONFIG_SCSI_GDTH=m
CONFIG_SCSI_ISCI=y
CONFIG_SCSI_GENERIC_NCR5380=m
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=y
CONFIG_SCSI_INIA100=y
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_NCR53C406A=m
CONFIG_SCSI_STEX=y
# CONFIG_SCSI_SYM53C8XX_2 is not set
CONFIG_SCSI_IPR=m
# CONFIG_SCSI_IPR_TRACE is not set
CONFIG_SCSI_IPR_DUMP=y
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
CONFIG_SCSI_QLA_ISCSI=y
# CONFIG_QEDI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
CONFIG_SCSI_AM53C974=m
# CONFIG_SCSI_NSP32 is not set
CONFIG_SCSI_WD719X=y
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_PMCRAID is not set
CONFIG_SCSI_PM8001=y
CONFIG_SCSI_BFA_FC=m
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
# CONFIG_SCSI_DH_HP_SW is not set
CONFIG_SCSI_DH_EMC=m
CONFIG_SCSI_DH_ALUA=y
# CONFIG_SCSI_OSD_INITIATOR is not set
CONFIG_ATA=y
# CONFIG_ATA_NONSTANDARD is not set
CONFIG_ATA_VERBOSE_ERROR=y
# CONFIG_ATA_ACPI is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
# CONFIG_SATA_AHCI_PLATFORM is not set
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=m
CONFIG_SATA_SIL24=y
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
CONFIG_SATA_QSTOR=y
CONFIG_SATA_SX4=y
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
CONFIG_SATA_DWC=m
# CONFIG_SATA_DWC_OLD_DMA is not set
CONFIG_SATA_DWC_DEBUG=y
# CONFIG_SATA_DWC_VDEBUG is not set
# CONFIG_SATA_MV is not set
CONFIG_SATA_NV=y
# CONFIG_SATA_PROMISE is not set
CONFIG_SATA_SIL=y
CONFIG_SATA_SIS=y
# CONFIG_SATA_SVW is not set
CONFIG_SATA_ULI=m
# CONFIG_SATA_VIA is not set
CONFIG_SATA_VITESSE=y

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=m
# CONFIG_PATA_AMD is not set
CONFIG_PATA_ARTOP=m
CONFIG_PATA_ATIIXP=m
CONFIG_PATA_ATP867X=y
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CS5520 is not set
CONFIG_PATA_CS5530=m
CONFIG_PATA_CS5535=m
CONFIG_PATA_CS5536=y
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
CONFIG_PATA_HPT37X=y
# CONFIG_PATA_HPT3X2N is not set
CONFIG_PATA_HPT3X3=y
# CONFIG_PATA_HPT3X3_DMA is not set
CONFIG_PATA_IT8213=m
CONFIG_PATA_IT821X=m
# CONFIG_PATA_JMICRON is not set
CONFIG_PATA_MARVELL=y
# CONFIG_PATA_NETCELL is not set
CONFIG_PATA_NINJA32=y
# CONFIG_PATA_NS87415 is not set
CONFIG_PATA_OLDPIIX=m
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
CONFIG_PATA_RADISYS=m
CONFIG_PATA_RDC=y
# CONFIG_PATA_SC1200 is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
CONFIG_PATA_SIL680=m
CONFIG_PATA_SIS=y
CONFIG_PATA_TOSHIBA=y
CONFIG_PATA_TRIFLEX=y
# CONFIG_PATA_VIA is not set
CONFIG_PATA_WINBOND=m

#
# PIO-only SFF controllers
#
CONFIG_PATA_CMD640_PCI=m
CONFIG_PATA_ISAPNP=y
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
CONFIG_PATA_QDI=m
# CONFIG_PATA_RZ1000 is not set
CONFIG_PATA_WINBOND_VLB=y

#
# Generic fallback / legacy drivers
#
CONFIG_ATA_GENERIC=m
CONFIG_PATA_LEGACY=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
# CONFIG_MD_AUTODETECT is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
CONFIG_MD_RAID1=y
CONFIG_MD_RAID10=y
CONFIG_MD_RAID456=y
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=y
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=y
CONFIG_DM_MQ_DEFAULT=y
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=y
CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING=y
# CONFIG_DM_DEBUG_BLOCK_STACK_TRACING is not set
CONFIG_DM_BIO_PRISON=y
CONFIG_DM_PERSISTENT_DATA=y
# CONFIG_DM_CRYPT is not set
# CONFIG_DM_SNAPSHOT is not set
# CONFIG_DM_THIN_PROVISIONING is not set
# CONFIG_DM_CACHE is not set
CONFIG_DM_ERA=y
# CONFIG_DM_MIRROR is not set
CONFIG_DM_RAID=y
CONFIG_DM_ZERO=y
CONFIG_DM_MULTIPATH=m
# CONFIG_DM_MULTIPATH_QL is not set
# CONFIG_DM_MULTIPATH_ST is not set
CONFIG_DM_DELAY=y
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=y
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=y
# CONFIG_DM_LOG_WRITES is not set
# CONFIG_TARGET_CORE is not set
CONFIG_FUSION=y
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
# CONFIG_FIREWIRE_OHCI is not set
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NOSY=y
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
CONFIG_DUMMY=y
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
CONFIG_NET_TEAM=y
CONFIG_NET_TEAM_MODE_BROADCAST=y
CONFIG_NET_TEAM_MODE_ROUNDROBIN=y
CONFIG_NET_TEAM_MODE_RANDOM=y
# CONFIG_NET_TEAM_MODE_ACTIVEBACKUP is not set
# CONFIG_NET_TEAM_MODE_LOADBALANCE is not set
# CONFIG_MACVLAN is not set
CONFIG_MACSEC=m
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
CONFIG_NTB_NETDEV=m
CONFIG_RIONET=m
CONFIG_RIONET_TX_SIZE=128
CONFIG_RIONET_RX_SIZE=128
CONFIG_TUN_VNET_CROSS_LE=y
# CONFIG_VETH is not set
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
CONFIG_SUNGEM_PHY=y
CONFIG_ARCNET=m
CONFIG_ARCNET_1201=m
CONFIG_ARCNET_1051=m
CONFIG_ARCNET_RAW=m
CONFIG_ARCNET_CAP=m
# CONFIG_ARCNET_COM90xx is not set
# CONFIG_ARCNET_COM90xxIO is not set
# CONFIG_ARCNET_RIM_I is not set
CONFIG_ARCNET_COM20020=m
CONFIG_ARCNET_COM20020_ISA=m
# CONFIG_ARCNET_COM20020_PCI is not set
# CONFIG_ATM_DRIVERS is not set

#
# CAIF transport drivers
#
CONFIG_CAIF_TTY=m
CONFIG_CAIF_SPI_SLAVE=y
CONFIG_CAIF_SPI_SYNC=y
# CONFIG_CAIF_HSI is not set
# CONFIG_CAIF_VIRTIO is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL3 is not set
CONFIG_3C515=m
CONFIG_VORTEX=y
# CONFIG_TYPHOON is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
# CONFIG_NET_VENDOR_AGERE is not set
# CONFIG_NET_VENDOR_ALACRITECH is not set
# CONFIG_NET_VENDOR_ALTEON is not set
CONFIG_ALTERA_TSE=y
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
CONFIG_LANCE=m
CONFIG_PCNET32=y
CONFIG_NI65=m
CONFIG_AMD_XGBE=y
CONFIG_AMD_XGBE_DCB=y
CONFIG_AMD_XGBE_HAVE_ECC=y
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_NET_VENDOR_ARC is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
CONFIG_ATL1=m
CONFIG_ATL1E=y
CONFIG_ATL1C=m
CONFIG_ALX=y
# CONFIG_NET_VENDOR_AURORA is not set
# CONFIG_NET_CADENCE is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
CONFIG_BCMGENET=m
CONFIG_BNX2=y
CONFIG_CNIC=y
# CONFIG_TIGON3 is not set
CONFIG_BNX2X=y
# CONFIG_BNX2X_SRIOV is not set
CONFIG_BNXT=y
# CONFIG_BNXT_SRIOV is not set
# CONFIG_BNXT_DCB is not set
# CONFIG_NET_VENDOR_BROCADE is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_NET_VENDOR_CHELSIO is not set
# CONFIG_NET_VENDOR_CIRRUS is not set
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=m
CONFIG_CX_ECAT=y
CONFIG_DNET=m
# CONFIG_NET_VENDOR_DEC is not set
CONFIG_NET_VENDOR_DLINK=y
CONFIG_DL2K=y
CONFIG_SUNDANCE=m
CONFIG_SUNDANCE_MMIO=y
# CONFIG_NET_VENDOR_EMULEX is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_EXAR=y
CONFIG_S2IO=m
CONFIG_VXGE=m
CONFIG_VXGE_DEBUG_TRACE_ALL=y
CONFIG_NET_VENDOR_HP=y
CONFIG_HP100=m
CONFIG_NET_VENDOR_INTEL=y
CONFIG_E100=m
CONFIG_E1000=m
CONFIG_E1000E=m
# CONFIG_E1000E_HWTS is not set
CONFIG_IGB=m
# CONFIG_IGB_HWMON is not set
CONFIG_IGBVF=y
# CONFIG_IXGB is not set
CONFIG_IXGBE=m
# CONFIG_IXGBE_HWMON is not set
# CONFIG_IXGBE_DCB is not set
CONFIG_I40E=m
# CONFIG_I40E_DCB is not set
CONFIG_NET_VENDOR_I825XX=y
# CONFIG_JME is not set
# CONFIG_NET_VENDOR_MARVELL is not set
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=m
# CONFIG_MLX4_EN_DCB is not set
CONFIG_MLX4_CORE=m
# CONFIG_MLX4_DEBUG is not set
# CONFIG_MLX5_CORE is not set
CONFIG_MLXSW_CORE=m
# CONFIG_MLXSW_CORE_HWMON is not set
CONFIG_MLXSW_CORE_THERMAL=y
CONFIG_MLXSW_PCI=m
# CONFIG_MLXSW_I2C is not set
# CONFIG_NET_VENDOR_MICREL is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
CONFIG_ENCX24J600=y
CONFIG_FEALNX=y
CONFIG_NET_VENDOR_NATSEMI=y
CONFIG_NATSEMI=m
CONFIG_NS83820=m
# CONFIG_NET_VENDOR_NETRONOME is not set
# CONFIG_NET_VENDOR_8390 is not set
CONFIG_NET_VENDOR_NVIDIA=y
CONFIG_FORCEDETH=m
CONFIG_NET_VENDOR_OKI=y
# CONFIG_PCH_GBE is not set
# CONFIG_ETHOC is not set
CONFIG_NET_PACKET_ENGINE=y
CONFIG_HAMACHI=m
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=y
# CONFIG_QLCNIC is not set
CONFIG_QLGE=m
# CONFIG_NETXEN_NIC is not set
CONFIG_QED=y
CONFIG_QED_SRIOV=y
CONFIG_QEDE=m
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_NET_VENDOR_REALTEK is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_RDC=y
CONFIG_R6040=m
# CONFIG_NET_VENDOR_ROCKER is not set
# CONFIG_NET_VENDOR_SAMSUNG is not set
CONFIG_NET_VENDOR_SEEQ=y
# CONFIG_NET_VENDOR_SILAN is not set
CONFIG_NET_VENDOR_SIS=y
CONFIG_SIS900=y
CONFIG_SIS190=m
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
# CONFIG_NET_VENDOR_SMSC is not set
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
CONFIG_HAPPYMEAL=m
CONFIG_SUNGEM=y
# CONFIG_CASSINI is not set
CONFIG_NIU=y
CONFIG_NET_VENDOR_TEHUTI=y
CONFIG_TEHUTI=y
CONFIG_NET_VENDOR_TI=y
CONFIG_TI_CPSW_ALE=y
# CONFIG_TLAN is not set
# CONFIG_NET_VENDOR_VIA is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
CONFIG_WIZNET_W5300=y
# CONFIG_WIZNET_BUS_DIRECT is not set
CONFIG_WIZNET_BUS_INDIRECT=y
# CONFIG_WIZNET_BUS_ANY is not set
CONFIG_FDDI=m
CONFIG_DEFXX=m
# CONFIG_DEFXX_MMIO is not set
CONFIG_SKFP=m
CONFIG_NET_SB1000=m
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MDIO bus device drivers
#
CONFIG_MDIO_BCM_UNIMAC=m
CONFIG_MDIO_BITBANG=y
CONFIG_MDIO_GPIO=m

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=y
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AT803X_PHY=m
CONFIG_BCM7XXX_PHY=m
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=m
# CONFIG_BROADCOM_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
CONFIG_DP83848_PHY=m
# CONFIG_DP83867_PHY is not set
CONFIG_FIXED_PHY=y
# CONFIG_ICPLUS_PHY is not set
CONFIG_INTEL_XWAY_PHY=m
CONFIG_LSI_ET1011C_PHY=m
CONFIG_LXT_PHY=y
CONFIG_MARVELL_PHY=m
# CONFIG_MICREL_PHY is not set
CONFIG_MICROCHIP_PHY=y
CONFIG_MICROSEMI_PHY=y
CONFIG_NATIONAL_PHY=m
# CONFIG_QSEMI_PHY is not set
# CONFIG_REALTEK_PHY is not set
CONFIG_SMSC_PHY=y
CONFIG_STE10XP=m
CONFIG_TERANETICS_PHY=y
# CONFIG_VITESSE_PHY is not set
CONFIG_XILINX_GMII2RGMII=m
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
# CONFIG_PPP_BSDCOMP is not set
# CONFIG_PPP_DEFLATE is not set
CONFIG_PPP_FILTER=y
# CONFIG_PPP_MPPE is not set
# CONFIG_PPP_MULTILINK is not set
CONFIG_PPPOATM=m
CONFIG_PPPOE=m
# CONFIG_PPP_ASYNC is not set
CONFIG_PPP_SYNC_TTY=m
# CONFIG_SLIP is not set
CONFIG_SLHC=m
CONFIG_USB_NET_DRIVERS=y
CONFIG_USB_CATC=m
CONFIG_USB_KAWETH=y
# CONFIG_USB_PEGASUS is not set
CONFIG_USB_RTL8150=y
CONFIG_USB_RTL8152=m
CONFIG_USB_LAN78XX=y
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
CONFIG_USB_NET_CDCETHER=y
# CONFIG_USB_NET_CDC_EEM is not set
CONFIG_USB_NET_CDC_NCM=m
CONFIG_USB_NET_HUAWEI_CDC_NCM=m
CONFIG_USB_NET_CDC_MBIM=m
CONFIG_USB_NET_DM9601=m
# CONFIG_USB_NET_SR9700 is not set
CONFIG_USB_NET_SR9800=m
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
CONFIG_USB_NET_GL620A=m
CONFIG_USB_NET_NET1080=y
CONFIG_USB_NET_PLUSB=m
# CONFIG_USB_NET_MCS7830 is not set
CONFIG_USB_NET_RNDIS_HOST=m
CONFIG_USB_NET_CDC_SUBSET_ENABLE=m
CONFIG_USB_NET_CDC_SUBSET=m
# CONFIG_USB_ALI_M5632 is not set
# CONFIG_USB_AN2720 is not set
CONFIG_USB_BELKIN=y
# CONFIG_USB_ARMLINUX is not set
# CONFIG_USB_EPSON2888 is not set
# CONFIG_USB_KC2190 is not set
# CONFIG_USB_NET_ZAURUS is not set
CONFIG_USB_NET_CX82310_ETH=y
CONFIG_USB_NET_KALMIA=y
# CONFIG_USB_NET_QMI_WWAN is not set
CONFIG_USB_NET_INT51X1=y
# CONFIG_USB_CDC_PHONET is not set
CONFIG_USB_IPHETH=m
# CONFIG_USB_SIERRA_NET is not set
CONFIG_USB_VL600=m
CONFIG_USB_NET_CH9200=y
# CONFIG_WLAN is not set

#
# WiMAX Wireless Broadband devices
#
CONFIG_WIMAX_I2400M=m
CONFIG_WIMAX_I2400M_USB=m
CONFIG_WIMAX_I2400M_DEBUG_LEVEL=8
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=m
# CONFIG_IEEE802154_FAKELB is not set
CONFIG_IEEE802154_AT86RF230=m
# CONFIG_IEEE802154_AT86RF230_DEBUGFS is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
CONFIG_IEEE802154_ADF7242=m
CONFIG_FUJITSU_ES=m
CONFIG_ISDN=y
CONFIG_ISDN_I4L=m
CONFIG_ISDN_AUDIO=y
# CONFIG_ISDN_TTY_FAX is not set
CONFIG_ISDN_X25=y

#
# ISDN feature submodules
#
# CONFIG_ISDN_DIVERSION is not set

#
# ISDN4Linux hardware drivers
#

#
# Passive cards
#
# CONFIG_ISDN_DRV_HISAX is not set
# CONFIG_ISDN_CAPI is not set
CONFIG_ISDN_DRV_GIGASET=m
CONFIG_GIGASET_I4L=y
# CONFIG_GIGASET_DUMMYLL is not set
CONFIG_GIGASET_BASE=m
# CONFIG_GIGASET_M105 is not set
CONFIG_GIGASET_M101=m
CONFIG_GIGASET_DEBUG=y
CONFIG_HYSDN=m
CONFIG_MISDN=m
CONFIG_MISDN_DSP=m
# CONFIG_MISDN_L1OIP is not set

#
# mISDN hardware drivers
#
# CONFIG_MISDN_HFCPCI is not set
# CONFIG_MISDN_HFCMULTI is not set
# CONFIG_MISDN_HFCUSB is not set
# CONFIG_MISDN_AVMFRITZ is not set
CONFIG_MISDN_SPEEDFAX=m
CONFIG_MISDN_INFINEON=m
CONFIG_MISDN_W6692=m
CONFIG_MISDN_NETJET=m
CONFIG_MISDN_IPAC=m
CONFIG_MISDN_ISAR=m
CONFIG_ISDN_HDLC=m
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_EVBUG=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5588 is not set
CONFIG_KEYBOARD_ADP5589=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
CONFIG_KEYBOARD_QT2160=y
CONFIG_KEYBOARD_LKKBD=y
# CONFIG_KEYBOARD_GPIO is not set
CONFIG_KEYBOARD_GPIO_POLLED=m
CONFIG_KEYBOARD_TCA6416=y
CONFIG_KEYBOARD_TCA8418=m
CONFIG_KEYBOARD_MATRIX=y
CONFIG_KEYBOARD_LM8323=y
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
CONFIG_KEYBOARD_MCS=m
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_KEYBOARD_OPENCORES=y
CONFIG_KEYBOARD_SAMSUNG=m
CONFIG_KEYBOARD_GOLDFISH_EVENTS=m
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
CONFIG_KEYBOARD_TM2_TOUCHKEY=m
# CONFIG_KEYBOARD_TWL4030 is not set
CONFIG_KEYBOARD_XTKBD=y
CONFIG_KEYBOARD_CROS_EC=m
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
CONFIG_TABLET_USB_GTCO=m
CONFIG_TABLET_USB_HANWANG=y
CONFIG_TABLET_USB_KBTAB=y
CONFIG_TABLET_USB_PEGASUS=y
# CONFIG_TABLET_SERIAL_WACOM4 is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_AD714X=m
CONFIG_INPUT_AD714X_I2C=m
CONFIG_INPUT_AD714X_SPI=m
# CONFIG_INPUT_ARIZONA_HAPTICS is not set
CONFIG_INPUT_BMA150=y
# CONFIG_INPUT_E3X0_BUTTON is not set
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_MC13783_PWRBUTTON is not set
CONFIG_INPUT_MMA8450=m
# CONFIG_INPUT_APANEL is not set
CONFIG_INPUT_GP2A=m
CONFIG_INPUT_GPIO_BEEPER=m
CONFIG_INPUT_GPIO_TILT_POLLED=y
# CONFIG_INPUT_GPIO_DECODER is not set
CONFIG_INPUT_WISTRON_BTNS=y
CONFIG_INPUT_ATLAS_BTNS=y
# CONFIG_INPUT_ATI_REMOTE2 is not set
CONFIG_INPUT_KEYSPAN_REMOTE=m
CONFIG_INPUT_KXTJ9=m
CONFIG_INPUT_KXTJ9_POLLED_MODE=y
CONFIG_INPUT_POWERMATE=y
CONFIG_INPUT_YEALINK=y
CONFIG_INPUT_CM109=y
CONFIG_INPUT_TPS65218_PWRBUTTON=m
# CONFIG_INPUT_TWL4030_PWRBUTTON is not set
# CONFIG_INPUT_TWL4030_VIBRA is not set
# CONFIG_INPUT_UINPUT is not set
CONFIG_INPUT_PALMAS_PWRBUTTON=m
CONFIG_INPUT_PCF50633_PMU=m
CONFIG_INPUT_PCF8574=y
CONFIG_INPUT_GPIO_ROTARY_ENCODER=y
CONFIG_INPUT_DA9052_ONKEY=y
# CONFIG_INPUT_DA9063_ONKEY is not set
CONFIG_INPUT_WM831X_ON=y
CONFIG_INPUT_ADXL34X=y
# CONFIG_INPUT_ADXL34X_I2C is not set
CONFIG_INPUT_ADXL34X_SPI=m
CONFIG_INPUT_IMS_PCU=m
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_IDEAPAD_SLIDEBAR=m
CONFIG_INPUT_DRV260X_HAPTICS=y
CONFIG_INPUT_DRV2665_HAPTICS=y
CONFIG_INPUT_DRV2667_HAPTICS=m
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
# CONFIG_RMI4_SPI is not set
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
CONFIG_SERIO_CT82C710=y
CONFIG_SERIO_PARKBD=y
CONFIG_SERIO_PCIPS2=m
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_ROCKETPORT=m
CONFIG_CYCLADES=y
CONFIG_CYZ_INTR=y
CONFIG_MOXA_INTELLIO=m
CONFIG_MOXA_SMARTIO=y
CONFIG_SYNCLINK=y
# CONFIG_SYNCLINKMP is not set
CONFIG_SYNCLINK_GT=m
CONFIG_NOZOMI=y
CONFIG_ISI=y
CONFIG_N_HDLC=y
CONFIG_N_GSM=m
# CONFIG_TRACE_ROUTER is not set
CONFIG_TRACE_SINK=m
# CONFIG_GOLDFISH_TTY is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_DMA is not set
CONFIG_SERIAL_8250_PCI=m
# CONFIG_SERIAL_8250_EXAR is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_DETECT_IRQ=y
# CONFIG_SERIAL_8250_RSA is not set
# CONFIG_SERIAL_8250_FSL is not set
# CONFIG_SERIAL_8250_DW is not set
CONFIG_SERIAL_8250_RT288X=y
# CONFIG_SERIAL_8250_LPSS is not set
CONFIG_SERIAL_8250_MID=m
CONFIG_SERIAL_8250_MOXA=m

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
CONFIG_SERIAL_UARTLITE=m
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
CONFIG_SERIAL_SC16IS7XX_CORE=m
CONFIG_SERIAL_SC16IS7XX=m
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
CONFIG_SERIAL_SC16IS7XX_SPI=y
# CONFIG_SERIAL_TIMBERDALE is not set
CONFIG_SERIAL_ALTERA_JTAGUART=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE=y
CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS=y
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_IFX6X60=y
# CONFIG_SERIAL_PCH_UART is not set
CONFIG_SERIAL_ARC=y
CONFIG_SERIAL_ARC_CONSOLE=y
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=m
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_TTY_PRINTK=y
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
# CONFIG_HW_RANDOM_INTEL is not set
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_GEODE=y
# CONFIG_HW_RANDOM_VIA is not set
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_TPM is not set
# CONFIG_NVRAM is not set
CONFIG_DTLK=y
CONFIG_R3964=m
# CONFIG_APPLICOM is not set
CONFIG_SONYPI=m
CONFIG_MWAVE=m
# CONFIG_SCx200_GPIO is not set
# CONFIG_PC8736x_GPIO is not set
CONFIG_NSC_GPIO=y
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=m
CONFIG_TCG_TIS_CORE=m
CONFIG_TCG_TIS=m
# CONFIG_TCG_TIS_SPI is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
# CONFIG_TCG_TIS_I2C_INFINEON is not set
CONFIG_TCG_TIS_I2C_NUVOTON=m
# CONFIG_TCG_NSC is not set
CONFIG_TCG_ATMEL=m
# CONFIG_TCG_INFINEON is not set
CONFIG_TCG_CRB=m
CONFIG_TCG_VTPM_PROXY=m
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=y
CONFIG_DEVPORT=y
CONFIG_XILLYBUS=m

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_ACPI_I2C_OPREGION is not set
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
CONFIG_I2C_MUX_PINCTRL=m
CONFIG_I2C_MUX_REG=m
CONFIG_I2C_MUX_MLXCPLD=m
# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI1563=m
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=y
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=y
CONFIG_I2C_ISMT=y
CONFIG_I2C_PIIX4=y
# CONFIG_I2C_NFORCE2 is not set
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=y
CONFIG_I2C_SIS96X=y
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=y

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=m
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=m
CONFIG_I2C_DESIGNWARE_PCI=y
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
CONFIG_I2C_EG20T=m
CONFIG_I2C_EMEV2=y
# CONFIG_I2C_GPIO is not set
CONFIG_I2C_KEMPLD=m
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
# CONFIG_I2C_PXA_PCI is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
# CONFIG_I2C_DLN2 is not set
CONFIG_I2C_PARPORT=y
CONFIG_I2C_PARPORT_LIGHT=y
CONFIG_I2C_ROBOTFUZZ_OSIF=m
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_PCA_ISA is not set
CONFIG_I2C_CROS_EC_TUNNEL=m
CONFIG_SCx200_ACB=y
CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
CONFIG_SPI_BITBANG=y
CONFIG_SPI_BUTTERFLY=m
CONFIG_SPI_CADENCE=m
CONFIG_SPI_DESIGNWARE=m
CONFIG_SPI_DW_PCI=m
CONFIG_SPI_DW_MMIO=m
CONFIG_SPI_DLN2=m
CONFIG_SPI_GPIO=y
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_OC_TINY is not set
CONFIG_SPI_PXA2XX=m
CONFIG_SPI_PXA2XX_PCI=m
# CONFIG_SPI_ROCKCHIP is not set
CONFIG_SPI_SC18IS602=y
CONFIG_SPI_TOPCLIFF_PCH=m
CONFIG_SPI_XCOMM=m
CONFIG_SPI_XILINX=m
CONFIG_SPI_ZYNQMP_GQSPI=m

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=m
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPMI is not set
CONFIG_HSI=m
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
# CONFIG_HSI_CHAR is not set

#
# PPS support
#
CONFIG_PPS=m
# CONFIG_PPS_DEBUG is not set
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=m
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PTP_1588_CLOCK_PCH=m
CONFIG_PINCTRL=y

#
# Pin controllers
#
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_SX150X=y
CONFIG_PINCTRL_BAYTRAIL=y
CONFIG_PINCTRL_CHERRYVIEW=y
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_BROXTON=y
CONFIG_PINCTRL_GEMINILAKE=m
CONFIG_PINCTRL_SUNRISEPOINT=y
CONFIG_GPIOLIB=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=m
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
CONFIG_GPIO_DWAPB=m
CONFIG_GPIO_GENERIC_PLATFORM=m
# CONFIG_GPIO_ICH is not set
CONFIG_GPIO_LYNXPOINT=y
# CONFIG_GPIO_MOCKUP is not set
CONFIG_GPIO_VX855=y

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_104_DIO_48E is not set
# CONFIG_GPIO_104_IDIO_16 is not set
CONFIG_GPIO_104_IDI_48=y
# CONFIG_GPIO_F7188X is not set
CONFIG_GPIO_GPIO_MM=y
CONFIG_GPIO_IT87=y
CONFIG_GPIO_SCH=m
CONFIG_GPIO_SCH311X=m
CONFIG_GPIO_WS16C48=y

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
CONFIG_GPIO_ADP5588_IRQ=y
CONFIG_GPIO_MAX7300=y
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_SX150X is not set
CONFIG_GPIO_TPIC2810=m

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ARIZONA is not set
# CONFIG_GPIO_CS5535 is not set
CONFIG_GPIO_DA9052=y
# CONFIG_GPIO_DLN2 is not set
CONFIG_GPIO_JANZ_TTL=m
# CONFIG_GPIO_KEMPLD is not set
CONFIG_GPIO_LP3943=m
CONFIG_GPIO_PALMAS=y
# CONFIG_GPIO_TIMBERDALE is not set
CONFIG_GPIO_TPS65086=m
# CONFIG_GPIO_TPS65218 is not set
# CONFIG_GPIO_TPS6586X is not set
CONFIG_GPIO_TPS65910=y
CONFIG_GPIO_TPS65912=m
# CONFIG_GPIO_TWL4030 is not set
CONFIG_GPIO_UCB1400=m
# CONFIG_GPIO_WM831X is not set
CONFIG_GPIO_WM8994=m

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=y
CONFIG_GPIO_BT8XX=y
# CONFIG_GPIO_ML_IOH is not set
CONFIG_GPIO_PCH=y
CONFIG_GPIO_PCI_IDIO_16=y
# CONFIG_GPIO_RDC321X is not set

#
# SPI GPIO expanders
#
CONFIG_GPIO_MAX7301=y
CONFIG_GPIO_MC33880=y
# CONFIG_GPIO_PISOSR is not set

#
# SPI or I2C GPIO expanders
#

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=y
CONFIG_W1=m
# CONFIG_W1_CON is not set

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
# CONFIG_W1_MASTER_DS2490 is not set
CONFIG_W1_MASTER_DS2482=m
CONFIG_W1_MASTER_DS1WM=m
CONFIG_W1_MASTER_GPIO=m

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
CONFIG_W1_SLAVE_SMEM=m
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=m
CONFIG_W1_SLAVE_DS2408_READBACK=y
CONFIG_W1_SLAVE_DS2413=m
CONFIG_W1_SLAVE_DS2406=m
CONFIG_W1_SLAVE_DS2423=m
CONFIG_W1_SLAVE_DS2431=m
# CONFIG_W1_SLAVE_DS2433 is not set
# CONFIG_W1_SLAVE_DS2438 is not set
# CONFIG_W1_SLAVE_DS2760 is not set
CONFIG_W1_SLAVE_DS2780=m
CONFIG_W1_SLAVE_DS2781=m
# CONFIG_W1_SLAVE_DS28E04 is not set
CONFIG_W1_SLAVE_BQ27000=m
CONFIG_POWER_AVS=y
CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_RESTART=y
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
# CONFIG_PDA_POWER is not set
CONFIG_GENERIC_ADC_BATTERY=m
# CONFIG_WM831X_BACKUP is not set
# CONFIG_WM831X_POWER is not set
CONFIG_TEST_POWER=y
CONFIG_BATTERY_DS2780=m
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_SBS is not set
CONFIG_CHARGER_SBS=y
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_DA9052 is not set
# CONFIG_BATTERY_DA9150 is not set
CONFIG_BATTERY_MAX17040=m
CONFIG_BATTERY_MAX17042=y
CONFIG_BATTERY_TWL4030_MADC=m
# CONFIG_CHARGER_PCF50633 is not set
# CONFIG_BATTERY_RX51 is not set
CONFIG_CHARGER_ISP1704=y
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_TWL4030 is not set
CONFIG_CHARGER_LP8727=m
CONFIG_CHARGER_GPIO=y
CONFIG_CHARGER_MAX14577=m
# CONFIG_CHARGER_BQ2415X is not set
CONFIG_CHARGER_BQ24190=y
CONFIG_CHARGER_BQ24257=m
CONFIG_CHARGER_BQ24735=m
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_SMB347=y
# CONFIG_CHARGER_TPS65217 is not set
CONFIG_BATTERY_GAUGE_LTC2941=y
# CONFIG_BATTERY_GOLDFISH is not set
CONFIG_BATTERY_RT5033=m
CONFIG_CHARGER_RT9455=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_AD7314=m
CONFIG_SENSORS_AD7414=y
# CONFIG_SENSORS_AD7418 is not set
CONFIG_SENSORS_ADM1021=m
# CONFIG_SENSORS_ADM1025 is not set
CONFIG_SENSORS_ADM1026=m
# CONFIG_SENSORS_ADM1029 is not set
# CONFIG_SENSORS_ADM1031 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7310=m
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=y
CONFIG_SENSORS_ADT7462=y
# CONFIG_SENSORS_ADT7470 is not set
CONFIG_SENSORS_ADT7475=y
# CONFIG_SENSORS_ASC7621 is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
# CONFIG_SENSORS_FAM15H_POWER is not set
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ATXP1=y
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
CONFIG_SENSORS_DA9052_ADC=y
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=y
# CONFIG_SENSORS_F71882FG is not set
CONFIG_SENSORS_F75375S=y
# CONFIG_SENSORS_MC13783_ADC is not set
# CONFIG_SENSORS_FSCHMD is not set
CONFIG_SENSORS_FTSTEUTATES=y
# CONFIG_SENSORS_GL518SM is not set
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
# CONFIG_SENSORS_G762 is not set
CONFIG_SENSORS_GPIO_FAN=y
CONFIG_SENSORS_HIH6130=m
CONFIG_SENSORS_IIO_HWMON=m
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_POWR1220=y
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2990=m
CONFIG_SENSORS_LTC4151=m
# CONFIG_SENSORS_LTC4215 is not set
CONFIG_SENSORS_LTC4222=m
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=y
CONFIG_SENSORS_LTC4261=y
CONFIG_SENSORS_MAX1111=y
# CONFIG_SENSORS_MAX16065 is not set
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
CONFIG_SENSORS_MAX6639=y
CONFIG_SENSORS_MAX6642=m
# CONFIG_SENSORS_MAX6650 is not set
CONFIG_SENSORS_MAX6697=y
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MCP3021 is not set
CONFIG_SENSORS_TC654=y
CONFIG_SENSORS_MENF21BMC_HWMON=y
CONFIG_SENSORS_ADCXX=m
CONFIG_SENSORS_LM63=y
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=y
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
CONFIG_SENSORS_LM80=m
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=m
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_LM93 is not set
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=y
CONFIG_SENSORS_NTC_THERMISTOR=m
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
CONFIG_SENSORS_NCT7904=y
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_LM25066 is not set
CONFIG_SENSORS_LTC2978=y
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=y
# CONFIG_SENSORS_MAX20751 is not set
CONFIG_SENSORS_MAX34440=y
CONFIG_SENSORS_MAX8688=y
# CONFIG_SENSORS_TPS40422 is not set
CONFIG_SENSORS_UCD9000=y
CONFIG_SENSORS_UCD9200=m
CONFIG_SENSORS_ZL6100=y
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
CONFIG_SENSORS_SHTC1=m
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=y
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=y
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=y
CONFIG_SENSORS_SCH5627=y
CONFIG_SENSORS_SCH5636=m
CONFIG_SENSORS_STTS751=y
CONFIG_SENSORS_SMM665=m
CONFIG_SENSORS_ADC128D818=m
CONFIG_SENSORS_ADS1015=y
CONFIG_SENSORS_ADS7828=y
CONFIG_SENSORS_ADS7871=y
# CONFIG_SENSORS_AMC6821 is not set
CONFIG_SENSORS_INA209=m
# CONFIG_SENSORS_INA2XX is not set
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=y
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
CONFIG_SENSORS_TMP103=y
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
# CONFIG_SENSORS_TMP421 is not set
CONFIG_SENSORS_TWL4030_MADC=m
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83781D=y
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
CONFIG_SENSORS_W83793=y
# CONFIG_SENSORS_W83795 is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
# CONFIG_SENSORS_W83627EHF is not set
CONFIG_SENSORS_WM831X=y

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=y
CONFIG_THERMAL=y
# CONFIG_THERMAL_HWMON is not set
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR=y
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_GOV_STEP_WISE is not set
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
# CONFIG_THERMAL_EMULATION is not set
CONFIG_INTEL_SOC_DTS_IOSF_CORE=y
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=y
CONFIG_ACPI_THERMAL_REL=y
CONFIG_INT3406_THERMAL=m
# CONFIG_INTEL_PCH_THERMAL is not set
CONFIG_GENERIC_ADC_THERMAL=m
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
CONFIG_WATCHDOG_NOWAYOUT=y
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
# CONFIG_DA9052_WATCHDOG is not set
CONFIG_DA9063_WATCHDOG=y
# CONFIG_DA9062_WATCHDOG is not set
CONFIG_MENF21BMC_WATCHDOG=y
# CONFIG_WDAT_WDT is not set
# CONFIG_WM831X_WATCHDOG is not set
# CONFIG_XILINX_WATCHDOG is not set
CONFIG_ZIIRAVE_WATCHDOG=y
CONFIG_CADENCE_WATCHDOG=m
# CONFIG_DW_WATCHDOG is not set
CONFIG_TWL4030_WATCHDOG=y
CONFIG_MAX63XX_WATCHDOG=m
CONFIG_ACQUIRE_WDT=m
CONFIG_ADVANTECH_WDT=y
# CONFIG_ALIM1535_WDT is not set
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=y
# CONFIG_SP5100_TCO is not set
# CONFIG_GEODE_WDT is not set
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_IBMASR is not set
CONFIG_WAFER_WDT=y
# CONFIG_I6300ESB_WDT is not set
CONFIG_IE6XX_WDT=y
# CONFIG_ITCO_WDT is not set
CONFIG_IT8712F_WDT=m
# CONFIG_IT87_WDT is not set
# CONFIG_HP_WATCHDOG is not set
# CONFIG_KEMPLD_WDT is not set
CONFIG_SC1200_WDT=m
CONFIG_SCx200_WDT=m
CONFIG_PC87413_WDT=m
CONFIG_NV_TCO=m
# CONFIG_RDC321X_WDT is not set
CONFIG_60XX_WDT=y
CONFIG_SBC8360_WDT=m
# CONFIG_SBC7240_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=y
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_VIA_WDT is not set
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
# CONFIG_MACHZ_WDT is not set
CONFIG_SBC_EPX_C3_WATCHDOG=m
CONFIG_INTEL_MEI_WDT=m
CONFIG_NI903X_WDT=m
CONFIG_NIC7018_WDT=y
# CONFIG_MEN_A21_WDT is not set

#
# ISA-based Watchdog Cards
#
# CONFIG_PCWATCHDOG is not set
# CONFIG_MIXCOMWD is not set
# CONFIG_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=y
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
CONFIG_SSB_POSSIBLE=y

#
# Sonics Silicon Backplane
#
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y

#
# Broadcom specific AMBA
#
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
CONFIG_BCMA_HOST_SOC=y
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_SFLASH=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_CS5535=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_BCM590XX=y
# CONFIG_MFD_AXP20X_I2C is not set
CONFIG_MFD_CROS_EC=y
CONFIG_MFD_CROS_EC_I2C=y
CONFIG_MFD_CROS_EC_SPI=m
# CONFIG_PMIC_DA903X is not set
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_SPI=y
CONFIG_MFD_DA9052_I2C=y
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=m
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
CONFIG_MFD_DLN2=m
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
# CONFIG_MFD_MC13XXX_I2C is not set
CONFIG_HTC_PASIC3=y
# CONFIG_HTC_I2CPLD is not set
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=m
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC is not set
CONFIG_MFD_INTEL_LPSS=m
CONFIG_MFD_INTEL_LPSS_ACPI=m
# CONFIG_MFD_INTEL_LPSS_PCI is not set
CONFIG_MFD_JANZ_CMODIO=m
CONFIG_MFD_KEMPLD=m
# CONFIG_MFD_88PM800 is not set
CONFIG_MFD_88PM805=y
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=y
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
CONFIG_MFD_MAX8907=m
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6397=m
CONFIG_MFD_MENF21BMC=y
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_VIPERBOARD=y
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=m
# CONFIG_PCF50633_ADC is not set
CONFIG_PCF50633_GPIO=m
CONFIG_UCB1400_CORE=m
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RTSX_PCI is not set
CONFIG_MFD_RT5033=m
# CONFIG_MFD_RTSX_USB is not set
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SM501=y
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
CONFIG_MFD_LP3943=y
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_PALMAS=y
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=m
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS65217=y
# CONFIG_MFD_TI_LP873X is not set
CONFIG_MFD_TPS65218=m
CONFIG_MFD_TPS6586X=y
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=y
# CONFIG_MFD_TPS65912_I2C is not set
CONFIG_MFD_TPS65912_SPI=y
CONFIG_MFD_TPS80031=y
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=m
CONFIG_MFD_LM3533=m
CONFIG_MFD_TIMBERDALE=y
# CONFIG_MFD_TMIO is not set
CONFIG_MFD_VX855=y
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_CS47L24 is not set
# CONFIG_MFD_WM5102 is not set
# CONFIG_MFD_WM5110 is not set
# CONFIG_MFD_WM8997 is not set
CONFIG_MFD_WM8998=y
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=y
# CONFIG_REGULATOR is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
# CONFIG_AGP is not set
# CONFIG_VGA_ARB is not set
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set

#
# ACP (Audio CoProcessor) Configuration
#
# CONFIG_DRM_LIB_RANDOM is not set

#
# Frame buffer Devices
#
CONFIG_FB=m
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB_DDC=m
# CONFIG_FB_BOOT_VESA_SUPPORT is not set
CONFIG_FB_CFB_FILLRECT=m
CONFIG_FB_CFB_COPYAREA=m
CONFIG_FB_CFB_IMAGEBLIT=m
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_PROVIDE_GET_FB_UNMAPPED_AREA is not set
CONFIG_FB_FOREIGN_ENDIAN=y
CONFIG_FB_BOTH_ENDIAN=y
# CONFIG_FB_BIG_ENDIAN is not set
# CONFIG_FB_LITTLE_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_SVGALIB=m
# CONFIG_FB_MACMODES is not set
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
CONFIG_FB_CYBER2000=m
CONFIG_FB_CYBER2000_DDC=y
CONFIG_FB_ARC=m
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
CONFIG_FB_OPENCORES=m
CONFIG_FB_S1D13XXX=m
CONFIG_FB_NVIDIA=m
# CONFIG_FB_NVIDIA_I2C is not set
CONFIG_FB_NVIDIA_DEBUG=y
# CONFIG_FB_NVIDIA_BACKLIGHT is not set
CONFIG_FB_RIVA=m
# CONFIG_FB_RIVA_I2C is not set
# CONFIG_FB_RIVA_DEBUG is not set
CONFIG_FB_RIVA_BACKLIGHT=y
CONFIG_FB_I740=m
CONFIG_FB_LE80578=m
CONFIG_FB_CARILLO_RANCH=m
CONFIG_FB_MATROX=m
# CONFIG_FB_MATROX_MILLENIUM is not set
CONFIG_FB_MATROX_MYSTIQUE=y
CONFIG_FB_MATROX_G=y
# CONFIG_FB_MATROX_I2C is not set
CONFIG_FB_RADEON=m
CONFIG_FB_RADEON_I2C=y
# CONFIG_FB_RADEON_BACKLIGHT is not set
CONFIG_FB_RADEON_DEBUG=y
CONFIG_FB_ATY128=m
CONFIG_FB_ATY128_BACKLIGHT=y
CONFIG_FB_ATY=m
# CONFIG_FB_ATY_CT is not set
CONFIG_FB_ATY_GX=y
# CONFIG_FB_ATY_BACKLIGHT is not set
CONFIG_FB_S3=m
# CONFIG_FB_S3_DDC is not set
CONFIG_FB_SAVAGE=m
# CONFIG_FB_SAVAGE_I2C is not set
# CONFIG_FB_SAVAGE_ACCEL is not set
# CONFIG_FB_SIS is not set
CONFIG_FB_VIA=m
# CONFIG_FB_VIA_DIRECT_PROCFS is not set
# CONFIG_FB_VIA_X_COMPATIBILITY is not set
CONFIG_FB_NEOMAGIC=m
# CONFIG_FB_KYRO is not set
CONFIG_FB_3DFX=m
CONFIG_FB_3DFX_ACCEL=y
# CONFIG_FB_3DFX_I2C is not set
CONFIG_FB_VOODOO1=m
CONFIG_FB_VT8623=m
# CONFIG_FB_TRIDENT is not set
CONFIG_FB_ARK=m
CONFIG_FB_PM3=m
CONFIG_FB_CARMINE=m
CONFIG_FB_CARMINE_DRAM_EVAL=y
# CONFIG_CARMINE_DRAM_CUSTOM is not set
CONFIG_FB_GEODE=y
CONFIG_FB_GEODE_LX=m
CONFIG_FB_GEODE_GX=m
CONFIG_FB_GEODE_GX1=m
CONFIG_FB_SM501=m
CONFIG_FB_SMSCUFX=m
# CONFIG_FB_UDL is not set
CONFIG_FB_IBM_GXT4500=m
CONFIG_FB_GOLDFISH=m
# CONFIG_FB_VIRTUAL is not set
CONFIG_FB_METRONOME=m
# CONFIG_FB_MB862XX is not set
CONFIG_FB_BROADSHEET=m
CONFIG_FB_AUO_K190X=m
CONFIG_FB_AUO_K1900=m
# CONFIG_FB_AUO_K1901 is not set
CONFIG_FB_SM712=m
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
CONFIG_LCD_LMS283GF05=m
# CONFIG_LCD_LTV350QV is not set
CONFIG_LCD_ILI922X=m
CONFIG_LCD_ILI9320=m
CONFIG_LCD_TDO24M=m
CONFIG_LCD_VGG2432A4=m
CONFIG_LCD_PLATFORM=m
CONFIG_LCD_S6E63M0=m
CONFIG_LCD_LD9040=m
CONFIG_LCD_AMS369FG06=m
CONFIG_LCD_LMS501KF03=m
CONFIG_LCD_HX8357=m
CONFIG_BACKLIGHT_CLASS_DEVICE=m
# CONFIG_BACKLIGHT_GENERIC is not set
CONFIG_BACKLIGHT_LM3533=m
CONFIG_BACKLIGHT_CARILLO_RANCH=m
# CONFIG_BACKLIGHT_DA9052 is not set
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_PM8941_WLED=m
# CONFIG_BACKLIGHT_SAHARA is not set
CONFIG_BACKLIGHT_WM831X=m
CONFIG_BACKLIGHT_ADP8860=m
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_PCF50633 is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_PANDORA=m
CONFIG_BACKLIGHT_SKY81452=m
# CONFIG_BACKLIGHT_TPS65217 is not set
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
CONFIG_BACKLIGHT_BD6107=m
CONFIG_VGASTATE=m
CONFIG_HDMI=y
# CONFIG_LOGO is not set
CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_PCM_ELD=y
CONFIG_SND_DMAENGINE_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
# CONFIG_SND_PCM_OSS is not set
# CONFIG_SND_PCM_TIMER is not set
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
# CONFIG_SND_PROC_FS is not set
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
# CONFIG_SND_DEBUG_VERBOSE is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
# CONFIG_SND_RAWMIDI_SEQ is not set
# CONFIG_SND_OPL3_LIB_SEQ is not set
# CONFIG_SND_OPL4_LIB_SEQ is not set
# CONFIG_SND_SBAWE_SEQ is not set
# CONFIG_SND_EMU10K1_SEQ is not set
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL4_LIB=m
CONFIG_SND_AC97_CODEC=m
# CONFIG_SND_DRIVERS is not set
CONFIG_SND_WSS_LIB=m
CONFIG_SND_SB_COMMON=m
CONFIG_SND_SB8_DSP=m
CONFIG_SND_SB16_DSP=m
CONFIG_SND_ISA=y
# CONFIG_SND_ADLIB is not set
CONFIG_SND_AD1816A=m
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_ALS100 is not set
CONFIG_SND_AZT1605=m
CONFIG_SND_AZT2316=m
CONFIG_SND_AZT2320=m
CONFIG_SND_CMI8328=m
# CONFIG_SND_CMI8330 is not set
CONFIG_SND_CS4231=m
CONFIG_SND_CS4236=m
# CONFIG_SND_ES1688 is not set
CONFIG_SND_ES18XX=m
CONFIG_SND_SC6000=m
CONFIG_SND_GUSCLASSIC=m
CONFIG_SND_GUSEXTREME=m
CONFIG_SND_GUSMAX=m
CONFIG_SND_INTERWAVE=m
CONFIG_SND_INTERWAVE_STB=m
CONFIG_SND_JAZZ16=m
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
CONFIG_SND_MIRO=m
CONFIG_SND_SB8=m
# CONFIG_SND_SB16 is not set
CONFIG_SND_SBAWE=m
# CONFIG_SND_SB16_CSP is not set
CONFIG_SND_SSCAPE=m
CONFIG_SND_WAVEFRONT=m
# CONFIG_SND_MSND_PINNACLE is not set
# CONFIG_SND_MSND_CLASSIC is not set
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
CONFIG_SND_ALS4000=m
# CONFIG_SND_ASIHPI is not set
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AW2 is not set
CONFIG_SND_BT87X=m
CONFIG_SND_BT87X_OVERCLOCK=y
CONFIG_SND_CA0106=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
# CONFIG_SND_CS4281 is not set
CONFIG_SND_CS46XX=m
# CONFIG_SND_CS46XX_NEW_DSP is not set
# CONFIG_SND_CS5530 is not set
# CONFIG_SND_CS5535AUDIO is not set
CONFIG_SND_CTXFI=m
# CONFIG_SND_DARLA20 is not set
CONFIG_SND_GINA20=m
CONFIG_SND_LAYLA20=m
CONFIG_SND_DARLA24=m
CONFIG_SND_GINA24=m
CONFIG_SND_LAYLA24=m
CONFIG_SND_MONA=m
CONFIG_SND_MIA=m
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
CONFIG_SND_INDIGODJ=m
CONFIG_SND_INDIGOIOX=m
CONFIG_SND_INDIGODJX=m
# CONFIG_SND_ENS1370 is not set
CONFIG_SND_ENS1371=m
CONFIG_SND_FM801=m
CONFIG_SND_HDSP=m
# CONFIG_SND_HDSPM is not set
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_KORG1212=m
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
CONFIG_SND_MIXART=m
CONFIG_SND_NM256=m
# CONFIG_SND_PCXHR is not set
CONFIG_SND_RIPTIDE=m
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
# CONFIG_SND_RME9652 is not set
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VIRTUOSO=m
# CONFIG_SND_VX222 is not set
CONFIG_SND_YMFPCI=m

#
# HD-Audio
#
# CONFIG_SND_HDA_INTEL is not set
CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_EXT_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=64
# CONFIG_SND_SPI is not set
CONFIG_SND_USB=y
# CONFIG_SND_USB_AUDIO is not set
CONFIG_SND_USB_UA101=m
CONFIG_SND_USB_USX2Y=m
CONFIG_SND_USB_CAIAQ=m
# CONFIG_SND_USB_CAIAQ_INPUT is not set
CONFIG_SND_USB_US122L=m
# CONFIG_SND_USB_6FIRE is not set
CONFIG_SND_USB_HIFACE=m
# CONFIG_SND_BCD2000 is not set
CONFIG_SND_USB_LINE6=m
CONFIG_SND_USB_POD=m
CONFIG_SND_USB_PODHD=m
CONFIG_SND_USB_TONEPORT=m
CONFIG_SND_USB_VARIAX=m
# CONFIG_SND_FIREWIRE is not set
CONFIG_SND_SOC=m
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_AMD_ACP=m
CONFIG_SND_ATMEL_SOC=m
CONFIG_SND_DESIGNWARE_I2S=m
CONFIG_SND_DESIGNWARE_PCM=m

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
CONFIG_SND_SOC_FSL_SAI=m
CONFIG_SND_SOC_FSL_SSI=m
CONFIG_SND_SOC_FSL_SPDIF=m
CONFIG_SND_SOC_FSL_ESAI=m
# CONFIG_SND_SOC_IMX_AUDMUX is not set
CONFIG_SND_SOC_IMG=y
CONFIG_SND_SOC_IMG_I2S_IN=m
# CONFIG_SND_SOC_IMG_I2S_OUT is not set
# CONFIG_SND_SOC_IMG_PARALLEL_OUT is not set
CONFIG_SND_SOC_IMG_SPDIF_IN=m
# CONFIG_SND_SOC_IMG_SPDIF_OUT is not set
# CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=m
CONFIG_SND_SST_IPC=m
CONFIG_SND_SST_IPC_ACPI=m
CONFIG_SND_SOC_INTEL_SST=m
CONFIG_SND_SOC_INTEL_SST_ACPI=m
CONFIG_SND_SOC_INTEL_SST_MATCH=m
# CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH is not set
CONFIG_SND_SOC_INTEL_BXT_RT298_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH=m
CONFIG_SND_SOC_INTEL_SKYLAKE=m
# CONFIG_SND_SOC_INTEL_SKL_RT286_MACH is not set
CONFIG_SND_SOC_XTFPGA_I2S=m
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
CONFIG_SND_SOC_AC97_CODEC=m
CONFIG_SND_SOC_ADAU1701=m
CONFIG_SND_SOC_ADAU7002=m
CONFIG_SND_SOC_AK4104=m
CONFIG_SND_SOC_AK4554=m
CONFIG_SND_SOC_AK4613=m
# CONFIG_SND_SOC_AK4642 is not set
# CONFIG_SND_SOC_AK5386 is not set
CONFIG_SND_SOC_ALC5623=m
# CONFIG_SND_SOC_BT_SCO is not set
# CONFIG_SND_SOC_CS35L32 is not set
CONFIG_SND_SOC_CS35L33=m
CONFIG_SND_SOC_CS35L34=m
CONFIG_SND_SOC_CS42L42=m
CONFIG_SND_SOC_CS42L51=m
CONFIG_SND_SOC_CS42L51_I2C=m
CONFIG_SND_SOC_CS42L52=m
CONFIG_SND_SOC_CS42L56=m
CONFIG_SND_SOC_CS42L73=m
CONFIG_SND_SOC_CS4265=m
# CONFIG_SND_SOC_CS4270 is not set
CONFIG_SND_SOC_CS4271=m
CONFIG_SND_SOC_CS4271_I2C=m
# CONFIG_SND_SOC_CS4271_SPI is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
CONFIG_SND_SOC_CS4349=m
CONFIG_SND_SOC_CS53L30=m
CONFIG_SND_SOC_DMIC=m
CONFIG_SND_SOC_ES8328=m
CONFIG_SND_SOC_ES8328_I2C=m
CONFIG_SND_SOC_ES8328_SPI=m
CONFIG_SND_SOC_GTM601=m
CONFIG_SND_SOC_HDAC_HDMI=m
# CONFIG_SND_SOC_INNO_RK3036 is not set
CONFIG_SND_SOC_MAX98504=m
CONFIG_SND_SOC_MAX9860=m
CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=m
CONFIG_SND_SOC_PCM1681=m
CONFIG_SND_SOC_PCM179X=m
# CONFIG_SND_SOC_PCM179X_I2C is not set
CONFIG_SND_SOC_PCM179X_SPI=m
CONFIG_SND_SOC_PCM3168A=m
CONFIG_SND_SOC_PCM3168A_I2C=m
# CONFIG_SND_SOC_PCM3168A_SPI is not set
CONFIG_SND_SOC_PCM512x=m
# CONFIG_SND_SOC_PCM512x_I2C is not set
CONFIG_SND_SOC_PCM512x_SPI=m
CONFIG_SND_SOC_RL6231=m
CONFIG_SND_SOC_RL6347A=m
CONFIG_SND_SOC_RT298=m
CONFIG_SND_SOC_RT5616=m
CONFIG_SND_SOC_RT5631=m
CONFIG_SND_SOC_RT5640=m
CONFIG_SND_SOC_RT5651=m
# CONFIG_SND_SOC_RT5677_SPI is not set
CONFIG_SND_SOC_SGTL5000=m
CONFIG_SND_SOC_SIGMADSP=m
CONFIG_SND_SOC_SIGMADSP_I2C=m
CONFIG_SND_SOC_SIRF_AUDIO_CODEC=m
CONFIG_SND_SOC_SPDIF=m
CONFIG_SND_SOC_SSM2602=m
CONFIG_SND_SOC_SSM2602_SPI=m
CONFIG_SND_SOC_SSM2602_I2C=m
# CONFIG_SND_SOC_SSM4567 is not set
CONFIG_SND_SOC_STA32X=m
CONFIG_SND_SOC_STA350=m
CONFIG_SND_SOC_STI_SAS=m
CONFIG_SND_SOC_TAS2552=m
# CONFIG_SND_SOC_TAS5086 is not set
# CONFIG_SND_SOC_TAS571X is not set
CONFIG_SND_SOC_TAS5720=m
CONFIG_SND_SOC_TFA9879=m
CONFIG_SND_SOC_TLV320AIC23=m
CONFIG_SND_SOC_TLV320AIC23_I2C=m
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
CONFIG_SND_SOC_TLV320AIC31XX=m
# CONFIG_SND_SOC_TLV320AIC3X is not set
CONFIG_SND_SOC_TS3A227E=m
CONFIG_SND_SOC_WM8510=m
CONFIG_SND_SOC_WM8523=m
CONFIG_SND_SOC_WM8580=m
# CONFIG_SND_SOC_WM8711 is not set
# CONFIG_SND_SOC_WM8728 is not set
CONFIG_SND_SOC_WM8731=m
CONFIG_SND_SOC_WM8737=m
CONFIG_SND_SOC_WM8741=m
# CONFIG_SND_SOC_WM8750 is not set
CONFIG_SND_SOC_WM8753=m
CONFIG_SND_SOC_WM8770=m
# CONFIG_SND_SOC_WM8776 is not set
CONFIG_SND_SOC_WM8804=m
CONFIG_SND_SOC_WM8804_I2C=m
# CONFIG_SND_SOC_WM8804_SPI is not set
# CONFIG_SND_SOC_WM8903 is not set
# CONFIG_SND_SOC_WM8960 is not set
CONFIG_SND_SOC_WM8962=m
# CONFIG_SND_SOC_WM8974 is not set
# CONFIG_SND_SOC_WM8978 is not set
# CONFIG_SND_SOC_WM8985 is not set
CONFIG_SND_SOC_NAU8540=m
# CONFIG_SND_SOC_NAU8810 is not set
CONFIG_SND_SOC_TPA6130A2=m
CONFIG_SND_SIMPLE_CARD_UTILS=m
CONFIG_SND_SIMPLE_CARD=m
CONFIG_SND_X86=m
CONFIG_SOUND_PRIME=m
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_OSS is not set
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=y
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=y
# CONFIG_HID_CHERRY is not set
CONFIG_HID_CHICONY=y
CONFIG_HID_CORSAIR=y
# CONFIG_HID_PRODIKEYS is not set
CONFIG_HID_CMEDIA=y
# CONFIG_HID_CYPRESS is not set
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
CONFIG_HID_EMS_FF=y
CONFIG_HID_ELECOM=y
CONFIG_HID_EZKEY=m
CONFIG_HID_GEMBIRD=y
CONFIG_HID_GFRM=m
# CONFIG_HID_KEYTOUCH is not set
CONFIG_HID_KYE=m
# CONFIG_HID_WALTOP is not set
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
CONFIG_HID_TWINHAN=m
# CONFIG_HID_KENSINGTON is not set
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=y
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
CONFIG_LOGITECH_FF=y
CONFIG_LOGIRUMBLEPAD2_FF=y
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MAYFLASH=y
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=y
CONFIG_HID_ORTEK=y
# CONFIG_HID_PANTHERLORD is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
# CONFIG_HID_PICOLCD_LCD is not set
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PLANTRONICS=m
CONFIG_HID_PRIMAX=m
CONFIG_HID_SAITEK=m
# CONFIG_HID_SAMSUNG is not set
CONFIG_HID_SPEEDLINK=y
CONFIG_HID_STEELSERIES=y
# CONFIG_HID_SUNPLUS is not set
CONFIG_HID_RMI=y
# CONFIG_HID_GREENASIA is not set
CONFIG_HID_SMARTJOYPLUS=y
# CONFIG_SMARTJOYPLUS_FF is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
CONFIG_HID_UDRAW_PS3=m
CONFIG_HID_WACOM=y
CONFIG_HID_WIIMOTE=y
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=y
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m

#
# USB HID support
#
# CONFIG_USB_HID is not set
CONFIG_HID_PID=y

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
CONFIG_USB_MOUSE=y

#
# I2C HID support
#
CONFIG_I2C_HID=y
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_OTG=y
CONFIG_USB_OTG_WHITELIST=y
CONFIG_USB_OTG_BLACKLIST_HUB=y
CONFIG_USB_OTG_FSM=m
# CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
# CONFIG_USB_MON is not set
CONFIG_USB_WUSB=m
CONFIG_USB_WUSB_CBAF=y
# CONFIG_USB_WUSB_CBAF_DEBUG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=m
# CONFIG_USB_XHCI_HCD is not set
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OXU210HP_HCD is not set
CONFIG_USB_ISP116X_HCD=m
CONFIG_USB_ISP1362_HCD=y
CONFIG_USB_FOTG210_HCD=m
CONFIG_USB_MAX3421_HCD=y
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=m
CONFIG_USB_OHCI_HCD_PLATFORM=y
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_SL811_HCD=m
# CONFIG_USB_SL811_HCD_ISO is not set
CONFIG_USB_R8A66597_HCD=y
# CONFIG_USB_WHCI_HCD is not set
# CONFIG_USB_HWA_HCD is not set
CONFIG_USB_HCD_BCMA=y
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
# CONFIG_USB_PRINTER is not set
CONFIG_USB_WDM=y
CONFIG_USB_TMC=y

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=y
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_STORAGE_REALTEK=y
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=y
CONFIG_USB_STORAGE_ALAUDA=y
CONFIG_USB_STORAGE_ONETOUCH=y
CONFIG_USB_STORAGE_KARMA=y
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
CONFIG_USB_STORAGE_ENE_UB6250=y
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
CONFIG_USBIP_CORE=m
CONFIG_USBIP_VHCI_HCD=m
CONFIG_USBIP_VHCI_HC_PORTS=8
CONFIG_USBIP_VHCI_NR_HCS=1
CONFIG_USBIP_HOST=m
CONFIG_USBIP_DEBUG=y
CONFIG_USB_MUSB_HDRC=y
CONFIG_USB_MUSB_HOST=y

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
# CONFIG_MUSB_PIO_ONLY is not set
CONFIG_USB_DWC3=m
CONFIG_USB_DWC3_ULPI=y
CONFIG_USB_DWC3_HOST=y

#
# Platform Glue Driver Support
#
# CONFIG_USB_DWC3_PCI is not set
CONFIG_USB_DWC2=m
CONFIG_USB_DWC2_HOST=y

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
CONFIG_USB_DWC2_PCI=m
# CONFIG_USB_DWC2_DEBUG is not set
CONFIG_USB_DWC2_TRACK_MISSED_SOFS=y
CONFIG_USB_ISP1760=y
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1760_HOST_ROLE=y

#
# USB port drivers
#
CONFIG_USB_USS720=y
CONFIG_USB_SERIAL=y
# CONFIG_USB_SERIAL_CONSOLE is not set
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_SIMPLE=y
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=y
CONFIG_USB_SERIAL_BELKIN=y
# CONFIG_USB_SERIAL_CH341 is not set
CONFIG_USB_SERIAL_WHITEHEAT=y
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=y
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
CONFIG_USB_SERIAL_F8153X=y
CONFIG_USB_SERIAL_GARMIN=y
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=y
# CONFIG_USB_SERIAL_KEYSPAN_MPR is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
CONFIG_USB_SERIAL_KEYSPAN_USA28X=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XA=y
# CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
CONFIG_USB_SERIAL_KEYSPAN_USA19W=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QW=y
# CONFIG_USB_SERIAL_KEYSPAN_USA19QI is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49WLC is not set
CONFIG_USB_SERIAL_KLSI=y
CONFIG_USB_SERIAL_KOBIL_SCT=y
CONFIG_USB_SERIAL_MCT_U232=m
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7715_PARPORT=y
CONFIG_USB_SERIAL_MOS7840=m
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
CONFIG_USB_SERIAL_PL2303=y
# CONFIG_USB_SERIAL_OTI6858 is not set
CONFIG_USB_SERIAL_QCAUX=m
CONFIG_USB_SERIAL_QUALCOMM=y
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
CONFIG_USB_SERIAL_SYMBOL=m
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=y
CONFIG_USB_SERIAL_WWAN=y
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
CONFIG_USB_SERIAL_XSENS_MT=m
CONFIG_USB_SERIAL_WISHBONE=m
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
CONFIG_USB_SERIAL_UPD78F0730=m
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=y
# CONFIG_USB_EMI26 is not set
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=y
CONFIG_USB_RIO500=m
CONFIG_USB_LEGOTOWER=y
CONFIG_USB_LCD=m
# CONFIG_USB_CYPRESS_CY7C63 is not set
CONFIG_USB_CYTHERM=m
CONFIG_USB_IDMOUSE=y
# CONFIG_USB_FTDI_ELAN is not set
CONFIG_USB_APPLEDISPLAY=m
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_LD=y
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=m
CONFIG_USB_TEST=m
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=m
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=y
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=m
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
CONFIG_USB_CHAOSKEY=m
CONFIG_UCSI=y
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m
CONFIG_USB_CXACRU=m
CONFIG_USB_UEAGLEATM=m
CONFIG_USB_XUSBATM=m

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=m
CONFIG_USB_GPIO_VBUS=y
CONFIG_USB_ISP1301=m
# CONFIG_USB_GADGET is not set
CONFIG_USB_LED_TRIG=y
CONFIG_USB_ULPI_BUS=y
CONFIG_UWB=y
CONFIG_UWB_HWA=m
# CONFIG_UWB_WHCI is not set
CONFIG_UWB_I1480U=m
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_LM3530=m
CONFIG_LEDS_LM3533=m
# CONFIG_LEDS_LM3642 is not set
CONFIG_LEDS_PCA9532=m
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=m
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
# CONFIG_LEDS_LP5523 is not set
# CONFIG_LEDS_LP5562 is not set
CONFIG_LEDS_LP8501=m
CONFIG_LEDS_LP8860=y
CONFIG_LEDS_PCA955X=m
CONFIG_LEDS_PCA963X=m
CONFIG_LEDS_WM831X_STATUS=y
CONFIG_LEDS_DA9052=y
CONFIG_LEDS_DAC124S085=m
CONFIG_LEDS_BD2802=y
CONFIG_LEDS_LT3593=m
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_TCA6507=m
CONFIG_LEDS_TLC591XX=m
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_OT200=y
CONFIG_LEDS_MENF21BMC=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_USER=m
CONFIG_LEDS_NIC78BX=m

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
# CONFIG_LEDS_TRIGGER_CPU is not set
CONFIG_LEDS_TRIGGER_GPIO=y
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
# CONFIG_LEDS_TRIGGER_CAMERA is not set
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_ACCESSIBILITY is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
CONFIG_EDAC_DEBUG=y
# CONFIG_EDAC_MM_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
# CONFIG_RTC_INTF_DEV is not set
CONFIG_RTC_DRV_TEST=y

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_ABB5ZES3=y
CONFIG_RTC_DRV_ABX80X=m
CONFIG_RTC_DRV_DS1307=y
CONFIG_RTC_DRV_DS1307_HWMON=y
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=y
CONFIG_RTC_DRV_DS1374_WDT=y
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=y
CONFIG_RTC_DRV_MAX8907=m
CONFIG_RTC_DRV_MAX8998=y
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
# CONFIG_RTC_DRV_ISL12022 is not set
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=y
CONFIG_RTC_DRV_PCF85063=m
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
CONFIG_RTC_DRV_M41T80=y
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
CONFIG_RTC_DRV_PALMAS=y
CONFIG_RTC_DRV_TPS6586X=m
CONFIG_RTC_DRV_TPS65910=m
CONFIG_RTC_DRV_TPS80031=m
CONFIG_RTC_DRV_S35390A=m
# CONFIG_RTC_DRV_FM3130 is not set
# CONFIG_RTC_DRV_RX8010 is not set
# CONFIG_RTC_DRV_RX8581 is not set
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=y
CONFIG_RTC_DRV_RV8803=y
# CONFIG_RTC_DRV_S5M is not set

#
# SPI RTC drivers
#
CONFIG_RTC_DRV_M41T93=m
CONFIG_RTC_DRV_M41T94=m
CONFIG_RTC_DRV_DS1302=y
CONFIG_RTC_DRV_DS1305=m
# CONFIG_RTC_DRV_DS1343 is not set
CONFIG_RTC_DRV_DS1347=m
# CONFIG_RTC_DRV_DS1390 is not set
CONFIG_RTC_DRV_MAX6916=m
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=y
CONFIG_RTC_DRV_RX6110=m
CONFIG_RTC_DRV_RS5C348=m
# CONFIG_RTC_DRV_MAX6902 is not set
CONFIG_RTC_DRV_PCF2123=m
CONFIG_RTC_DRV_MCP795=m
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=y
CONFIG_RTC_DRV_RV3029_HWMON=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=m
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=y
CONFIG_RTC_DRV_DS1553=m
CONFIG_RTC_DRV_DS1685_FAMILY=m
# CONFIG_RTC_DRV_DS1685 is not set
# CONFIG_RTC_DRV_DS1689 is not set
# CONFIG_RTC_DRV_DS17285 is not set
CONFIG_RTC_DRV_DS17485=y
# CONFIG_RTC_DRV_DS17885 is not set
# CONFIG_RTC_DS1685_PROC_REGS is not set
# CONFIG_RTC_DS1685_SYSFS_REGS is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_DS2404 is not set
CONFIG_RTC_DRV_DA9052=y
# CONFIG_RTC_DRV_DA9063 is not set
CONFIG_RTC_DRV_STK17TA8=y
CONFIG_RTC_DRV_M48T86=y
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=y
CONFIG_RTC_DRV_MSM6242=y
# CONFIG_RTC_DRV_BQ4802 is not set
CONFIG_RTC_DRV_RP5C01=y
# CONFIG_RTC_DRV_V3020 is not set
CONFIG_RTC_DRV_WM831X=m
# CONFIG_RTC_DRV_PCF50633 is not set

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_MC13XXX is not set
CONFIG_RTC_DRV_MT6397=m

#
# HID Sensor RTC drivers
#
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=m
CONFIG_DMA_ACPI=y
CONFIG_INTEL_IDMA64=m
# CONFIG_PCH_DMA is not set
CONFIG_TIMB_DMA=m
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=m
CONFIG_DW_DMAC=m
# CONFIG_DW_DMAC_PCI is not set

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
CONFIG_DMATEST=m

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
CONFIG_AUXDISPLAY=y
# CONFIG_KS0108 is not set
CONFIG_IMG_ASCII_LCD=y
CONFIG_UIO=y
CONFIG_UIO_CIF=y
CONFIG_UIO_PDRV_GENIRQ=y
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=y
CONFIG_UIO_NETX=y
CONFIG_UIO_PRUSS=m
CONFIG_UIO_MF624=m
CONFIG_VIRT_DRIVERS=y
CONFIG_VIRTIO=y

#
# Virtio drivers
#
# CONFIG_VIRTIO_PCI is not set
# CONFIG_VIRTIO_BALLOON is not set
# CONFIG_VIRTIO_INPUT is not set
CONFIG_VIRTIO_MMIO=y
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
CONFIG_STAGING=y
CONFIG_COMEDI=m
CONFIG_COMEDI_DEBUG=y
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
# CONFIG_COMEDI_BOND is not set
CONFIG_COMEDI_TEST=m
CONFIG_COMEDI_PARPORT=m
# CONFIG_COMEDI_SERIAL2002 is not set
CONFIG_COMEDI_SSV_DNP=m
# CONFIG_COMEDI_ISA_DRIVERS is not set
CONFIG_COMEDI_PCI_DRIVERS=m
# CONFIG_COMEDI_8255_PCI is not set
CONFIG_COMEDI_ADDI_WATCHDOG=m
CONFIG_COMEDI_ADDI_APCI_1032=m
CONFIG_COMEDI_ADDI_APCI_1500=m
CONFIG_COMEDI_ADDI_APCI_1516=m
CONFIG_COMEDI_ADDI_APCI_1564=m
# CONFIG_COMEDI_ADDI_APCI_16XX is not set
CONFIG_COMEDI_ADDI_APCI_2032=m
CONFIG_COMEDI_ADDI_APCI_2200=m
# CONFIG_COMEDI_ADDI_APCI_3120 is not set
CONFIG_COMEDI_ADDI_APCI_3501=m
CONFIG_COMEDI_ADDI_APCI_3XXX=m
# CONFIG_COMEDI_ADL_PCI6208 is not set
CONFIG_COMEDI_ADL_PCI7X3X=m
CONFIG_COMEDI_ADL_PCI8164=m
CONFIG_COMEDI_ADL_PCI9111=m
# CONFIG_COMEDI_ADL_PCI9118 is not set
# CONFIG_COMEDI_ADV_PCI1710 is not set
CONFIG_COMEDI_ADV_PCI1720=m
CONFIG_COMEDI_ADV_PCI1723=m
# CONFIG_COMEDI_ADV_PCI1724 is not set
CONFIG_COMEDI_ADV_PCI1760=m
# CONFIG_COMEDI_ADV_PCI_DIO is not set
CONFIG_COMEDI_AMPLC_DIO200_PCI=m
CONFIG_COMEDI_AMPLC_PC236_PCI=m
CONFIG_COMEDI_AMPLC_PC263_PCI=m
CONFIG_COMEDI_AMPLC_PCI224=m
# CONFIG_COMEDI_AMPLC_PCI230 is not set
CONFIG_COMEDI_CONTEC_PCI_DIO=m
# CONFIG_COMEDI_DAS08_PCI is not set
CONFIG_COMEDI_DT3000=m
CONFIG_COMEDI_DYNA_PCI10XX=m
# CONFIG_COMEDI_GSC_HPDI is not set
CONFIG_COMEDI_MF6X4=m
# CONFIG_COMEDI_ICP_MULTI is not set
# CONFIG_COMEDI_DAQBOARD2000 is not set
CONFIG_COMEDI_JR3_PCI=m
CONFIG_COMEDI_KE_COUNTER=m
# CONFIG_COMEDI_CB_PCIDAS64 is not set
# CONFIG_COMEDI_CB_PCIDAS is not set
CONFIG_COMEDI_CB_PCIDDA=m
CONFIG_COMEDI_CB_PCIMDAS=m
CONFIG_COMEDI_CB_PCIMDDA=m
# CONFIG_COMEDI_ME4000 is not set
CONFIG_COMEDI_ME_DAQ=m
# CONFIG_COMEDI_NI_6527 is not set
CONFIG_COMEDI_NI_65XX=m
# CONFIG_COMEDI_NI_660X is not set
# CONFIG_COMEDI_NI_670X is not set
CONFIG_COMEDI_NI_LABPC_PCI=m
# CONFIG_COMEDI_NI_PCIDIO is not set
# CONFIG_COMEDI_NI_PCIMIO is not set
# CONFIG_COMEDI_RTD520 is not set
CONFIG_COMEDI_S626=m
CONFIG_COMEDI_USB_DRIVERS=m
CONFIG_COMEDI_DT9812=m
CONFIG_COMEDI_NI_USB6501=m
CONFIG_COMEDI_USBDUX=m
CONFIG_COMEDI_USBDUXFAST=m
CONFIG_COMEDI_USBDUXSIGMA=m
CONFIG_COMEDI_VMK80XX=m
CONFIG_COMEDI_8254=m
CONFIG_COMEDI_8255=m
CONFIG_COMEDI_8255_SA=m
CONFIG_COMEDI_KCOMEDILIB=m
CONFIG_COMEDI_AMPLC_DIO200=m
CONFIG_COMEDI_AMPLC_PC236=m
CONFIG_COMEDI_NI_LABPC=m
# CONFIG_RTS5208 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
CONFIG_ADIS16203=m
CONFIG_ADIS16209=m
CONFIG_ADIS16240=m

#
# Analog to digital converters
#
CONFIG_AD7606=m
# CONFIG_AD7606_IFACE_PARALLEL is not set
# CONFIG_AD7606_IFACE_SPI is not set
CONFIG_AD7780=m
CONFIG_AD7816=m
CONFIG_AD7192=m
CONFIG_AD7280=m

#
# Analog digital bi-direction converters
#
# CONFIG_ADT7316 is not set

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
CONFIG_AD7152=m
# CONFIG_AD7746 is not set

#
# Direct Digital Synthesis
#
CONFIG_AD9832=m
CONFIG_AD9834=m

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16060 is not set

#
# Network Analyzer, Impedance Converters
#
CONFIG_AD5933=m

#
# Light sensors
#
CONFIG_SENSORS_ISL29028=m
# CONFIG_TSL2x7x is not set

#
# Active energy metering IC
#
CONFIG_ADE7753=m
CONFIG_ADE7754=m
CONFIG_ADE7758=m
CONFIG_ADE7759=m
# CONFIG_ADE7854 is not set

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
CONFIG_AD2S1200=m
CONFIG_AD2S1210=m

#
# Triggers - standalone
#
CONFIG_FB_SM750=m
# CONFIG_FB_XGI is not set

#
# Speakup console speech
#
CONFIG_STAGING_MEDIA=y

#
# Android
#
# CONFIG_ASHMEM is not set
# CONFIG_ANDROID_LOW_MEMORY_KILLER is not set
CONFIG_ION=y
CONFIG_ION_TEST=y
# CONFIG_ION_DUMMY is not set
CONFIG_LTE_GDM724X=m
CONFIG_FIREWIRE_SERIAL=m
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
# CONFIG_GOLDFISH_AUDIO is not set
CONFIG_DGNC=m
CONFIG_GS_FPGABOOT=m
# CONFIG_FB_TFT is not set
CONFIG_MOST=y
CONFIG_MOSTCORE=y
CONFIG_AIM_CDEV=m
CONFIG_AIM_NETWORK=m
CONFIG_AIM_SOUND=m
CONFIG_HDM_DIM2=m
CONFIG_HDM_I2C=y
CONFIG_HDM_USB=m
# CONFIG_GREYBUS is not set
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
# CONFIG_GOLDFISH_BUS is not set
CONFIG_GOLDFISH_PIPE=y
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_PSTORE is not set
CONFIG_CROS_EC_CHARDEV=m
CONFIG_CROS_EC_LPC=y
CONFIG_CROS_EC_PROTO=y
CONFIG_CROS_KBD_LED_BACKLIGHT=m
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
CONFIG_COMMON_CLK_WM831X=m
CONFIG_COMMON_CLK_SI5351=y
CONFIG_COMMON_CLK_CDCE706=m
CONFIG_COMMON_CLK_CS2000_CP=y
# CONFIG_COMMON_CLK_S2MPS11 is not set
# CONFIG_COMMON_CLK_NXP is not set
# CONFIG_COMMON_CLK_PALMAS is not set
# CONFIG_COMMON_CLK_PXA is not set
# CONFIG_COMMON_CLK_PIC32 is not set

#
# Hardware Spinlock drivers
#

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# CONFIG_ATMEL_PIT is not set
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
CONFIG_MAILBOX=y
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=y
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=m

#
# Rpmsg drivers
#

#
# SOC (System On Chip) specific Drivers
#

#
# Broadcom SoC drivers
#
# CONFIG_SUNXI_SRAM is not set
# CONFIG_SOC_TI is not set
CONFIG_SOC_ZTE=y
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
CONFIG_DEVFREQ_GOV_POWERSAVE=m
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=m

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=m
CONFIG_EXTCON_ARIZONA=m
CONFIG_EXTCON_GPIO=m
CONFIG_EXTCON_INTEL_INT3496=m
CONFIG_EXTCON_MAX14577=m
CONFIG_EXTCON_MAX3355=m
CONFIG_EXTCON_PALMAS=m
# CONFIG_EXTCON_QCOM_SPMI_MISC is not set
CONFIG_EXTCON_RT8973A=m
# CONFIG_EXTCON_SM5502 is not set
# CONFIG_EXTCON_USB_GPIO is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=m
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=m
CONFIG_IIO_KFIFO_BUF=m
CONFIG_IIO_TRIGGERED_BUFFER=m
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
CONFIG_IIO_SW_TRIGGER=m

#
# Accelerometers
#
CONFIG_BMA180=m
CONFIG_BMA220=m
CONFIG_BMC150_ACCEL=m
CONFIG_BMC150_ACCEL_I2C=m
CONFIG_BMC150_ACCEL_SPI=m
CONFIG_DA280=m
# CONFIG_DA311 is not set
CONFIG_DMARD09=m
CONFIG_DMARD10=m
# CONFIG_HID_SENSOR_ACCEL_3D is not set
CONFIG_KXSD9=m
# CONFIG_KXSD9_SPI is not set
CONFIG_KXSD9_I2C=m
CONFIG_KXCJK1013=m
CONFIG_MC3230=m
CONFIG_MMA7455=m
# CONFIG_MMA7455_I2C is not set
CONFIG_MMA7455_SPI=m
# CONFIG_MMA7660 is not set
CONFIG_MMA8452=m
CONFIG_MMA9551_CORE=m
# CONFIG_MMA9551 is not set
CONFIG_MMA9553=m
CONFIG_MXC4005=m
CONFIG_MXC6255=m
CONFIG_SCA3000=m
CONFIG_STK8312=m
# CONFIG_STK8BA50 is not set

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=m
CONFIG_AD7266=m
CONFIG_AD7291=m
CONFIG_AD7298=m
CONFIG_AD7476=m
# CONFIG_AD7766 is not set
# CONFIG_AD7791 is not set
CONFIG_AD7793=m
CONFIG_AD7887=m
CONFIG_AD7923=m
# CONFIG_AD799X is not set
# CONFIG_DA9150_GPADC is not set
# CONFIG_HI8435 is not set
CONFIG_HX711=m
CONFIG_INA2XX_ADC=m
CONFIG_LTC2485=m
CONFIG_MAX1027=m
CONFIG_MAX11100=m
CONFIG_MAX1363=m
CONFIG_MCP320X=m
# CONFIG_MCP3422 is not set
CONFIG_NAU7802=m
CONFIG_PALMAS_GPADC=m
CONFIG_STX104=m
CONFIG_TI_ADC081C=m
CONFIG_TI_ADC0832=m
# CONFIG_TI_ADC12138 is not set
CONFIG_TI_ADC128S052=m
CONFIG_TI_ADC161S626=m
# CONFIG_TI_ADS7950 is not set
CONFIG_TI_TLC4541=m
CONFIG_TWL4030_MADC=m
CONFIG_TWL6030_GPADC=m
# CONFIG_VIPERBOARD_ADC is not set

#
# Amplifiers
#
# CONFIG_AD8366 is not set

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=m
CONFIG_IAQCORE=m
CONFIG_VZ89X=m
CONFIG_IIO_CROS_EC_SENSORS_CORE=m
CONFIG_IIO_CROS_EC_SENSORS=m

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
CONFIG_IIO_MS_SENSORS_I2C=m

#
# SSP Sensor Common
#
CONFIG_IIO_SSP_SENSORS_COMMONS=m
CONFIG_IIO_SSP_SENSORHUB=m
CONFIG_IIO_ST_SENSORS_I2C=m
CONFIG_IIO_ST_SENSORS_SPI=m
CONFIG_IIO_ST_SENSORS_CORE=m

#
# Counters
#
CONFIG_104_QUAD_8=m

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
CONFIG_AD5360=m
# CONFIG_AD5380 is not set
# CONFIG_AD5421 is not set
CONFIG_AD5446=m
CONFIG_AD5449=m
CONFIG_AD5592R_BASE=m
CONFIG_AD5592R=m
CONFIG_AD5593R=m
# CONFIG_AD5504 is not set
CONFIG_AD5624R_SPI=m
CONFIG_AD5686=m
CONFIG_AD5755=m
CONFIG_AD5761=m
CONFIG_AD5764=m
# CONFIG_AD5791 is not set
# CONFIG_AD7303 is not set
CONFIG_CIO_DAC=m
CONFIG_AD8801=m
CONFIG_M62332=m
CONFIG_MAX517=m
# CONFIG_MCP4725 is not set
# CONFIG_MCP4922 is not set

#
# IIO dummy driver
#

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
CONFIG_AD9523=m

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# CONFIG_ADF4350 is not set

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
# CONFIG_ADIS16130 is not set
CONFIG_ADIS16136=m
# CONFIG_ADIS16260 is not set
# CONFIG_ADXRS450 is not set
# CONFIG_BMG160 is not set
# CONFIG_HID_SENSOR_GYRO_3D is not set
CONFIG_MPU3050=m
CONFIG_MPU3050_I2C=m
CONFIG_IIO_ST_GYRO_3AXIS=m
CONFIG_IIO_ST_GYRO_I2C_3AXIS=m
CONFIG_IIO_ST_GYRO_SPI_3AXIS=m
# CONFIG_ITG3200 is not set

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4403=m
CONFIG_AFE4404=m
CONFIG_MAX30100=m

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
# CONFIG_DHT11 is not set
# CONFIG_HDC100X is not set
CONFIG_HTS221=m
CONFIG_HTS221_I2C=m
CONFIG_HTS221_SPI=m
CONFIG_HTU21=m
CONFIG_SI7005=m
CONFIG_SI7020=m

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
CONFIG_ADIS16480=m
CONFIG_BMI160=m
# CONFIG_BMI160_I2C is not set
CONFIG_BMI160_SPI=m
CONFIG_KMX61=m
CONFIG_INV_MPU6050_IIO=m
# CONFIG_INV_MPU6050_I2C is not set
CONFIG_INV_MPU6050_SPI=m
# CONFIG_IIO_ST_LSM6DSX is not set
CONFIG_IIO_ADIS_LIB=m
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
CONFIG_ACPI_ALS=m
# CONFIG_ADJD_S311 is not set
CONFIG_AL3320A=m
CONFIG_APDS9300=m
CONFIG_APDS9960=m
# CONFIG_BH1750 is not set
CONFIG_BH1780=m
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
CONFIG_CM3323=m
CONFIG_CM36651=m
# CONFIG_GP2AP020A00F is not set
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_ISL29125 is not set
# CONFIG_HID_SENSOR_ALS is not set
CONFIG_HID_SENSOR_PROX=m
# CONFIG_JSA1212 is not set
# CONFIG_RPR0521 is not set
CONFIG_SENSORS_LM3533=m
# CONFIG_LTR501 is not set
CONFIG_MAX44000=m
CONFIG_OPT3001=m
# CONFIG_PA12203001 is not set
# CONFIG_SI1145 is not set
CONFIG_STK3310=m
# CONFIG_TCS3414 is not set
# CONFIG_TCS3472 is not set
CONFIG_SENSORS_TSL2563=m
# CONFIG_TSL2583 is not set
CONFIG_TSL4531=m
CONFIG_US5182D=m
CONFIG_VCNL4000=m
# CONFIG_VEML6070 is not set

#
# Magnetometer sensors
#
CONFIG_AK8975=m
CONFIG_AK09911=m
CONFIG_BMC150_MAGN=m
CONFIG_BMC150_MAGN_I2C=m
# CONFIG_BMC150_MAGN_SPI is not set
CONFIG_MAG3110=m
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
CONFIG_MMC35240=m
CONFIG_IIO_ST_MAGN_3AXIS=m
CONFIG_IIO_ST_MAGN_I2C_3AXIS=m
CONFIG_IIO_ST_MAGN_SPI_3AXIS=m
CONFIG_SENSORS_HMC5843=m
CONFIG_SENSORS_HMC5843_I2C=m
CONFIG_SENSORS_HMC5843_SPI=m

#
# Inclinometer sensors
#
# CONFIG_HID_SENSOR_INCLINOMETER_3D is not set
CONFIG_HID_SENSOR_DEVICE_ROTATION=m

#
# Triggers - standalone
#
# CONFIG_IIO_HRTIMER_TRIGGER is not set
CONFIG_IIO_INTERRUPT_TRIGGER=m
# CONFIG_IIO_TIGHTLOOP_TRIGGER is not set
# CONFIG_IIO_SYSFS_TRIGGER is not set

#
# Digital potentiometers
#
CONFIG_DS1803=m
# CONFIG_MAX5481 is not set
CONFIG_MAX5487=m
# CONFIG_MCP4131 is not set
CONFIG_MCP4531=m
CONFIG_TPL0102=m

#
# Digital potentiostats
#
CONFIG_LMP91000=m

#
# Pressure sensors
#
CONFIG_ABP060MG=m
CONFIG_BMP280=m
CONFIG_BMP280_I2C=m
CONFIG_BMP280_SPI=m
CONFIG_IIO_CROS_EC_BARO=m
CONFIG_HID_SENSOR_PRESS=m
CONFIG_HP03=m
CONFIG_MPL115=m
CONFIG_MPL115_I2C=m
# CONFIG_MPL115_SPI is not set
CONFIG_MPL3115=m
# CONFIG_MS5611 is not set
# CONFIG_MS5637 is not set
# CONFIG_IIO_ST_PRESS is not set
# CONFIG_T5403 is not set
CONFIG_HP206C=m
# CONFIG_ZPA2326 is not set

#
# Lightning sensors
#
CONFIG_AS3935=m

#
# Proximity and distance sensors
#
CONFIG_LIDAR_LITE_V2=m
CONFIG_SX9500=m
CONFIG_SRF08=m

#
# Temperature sensors
#
CONFIG_MAXIM_THERMOCOUPLE=m
# CONFIG_MLX90614 is not set
CONFIG_TMP006=m
CONFIG_TMP007=m
CONFIG_TSYS01=m
CONFIG_TSYS02D=m
CONFIG_NTB=y
CONFIG_NTB_PINGPONG=y
CONFIG_NTB_TOOL=m
CONFIG_NTB_PERF=m
CONFIG_NTB_TRANSPORT=y
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set
CONFIG_ARM_GIC_MAX_NR=1
CONFIG_IPACK_BUS=m
# CONFIG_BOARD_TPCI200 is not set
# CONFIG_SERIAL_IPOCTAL is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_ATH79 is not set
# CONFIG_RESET_BERLIN is not set
# CONFIG_RESET_LPC18XX is not set
# CONFIG_RESET_MESON is not set
# CONFIG_RESET_PISTACHIO is not set
# CONFIG_RESET_SOCFPGA is not set
# CONFIG_RESET_STM32 is not set
# CONFIG_RESET_SUNXI is not set
CONFIG_TI_SYSCON_RESET=m
# CONFIG_RESET_ZYNQ is not set
# CONFIG_RESET_TEGRA_BPMP is not set
CONFIG_FMC=m
CONFIG_FMC_FAKEDEV=m
CONFIG_FMC_TRIVIAL=m
# CONFIG_FMC_WRITE_EEPROM is not set
# CONFIG_FMC_CHARDEV is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
CONFIG_BCM_KONA_USB2_PHY=m
# CONFIG_PHY_SAMSUNG_USB2 is not set
# CONFIG_PHY_QCOM_USB_HS is not set
CONFIG_PHY_QCOM_USB_HSIC=y
CONFIG_PHY_TUSB1210=y
CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL=m
# CONFIG_MCB is not set

#
# Performance monitor support
#
CONFIG_RAS=y
CONFIG_THUNDERBOLT=y

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
CONFIG_LIBNVDIMM=y
# CONFIG_BLK_DEV_PMEM is not set
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_NVMEM=y
# CONFIG_STM is not set
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
CONFIG_INTEL_TH_DEBUG=y

#
# FPGA Configuration Support
#
CONFIG_FPGA=y

#
# FSI support
#
CONFIG_FSI=m

#
# Firmware Drivers
#
CONFIG_EDD=y
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DELL_RBU=m
# CONFIG_DCDBAS is not set
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=y
# CONFIG_FW_CFG_SYSFS is not set
CONFIG_GOOGLE_FIRMWARE=y

#
# Google Firmware Drivers
#
CONFIG_UEFI_CPER=y
# CONFIG_EFI_DEV_PATH_PARSER is not set

#
# Tegra firmware driver
#

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=m
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
# CONFIG_EXT4_FS_SECURITY is not set
# CONFIG_EXT4_ENCRYPTION is not set
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=m
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=m
# CONFIG_REISERFS_FS is not set
CONFIG_JFS_FS=y
CONFIG_JFS_POSIX_ACL=y
# CONFIG_JFS_SECURITY is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_XFS_FS=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_DEBUG=y
CONFIG_GFS2_FS=m
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_STATS=y
# CONFIG_OCFS2_DEBUG_MASKLOG is not set
# CONFIG_OCFS2_DEBUG_FS is not set
# CONFIG_BTRFS_FS is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
# CONFIG_F2FS_FS_POSIX_ACL is not set
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
CONFIG_F2FS_FS_ENCRYPTION=y
CONFIG_F2FS_FAULT_INJECTION=y
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=m
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS4_FS is not set
# CONFIG_FUSE_FS is not set
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
CONFIG_FSCACHE_DEBUG=y
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
CONFIG_CACHEFILES_HISTOGRAM=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_VFAT_FS is not set
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
# CONFIG_PROC_VMCORE is not set
# CONFIG_PROC_SYSCTL is not set
CONFIG_PROC_PAGE_MONITOR=y
# CONFIG_PROC_CHILDREN is not set
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
CONFIG_TMPFS_XATTR=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_CONFIGFS_FS=y
CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=y
CONFIG_ADFS_FS=m
CONFIG_ADFS_FS_RW=y
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
CONFIG_HFS_FS=y
# CONFIG_HFSPLUS_FS is not set
CONFIG_BEFS_FS=y
# CONFIG_BEFS_DEBUG is not set
CONFIG_BFS_FS=y
CONFIG_EFS_FS=y
CONFIG_CRAMFS=y
CONFIG_SQUASHFS=y
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
# CONFIG_SQUASHFS_ZLIB is not set
CONFIG_SQUASHFS_LZ4=y
CONFIG_SQUASHFS_LZO=y
# CONFIG_SQUASHFS_XZ is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
CONFIG_VXFS_FS=m
CONFIG_MINIX_FS=y
CONFIG_OMFS_FS=m
CONFIG_HPFS_FS=m
CONFIG_QNX4FS_FS=y
CONFIG_QNX6FS_FS=m
CONFIG_QNX6FS_DEBUG=y
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
# CONFIG_PSTORE_ZLIB_COMPRESS is not set
CONFIG_PSTORE_LZO_COMPRESS=y
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_CONSOLE is not set
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_RAM is not set
CONFIG_SYSV_FS=y
CONFIG_UFS_FS=m
CONFIG_UFS_FS_WRITE=y
CONFIG_UFS_DEBUG=y
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=y
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=y
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
CONFIG_NLS_CODEPAGE_874=m
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
# CONFIG_NLS_ISO8859_9 is not set
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
# CONFIG_NLS_MAC_CELTIC is not set
CONFIG_NLS_MAC_CENTEURO=y
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
# CONFIG_NLS_MAC_ROMANIAN is not set
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y

#
# Compile-time checks and compiler options
#
# CONFIG_DEBUG_INFO is not set
CONFIG_ENABLE_WARN_DEPRECATED=y
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=1024
# CONFIG_STRIP_ASM_SYMS is not set
CONFIG_READABLE_ASM=y
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_ARCH_WANT_FRAME_POINTERS=y
CONFIG_FRAME_POINTER=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_PAGE_POISONING=y
# CONFIG_PAGE_POISONING_NO_SANITY is not set
CONFIG_PAGE_POISONING_ZERO=y
# CONFIG_DEBUG_RODATA_TEST is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
CONFIG_DEBUG_STACK_USAGE=y
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_DEBUG_HIGHMEM=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_HAVE_ARCH_KMEMCHECK=y
# CONFIG_KMEMCHECK is not set
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=1
# CONFIG_WQ_WATCHDOG is not set
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
# CONFIG_SCHEDSTATS is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_DEBUG_TIMEKEEPING=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_PROVE_LOCKING=y
CONFIG_LOCKDEP=y
CONFIG_LOCK_STAT=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=m
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PI_LIST=y
CONFIG_DEBUG_SG=y
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_PROVE_RCU_REPEATEDLY=y
# CONFIG_SPARSE_RCU_POINTER is not set
CONFIG_TORTURE_TEST=y
CONFIG_RCU_PERF_TEST=m
CONFIG_RCU_TORTURE_TEST=y
# CONFIG_RCU_TORTURE_TEST_SLOW_PREINIT is not set
CONFIG_RCU_TORTURE_TEST_SLOW_INIT=y
CONFIG_RCU_TORTURE_TEST_SLOW_INIT_DELAY=3
# CONFIG_RCU_TORTURE_TEST_SLOW_CLEANUP is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_EQS_DEBUG=y
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set

#
# Runtime Testing
#
# CONFIG_LKDTM is not set
CONFIG_TEST_LIST_SORT=y
CONFIG_TEST_SORT=y
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
CONFIG_INTERVAL_TREE_TEST=m
CONFIG_PERCPU_TEST=m
# CONFIG_ATOMIC64_SELFTEST is not set
CONFIG_ASYNC_RAID6_TEST=y
CONFIG_TEST_HEXDUMP=m
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_KSTRTOX=m
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_RHASHTABLE is not set
CONFIG_TEST_HASH=y
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_FIRMWARE=y
CONFIG_TEST_UDELAY=m
CONFIG_MEMTEST=y
CONFIG_TEST_STATIC_KEYS=m
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set
CONFIG_X86_VERBOSE_BOOTUP=y
# CONFIG_EARLY_PRINTK is not set
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=y
CONFIG_DEBUG_WX=y
# CONFIG_DOUBLEFAULT is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_IOMMU_STRESS=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=0
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_OPTIMIZE_INLINING is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
CONFIG_PUNIT_ATOM_DEBUG=m

#
# Security options
#
CONFIG_KEYS=y
CONFIG_PERSISTENT_KEYRINGS=y
# CONFIG_BIG_KEYS is not set
CONFIG_TRUSTED_KEYS=m
# CONFIG_ENCRYPTED_KEYS is not set
CONFIG_KEY_DH_OPERATIONS=y
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HAVE_ARCH_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_PAGESPAN=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_XOR_BLOCKS=y
CONFIG_ASYNC_CORE=y
CONFIG_ASYNC_MEMCPY=y
CONFIG_ASYNC_XOR=y
CONFIG_ASYNC_PQ=y
CONFIG_ASYNC_RAID6_RECOV=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
# CONFIG_CRYPTO_ECDH is not set
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_WORKQUEUE=y
# CONFIG_CRYPTO_CRYPTD is not set
# CONFIG_CRYPTO_MCRYPTD is not set
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_ENGINE=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
CONFIG_CRYPTO_KEYWRAP=m

#
# Hash modes
#
# CONFIG_CRYPTO_CMAC is not set
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
# CONFIG_CRYPTO_MICHAEL_MIC is not set
CONFIG_CRYPTO_RMD128=y
CONFIG_CRYPTO_RMD160=y
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
# CONFIG_CRYPTO_AES_586 is not set
# CONFIG_CRYPTO_AES_NI_INTEL is not set
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=y
# CONFIG_CRYPTO_SALSA20 is not set
CONFIG_CRYPTO_SALSA20_586=y
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_SEED is not set
CONFIG_CRYPTO_SERPENT=y
# CONFIG_CRYPTO_SERPENT_SSE2_586 is not set
# CONFIG_CRYPTO_TEA is not set
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
# CONFIG_CRYPTO_TWOFISH_586 is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=m
CONFIG_CRYPTO_842=m
CONFIG_CRYPTO_LZ4=m
# CONFIG_CRYPTO_LZ4HC is not set

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_PADLOCK is not set
# CONFIG_CRYPTO_DEV_GEODE is not set
# CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API_DESC is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_QAT=y
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=y
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
CONFIG_CRYPTO_DEV_VIRTIO=y
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
CONFIG_VHOST_NET=m
CONFIG_VHOST=m
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y
# CONFIG_LGUEST is not set
# CONFIG_BINARY_PRINTF is not set

#
# Library routines
#
CONFIG_RAID6_PQ=y
CONFIG_BITREVERSE=y
# CONFIG_HAVE_ARCH_BITREVERSE is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_IO=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
CONFIG_CRC32_BIT=y
CONFIG_CRC7=m
CONFIG_LIBCRC32C=y
CONFIG_CRC8=m
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=m
CONFIG_842_DECOMPRESS=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
# CONFIG_XZ_DEC_IA64 is not set
CONFIG_XZ_DEC_ARM=y
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_SPARC is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_INTERVAL_TREE=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
# CONFIG_DMA_NOOP_OPS is not set
# CONFIG_DMA_VIRT_OPS is not set
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=m
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=m
CONFIG_DDR=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
# CONFIG_SG_SPLIT is not set
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_ARCH_HAS_MMIO_FLUSH=y
CONFIG_SBITMAP=y

--=_58cb6cce.FHOf4g3vGnR3ov+JjvcdmWpVmBsrNUYso8j8n9piE+6aaOwt--
