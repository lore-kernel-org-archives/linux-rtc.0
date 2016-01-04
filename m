Return-Path: <rtc-linux+bncBDS7HNEFSALRBGWOVK2AKGQE2ZW45AQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id v7si866788wmg.3.2016.01.04.09.08.42
        for <rtc-linux@googlegroups.com>;
        Mon, 04 Jan 2016 09:08:42 -0800 (PST)
Date: Mon, 4 Jan 2016 18:08:41 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, rtc-linux@googlegroups.com,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Yadwinder Singh Brar <yadi.brar01@gmail.com>
Subject: [rtc-linux] Re: [PATCH v2 1/3] rtc: s5m: Cleanup by removing useless
 'rtc' prefix from fields
Message-ID: <20160104170841.GD32724@piout.net>
References: <1451450847-928-1-git-send-email-k.kozlowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1451450847-928-1-git-send-email-k.kozlowski@samsung.com>
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

On 30/12/2015 at 13:47:25 +0900, Krzysztof Kozlowski wrote :
> Remove the 'rtc' prefix from some of the fields in struct
> s5m_rtc_reg_config because it is obvious - this is a RTC driver. No
> functional changes.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 

I was going to apply those patches but they don't apply cleanly on
rtc-next. Did I miss something?

> ---
> 
> Changes since v1:
> 1. None.
> ---
>  drivers/rtc/rtc-s5m.c | 40 +++++++++++++++++++---------------------
>  1 file changed, 19 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
> index 0d68a85dd429..85649861a6b0 100644
> --- a/drivers/rtc/rtc-s5m.c
> +++ b/drivers/rtc/rtc-s5m.c
> @@ -55,9 +55,9 @@ struct s5m_rtc_reg_config {
>  	 * will enable update of time or alarm register. Then it will be
>  	 * auto-cleared after successful update.
>  	 */
> -	unsigned int rtc_udr_update;
> -	/* Mask for UDR field in 'rtc_udr_update' register */
> -	unsigned int rtc_udr_mask;
> +	unsigned int udr_update;
> +	/* Mask for UDR field in 'udr_update' register */
> +	unsigned int udr_mask;
>  };
>  
>  /* Register map for S5M8763 and S5M8767 */
> @@ -67,8 +67,8 @@ static const struct s5m_rtc_reg_config s5m_rtc_regs = {
>  	.ctrl			= S5M_ALARM1_CONF,
>  	.alarm0			= S5M_ALARM0_SEC,
>  	.alarm1			= S5M_ALARM1_SEC,
> -	.rtc_udr_update		= S5M_RTC_UDR_CON,
> -	.rtc_udr_mask		= S5M_RTC_UDR_MASK,
> +	.udr_update		= S5M_RTC_UDR_CON,
> +	.udr_mask		= S5M_RTC_UDR_MASK,
>  };
>  
>  /*
> @@ -81,8 +81,8 @@ static const struct s5m_rtc_reg_config s2mps_rtc_regs = {
>  	.ctrl			= S2MPS_RTC_CTRL,
>  	.alarm0			= S2MPS_ALARM0_SEC,
>  	.alarm1			= S2MPS_ALARM1_SEC,
> -	.rtc_udr_update		= S2MPS_RTC_UDR_CON,
> -	.rtc_udr_mask		= S2MPS_RTC_WUDR_MASK,
> +	.udr_update		= S2MPS_RTC_UDR_CON,
> +	.udr_mask		= S2MPS_RTC_WUDR_MASK,
>  };
>  
>  struct s5m_rtc_info {
> @@ -166,9 +166,8 @@ static inline int s5m8767_wait_for_udr_update(struct s5m_rtc_info *info)
>  	unsigned int data;
>  
>  	do {
> -		ret = regmap_read(info->regmap, info->regs->rtc_udr_update,
> -				&data);
> -	} while (--retry && (data & info->regs->rtc_udr_mask) && !ret);
> +		ret = regmap_read(info->regmap, info->regs->udr_update, &data);
> +	} while (--retry && (data & info->regs->udr_mask) && !ret);
>  
>  	if (!retry)
>  		dev_err(info->dev, "waiting for UDR update, reached max number of retries\n");
> @@ -214,7 +213,7 @@ static inline int s5m8767_rtc_set_time_reg(struct s5m_rtc_info *info)
>  	int ret;
>  	unsigned int data;
>  
> -	ret = regmap_read(info->regmap, info->regs->rtc_udr_update, &data);
> +	ret = regmap_read(info->regmap, info->regs->udr_update, &data);
>  	if (ret < 0) {
>  		dev_err(info->dev, "failed to read update reg(%d)\n", ret);
>  		return ret;
> @@ -223,21 +222,20 @@ static inline int s5m8767_rtc_set_time_reg(struct s5m_rtc_info *info)
>  	switch (info->device_type) {
>  	case S5M8763X:
>  	case S5M8767X:
> -		data |= info->regs->rtc_udr_mask | S5M_RTC_TIME_EN_MASK;
> +		data |= info->regs->udr_mask | S5M_RTC_TIME_EN_MASK;
>  	case S2MPS15X:
>  		/* As per UM, for write time register, set WUDR bit to high */
>  		data |= S2MPS15_RTC_WUDR_MASK;
>  		break;
>  	case S2MPS14X:
>  	case S2MPS13X:
> -		data |= info->regs->rtc_udr_mask;
> +		data |= info->regs->udr_mask;
>  		break;
>  	default:
>  		return -EINVAL;
>  	}
>  
> -
> -	ret = regmap_write(info->regmap, info->regs->rtc_udr_update, data);
> +	ret = regmap_write(info->regmap, info->regs->udr_update, data);
>  	if (ret < 0) {
>  		dev_err(info->dev, "failed to write update reg(%d)\n", ret);
>  		return ret;
> @@ -253,14 +251,14 @@ static inline int s5m8767_rtc_set_alarm_reg(struct s5m_rtc_info *info)
>  	int ret;
>  	unsigned int data;
>  
> -	ret = regmap_read(info->regmap, info->regs->rtc_udr_update, &data);
> +	ret = regmap_read(info->regmap, info->regs->udr_update, &data);
>  	if (ret < 0) {
>  		dev_err(info->dev, "%s: fail to read update reg(%d)\n",
>  			__func__, ret);
>  		return ret;
>  	}
>  
> -	data |= info->regs->rtc_udr_mask;
> +	data |= info->regs->udr_mask;
>  	switch (info->device_type) {
>  	case S5M8763X:
>  	case S5M8767X:
> @@ -268,7 +266,7 @@ static inline int s5m8767_rtc_set_alarm_reg(struct s5m_rtc_info *info)
>  		break;
>  	case S2MPS15X:
>  		/* As per UM, for write alarm, set A_UDR(bit[4]) to high
> -		 * rtc_udr_mask above sets bit[4]
> +		 * udr_mask above sets bit[4]
>  		 */
>  		break;
>  	case S2MPS14X:
> @@ -281,7 +279,7 @@ static inline int s5m8767_rtc_set_alarm_reg(struct s5m_rtc_info *info)
>  		return -EINVAL;
>  	}
>  
> -	ret = regmap_write(info->regmap, info->regs->rtc_udr_update, data);
> +	ret = regmap_write(info->regmap, info->regs->udr_update, data);
>  	if (ret < 0) {
>  		dev_err(info->dev, "%s: fail to write update reg(%d)\n",
>  			__func__, ret);
> @@ -292,7 +290,7 @@ static inline int s5m8767_rtc_set_alarm_reg(struct s5m_rtc_info *info)
>  
>  	/* On S2MPS13 the AUDR is not auto-cleared */
>  	if (info->device_type == S2MPS13X)
> -		regmap_update_bits(info->regmap, info->regs->rtc_udr_update,
> +		regmap_update_bits(info->regmap, info->regs->udr_update,
>  				   S2MPS13_RTC_AUDR_MASK, 0);
>  
>  	return ret;
> @@ -339,7 +337,7 @@ static int s5m_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  	if (info->device_type == S2MPS15X || info->device_type == S2MPS14X ||
>  			info->device_type == S2MPS13X) {
>  		ret = regmap_update_bits(info->regmap,
> -				info->regs->rtc_udr_update,
> +				info->regs->udr_update,
>  				S2MPS_RTC_RUDR_MASK, S2MPS_RTC_RUDR_MASK);
>  		if (ret) {
>  			dev_err(dev,
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
