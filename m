Return-Path: <rtc-linux+bncBDS7HNEFSALRBTH6VC2AKGQEX4RQ42I@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id b62si2153589wmc.0.2016.01.04.01.45.47
        for <rtc-linux@googlegroups.com>;
        Mon, 04 Jan 2016 01:45:47 -0800 (PST)
Date: Mon, 4 Jan 2016 10:45:46 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: zhangqing <zhangqing@rock-chips.com>
Cc: heiko@sntech.de, lee.jones@linaro.org, a.zummo@towertech.it,
	huangtao@rock-chips.com, zyw@rock-chips.com,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [RESEND PATCH] rtc: rk808: rename rtc-rk808.c to rtc-rk8xx.c
Message-ID: <20160104094546.GB32724@piout.net>
References: <1451571295-4193-1-git-send-email-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1451571295-4193-1-git-send-email-zhangqing@rock-chips.com>
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

On 31/12/2015 at 06:14:55 -0800, zhangqing wrote :
> make rtc-rk8xx.c compatible for all pmic chips.
> for pmic chips(rk808\rk807\rk816\rk818) in the future.
> 

I'm not sure it is useful to do that renaming. It is usual to have one
driver that supports multiple chips named with the forst chip it
supported.

Also, what would happen if for example rk855 is not compatible at all
with the previous implementations?

