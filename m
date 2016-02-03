Return-Path: <rtc-linux+bncBDKZNNNLXAHBBNNUY62QKGQETBWXIVI@googlegroups.com>
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com. [210.118.77.12])
        by gmr-mx.google.com with ESMTPS id tn7si788097pac.1.2016.02.03.02.45.09
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 03 Feb 2016 02:45:09 -0800 (PST)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O1Y007C3WJ5MU60@mailout2.w1.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 03 Feb 2016 10:45:05 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH V2 5/5] rtc: max77686: move initialisation of
 rtc regmap, irq chip locally
To: Laxman Dewangan <ldewangan@nvidia.com>, lee.jones@linaro.org,
 alexandre.belloni@free-electrons.com, javier@osg.samsung.com
References: <1454491848-26551-1-git-send-email-ldewangan@nvidia.com>
 <1454491848-26551-6-git-send-email-ldewangan@nvidia.com>
Cc: cw00.choi@samsung.com, linux-kernel@vger.kernel.org,
 rtc-linux@googlegroups.com
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56B1DA31.7070109@samsung.com>
Date: Wed, 03 Feb 2016 19:45:05 +0900
MIME-version: 1.0
In-reply-to: <1454491848-26551-6-git-send-email-ldewangan@nvidia.com>
Content-type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 03.02.2016 18:30, Laxman Dewangan wrote:
> To make RTC block of MAX77686/MAX77802 as independent driver,
> move the registration of i2c device, regmap for register access
> and irq_chip for interrupt support inside the RTC driver.
> Removed the same initialisation from MFD driver.
> 
> Having this change will allow to reuse this driver for different
> PMIC/devices from Maxim Semiconductor if they kept same RTC IP on
> different PMIC. Some of examples as PMIC MAX77620, MAX20024 where
> same RTC IP used and hence driver for these chips will use this
> driver only for RTC support.
> 
> Suggested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> CC: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> Changes from V1:
> - Remove changes from Kconfig.
> - Maintain all register definition in max77686 private header and remove
>   the movement to rtc driver.
> - Taken care of all comments on V1 from Krzysztof and Javier.

Almost everything is good. You skipped one my comment, at the end:

(...)

> @@ -659,14 +745,33 @@ static int max77686_rtc_probe(struct platform_device *pdev)
>  	ret = devm_request_threaded_irq(&pdev->dev, info->virq, NULL,
>  					max77686_rtc_alarm_irq, 0,
>  					"rtc-alarm1", info);
> -	if (ret < 0)
> +	if (ret < 0) {
>  		dev_err(&pdev->dev, "Failed to request alarm IRQ: %d: %d\n",
>  			info->virq, ret);
> +		goto err_rtc;
> +	}
> +
> +	return 0;
>  
>  err_rtc:
> +	if (info->rtc)
> +		i2c_unregister_device(info->rtc);
> +	regmap_del_irq_chip(info->rtc_irq, info->rtc_irq_data);
> +

You should clean up in reverse order of allocation, so first
regmap_del_irq_chip then i2c_unregister_device. This
is a common pattern of cleaning up. Sometimes such order
is even necessary because of dependencies between
components... which is not a case here but still the
natural way is reversing the allocation code.

