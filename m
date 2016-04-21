Return-Path: <rtc-linux+bncBDS7HNEFSALRBJGK4O4AKGQE5S5CPYI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id d92si628260wma.2.2016.04.21.07.35.16
        for <rtc-linux@googlegroups.com>;
        Thu, 21 Apr 2016 07:35:16 -0700 (PDT)
Date: Thu, 21 Apr 2016 16:35:06 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	mturquette@baylibre.com, sboyd@codeaurora.org, lee.jones@linaro.org,
	lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it,
	dianders@chromium.org, zyw@rock-chips.com
Subject: [rtc-linux] Re: [PATCH v2 7/7] rtc: Kconfig: Name RK818 in Kconfig
 for RTC_DRV_RK808
Message-ID: <20160421143506.GB29844@piout.net>
References: <1461244361-45686-1-git-send-email-w.egorov@phytec.de>
 <1461244361-45686-8-git-send-email-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1461244361-45686-8-git-send-email-w.egorov@phytec.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 21/04/2016 at 15:12:41 +0200, Wadim Egorov wrote :
> The RK808 and RK818 PMICs are using a similar register map.
> We can reuse the rtc driver for the RK818 PMIC. So let's add
> the RK818 in the Kconfig description.
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  drivers/rtc/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 3e84315..acc2651 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -324,11 +324,11 @@ config RTC_DRV_MAX77686
>  	  will be called rtc-max77686.
>  
>  config RTC_DRV_RK808
> -	tristate "Rockchip RK808 RTC"
> +	tristate "Rockchip RK808/RK818 RTC"
>  	depends on MFD_RK808
>  	help
>  	  If you say yes here you will get support for the
> -	  RTC of RK808 PMIC.
> +	  RTC of RK808 and RK818 PMIC.
>  
>  	  This driver can also be built as a module. If so, the module
>  	  will be called rk808-rtc.
> -- 
> 1.9.1
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