> Signed-off-by: zhangqing <zhangqing@rock-chips.com>
> ---
>  drivers/mfd/rk808.c                      |   2 +-
>  drivers/rtc/Kconfig                      |   8 +-
>  drivers/rtc/Makefile                     |   2 +-
>  drivers/rtc/{rtc-rk808.c => rtc-rk8xx.c} | 218 ++++++++++++++++++-------------
>  4 files changed, 131 insertions(+), 99 deletions(-)
>  rename drivers/rtc/{rtc-rk808.c => rtc-rk8xx.c} (64%)
> 
> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
> index 4b1e439..21da22b 100644
> --- a/drivers/mfd/rk808.c
> +++ b/drivers/mfd/rk808.c
> @@ -77,7 +77,7 @@ static const struct mfd_cell rk808s[] = {
>  	{ .name = "rk808-clkout", },
>  	{ .name = "rk808-regulator", },
>  	{
> -		.name = "rk808-rtc",
> +		.name = "rk8xx-rtc",
>  		.num_resources = ARRAY_SIZE(rtc_resources),
>  		.resources = &rtc_resources[0],
>  	},
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 376322f..d669473d 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -325,15 +325,15 @@ config RTC_DRV_MAX77686
>  	  This driver can also be built as a module. If so, the module
>  	  will be called rtc-max77686.
>  
> -config RTC_DRV_RK808
> -	tristate "Rockchip RK808 RTC"
> +config RTC_DRV_RK8XX
> +	tristate "Rockchip RK8XX RTC"
>  	depends on MFD_RK808
>  	help
>  	  If you say yes here you will get support for the
> -	  RTC of RK808 PMIC.
> +	  RTC of RK8XX PMIC.
>  
>  	  This driver can also be built as a module. If so, the module
> -	  will be called rk808-rtc.
> +	  will be called rk8xx-rtc.
>  
>  config RTC_DRV_MAX77802
>  	tristate "Maxim 77802 RTC"
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index 62d61b2..5b1384a 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -120,7 +120,7 @@ obj-$(CONFIG_RTC_DRV_PUV3)	+= rtc-puv3.o
>  obj-$(CONFIG_RTC_DRV_PXA)	+= rtc-pxa.o
>  obj-$(CONFIG_RTC_DRV_R9701)	+= rtc-r9701.o
>  obj-$(CONFIG_RTC_DRV_RC5T583)	+= rtc-rc5t583.o
> -obj-$(CONFIG_RTC_DRV_RK808)	+= rtc-rk808.o
> +obj-$(CONFIG_RTC_DRV_RK8XX)	+= rtc-rk8xx.o
>  obj-$(CONFIG_RTC_DRV_RP5C01)	+= rtc-rp5c01.o
>  obj-$(CONFIG_RTC_DRV_RS5C313)	+= rtc-rs5c313.o
>  obj-$(CONFIG_RTC_DRV_RS5C348)	+= rtc-rs5c348.o
> diff --git a/drivers/rtc/rtc-rk808.c b/drivers/rtc/rtc-rk8xx.c
> similarity index 64%
> rename from drivers/rtc/rtc-rk808.c
> rename to drivers/rtc/rtc-rk8xx.c
> index 35c9aad..5d946bf 100644
> --- a/drivers/rtc/rtc-rk808.c
> +++ b/drivers/rtc/rtc-rk8xx.c
> @@ -1,5 +1,5 @@
>  /*
> - * RTC driver for Rockchip RK808
> + * RTC driver for Rockchip RK8XX
>   *
>   * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
>   *
> @@ -20,14 +20,33 @@
>  #include <linux/kernel.h>
>  #include <linux/rtc.h>
>  #include <linux/bcd.h>
> -#include <linux/mfd/rk808.h>
>  #include <linux/platform_device.h>
>  #include <linux/i2c.h>
> +#include <linux/regmap.h>
> +
> +#define RK8XX_SECONDS_REG			0x00
> +#define RK8XX_MINUTES_REG			0x01
> +#define RK8XX_HOURS_REG				0x02
> +#define RK8XX_DAYS_REG				0x03
> +#define RK8XX_MONTHS_REG			0x04
> +#define RK8XX_YEARS_REG				0x05
> +#define RK8XX_WEEKS_REG				0x06
> +#define RK8XX_ALARM_SECONDS_REG			0x08
> +#define RK8XX_ALARM_MINUTES_REG			0x09
> +#define RK8XX_ALARM_HOURS_REG			0x0A
> +#define RK8XX_ALARM_DAYS_REG			0x0B
> +#define RK8XX_ALARM_MONTHS_REG			0x0C
> +#define RK8XX_ALARM_YEARS_REG			0x0D
> +#define RK8XX_RTC_CTRL_REG			0x10
> +#define RK8XX_RTC_STATUS_REG			0x11
> +#define RK8XX_RTC_INT_REG			0x12
> +#define RK8XX_RTC_COMP_LSB_REG			0x13
> +#define RK8XX_RTC_COMP_MSB_REG			0x14
>  
>  /* RTC_CTRL_REG bitfields */
>  #define BIT_RTC_CTRL_REG_STOP_RTC_M		BIT(0)
>  
> -/* RK808 has a shadowed register for saving a "frozen" RTC time.
> +/* RK8xx has a shadowed register for saving a "frozen" RTC time.
>   * When user setting "GET_TIME" to 1, the time will save in this shadowed
>   * register. If set "READSEL" to 1, user read rtc time register, actually
>   * get the time of that moment. If we need the real time, clr this bit.
> @@ -47,17 +66,25 @@
>  
>  /* REG_SECONDS_REG through REG_YEARS_REG is how many registers? */
>  
> -#define NUM_TIME_REGS	(RK808_WEEKS_REG - RK808_SECONDS_REG + 1)
> -#define NUM_ALARM_REGS	(RK808_ALARM_YEARS_REG - RK808_ALARM_SECONDS_REG + 1)
> +#define NUM_TIME_REGS	(RK8XX_WEEKS_REG - RK8XX_SECONDS_REG + 1)
> +#define NUM_ALARM_REGS	(RK8XX_ALARM_YEARS_REG - RK8XX_ALARM_SECONDS_REG + 1)
>  
> -struct rk808_rtc {
> -	struct rk808 *rk808;
> +static const struct regmap_config rk8xx_rtc_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = RK8XX_RTC_COMP_MSB_REG,
> +	.cache_type = REGCACHE_RBTREE,
> +};
> +
> +struct rk8xx_rtc {
>  	struct rtc_device *rtc;
> +	struct i2c_client *i2c;
> +	struct regmap *regmap;
>  	int irq;
>  };
>  
>  /*
> - * The Rockchip calendar used by the RK808 counts November with 31 days. We use
> + * The Rockchip calendar used by the RK8xx counts November with 31 days. We use
>   * these translation functions to convert its dates to/from the Gregorian
>   * calendar used by the rest of the world. We arbitrarily define Jan 1st, 2016
>   * as the day when both calendars were in sync, and treat all other dates
> @@ -74,6 +101,7 @@ static void rockchip_to_gregorian(struct rtc_time *tm)
>  {
>  	/* If it's Nov 31st, rtc_tm_to_time64() will count that like Dec 1st */
>  	time64_t time = rtc_tm_to_time64(tm);
> +
>  	rtc_time64_to_tm(time + nov2dec_transitions(tm) * 86400, tm);
>  }
>  
> @@ -81,6 +109,7 @@ static void gregorian_to_rockchip(struct rtc_time *tm)
>  {
>  	time64_t extra_days = nov2dec_transitions(tm);
>  	time64_t time = rtc_tm_to_time64(tm);
> +
>  	rtc_time64_to_tm(time - extra_days * 86400, tm);
>  
>  	/* Compensate if we went back over Nov 31st (will work up to 2381) */
> @@ -93,15 +122,14 @@ static void gregorian_to_rockchip(struct rtc_time *tm)
>  }
>  
>  /* Read current time and date in RTC */
> -static int rk808_rtc_readtime(struct device *dev, struct rtc_time *tm)
> +static int rk8xx_rtc_readtime(struct device *dev, struct rtc_time *tm)
>  {
> -	struct rk808_rtc *rk808_rtc = dev_get_drvdata(dev);
> -	struct rk808 *rk808 = rk808_rtc->rk808;
> +	struct rk8xx_rtc *rk8xx_rtc = dev_get_drvdata(dev);
>  	u8 rtc_data[NUM_TIME_REGS];
>  	int ret;
>  
>  	/* Force an update of the shadowed registers right now */
> -	ret = regmap_update_bits(rk808->regmap, RK808_RTC_CTRL_REG,
> +	ret = regmap_update_bits(rk8xx_rtc->regmap, RK8XX_RTC_CTRL_REG,
>  				 BIT_RTC_CTRL_REG_RTC_GET_TIME,
>  				 BIT_RTC_CTRL_REG_RTC_GET_TIME);
>  	if (ret) {
> @@ -115,7 +143,7 @@ static int rk808_rtc_readtime(struct device *dev, struct rtc_time *tm)
>  	 * 32khz. If we clear the GET_TIME bit here, the time of i2c transfer
>  	 * certainly more than 31.25us: 16 * 2.5us at 400kHz bus frequency.
>  	 */
> -	ret = regmap_update_bits(rk808->regmap, RK808_RTC_CTRL_REG,
> +	ret = regmap_update_bits(rk8xx_rtc->regmap, RK8XX_RTC_CTRL_REG,
>  				 BIT_RTC_CTRL_REG_RTC_GET_TIME,
>  				 0);
>  	if (ret) {
> @@ -123,7 +151,7 @@ static int rk808_rtc_readtime(struct device *dev, struct rtc_time *tm)
>  		return ret;
>  	}
>  
> -	ret = regmap_bulk_read(rk808->regmap, RK808_SECONDS_REG,
> +	ret = regmap_bulk_read(rk8xx_rtc->regmap, RK8XX_SECONDS_REG,
>  			       rtc_data, NUM_TIME_REGS);
>  	if (ret) {
>  		dev_err(dev, "Failed to bulk read rtc_data: %d\n", ret);
> @@ -146,10 +174,9 @@ static int rk808_rtc_readtime(struct device *dev, struct rtc_time *tm)
>  }
>  
>  /* Set current time and date in RTC */
> -static int rk808_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +static int rk8xx_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  {
> -	struct rk808_rtc *rk808_rtc = dev_get_drvdata(dev);
> -	struct rk808 *rk808 = rk808_rtc->rk808;
> +	struct rk8xx_rtc *rk8xx_rtc = dev_get_drvdata(dev);
>  	u8 rtc_data[NUM_TIME_REGS];
>  	int ret;
>  
> @@ -166,7 +193,7 @@ static int rk808_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  	rtc_data[6] = bin2bcd(tm->tm_wday);
>  
>  	/* Stop RTC while updating the RTC registers */
> -	ret = regmap_update_bits(rk808->regmap, RK808_RTC_CTRL_REG,
> +	ret = regmap_update_bits(rk8xx_rtc->regmap, RK8XX_RTC_CTRL_REG,
>  				 BIT_RTC_CTRL_REG_STOP_RTC_M,
>  				 BIT_RTC_CTRL_REG_STOP_RTC_M);
>  	if (ret) {
> @@ -174,14 +201,14 @@ static int rk808_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  		return ret;
>  	}
>  
> -	ret = regmap_bulk_write(rk808->regmap, RK808_SECONDS_REG,
> +	ret = regmap_bulk_write(rk8xx_rtc->regmap, RK8XX_SECONDS_REG,
>  				rtc_data, NUM_TIME_REGS);
>  	if (ret) {
>  		dev_err(dev, "Failed to bull write rtc_data: %d\n", ret);
>  		return ret;
>  	}
>  	/* Start RTC again */
> -	ret = regmap_update_bits(rk808->regmap, RK808_RTC_CTRL_REG,
> +	ret = regmap_update_bits(rk8xx_rtc->regmap, RK8XX_RTC_CTRL_REG,
>  				 BIT_RTC_CTRL_REG_STOP_RTC_M, 0);
>  	if (ret) {
>  		dev_err(dev, "Failed to update RTC control: %d\n", ret);
> @@ -191,15 +218,15 @@ static int rk808_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  }
>  
>  /* Read alarm time and date in RTC */
> -static int rk808_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
> +static int rk8xx_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
>  {
> -	struct rk808_rtc *rk808_rtc = dev_get_drvdata(dev);
> -	struct rk808 *rk808 = rk808_rtc->rk808;
> +	struct rk8xx_rtc *rk8xx_rtc = dev_get_drvdata(dev);
>  	u8 alrm_data[NUM_ALARM_REGS];
>  	uint32_t int_reg;
>  	int ret;
>  
> -	ret = regmap_bulk_read(rk808->regmap, RK808_ALARM_SECONDS_REG,
> +	ret = regmap_bulk_read(rk8xx_rtc->regmap,
> +			       RK8XX_ALARM_SECONDS_REG,
>  			       alrm_data, NUM_ALARM_REGS);
>  
>  	alrm->time.tm_sec = bcd2bin(alrm_data[0] & SECONDS_REG_MSK);
> @@ -210,7 +237,8 @@ static int rk808_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
>  	alrm->time.tm_year = (bcd2bin(alrm_data[5] & YEARS_REG_MSK)) + 100;
>  	rockchip_to_gregorian(&alrm->time);
>  
> -	ret = regmap_read(rk808->regmap, RK808_RTC_INT_REG, &int_reg);
> +	ret = regmap_read(rk8xx_rtc->regmap,
> +			  RK8XX_RTC_INT_REG, &int_reg);
>  	if (ret) {
>  		dev_err(dev, "Failed to read RTC INT REG: %d\n", ret);
>  		return ret;
> @@ -226,37 +254,34 @@ static int rk808_rtc_readalarm(struct device *dev, struct rtc_wkalrm *alrm)
>  	return 0;
>  }
>  
> -static int rk808_rtc_stop_alarm(struct rk808_rtc *rk808_rtc)
> +static int rk8xx_rtc_stop_alarm(struct rk8xx_rtc *rk8xx_rtc)
>  {
> -	struct rk808 *rk808 = rk808_rtc->rk808;
>  	int ret;
>  
> -	ret = regmap_update_bits(rk808->regmap, RK808_RTC_INT_REG,
> +	ret = regmap_update_bits(rk8xx_rtc->regmap, RK8XX_RTC_INT_REG,
>  				 BIT_RTC_INTERRUPTS_REG_IT_ALARM_M, 0);
>  
>  	return ret;
>  }
>  
> -static int rk808_rtc_start_alarm(struct rk808_rtc *rk808_rtc)
> +static int rk8xx_rtc_start_alarm(struct rk8xx_rtc *rk8xx_rtc)
>  {
> -	struct rk808 *rk808 = rk808_rtc->rk808;
>  	int ret;
>  
> -	ret = regmap_update_bits(rk808->regmap, RK808_RTC_INT_REG,
> +	ret = regmap_update_bits(rk8xx_rtc->regmap, RK8XX_RTC_INT_REG,
>  				 BIT_RTC_INTERRUPTS_REG_IT_ALARM_M,
>  				 BIT_RTC_INTERRUPTS_REG_IT_ALARM_M);
>  
>  	return ret;
>  }
>  
> -static int rk808_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
> +static int rk8xx_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
>  {
> -	struct rk808_rtc *rk808_rtc = dev_get_drvdata(dev);
> -	struct rk808 *rk808 = rk808_rtc->rk808;
> +	struct rk8xx_rtc *rk8xx_rtc = dev_get_drvdata(dev);
>  	u8 alrm_data[NUM_ALARM_REGS];
>  	int ret;
>  
> -	ret = rk808_rtc_stop_alarm(rk808_rtc);
> +	ret = rk8xx_rtc_stop_alarm(rk8xx_rtc);
>  	if (ret) {
>  		dev_err(dev, "Failed to stop alarm: %d\n", ret);
>  		return ret;
> @@ -274,14 +299,15 @@ static int rk808_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
>  	alrm_data[4] = bin2bcd(alrm->time.tm_mon + 1);
>  	alrm_data[5] = bin2bcd(alrm->time.tm_year - 100);
>  
> -	ret = regmap_bulk_write(rk808->regmap, RK808_ALARM_SECONDS_REG,
> +	ret = regmap_bulk_write(rk8xx_rtc->regmap,
> +				RK8XX_ALARM_SECONDS_REG,
>  				alrm_data, NUM_ALARM_REGS);
>  	if (ret) {
>  		dev_err(dev, "Failed to bulk write: %d\n", ret);
>  		return ret;
>  	}
>  	if (alrm->enabled) {
> -		ret = rk808_rtc_start_alarm(rk808_rtc);
> +		ret = rk8xx_rtc_start_alarm(rk8xx_rtc);
>  		if (ret) {
>  			dev_err(dev, "Failed to start alarm: %d\n", ret);
>  			return ret;
> @@ -290,15 +316,15 @@ static int rk808_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
>  	return 0;
>  }
>  
> -static int rk808_rtc_alarm_irq_enable(struct device *dev,
> +static int rk8xx_rtc_alarm_irq_enable(struct device *dev,
>  				      unsigned int enabled)
>  {
> -	struct rk808_rtc *rk808_rtc = dev_get_drvdata(dev);
> +	struct rk8xx_rtc *rk8xx_rtc = dev_get_drvdata(dev);
>  
>  	if (enabled)
> -		return rk808_rtc_start_alarm(rk808_rtc);
> +		return rk8xx_rtc_start_alarm(rk8xx_rtc);
>  
> -	return rk808_rtc_stop_alarm(rk808_rtc);
> +	return rk8xx_rtc_stop_alarm(rk8xx_rtc);
>  }
>  
>  /*
> @@ -311,14 +337,13 @@ static int rk808_rtc_alarm_irq_enable(struct device *dev,
>   * bit 2: every hour
>   * bit 3: every day
>   */
> -static irqreturn_t rk808_alarm_irq(int irq, void *data)
> +static irqreturn_t rk8xx_alarm_irq(int irq, void *data)
>  {
> -	struct rk808_rtc *rk808_rtc = data;
> -	struct rk808 *rk808 = rk808_rtc->rk808;
> -	struct i2c_client *client = rk808->i2c;
> +	struct rk8xx_rtc *rk8xx_rtc = data;
> +	struct i2c_client *client = rk8xx_rtc->i2c;
>  	int ret;
>  
> -	ret = regmap_write(rk808->regmap, RK808_RTC_STATUS_REG,
> +	ret = regmap_write(rk8xx_rtc->regmap, RK8XX_RTC_STATUS_REG,
>  			   RTC_STATUS_MASK);
>  	if (ret) {
>  		dev_err(&client->dev,
> @@ -326,29 +351,29 @@ static irqreturn_t rk808_alarm_irq(int irq, void *data)
>  		return ret;
>  	}
>  
> -	rtc_update_irq(rk808_rtc->rtc, 1, RTC_IRQF | RTC_AF);
> +	rtc_update_irq(rk8xx_rtc->rtc, 1, RTC_IRQF | RTC_AF);
>  	dev_dbg(&client->dev,
> -		 "%s:irq=%d\n", __func__, irq);
> +		"%s:irq=%d\n", __func__, irq);
>  	return IRQ_HANDLED;
>  }
>  
> -static const struct rtc_class_ops rk808_rtc_ops = {
> -	.read_time = rk808_rtc_readtime,
> -	.set_time = rk808_rtc_set_time,
> -	.read_alarm = rk808_rtc_readalarm,
> -	.set_alarm = rk808_rtc_setalarm,
> -	.alarm_irq_enable = rk808_rtc_alarm_irq_enable,
> +static const struct rtc_class_ops rk8xx_rtc_ops = {
> +	.read_time = rk8xx_rtc_readtime,
> +	.set_time = rk8xx_rtc_set_time,
> +	.read_alarm = rk8xx_rtc_readalarm,
> +	.set_alarm = rk8xx_rtc_setalarm,
> +	.alarm_irq_enable = rk8xx_rtc_alarm_irq_enable,
>  };
>  
>  #ifdef CONFIG_PM_SLEEP
>  /* Turn off the alarm if it should not be a wake source. */
> -static int rk808_rtc_suspend(struct device *dev)
> +static int rk8xx_rtc_suspend(struct device *dev)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
> -	struct rk808_rtc *rk808_rtc = dev_get_drvdata(&pdev->dev);
> +	struct rk8xx_rtc *rk8xx_rtc = dev_get_drvdata(&pdev->dev);
>  
>  	if (device_may_wakeup(dev))
> -		enable_irq_wake(rk808_rtc->irq);
> +		enable_irq_wake(rk8xx_rtc->irq);
>  
>  	return 0;
>  }
> @@ -356,37 +381,44 @@ static int rk808_rtc_suspend(struct device *dev)
>  /* Enable the alarm if it should be enabled (in case it was disabled to
>   * prevent use as a wake source).
>   */
> -static int rk808_rtc_resume(struct device *dev)
> +static int rk8xx_rtc_resume(struct device *dev)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
> -	struct rk808_rtc *rk808_rtc = dev_get_drvdata(&pdev->dev);
> +	struct rk8xx_rtc *rk8xx_rtc = dev_get_drvdata(&pdev->dev);
>  
>  	if (device_may_wakeup(dev))
> -		disable_irq_wake(rk808_rtc->irq);
> +		disable_irq_wake(rk8xx_rtc->irq);
>  
>  	return 0;
>  }
>  #endif
>  
> -static SIMPLE_DEV_PM_OPS(rk808_rtc_pm_ops,
> -	rk808_rtc_suspend, rk808_rtc_resume);
> +static SIMPLE_DEV_PM_OPS(rk8xx_rtc_pm_ops,
> +	rk8xx_rtc_suspend, rk8xx_rtc_resume);
>  
> -static int rk808_rtc_probe(struct platform_device *pdev)
> +static int rk8xx_rtc_probe(struct platform_device *pdev)
>  {
> -	struct rk808 *rk808 = dev_get_drvdata(pdev->dev.parent);
> -	struct rk808_rtc *rk808_rtc;
> +	struct i2c_client *client = to_i2c_client(pdev->dev.parent);
> +	struct rk8xx_rtc *rk8xx_rtc;
>  	struct rtc_time tm;
>  	int ret;
>  
> -	rk808_rtc = devm_kzalloc(&pdev->dev, sizeof(*rk808_rtc), GFP_KERNEL);
> -	if (rk808_rtc == NULL)
> +	rk8xx_rtc = devm_kzalloc(&pdev->dev, sizeof(*rk8xx_rtc), GFP_KERNEL);
> +	if (rk8xx_rtc == NULL)
>  		return -ENOMEM;
>  
> -	platform_set_drvdata(pdev, rk808_rtc);
> -	rk808_rtc->rk808 = rk808;
> +	rk8xx_rtc->regmap = devm_regmap_init_i2c(client,
> +					     &rk8xx_rtc_regmap_config);
> +	if (IS_ERR(rk8xx_rtc->regmap)) {
> +		dev_err(&pdev->dev, "regmap initialization failed\n");
> +		return PTR_ERR(rk8xx_rtc->regmap);
> +	}
> +
> +	platform_set_drvdata(pdev, rk8xx_rtc);
> +	rk8xx_rtc->i2c = client;
>  
>  	/* start rtc running by default, and use shadowed timer. */
> -	ret = regmap_update_bits(rk808->regmap, RK808_RTC_CTRL_REG,
> +	ret = regmap_update_bits(rk8xx_rtc->regmap, RK8XX_RTC_CTRL_REG,
>  				 BIT_RTC_CTRL_REG_STOP_RTC_M |
>  				 BIT_RTC_CTRL_REG_RTC_READSEL_M,
>  				 BIT_RTC_CTRL_REG_RTC_READSEL_M);
> @@ -396,7 +428,7 @@ static int rk808_rtc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	ret = regmap_write(rk808->regmap, RK808_RTC_STATUS_REG,
> +	ret = regmap_write(rk8xx_rtc->regmap, RK8XX_RTC_STATUS_REG,
>  			   RTC_STATUS_MASK);
>  	if (ret) {
>  		dev_err(&pdev->dev,
> @@ -405,7 +437,7 @@ static int rk808_rtc_probe(struct platform_device *pdev)
>  	}
>  
>  	/* set init time */
> -	ret = rk808_rtc_readtime(&pdev->dev, &tm);
> +	ret = rk8xx_rtc_readtime(&pdev->dev, &tm);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to read RTC time\n");
>  		return ret;
> @@ -416,45 +448,45 @@ static int rk808_rtc_probe(struct platform_device *pdev)
>  
>  	device_init_wakeup(&pdev->dev, 1);
>  
> -	rk808_rtc->rtc = devm_rtc_device_register(&pdev->dev, "rk808-rtc",
> -						  &rk808_rtc_ops, THIS_MODULE);
> -	if (IS_ERR(rk808_rtc->rtc)) {
> -		ret = PTR_ERR(rk808_rtc->rtc);
> +	rk8xx_rtc->rtc = devm_rtc_device_register(&pdev->dev, "rk8xx-rtc",
> +						  &rk8xx_rtc_ops, THIS_MODULE);
> +	if (IS_ERR(rk8xx_rtc->rtc)) {
> +		ret = PTR_ERR(rk8xx_rtc->rtc);
>  		return ret;
>  	}
>  
> -	rk808_rtc->irq = platform_get_irq(pdev, 0);
> -	if (rk808_rtc->irq < 0) {
> -		if (rk808_rtc->irq != -EPROBE_DEFER)
> +	rk8xx_rtc->irq = platform_get_irq(pdev, 0);
> +	if (rk8xx_rtc->irq < 0) {
> +		if (rk8xx_rtc->irq != -EPROBE_DEFER)
>  			dev_err(&pdev->dev, "Wake up is not possible as irq = %d\n",
> -				rk808_rtc->irq);
> -		return rk808_rtc->irq;
> +				rk8xx_rtc->irq);
> +		return rk8xx_rtc->irq;
>  	}
>  
> -	/* request alarm irq of rk808 */
> -	ret = devm_request_threaded_irq(&pdev->dev, rk808_rtc->irq, NULL,
> -					rk808_alarm_irq, 0,
> -					"RTC alarm", rk808_rtc);
> +	/* request alarm irq of rk8xx */
> +	ret = devm_request_threaded_irq(&pdev->dev, rk8xx_rtc->irq, NULL,
> +					rk8xx_alarm_irq, 0,
> +					"RTC alarm", rk8xx_rtc);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to request alarm IRQ %d: %d\n",
> -			rk808_rtc->irq, ret);
> +			rk8xx_rtc->irq, ret);
>  	}
>  
>  	return ret;
>  }
>  
> -static struct platform_driver rk808_rtc_driver = {
> -	.probe = rk808_rtc_probe,
> +static struct platform_driver rk8xx_rtc_driver = {
> +	.probe = rk8xx_rtc_probe,
>  	.driver = {
> -		.name = "rk808-rtc",
> -		.pm = &rk808_rtc_pm_ops,
> +		.name = "rk8xx-rtc",
> +		.pm = &rk8xx_rtc_pm_ops,
>  	},
>  };
>  
> -module_platform_driver(rk808_rtc_driver);
> +module_platform_driver(rk8xx_rtc_driver);
>  
> -MODULE_DESCRIPTION("RTC driver for the rk808 series PMICs");
> +MODULE_DESCRIPTION("RTC driver for the rk8xx series PMICs");
>  MODULE_AUTHOR("Chris Zhong <zyw@rock-chips.com>");
>  MODULE_AUTHOR("Zhang Qing <zhangqing@rock-chips.com>");
>  MODULE_LICENSE("GPL");
> -MODULE_ALIAS("platform:rk808-rtc");
> +MODULE_ALIAS("platform:rk8xx-rtc");
> -- 
> 1.9.1
> 
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
