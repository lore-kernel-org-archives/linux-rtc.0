Return-Path: <rtc-linux+bncBDA7X7F2WUEBBEHSZW2AKGQEAS3TCCY@googlegroups.com>
Received: from mail-wm0-x22f.google.com (mail-wm0-x22f.google.com. [2a00:1450:400c:c09::22f])
        by gmr-mx.google.com with ESMTPS id b4si207674wme.3.2016.01.11.01.42.39
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jan 2016 01:42:39 -0800 (PST)
Received: by mail-wm0-x22f.google.com with SMTP id f206so202703339wmf.0
        for <rtc-linux@googlegroups.com>; Mon, 11 Jan 2016 01:42:39 -0800 (PST)
Date: Mon, 11 Jan 2016 09:42:36 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	rtc-linux@googlegroups.com, Alim Akhtar <alim.akhtar@samsung.com>,
	Yadwinder Singh Brar <yadi.brar01@gmail.com>
Subject: [rtc-linux] Re: [PATCH v2 3/3] rtc: s5m: Make register configuration
 per S2MPS device to remove exceptions
Message-ID: <20160111094236.GO14104@x1>
References: <1451450847-928-1-git-send-email-k.kozlowski@samsung.com>
 <1451450847-928-3-git-send-email-k.kozlowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1451450847-928-3-git-send-email-k.kozlowski@samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Wed, 30 Dec 2015, Krzysztof Kozlowski wrote:

> Before updating time and alarm the driver must set appropriate mask in
> UDR register. For that purpose the driver uses common register
> configuration and a lot of exceptions per device in the code. The
> exceptions are not obvious, for example except the change in the logic
> sometimes the fields are swapped (WUDR and AUDR between S2MPS14 and
> S2MPS15). This leads to quite complicated code.
>=20
> Try to make it more obvious by:
> 1. Documenting the UDR masks for devices and operations.
> 2. Adding fields in register configuration structure for each operation
>    (read time, write time and alarm).
> 3. Splitting the configuration per S2MPS13, S2MPS14 and S2MPS15 thus
>    removing exceptions for them.
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>=20
> ---
>=20
> Tested on S2MPS11 (Odroid XU4) and S2MPS13. Testing on S2MPS15 would be
> appreciated!
>=20
> Changes since v1:
> 1. Fix value used in S2MPS15_RTC_AUDR_MASK, pointed by Yadwinder Singh
>    Brar.
> ---
>  drivers/rtc/rtc-s5m.c           | 110 +++++++++++++++++++++++++++-------=
------
>  include/linux/mfd/samsung/rtc.h |   2 +

Acked-by: Lee Jones <lee.jones@linaro.org>

