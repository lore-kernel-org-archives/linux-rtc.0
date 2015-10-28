Return-Path: <rtc-linux+bncBDKZNNNLXAHBBMGJYCYQKGQEA4SKZGI@googlegroups.com>
Received: from mailout3.w1.samsung.com (mailout3.w1.samsung.com. [210.118.77.13])
        by gmr-mx.google.com with ESMTPS id zg1si4651037pbb.2.2015.10.27.18.28.15
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 27 Oct 2015 18:28:15 -0700 (PDT)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NWW00JH9PEZQH00@mailout3.w1.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 28 Oct 2015 01:28:11 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH v3 2/5] mfd: sec: Add support for S2MPS15 PMIC
To: Alim Akhtar <alim.akhtar@samsung.com>, lee.jones@linaro.org,
 broonie@kernel.org
References: <1445863883-5187-1-git-send-email-alim.akhtar@samsung.com>
 <1445863883-5187-3-git-send-email-alim.akhtar@samsung.com>
Cc: mturquette@baylibre.com, linux-samsung-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, rtc-linux@googlegroups.com,
 linux-kernel@vger.kernel.org, Thomas Abraham <thomas.ab@samsung.com>
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <563024A5.1050705@samsung.com>
Date: Wed, 28 Oct 2015 10:28:05 +0900
MIME-version: 1.0
In-reply-to: <1445863883-5187-3-git-send-email-alim.akhtar@samsung.com>
Content-type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 26.10.2015 21:51, Alim Akhtar wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> Add support for S2MPS15 PMIC which is similar to S2MPS11 PMIC. The S2MPS15
> PMIC supports 27 LDO regulators, 10 buck regulators, RTC, three 32.768KHz
> clock outputs and battery charger. This patch adds initial support for
> LDO and buck regulators of S2MPS15 device.
> 
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> [Alim: Added s2mps15_devs like rtc and clk and related changes]
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/mfd/sec-core.c              |   31 +++++++
>  drivers/mfd/sec-irq.c               |    8 ++
>  include/linux/mfd/samsung/core.h    |    1 +
>  include/linux/mfd/samsung/s2mps15.h |  158 +++++++++++++++++++++++++++++++++++
>  4 files changed, 198 insertions(+)
>  create mode 100644 include/linux/mfd/samsung/s2mps15.h
> 
> diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
> index 2626fc0b5b8c..db3d4d4ff805 100644
> --- a/drivers/mfd/sec-core.c
> +++ b/drivers/mfd/sec-core.c
> @@ -29,6 +29,7 @@
>  #include <linux/mfd/samsung/s2mps11.h>
>  #include <linux/mfd/samsung/s2mps13.h>
>  #include <linux/mfd/samsung/s2mps14.h>
> +#include <linux/mfd/samsung/s2mps15.h>
>  #include <linux/mfd/samsung/s2mpu02.h>
>  #include <linux/mfd/samsung/s5m8763.h>
>  #include <linux/mfd/samsung/s5m8767.h>
> @@ -96,6 +97,17 @@ static const struct mfd_cell s2mps14_devs[] = {
>  	}
>  };
>  
> +static const struct mfd_cell s2mps15_devs[] = {
> +	{
> +		.name = "s2mps15-pmic",
> +	}, {
> +		.name = "s2mps15-rtc",
> +	}, {
> +		.name = "s2mps15-clk",
> +		.of_compatible = "samsung,s2mps15-clk",
> +	},

I have different questions here. RTC and CLK module look the same as
S2MPS14. Then you should existing compatibles and names.

I'll ask in details about this in separate emails for patch 4 and 5.
Until questions are resolved, these looks wrong.

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
