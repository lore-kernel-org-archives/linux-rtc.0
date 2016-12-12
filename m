Return-Path: <rtc-linux+bncBDA7X7F2WUEBBCNJXHBAKGQEE5Q4SOY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x22c.google.com (mail-wm0-x22c.google.com. [2a00:1450:400c:c09::22c])
        by gmr-mx.google.com with ESMTPS id o77si2534128wme.0.2016.12.11.23.40.57
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Dec 2016 23:40:57 -0800 (PST)
Received: by mail-wm0-x22c.google.com with SMTP id t79so52634810wmt.0
        for <rtc-linux@googlegroups.com>; Sun, 11 Dec 2016 23:40:57 -0800 (PST)
Date: Mon, 12 Dec 2016 07:44:16 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Vesa =?iso-8859-1?B?SuTkc2tlbORpbmVu?= <vesa.jaaskelainen@vaisala.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH v2 1/2] drivers: rtc: rtc-tps65910: Add RTC
 calibration support
Message-ID: <20161212074416.GN3625@dell.home>
References: <1481406644-1614-1-git-send-email-vesa.jaaskelainen@vaisala.com>
 <1481406644-1614-2-git-send-email-vesa.jaaskelainen@vaisala.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1481406644-1614-2-git-send-email-vesa.jaaskelainen@vaisala.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Sat, 10 Dec 2016, Vesa J=C3=A4=C3=A4skel=C3=A4inen wrote:

> Texas Instrument's TPS65910 has support for compensating RTC crystal
> inaccuracies. When enabled every hour RTC counter value will be compensat=
ed
> with two's complement value.
>=20
> Signed-off-by: Vesa J=C3=A4=C3=A4skel=C3=A4inen <vesa.jaaskelainen@vaisal=
a.com>
> ---
>  drivers/rtc/rtc-tps65910.c   | 132 +++++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/mfd/tps65910.h |   1 +

For the MFD change:

Acked-by: Lee Jones <lee.jones@linaro.org>

