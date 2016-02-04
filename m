Return-Path: <rtc-linux+bncBDKZNNNLXAHBB6VNZK2QKGQE2SY4F3Y@googlegroups.com>
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com. [210.118.77.12])
        by gmr-mx.google.com with ESMTPS id ui7si1169871pab.0.2016.02.03.16.10.34
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 03 Feb 2016 16:10:34 -0800 (PST)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O1Z008G0XTHNO50@mailout2.w1.samsung.com> for
 rtc-linux@googlegroups.com; Thu, 04 Feb 2016 00:10:29 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH V3 5/5] rtc: max77686: move initialisation of
 rtc regmap, irq chip locally
To: Laxman Dewangan <ldewangan@nvidia.com>, lee.jones@linaro.org,
 alexandre.belloni@free-electrons.com, javier@osg.samsung.com
References: <1454507233-9959-1-git-send-email-ldewangan@nvidia.com>
 <1454507233-9959-6-git-send-email-ldewangan@nvidia.com>
Cc: cw00.choi@samsung.com, linux-kernel@vger.kernel.org,
 rtc-linux@googlegroups.com
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56B296F6.3060002@samsung.com>
Date: Thu, 04 Feb 2016 09:10:30 +0900
MIME-version: 1.0
In-reply-to: <1454507233-9959-6-git-send-email-ldewangan@nvidia.com>
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

On 03.02.2016 22:47, Laxman Dewangan wrote:
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
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> Changes from V1:
> - Remove changes from Kconfig.
> - Maintain all register definition in max77686 private header and remove
>   the movement to rtc driver.
> - Taken care of all comments on V1 from Krzysztof and Javier.
> 
> Changes from V2:
> - Taken care of missed sequence for removing the resource.
> - Fix the crash when doing unbind by using requested_threaded_irq()
>   instead of demv_requested_threaded_irq().
> 
>  drivers/mfd/max77686.c               |  85 +-------------------
>  drivers/rtc/rtc-max77686.c           | 148 ++++++++++++++++++++++++++++++-----
>  include/linux/mfd/max77686-private.h |   3 -
>  3 files changed, 130 insertions(+), 106 deletions(-)
> 

Looks good and works properly (RTC, unbind/rebind, wakealarm again)
but... after applying this patch the device cannot suspend to RAM after
unbind/rebind.

Reproduce path, after booting:
$ echo max77686-rtc > /sys/bus/platform/drivers/max77686-rtc/unbind
$ echo max77686-rtc > /sys/bus/platform/drivers/max77686-rtc/bind
$ rtcwake -d rtc2 -m mem -s 5 -v
(or instead of rtcwake: echo mem > /sys/power/state)

Proper behaviour:
##############################
[   28.549244] PM: late suspend of devices complete after 2.239 msecs
[   28.556051] PM: noirq suspend of devices complete after 2.078 msecs
[   28.560952] Disabling non-boot CPUs ...
[   28.588392] CPU1: shutdown
[   28.623283] CPU2: shutdown
[   28.653242] CPU3: shutdown

Power usage drops. Device wakes up (either from RTC or from manual, e.g.
key press)
##############################


Behaviour with patch 5/5:
[   67.068586] PM: Syncing filesystems ... done.
[   67.121673] Freezing user space processes ... (elapsed 0.004 seconds)
done.
[   67.123457] Freezing remaining freezable tasks ... (elapsed 0.001
seconds) done.
[   67.182024] wake enabled for irq 125
[   67.184315] wake enabled for irq 127
[   67.187829] wake enabled for irq 147
[   67.191238] wake enabled for irq 148
[   67.195178] dwc2 12480000.hsotg: suspending usb gadget g_ether
[   67.200647] dwc2 12480000.hsotg: new device is full-speed
[   67.206036] dwc2 12480000.hsotg: dwc2_hsotg_ep_disable: called for ep0
[   67.212523] dwc2 12480000.hsotg: dwc2_hsotg_ep_disable: called for ep0
[   67.221742] PM: suspend of devices complete after 93.132 msecs
[   67.226113] VALIVE_1.0V_AP: No configuration
[   67.230399] VCC_1.8V_AP: No configuration
[   67.234385] VCC_2.8V_AP: No configuration
[   67.238373] VCC_1.8V_IO: No configuration
[   67.243130] CAM_ISP_MIPI_1.2V: No configuration
[   67.249142] NFC_AVDD_1.8V: No configuration
[   67.252661] CAM_SENSOR_CORE_1.2V: No configuration
[   67.256648] CAM_ISP_SEN_IO_1.8V: No configuration
[   67.261311] VT_CAM_1.8V: No configuration
[   67.265323] VDDQ_PRE_1.8V: No configuration
[   67.269488] VTF_2.8V: No configuration
[   67.273219] VMEM_VDD_2.8V: No configuration
[   67.277386] TSP_AVDD_3.3V: No configuration
[   67.281553] TSP_VDD_1.8V: No configuration
[   67.285615] LCD_VCC_3.3V: No configuration
[   67.289712] MOTOR_VCC_3.0V: No configuration
[   67.296266] VMEM_1.2V_AP: No configuration
[   67.298902] VCC_SUB_1.35V: No configuration
[   67.303064] VCC_SUB_2.0V: No configuration
[   67.307142] VMEM_VDDF_3.0V: No configuration
[   67.311377] CAM_ISP_CORE_1.2V: No configuration
[   67.318181] PM: late suspend of devices complete after 2.267 msecs
[   67.325046] PM: noirq suspend of devices complete after 2.137 msecs
[   67.329857] Disabling non-boot CPUs ...

No CPU shutdown messages. Power usage not decreased, device does not
wake up.

I don't know yet what is the cause... At first glance it looks okay...

Best regards,
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