>  2 files changed, 77 insertions(+), 35 deletions(-)
>=20
> diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
> index 559db8f72117..7407d7394bb4 100644
> --- a/drivers/rtc/rtc-s5m.c
> +++ b/drivers/rtc/rtc-s5m.c
> @@ -38,7 +38,22 @@
>   */
>  #define UDR_READ_RETRY_CNT	5
> =20
> -/* Registers used by the driver which are different between chipsets. */
> +/*
> + * Registers used by the driver which are different between chipsets.
> + *
> + * Operations like read time and write alarm/time require updating
> + * specific fields in UDR register. These fields usually are auto-cleare=
d
> + * (with some exceptions).
> + *
> + * Table of operations per device:
> + *
> + * Device     | Write time | Read time | Write alarm
> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> + * S5M8767    | UDR + TIME |           | UDR
> + * S2MPS11/14 | WUDR       | RUDR      | WUDR + RUDR
> + * S2MPS13    | WUDR       | RUDR      | WUDR + AUDR
> + * S2MPS15    | WUDR       | RUDR      | AUDR
> + */
>  struct s5m_rtc_reg_config {
>  	/* Number of registers used for setting time/alarm0/alarm1 */
>  	unsigned int regs_count;
> @@ -58,8 +73,13 @@ struct s5m_rtc_reg_config {
>  	unsigned int udr_update;
>  	/* Auto-cleared mask in UDR field for writing time and alarm */
>  	unsigned int autoclear_udr_mask;
> -	/* Mask for UDR field in 'udr_update' register */
> -	unsigned int udr_mask;
> +	/*
> +	 * Masks in UDR field for time and alarm operations.
> +	 * The read time mask can be 0. Rest should not.
> +	 */
> +	unsigned int read_time_udr_mask;
> +	unsigned int write_time_udr_mask;
> +	unsigned int write_alarm_udr_mask;
>  };
> =20
>  /* Register map for S5M8763 and S5M8767 */
> @@ -71,14 +91,44 @@ static const struct s5m_rtc_reg_config s5m_rtc_regs =
=3D {
>  	.alarm1			=3D S5M_ALARM1_SEC,
>  	.udr_update		=3D S5M_RTC_UDR_CON,
>  	.autoclear_udr_mask	=3D S5M_RTC_UDR_MASK,
> -	.udr_mask		=3D S5M_RTC_UDR_MASK,
> +	.read_time_udr_mask	=3D 0, /* Not needed */
> +	.write_time_udr_mask	=3D S5M_RTC_UDR_MASK | S5M_RTC_TIME_EN_MASK,
> +	.write_alarm_udr_mask	=3D S5M_RTC_UDR_MASK,
> +};
> +
> +/* Register map for S2MPS13 */
> +static const struct s5m_rtc_reg_config s2mps13_rtc_regs =3D {
> +	.regs_count		=3D 7,
> +	.time			=3D S2MPS_RTC_SEC,
> +	.ctrl			=3D S2MPS_RTC_CTRL,
> +	.alarm0			=3D S2MPS_ALARM0_SEC,
> +	.alarm1			=3D S2MPS_ALARM1_SEC,
> +	.udr_update		=3D S2MPS_RTC_UDR_CON,
> +	.autoclear_udr_mask	=3D S2MPS_RTC_WUDR_MASK,
> +	.read_time_udr_mask	=3D S2MPS_RTC_RUDR_MASK,
> +	.write_time_udr_mask	=3D S2MPS_RTC_WUDR_MASK,
> +	.write_alarm_udr_mask	=3D S2MPS_RTC_WUDR_MASK | S2MPS13_RTC_AUDR_MASK,
> +};
> +
> +/* Register map for S2MPS11/14 */
> +static const struct s5m_rtc_reg_config s2mps14_rtc_regs =3D {
> +	.regs_count		=3D 7,
> +	.time			=3D S2MPS_RTC_SEC,
> +	.ctrl			=3D S2MPS_RTC_CTRL,
> +	.alarm0			=3D S2MPS_ALARM0_SEC,
> +	.alarm1			=3D S2MPS_ALARM1_SEC,
> +	.udr_update		=3D S2MPS_RTC_UDR_CON,
> +	.autoclear_udr_mask	=3D S2MPS_RTC_WUDR_MASK,
> +	.read_time_udr_mask	=3D S2MPS_RTC_RUDR_MASK,
> +	.write_time_udr_mask	=3D S2MPS_RTC_WUDR_MASK,
> +	.write_alarm_udr_mask	=3D S2MPS_RTC_WUDR_MASK | S2MPS_RTC_RUDR_MASK,
>  };
> =20
>  /*
> - * Register map for S2MPS14.
> - * It may be also suitable for S2MPS11 but this was not tested.
> + * Register map for S2MPS15 - in comparison to S2MPS14 the WUDR and AUDR=
 bits
> + * are swapped.
>   */
> -static const struct s5m_rtc_reg_config s2mps_rtc_regs =3D {
> +static const struct s5m_rtc_reg_config s2mps15_rtc_regs =3D {
>  	.regs_count		=3D 7,
>  	.time			=3D S2MPS_RTC_SEC,
>  	.ctrl			=3D S2MPS_RTC_CTRL,
> @@ -86,7 +136,9 @@ static const struct s5m_rtc_reg_config s2mps_rtc_regs =
=3D {
>  	.alarm1			=3D S2MPS_ALARM1_SEC,
>  	.udr_update		=3D S2MPS_RTC_UDR_CON,
>  	.autoclear_udr_mask	=3D S2MPS_RTC_WUDR_MASK,
> -	.udr_mask		=3D S2MPS_RTC_WUDR_MASK,
> +	.read_time_udr_mask	=3D S2MPS_RTC_RUDR_MASK,
> +	.write_time_udr_mask	=3D S2MPS15_RTC_WUDR_MASK,
> +	.write_alarm_udr_mask	=3D S2MPS15_RTC_AUDR_MASK,
>  };
> =20
>  struct s5m_rtc_info {
> @@ -223,21 +275,7 @@ static inline int s5m8767_rtc_set_time_reg(struct s5=
m_rtc_info *info)
>  		return ret;
>  	}
> =20
> -	switch (info->device_type) {
> -	case S5M8763X:
> -	case S5M8767X:
> -		data |=3D info->regs->udr_mask | S5M_RTC_TIME_EN_MASK;
> -	case S2MPS15X:
> -		/* As per UM, for write time register, set WUDR bit to high */
> -		data |=3D S2MPS15_RTC_WUDR_MASK;
> -		break;
> -	case S2MPS14X:
> -	case S2MPS13X:
> -		data |=3D info->regs->udr_mask;
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> +	data |=3D info->regs->write_time_udr_mask;
> =20
>  	ret =3D regmap_write(info->regmap, info->regs->udr_update, data);
>  	if (ret < 0) {
> @@ -262,22 +300,16 @@ static inline int s5m8767_rtc_set_alarm_reg(struct =
s5m_rtc_info *info)
>  		return ret;
>  	}
> =20
> -	data |=3D info->regs->udr_mask;
> +	data |=3D info->regs->write_alarm_udr_mask;
>  	switch (info->device_type) {
>  	case S5M8763X:
>  	case S5M8767X:
>  		data &=3D ~S5M_RTC_TIME_EN_MASK;
>  		break;
>  	case S2MPS15X:
> -		/* As per UM, for write alarm, set A_UDR(bit[4]) to high
> -		 * udr_mask above sets bit[4]
> -		 */
> -		break;
>  	case S2MPS14X:
> -		data |=3D S2MPS_RTC_RUDR_MASK;
> -		break;
>  	case S2MPS13X:
> -		data |=3D S2MPS13_RTC_AUDR_MASK;
> +		/* No exceptions needed */
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -338,11 +370,11 @@ static int s5m_rtc_read_time(struct device *dev, st=
ruct rtc_time *tm)
>  	u8 data[info->regs->regs_count];
>  	int ret;
> =20
> -	if (info->device_type =3D=3D S2MPS15X || info->device_type =3D=3D S2MPS=
14X ||
> -			info->device_type =3D=3D S2MPS13X) {
> +	if (info->regs->read_time_udr_mask) {
>  		ret =3D regmap_update_bits(info->regmap,
>  				info->regs->udr_update,
> -				S2MPS_RTC_RUDR_MASK, S2MPS_RTC_RUDR_MASK);
> +				info->regs->read_time_udr_mask,
> +				info->regs->read_time_udr_mask);
>  		if (ret) {
>  			dev_err(dev,
>  				"Failed to prepare registers for time reading: %d\n",
> @@ -709,10 +741,18 @@ static int s5m_rtc_probe(struct platform_device *pd=
ev)
> =20
>  	switch (platform_get_device_id(pdev)->driver_data) {
>  	case S2MPS15X:
> +		regmap_cfg =3D &s2mps14_rtc_regmap_config;
> +		info->regs =3D &s2mps15_rtc_regs;
> +		alarm_irq =3D S2MPS14_IRQ_RTCA0;
> +		break;
>  	case S2MPS14X:
> +		regmap_cfg =3D &s2mps14_rtc_regmap_config;
> +		info->regs =3D &s2mps14_rtc_regs;
> +		alarm_irq =3D S2MPS14_IRQ_RTCA0;
> +		break;
>  	case S2MPS13X:
>  		regmap_cfg =3D &s2mps14_rtc_regmap_config;
> -		info->regs =3D &s2mps_rtc_regs;
> +		info->regs =3D &s2mps13_rtc_regs;
>  		alarm_irq =3D S2MPS14_IRQ_RTCA0;
>  		break;
>  	case S5M8763X:
> diff --git a/include/linux/mfd/samsung/rtc.h b/include/linux/mfd/samsung/=
rtc.h
> index a65e4655d470..48c3c5be7eb1 100644
> --- a/include/linux/mfd/samsung/rtc.h
> +++ b/include/linux/mfd/samsung/rtc.h
> @@ -105,6 +105,8 @@ enum s2mps_rtc_reg {
>  #define S5M_RTC_UDR_MASK	(1 << S5M_RTC_UDR_SHIFT)
>  #define S2MPS_RTC_WUDR_SHIFT	4
>  #define S2MPS_RTC_WUDR_MASK	(1 << S2MPS_RTC_WUDR_SHIFT)
> +#define S2MPS15_RTC_AUDR_SHIFT	4
> +#define S2MPS15_RTC_AUDR_MASK	(1 << S2MPS15_RTC_AUDR_SHIFT)
>  #define S2MPS13_RTC_AUDR_SHIFT	1
>  #define S2MPS13_RTC_AUDR_MASK	(1 << S2MPS13_RTC_AUDR_SHIFT)
>  #define S2MPS15_RTC_WUDR_SHIFT	1

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
