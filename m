Return-Path: <rtc-linux+bncBDA7X7F2WUEBBAGB5W2QKGQE3POMNOA@googlegroups.com>
Received: from mail-wm0-x22b.google.com (mail-wm0-x22b.google.com. [2a00:1450:400c:c09::22b])
        by gmr-mx.google.com with ESMTPS id c143si123048wmd.1.2016.02.10.08.08.31
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Feb 2016 08:08:31 -0800 (PST)
Received: by mail-wm0-x22b.google.com with SMTP id g62so32510965wme.0
        for <rtc-linux@googlegroups.com>; Wed, 10 Feb 2016 08:08:31 -0800 (PST)
Date: Wed, 10 Feb 2016 16:08:28 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: alexandre.belloni@free-electrons.com, k.kozlowski@samsung.com,
	javier@osg.samsung.com, broonie@kernel.org,
	gregkh@linuxfoundation.org, a.zummo@towertech.it,
	cw00.choi@samsung.com, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH V7 5/5] rtc: max77686: move initialisation of
 rtc regmap, irq chip locally
Message-ID: <20160210160828.GE26950@x1>
References: <1455038794-9921-1-git-send-email-ldewangan@nvidia.com>
 <1455038794-9921-6-git-send-email-ldewangan@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1455038794-9921-6-git-send-email-ldewangan@nvidia.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, 09 Feb 2016, Laxman Dewangan wrote:

> To make RTC block of MAX77686/MAX77802 as independent driver,
> move the registration of i2c device, regmap for register access
> and irq_chip for interrupt support inside the RTC driver.
> Removed the same initialisation from MFD driver.
>=20
> Having this change will allow to reuse this driver for different
> PMIC/devices from Maxim Semiconductor if they kept same RTC IP on
> different PMIC. Some of examples as PMIC MAX77620, MAX20024 where
> same RTC IP used and hence driver for these chips will use this
> driver only for RTC support.
>=20
> Suggested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> CC: Javier Martinez Canillas <javier@osg.samsung.com>
> Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
>=20
> ---
> Changes from V1:
> - Remove changes from Kconfig.
> - Maintain all register definition in max77686 private header and remove
>   the movement to rtc driver.
> - Taken care of all comments on V1 from Krzysztof and Javier.
>=20
> Changes from V2:
> - Taken care of missed sequence for removing the resource.
> - Fix the crash when doing unbind by using requested_threaded_irq()
>   instead of demv_requested_threaded_irq().
>=20
> Changes from V3:
> - Fix the issue of suspend-resume with unbind/bind by unmapping the
>   virq.
>=20
> Changes from V4:
> - Dispose mapped irq in error path in probe
>=20
> Changes from V5:
> - Remove the new APIs from regmap as functionality added to dispose the
>   virq inside the regmap_del_irq_chip().
>=20
> Changes from V6:
> Make this as 5th of series as regmap change applied independently.
> Also rebase on linux-next 20160209
>=20
>  drivers/mfd/max77686.c               |  85 +-------------------
>  drivers/rtc/rtc-max77686.c           | 148 +++++++++++++++++++++++++++++=
+-----
>  include/linux/mfd/max77686-private.h |   3 -
>  3 files changed, 130 insertions(+), 106 deletions(-)

Yes, yes, yes!

This is how it should have been done in the first place IMHO.

Acked-by: Lee Jones <lee.jones@linaro.org>

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

--=20
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
