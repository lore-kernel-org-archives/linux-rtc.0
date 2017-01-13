Return-Path: <rtc-linux+bncBC2IT2GSZUDRBTPR4PBQKGQEUIPNY7Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com. [62.209.51.94])
        by gmr-mx.google.com with ESMTPS id 133si175815wmj.1.2017.01.13.07.57.00
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jan 2017 07:57:00 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH 3/3] rtc: stm32: use 32-bit cast for BIT() macro
To: Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni
	<alexandre.belloni@free-electrons.com>
References: <20170113153311.2611510-1-arnd@arndb.de>
 <20170113153311.2611510-3-arnd@arndb.de>
CC: Mark Brown <broonie@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE
	<alexandre.torgue@st.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
From: Amelie DELAUNAY <amelie.delaunay@st.com>
Message-ID: <26624cbe-7e71-35a4-b8df-f5ac5d15b1ec@st.com>
Date: Fri, 13 Jan 2017 16:56:54 +0100
MIME-Version: 1.0
In-Reply-To: <20170113153311.2611510-3-arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Arnd,

On 01/13/2017 04:32 PM, Arnd Bergmann wrote:
> Using the ~ operator on a BIT() constant results in a large 'unsigned long'
> constant that won't fit into an 'unsigned int' function argument on 64-bit
> architectures, resulting in a harmless build warning in x86 allmodconfig:
>
> drivers/rtc/rtc-stm32.c: In function 'stm32_rtc_probe':
> drivers/rtc/rtc-stm32.c:651:51: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
>   regmap_update_bits(rtc->dbp, PWR_CR, PWR_CR_DBP, ~PWR_CR_DBP);
I thought I would fix this warning by replacing all ~PWR_CR_DBP by 0, 
because the mask PWR_CR_DBP prevents other bits to be cleared.
In this way, I avoid the ugly cast...
>
> This works around the warning by adding an explict cast to 'u32', but
> that is unfortunately a bit ugly and I feel there should be a better
> way to do this, possibly with some changes to either the bitops.h
> header or the regmap API.
>
> Cc: Mark Brown <broonie@kernel.org>
> Fixes: 4e64350f42e2 ("rtc: add STM32 RTC driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/rtc/rtc-stm32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
> index 8c599f52124c..05d3dc89e55f 100644
> --- a/drivers/rtc/rtc-stm32.c
> +++ b/drivers/rtc/rtc-stm32.c
> @@ -92,7 +92,7 @@
>  /* STM32_PWR_CR */
>  #define PWR_CR				0x00
>  /* STM32_PWR_CR bit field */
> -#define PWR_CR_DBP			BIT(8)
> +#define PWR_CR_DBP			(u32)BIT(8)
>
>  struct stm32_rtc {
>  	struct rtc_device *rtc_dev;
>

Regards,
Amelie

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