>  2 files changed, 133 insertions(+)
>=20
> diff --git a/drivers/rtc/rtc-tps65910.c b/drivers/rtc/rtc-tps65910.c
> index 5a3d53c..aafa716 100644
> --- a/drivers/rtc/rtc-tps65910.c
> +++ b/drivers/rtc/rtc-tps65910.c
> @@ -21,6 +21,7 @@
>  #include <linux/types.h>
>  #include <linux/rtc.h>
>  #include <linux/bcd.h>
> +#include <linux/math64.h>
>  #include <linux/platform_device.h>
>  #include <linux/interrupt.h>
>  #include <linux/mfd/tps65910.h>
> @@ -33,6 +34,19 @@ struct tps65910_rtc {
>  /* Total number of RTC registers needed to set time*/
>  #define NUM_TIME_REGS	(TPS65910_YEARS - TPS65910_SECONDS + 1)
> =20
> +/* Total number of RTC registers needed to set compensation registers */
> +#define NUM_COMP_REGS	(TPS65910_RTC_COMP_MSB - TPS65910_RTC_COMP_LSB + 1=
)
> +
> +/* Min and max values supported with 'offset' interface (swapped sign) *=
/
> +#define MIN_OFFSET	(-277761)
> +#define MAX_OFFSET	(277778)
> +
> +/* Number of ticks per hour */
> +#define TICKS_PER_HOUR	(32768 * 3600)
> +
> +/* Multiplier for ppb conversions */
> +#define PPB_MULT	(1000000000LL)
> +
>  static int tps65910_rtc_alarm_irq_enable(struct device *dev, unsigned en=
abled)
>  {
>  	struct tps65910 *tps =3D dev_get_drvdata(dev->parent);
> @@ -187,6 +201,122 @@ static int tps65910_rtc_set_alarm(struct device *de=
v, struct rtc_wkalrm *alm)
>  	return ret;
>  }
> =20
> +static int tps65910_rtc_set_calibration(struct device *dev, int calibrat=
ion)
> +{
> +	unsigned char comp_data[NUM_COMP_REGS];
> +	struct tps65910 *tps =3D dev_get_drvdata(dev->parent);
> +	s16 value;
> +	int ret;
> +
> +	/*
> +	 * TPS65910 uses two's complement 16 bit value for compensation for RTC
> +	 * crystal inaccuracies. One time every hour when seconds counter
> +	 * increments from 0 to 1 compensation value will be added to internal
> +	 * RTC counter value.
> +	 *
> +	 * Compensation value 0x7FFF is prohibited value.
> +	 *
> +	 * Valid range for compensation value: [-32768 .. 32766]
> +	 */
> +	if ((calibration < -32768) || (calibration > 32766)) {
> +		dev_err(dev, "RTC calibration value out of range: %d\n",
> +			calibration);
> +		return -EINVAL;
> +	}
> +
> +	value =3D (s16)calibration;
> +
> +	comp_data[0] =3D (u16)value & 0xFF;
> +	comp_data[1] =3D ((u16)value >> 8) & 0xFF;
> +
> +	/* Update all the compensation registers in one shot */
> +	ret =3D regmap_bulk_write(tps->regmap, TPS65910_RTC_COMP_LSB,
> +		comp_data, NUM_COMP_REGS);
> +	if (ret < 0) {
> +		dev_err(dev, "rtc_set_calibration error: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Enable automatic compensation */
> +	ret =3D regmap_update_bits(tps->regmap, TPS65910_RTC_CTRL,
> +		TPS65910_RTC_CTRL_AUTO_COMP, TPS65910_RTC_CTRL_AUTO_COMP);
> +	if (ret < 0)
> +		dev_err(dev, "auto_comp enable failed with error: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int tps65910_rtc_get_calibration(struct device *dev, int *calibra=
tion)
> +{
> +	unsigned char comp_data[NUM_COMP_REGS];
> +	struct tps65910 *tps =3D dev_get_drvdata(dev->parent);
> +	u16 value;
> +	int ret;
> +
> +	ret =3D regmap_bulk_read(tps->regmap, TPS65910_RTC_COMP_LSB, comp_data,
> +		NUM_COMP_REGS);
> +	if (ret < 0) {
> +		dev_err(dev, "rtc_get_calibration error: %d\n", ret);
> +		return ret;
> +	}
> +
> +	value =3D (u16)comp_data[0] | ((u16)comp_data[1] << 8);
> +
> +	*calibration =3D (s16)value;
> +
> +	return 0;
> +}
> +
> +static int tps65910_read_offset(struct device *dev, long *offset)
> +{
> +	int calibration;
> +	s64 tmp;
> +	int ret;
> +
> +	ret =3D tps65910_rtc_get_calibration(dev, &calibration);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Convert from RTC calibration register format to ppb format */
> +	tmp =3D calibration * (s64)PPB_MULT;
> +	if (tmp < 0)
> +		tmp -=3D TICKS_PER_HOUR / 2LL;
> +	else
> +		tmp +=3D TICKS_PER_HOUR / 2LL;
> +	tmp =3D div_s64(tmp, TICKS_PER_HOUR);
> +
> +	/* Offset value operates in negative way, so swap sign */
> +	*offset =3D (long)-tmp;
> +
> +	return 0;
> +}
> +
> +static int tps65910_set_offset(struct device *dev, long offset)
> +{
> +	int calibration;
> +	s64 tmp;
> +	int ret;
> +
> +	/* Make sure offset value is within supported range */
> +	if (offset < MIN_OFFSET || offset > MAX_OFFSET)
> +		return -ERANGE;
> +
> +	/* Convert from ppb format to RTC calibration register format */
> +	tmp =3D offset * (s64)TICKS_PER_HOUR;
> +	if (tmp < 0)
> +		tmp -=3D PPB_MULT / 2LL;
> +	else
> +		tmp +=3D PPB_MULT / 2LL;
> +	tmp =3D div_s64(tmp, PPB_MULT);
> +
> +	/* Offset value operates in negative way, so swap sign */
> +	calibration =3D (int)-tmp;
> +
> +	ret =3D tps65910_rtc_set_calibration(dev, calibration);
> +
> +	return ret;
> +}
> +
>  static irqreturn_t tps65910_rtc_interrupt(int irq, void *rtc)
>  {
>  	struct device *dev =3D rtc;
> @@ -219,6 +349,8 @@ static const struct rtc_class_ops tps65910_rtc_ops =
=3D {
>  	.read_alarm	=3D tps65910_rtc_read_alarm,
>  	.set_alarm	=3D tps65910_rtc_set_alarm,
>  	.alarm_irq_enable =3D tps65910_rtc_alarm_irq_enable,
> +	.read_offset	=3D tps65910_read_offset,
> +	.set_offset	=3D tps65910_set_offset,
>  };
> =20
>  static int tps65910_rtc_probe(struct platform_device *pdev)
> diff --git a/include/linux/mfd/tps65910.h b/include/linux/mfd/tps65910.h
> index 6483a6f..ffb21e7 100644
> --- a/include/linux/mfd/tps65910.h
> +++ b/include/linux/mfd/tps65910.h
> @@ -134,6 +134,7 @@
> =20
>  /* RTC_CTRL_REG bitfields */
>  #define TPS65910_RTC_CTRL_STOP_RTC			0x01 /*0=3Dstop, 1=3Drun */
> +#define TPS65910_RTC_CTRL_AUTO_COMP			0x04
>  #define TPS65910_RTC_CTRL_GET_TIME			0x40
> =20
>  /* RTC_STATUS_REG bitfields */

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

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
