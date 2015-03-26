Return-Path: <rtc-linux+bncBDA7X7F2WUEBBL5H2CUAKGQEPXHCXQI@googlegroups.com>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com. [209.85.212.180])
        by gmr-mx.google.com with ESMTPS id p4si1854wiz.0.2015.03.26.07.11.59
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Mar 2015 07:11:59 -0700 (PDT)
Received: by mail-wi0-f180.google.com with SMTP id g7so150069090wib.1
        for <rtc-linux@googlegroups.com>; Thu, 26 Mar 2015 07:11:59 -0700 (PDT)
Date: Thu, 26 Mar 2015 14:11:54 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Sangbeom Kim <sbkim73@samsung.com>,
	Samuel Ortiz <sameo@linux.intel.com>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
Subject: [rtc-linux] Re: [PATCH] rtc: s5m: Add support for S2MPS13 RTC
Message-ID: <20150326141154.GN5951@x1>
References: <1427207619-26742-1-git-send-email-k.kozlowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1427207619-26742-1-git-send-email-k.kozlowski@samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Tue, 24 Mar 2015, Krzysztof Kozlowski wrote:

> The S2MPS13 RTC is almost the same as S2MPS14. The differences when
> updating alarm are:
> 1. Set WUDR+AUDR field instead of WUDR+RUDR.
> 2. Clear the AUDR field later (it is not auto-cleared).
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/rtc/rtc-s5m.c           | 20 +++++++++++++++++++-
>  include/linux/mfd/samsung/rtc.h |  2 ++
>  2 files changed, 21 insertions(+), 1 deletion(-)

[...]

> diff --git a/include/linux/mfd/samsung/rtc.h b/include/linux/mfd/samsung/=
rtc.h
> index b6401e7661c7..29c30ac36020 100644
> --- a/include/linux/mfd/samsung/rtc.h
> +++ b/include/linux/mfd/samsung/rtc.h
> @@ -105,6 +105,8 @@ enum s2mps_rtc_reg {
>  #define S5M_RTC_UDR_MASK	(1 << S5M_RTC_UDR_SHIFT)
>  #define S2MPS_RTC_WUDR_SHIFT	4
>  #define S2MPS_RTC_WUDR_MASK	(1 << S2MPS_RTC_WUDR_SHIFT)
> +#define S2MPS13_RTC_AUDR_SHIFT	1
> +#define S2MPS13_RTC_AUDR_MASK	(1 << S2MPS13_RTC_AUDR_SHIFT)
>  #define S2MPS_RTC_RUDR_SHIFT	0
>  #define S2MPS_RTC_RUDR_MASK	(1 << S2MPS_RTC_RUDR_SHIFT)
>  #define RTC_TCON_SHIFT		1

Please consider writing these like:

#define S2MPS_RTC_WUDR_MASK	bit(4)
#define S2MPS13_RTC_AUDR_MASK	bit(1)
#define S2MPS_RTC_RUDR_MASK	bit(0)

But for the MFD part of this patch:

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
