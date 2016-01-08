Return-Path: <rtc-linux+bncBD4JJDNX54MRBWMXXS2AKGQEMTXZLPA@googlegroups.com>
Received: from mail-pf0-x230.google.com (mail-pf0-x230.google.com. [2607:f8b0:400e:c00::230])
        by gmr-mx.google.com with ESMTPS id dz2si5095083pab.1.2016.01.07.17.07.37
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jan 2016 17:07:37 -0800 (PST)
Received: by mail-pf0-x230.google.com with SMTP id e65so1493066pfe.0
        for <rtc-linux@googlegroups.com>; Thu, 07 Jan 2016 17:07:37 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH 5/6] rtc: max77620: add support for
 max77620/max20024 RTC driver
To: Laxman Dewangan <ldewangan@nvidia.com>, robh+dt@kernel.org,
 pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
 galak@codeaurora.org, linus.walleij@linaro.org, gnurou@gmail.com,
 lee.jones@linaro.org, broonie@kernel.org, a.zummo@towertech.it,
 alexandre.belloni@free-electrons.com
References: <1452177524-23192-1-git-send-email-ldewangan@nvidia.com>
 <1452177524-23192-6-git-send-email-ldewangan@nvidia.com>
Cc: lgirdwood@gmail.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 rtc-linux@googlegroups.com, swarren@nvidia.com, treding@nvidia.com,
 Chaitanya Bandi <bandik@nvidia.com>
From: Linux Kernel <linuxkernelmails@gmail.com>
Message-ID: <568F0BD3.8080000@gmail.com>
Date: Fri, 8 Jan 2016 06:37:31 +0530
MIME-Version: 1.0
In-Reply-To: <1452177524-23192-6-git-send-email-ldewangan@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On Thursday 07 January 2016 08:08 PM, Laxman Dewangan wrote:

> Maxim Semiconductor's PMIC MAX77620/MAX20024 has on chip
> RTC  module. This support for setting alarm and time.
>
> Add RTC driver to access this chip's RTC module via RTC
> APIs.
>
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Signed-off-by: Chaitanya Bandi <bandik@nvidia.com>
> Tested-by: Venkat Reddy Talla <vreddytalla@nvidia.com>
> ---
>   drivers/rtc/Kconfig        |   9 +
>   drivers/rtc/Makefile       |   1 +
>   drivers/rtc/rtc-max77620.c | 574 +++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 584 insertions(+)
>   create mode 100644 drivers/rtc/rtc-max77620.c
>
(...)

> +static struct platform_driver max77620_rtc_driver = {
> +	.probe = max77620_rtc_probe,
> +	.remove = max77620_rtc_remove,
> +	.id_table = max77620_rtc_devtype,
> +	.driver = {
> +			.name = "max77620-rtc",
> +			.owner = THIS_MODULE,

Drop this line, .owner will be populated by driver core.

> +			.pm = &max77620_rtc_pm_ops,
> +	},
> +};
> +
> +module_platform_driver(max77620_rtc_driver);
> +
> +MODULE_DESCRIPTION("max77620 RTC driver");
> +MODULE_AUTHOR("Chaitanya Bandi <bandik@nvidia.com>");
> +MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
> +MODULE_ALIAS("platform:max77620-rtc");
> +MODULE_LICENSE("GPL v2");

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