>  	return ret;
>  }
>  
> +static int max77686_rtc_remove(struct platform_device *pdev)
> +{
> +	struct max77686_rtc_info *info = platform_get_drvdata(pdev);
> +
> +	regmap_del_irq_chip(info->rtc_irq, info->rtc_irq_data);
> +	if (info->rtc)
> +		i2c_unregister_device(info->rtc);

Here it is okay.

Anyway RTC works... but unbinding leads to oops:
echo max77686-rtc > /sys/bus/platform/drivers/max77686-rtc/unbind
[   80.505411] Unable to handle kernel paging request at virtual address ffffffff
[   80.511257] pgd = ec3a0000
[   80.513870] [ffffffff] *pgd=6fffd861, *pte=00000000, *ppte=00000000
[   80.520130] Internal error: Oops: 37 [#1] PREEMPT SMP ARM
[   80.525498] Modules linked in:
[   80.528551] CPU: 2 PID: 1325 Comm: sleep Tainted: G        W       4.5.0-rc2-next-20160202-00006-gb28bd1d36a08 #62
[   80.538867] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   80.544947] task: eeb53440 ti: eeb12000 task.ti: eeb12000
[   80.550349] PC is at kmem_cache_alloc+0x7c/0x154
[   80.554933] LR is at kmem_cache_alloc+0x3c/0x154
[   80.559535] pc : [<c00d5818>]    lr : [<c00d57d8>]    psr: a00f0013
[   80.559535] sp : eeb13e18  ip : 00000001  fp : bee6c4f4
[   80.570986] r10: 024080c0  r9 : eeb13ed0  r8 : 00033d72
[   80.576195] r7 : c00deda8  r6 : c08585f4  r5 : ffffffff  r4 : ef001d80
[   80.582704] r3 : 00000000  r2 : 00033d72  r1 : c070e2ac  r0 : 2ef40000
[   80.589217] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   80.596332] Control: 10c5387d  Table: 6c3a004a  DAC: 00000051
[   80.602061] Process sleep (pid: 1325, stack limit = 0xeeb12210)
[   80.607963] Stack: (0xeeb13e18 to 0xeeb14000)
[   80.612306] 3e00:                                                       c0858280 ee4ada00
[   80.620475] 3e20: c0863e80 eeb13f74 c000fa84 eeb13ed0 00000000 c00deda8 b6f4f000 00000011
[   80.628632] 3e40: 00000003 eeb13f74 00000001 c00e8ebc 386de9c0 00000000 00000001 00000001
[   80.636792] 3e60: eeb53440 00000041 eee89514 0000014f 00000054 0000053c eeb6c190 ee4f653c
[   80.644934] 3e80: 00013000 ee4f6000 00000001 00000000 00000054 024200ca 00000010 b6f4e000
[   80.653093] 3ea0: ee58e7a8 b6f3e000 00000011 00000003 eeb13f74 00000001 00000005 c000fa84
[   80.661253] 3ec0: eeb12000 00000000 bee6c4f4 c00eaa6c 00000000 c0018570 eea49700 ee58e160
[   80.669412] 3ee0: 00000000 00000000 c001921c 00000017 c0018388 b6f4f0dd c085cf34 eeb13fb0
[   80.677571] 3f00: b6f96b40 7f62b751 00000000 eeb13f10 eeb13f24 ef001b80 00000001 00000001
[   80.685730] 3f20: 00000003 ee5aac00 ee5aac24 00000020 00080000 c05a0390 00000000 c00f72ec
[   80.693889] 3f40: eebac000 00000000 eebac000 ffffff9c ffffff9c c000fa84 00000003 eebac000
[   80.702048] 3f60: ffffff9c c00dc29c eeb53440 00000003 ee5aac00 00000000 eea40000 00000004
[   80.710208] 3f80: 00000100 00000001 eea49700 00000008 00000000 bee6c534 00000005 c000fa84
[   80.718367] 3fa0: 00000000 c000f8c0 00000008 00000000 b6f4f0ce 00080000 b6f96958 00000000
[   80.726526] 3fc0: 00000008 00000000 bee6c534 00000005 00000001 b6f4f0ce 00000000 bee6c4f4
[   80.734685] 3fe0: b6f95ce0 bee6c4ac b6f6ba14 b6f7f24c 600f0010 b6f4f0ce ffffffff ffffffff
[   80.742854] [<c00d5818>] (kmem_cache_alloc) from [<c00deda8>] (get_empty_filp+0x70/0x1d4)
[   80.751008] [<c00deda8>] (get_empty_filp) from [<c00e8ebc>] (path_openat+0x20/0xf1c)
[   80.758731] [<c00e8ebc>] (path_openat) from [<c00eaa6c>] (do_filp_open+0x60/0xb4)
[   80.766195] [<c00eaa6c>] (do_filp_open) from [<c00dc29c>] (do_sys_open+0x114/0x1c0)
[   80.773838] [<c00dc29c>] (do_sys_open) from [<c000f8c0>] (ret_fast_syscall+0x0/0x3c)
[   80.781559] Code: e7905003 e3550000 0a00001f e5943014 (e7950003)
[   80.787694] ---[ end trace 9502799e3ea05a7e ]---
[   80.792503] Unable to handle kernel paging request at virtual address ffffffff
[   80.799457] pgd = ec39c000
[   80.802140] [ffffffff] *pgd=6fffd861, *pte=00000000, *ppte=00000000
[   80.808377] Internal error: Oops: 37 [#2] PREEMPT SMP ARM
[   80.813756] Modules linked in:
[   80.816798] CPU: 2 PID: 628 Comm: sh Tainted: G      D W       4.5.0-rc2-next-20160202-00006-gb28bd1d36a08 #62
[   80.826776] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   80.832853] task: ec3050c0 ti: ee66e000 task.ti: ee66e000
[   80.838240] PC is at kmem_cache_alloc+0x7c/0x154
[   80.842836] LR is at kmem_cache_alloc+0x3c/0x154
[   80.847437] pc : [<c00d5818>]    lr : [<c00d57d8>]    psr: a00f0013
[   80.847437] sp : ee66fe18  ip : 00000001  fp : beaba124
[   80.858893] r10: 024080c0  r9 : ee66fed0  r8 : 00033d72
[   80.864100] r7 : c00deda8  r6 : c08585f4  r5 : ffffffff  r4 : ef001d80
[   80.870610] r3 : 00000000  r2 : 00033d72  r1 : c070e2ac  r0 : 2ef40000
[   80.877120] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   80.884237] Control: 10c5387d  Table: 6c39c04a  DAC: 00000051
[   80.889966] Process sh (pid: 628, stack limit = 0xee66e210)
[   80.895522] Stack: (0xee66fe18 to 0xee670000)
[   80.899862] fe00:                                                       c0858280 ec264f80
[   80.908023] fe20: c0863e80 ee66ff74 c000fa84 ee66fed0 00000000 c00deda8 00000040 ee58e9a0
[   80.916182] fe40: 00000003 ee66ff74 00000001 c00e8ebc ec39efa8 eeb6cee0 69f907df ef00cc10
[   80.924341] fe60: c0850200 00000041 00000001 00000195 00000055 00000654 ec39edb8 ee464380
[   80.932500] fe80: ffffff05 c023bd4c 00000000 00000000 00000000 ee464380 ee58e9a0 c00c0904
[   80.940660] fea0: ee464380 ee58e9a0 ee464380 00000003 ee66ff74 00000001 00000005 c000fa84
[   80.948819] fec0: ee66e000 00000000 beaba124 c00eaa6c 00000800 c0018570 ec19fa08 00000000
[   80.956978] fee0: 00000000 00000000 00000000 00000817 c0018388 b6f95000 c085cf34 ee66ffb0
[   80.965137] ff00: 00000000 b6f974c0 00000000 ee66ff10 ee66ff24 ef001b80 00000001 00000001
[   80.973296] ff20: 00000003 ee59ba00 ee405e00 00000100 00080000 c05a0390 00000000 c00f72ec
[   80.981456] ff40: eebaf000 00000000 eebaf000 ffffff9c ffffff9c c000fa84 00000003 eebaf000
[   80.989615] ff60: ffffff9c c00dc29c beaba52c c00b0e8c 00000022 00000000 000b0000 00000004
[   80.997774] ff80: 00000100 00000001 ffffffff 000d6430 00000008 00000008 00000005 c000fa84
[   81.005933] ffa0: 00000000 c000f8c0 000d6430 00000008 beaba148 00080000 000001b6 000001b6
[   81.014092] ffc0: 000d6430 00000008 00000008 00000005 00000000 b6f0405c beaba408 beaba124
[   81.022252] ffe0: 00080000 beaba0c4 b6e3529c b6e8a9bc 200f0010 beaba148 6fffd861 6fffdc61
[   81.030416] [<c00d5818>] (kmem_cache_alloc) from [<c00deda8>] (get_empty_filp+0x70/0x1d4)
[   81.038572] [<c00deda8>] (get_empty_filp) from [<c00e8ebc>] (path_openat+0x20/0xf1c)
[   81.046296] [<c00e8ebc>] (path_openat) from [<c00eaa6c>] (do_filp_open+0x60/0xb4)
[   81.053761] [<c00eaa6c>] (do_filp_open) from [<c00dc29c>] (do_sys_open+0x114/0x1c0)
[   81.061401] [<c00dc29c>] (do_sys_open) from [<c000f8c0>] (ret_fast_syscall+0x0/0x3c)
[   81.069124] Code: e7905003 e3550000 0a00001f e5943014 (e7950003)
[   81.075245] ---[ end trace 9502799e3ea05a7f ]---
[   88.035087] Unable to handle kernel paging request at virtual address ffffffff
[   88.040971] pgd = ee604000
[   88.043617] [ffffffff] *pgd=6fffd861, *pte=00000000, *ppte=00000000
[   88.049822] Internal error: Oops: 37 [#3] PREEMPT SMP ARM
[   88.055186] Modules linked in:
[   88.058245] CPU: 2 PID: 396 Comm: deviced Tainted: G      D W       4.5.0-rc2-next-20160202-00006-gb28bd1d36a08 #62
[   88.068641] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   88.074723] task: ec089c80 ti: ec180000 task.ti: ec180000
[   88.080132] PC is at kmem_cache_alloc+0x7c/0x154
[   88.084712] LR is at kmem_cache_alloc+0x3c/0x154
[   88.089313] pc : [<c00d5818>]    lr : [<c00d57d8>]    psr: a0000013
[   88.089313] sp : ec181e18  ip : 00000001  fp : be9821e4
[   88.100763] r10: 024080c0  r9 : ec181ed0  r8 : 00033d82
[   88.105971] r7 : c00deda8  r6 : c08585f4  r5 : ffffffff  r4 : ef001d80
[   88.112482] r3 : 00000000  r2 : 00033d82  r1 : c070e2ac  r0 : 2ef40000
[   88.118995] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   88.126095] Control: 10c5387d  Table: 6e60404a  DAC: 00000051
[   88.131824] Process deviced (pid: 396, stack limit = 0xec180210)
[   88.137812] Stack: (0xec181e18 to 0xec182000)
[   88.142153] 1e00:                                                       c0858280 ee7bb900
[   88.150317] 1e20: c0863e80 ec181f74 c000fa84 ec181ed0 00000000 c00deda8 ec181e50 ec181e54
[   88.158475] 1e40: 00000016 ec181f74 00000001 c00e8ebc 00000000 00000000 00000000 00000000
[   88.166635] 1e60: ec181eb8 00000041 ffede000 00000127 00000055 0000049c ee605fd8 00002000
[   88.174793] 1e80: 00000011 ec181f80 00000044 00000000 00000011 c012ca68 00000000 eb17e260
[   88.182953] 1ea0: 00000051 00000011 ec181f80 00000016 ec181f74 00000001 00000005 c000fa84
[   88.191112] 1ec0: ec180000 00000000 be9821e4 c00eaa6c 00000800 c0018570 be981c48 ee51cd24
[   88.199272] 1ee0: ec089c80 00000008 ee51ccc0 0000081f c0018388 7f727c20 c085cfb4 ec181fb0
[   88.207430] 1f00: c792168f ffffffff 00000000 ec181f10 ec181f24 ef001b80 00000001 00000001
[   88.215590] 1f20: 00000016 ee5b1000 ee74d7c0 00000100 00000000 c05a0390 00000000 c00f72ec
[   88.223749] 1f40: eeba9000 00000000 eeba9000 ffffff9c ffffff9c c000fa84 00000016 eeba9000
[   88.231908] 1f60: ffffff9c c00dc29c ec180000 be9828a8 00000051 00000000 c0000000 00000004
[   88.240067] 1f80: 00000100 00000001 00000000 7f721c00 00000008 00000008 00000005 c000fa84
[   88.248226] 1fa0: 00000000 c000f8c0 7f721c00 00000008 be9822cc 00000000 000001b6 000001b6
[   88.256386] 1fc0: 7f721c00 00000008 00000008 00000005 7f6de5c0 be9822cc be9822cc be9821e4
[   88.264544] 1fe0: 00000000 be982180 b6efb4c0 b669aa14 80000010 be9822cc 00000000 00000000
[   88.272716] [<c00d5818>] (kmem_cache_alloc) from [<c00deda8>] (get_empty_filp+0x70/0x1d4)
[   88.280868] [<c00deda8>] (get_empty_filp) from [<c00e8ebc>] (path_openat+0x20/0xf1c)
[   88.288591] [<c00e8ebc>] (path_openat) from [<c00eaa6c>] (do_filp_open+0x60/0xb4)
[   88.296055] [<c00eaa6c>] (do_filp_open) from [<c00dc29c>] (do_sys_open+0x114/0x1c0)
[   88.303699] [<c00dc29c>] (do_sys_open) from [<c000f8c0>] (ret_fast_syscall+0x0/0x3c)
[   88.311419] Code: e7905003 e3550000 0a00001f e5943014 (e7950003)
[   88.317573] ---[ end trace 9502799e3ea05a80 ]---


Without patch 5 it is ok.

BR,
Krzysztof

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
