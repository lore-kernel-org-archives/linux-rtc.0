Return-Path: <rtc-linux+bncBDS7HNEFSALRBCM646YQKGQEC5EIGYY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id l1si806850wmb.1.2015.11.04.01.25.29
        for <rtc-linux@googlegroups.com>;
        Wed, 04 Nov 2015 01:25:29 -0800 (PST)
Date: Wed, 4 Nov 2015 10:25:29 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Soren Brinkmann <soren.brinkmann@xilinx.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: Group Kconfig entries by vendor
Message-ID: <20151104092529.GX22331@piout.net>
References: <1446621226-28429-1-git-send-email-soren.brinkmann@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1446621226-28429-1-git-send-email-soren.brinkmann@xilinx.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 03/11/2015 at 23:13:46 -0800, Soren Brinkmann wrote :
> The RTC entries are mostly grouped by vendor. Move the few outliers in
> place.
> Also, change the one occurrence of 'nxp' to 'NXP' to make all NXP
> entries consistent.
> 

Yeah, I've been contemplating reordering the Kconfig, the main issue
being that Philips and NXP is the same entity. And also, we have RTCs
manufactured by different vendors that use the same chip
(Abracon/Epson/Philips/Microcrystal) so I'm not sure what is clearer for
the end user :)

> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  drivers/rtc/Kconfig | 90 ++++++++++++++++++++++++++---------------------------
>  1 file changed, 45 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 2a524244afec..ea7f43f12f69 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -325,16 +325,6 @@ config RTC_DRV_MAX77686
>  	  This driver can also be built as a module. If so, the module
>  	  will be called rtc-max77686.
>  
> -config RTC_DRV_RK808
> -	tristate "Rockchip RK808 RTC"
> -	depends on MFD_RK808
> -	help
> -	  If you say yes here you will get support for the
> -	  RTC of RK808 PMIC.
> -
> -	  This driver can also be built as a module. If so, the module
> -	  will be called rk808-rtc.
> -
>  config RTC_DRV_MAX77802
>  	tristate "Maxim 77802 RTC"
>  	depends on MFD_MAX77686
> @@ -345,6 +335,16 @@ config RTC_DRV_MAX77802
>  	  This driver can also be built as a module. If so, the module
>  	  will be called rtc-max77802.
>  
> +config RTC_DRV_RK808
> +	tristate "Rockchip RK808 RTC"
> +	depends on MFD_RK808
> +	help
> +	  If you say yes here you will get support for the
> +	  RTC of RK808 PMIC.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called rk808-rtc.
> +
>  config RTC_DRV_RS5C372
>  	tristate "Ricoh R2025S/D, RS5C372A/B, RV5C386, RV5C387A"
>  	help
> @@ -391,16 +391,6 @@ config RTC_DRV_X1205
>  	  This driver can also be built as a module. If so, the module
>  	  will be called rtc-x1205.
>  
> -config RTC_DRV_PALMAS
> -	tristate "TI Palmas RTC driver"
> -	depends on MFD_PALMAS
> -	help
> -	  If you say yes here you get support for the RTC of TI PALMA series PMIC
> -	  chips.
> -
> -	  This driver can also be built as a module. If so, the module
> -	  will be called rtc-palma.
> -
>  config RTC_DRV_PCF2127
>  	tristate "NXP PCF2127"
>  	help
> @@ -419,6 +409,14 @@ config RTC_DRV_PCF8523
>  	  This driver can also be built as a module. If so, the module
>  	  will be called rtc-pcf8523.
>  
> +config RTC_DRV_PCF85063
> +	tristate "NXP PCF85063"
> +	help
> +	  If you say yes here you get support for the PCF85063 RTC chip
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called rtc-pcf85063.
> +
>  config RTC_DRV_PCF8563
>  	tristate "Philips PCF8563/Epson RTC8564"
>  	help
> @@ -429,14 +427,6 @@ config RTC_DRV_PCF8563
>  	  This driver can also be built as a module. If so, the module
>  	  will be called rtc-pcf8563.
>  
> -config RTC_DRV_PCF85063
> -	tristate "nxp PCF85063"
> -	help
> -	  If you say yes here you get support for the PCF85063 RTC chip
> -
> -	  This driver can also be built as a module. If so, the module
> -	  will be called rtc-pcf85063.
> -
>  config RTC_DRV_PCF8583
>  	tristate "Philips PCF8583"
>  	help
> @@ -501,6 +491,16 @@ config RTC_DRV_TWL4030
>  	  This driver can also be built as a module. If so, the module
>  	  will be called rtc-twl.
>  
> +config RTC_DRV_PALMAS
> +	tristate "TI Palmas RTC driver"
> +	depends on MFD_PALMAS
> +	help
> +	  If you say yes here you get support for the RTC of TI PALMA series PMIC
> +	  chips.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called rtc-palma.
> +
>  config RTC_DRV_TPS6586X
>  	tristate "TI TPS6586X RTC driver"
>  	depends on MFD_TPS6586X
> @@ -681,15 +681,6 @@ config RTC_DRV_DS1390
>  	  This driver can also be built as a module. If so, the module
>  	  will be called rtc-ds1390.
>  
> -config RTC_DRV_MAX6902
> -	tristate "Maxim MAX6902"
> -	help
> -	  If you say yes here you will get support for the
> -	  Maxim MAX6902 SPI RTC chip.
> -
> -	  This driver can also be built as a module. If so, the module
> -	  will be called rtc-max6902.
> -
>  config RTC_DRV_R9701
>  	tristate "Epson RTC-9701JE"
>  	help
> @@ -699,6 +690,14 @@ config RTC_DRV_R9701
>  	  This driver can also be built as a module. If so, the module
>  	  will be called rtc-r9701.
>  
> +config RTC_DRV_RX4581
> +	tristate "Epson RX-4581"
> +	help
> +	  If you say yes here you will get support for the Epson RX-4581.
> +
> +	  This driver can also be built as a module. If so the module
> +	  will be called rtc-rx4581.
> +
>  config RTC_DRV_RS5C348
>  	tristate "Ricoh RS5C348A/B"
>  	help
> @@ -708,6 +707,15 @@ config RTC_DRV_RS5C348
>  	  This driver can also be built as a module. If so, the module
>  	  will be called rtc-rs5c348.
>  
> +config RTC_DRV_MAX6902
> +	tristate "Maxim MAX6902"
> +	help
> +	  If you say yes here you will get support for the
> +	  Maxim MAX6902 SPI RTC chip.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called rtc-max6902.
> +
>  config RTC_DRV_DS3234
>  	tristate "Maxim/Dallas DS3234"
>  	help
> @@ -726,14 +734,6 @@ config RTC_DRV_PCF2123
>  	  This driver can also be built as a module. If so, the module
>  	  will be called rtc-pcf2123.
>  
> -config RTC_DRV_RX4581
> -	tristate "Epson RX-4581"
> -	help
> -	  If you say yes here you will get support for the Epson RX-4581.
> -
> -	  This driver can also be built as a module. If so the module
> -	  will be called rtc-rx4581.
> -
>  config RTC_DRV_MCP795
>  	tristate "Microchip MCP795"
>  	help
> -- 
> 2.6.2.3.ga463a5b
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
