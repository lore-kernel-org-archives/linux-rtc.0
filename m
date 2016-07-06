Return-Path: <rtc-linux+bncBCYKZMUQ7QBBBOMJ625QKGQE2UEEJGI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com. [2607:f8b0:400e:c03::229])
        by gmr-mx.google.com with ESMTPS id un17si49607pab.0.2016.07.06.15.22.49
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jul 2016 15:22:49 -0700 (PDT)
Received: by mail-pa0-x229.google.com with SMTP id dx3so95911pab.2
        for <rtc-linux@googlegroups.com>; Wed, 06 Jul 2016 15:22:49 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
To: Wadim Egorov <w.egorov@phytec.de>, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, rtc-linux@googlegroups.com,
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
From: Michael Turquette <mturquette@baylibre.com>
In-Reply-To: <1464850228-17244-4-git-send-email-w.egorov@phytec.de>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
 ijc+devicetree@hellion.org.uk, galak@codeaurora.org, sboyd@codeaurora.org,
 lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
 a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
 dianders@chromium.org, zyw@rock-chips.com
References: <1464850228-17244-1-git-send-email-w.egorov@phytec.de>
 <1464850228-17244-4-git-send-email-w.egorov@phytec.de>
Message-ID: <146784376682.73491.439491426208764255@resonance>
Subject: [rtc-linux] Re: [RESEND PATCH v5 4/5] clk: Kconfig: Name RK818 in
 Kconfig for COMMON_CLK_RK808
Date: Wed, 06 Jul 2016 15:22:46 -0700
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Quoting Wadim Egorov (2016-06-01 23:50:27)
> The RK808 and RK818 PMICs are using a similar register map.
> We can reuse the clk driver for the RK818 PMIC. So let's add
> the RK818 in the Kconfig description.
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>

Applied.

Regards,
Mike

> ---
>  drivers/clk/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 53ddba2..87b9fd2 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -49,10 +49,10 @@ config COMMON_CLK_MAX77802
>           This driver supports Maxim 77802 crystal oscillator clock.
>  
>  config COMMON_CLK_RK808
> -       tristate "Clock driver for RK808"
> +       tristate "Clock driver for RK808/RK818"
>         depends on MFD_RK808
>         ---help---
> -         This driver supports RK808 crystal oscillator clock. These
> +         This driver supports RK808 and RK818 crystal oscillator clock. These
>           multi-function devices have two fixed-rate oscillators,
>           clocked at 32KHz each. Clkout1 is always on, Clkout2 can off
>           by control register.
> -- 
> 1.9.1
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
