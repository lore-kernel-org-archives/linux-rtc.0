Return-Path: <rtc-linux+bncBDKZNNNLXAHBBHOKYCYQKGQEF5N7BPA@googlegroups.com>
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com. [210.118.77.14])
        by gmr-mx.google.com with ESMTPS id el2si4563373pbb.0.2015.10.27.18.30.05
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 27 Oct 2015 18:30:05 -0700 (PDT)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NWW006HJPI1B900@mailout4.w1.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 28 Oct 2015 01:30:01 +0000 (GMT)
Subject: [rtc-linux] Re: [PATCH v3 5/5] drivers/rtc/rtc-s5m.c: add support for
 S2MPS15 RTC
To: Alim Akhtar <alim.akhtar@samsung.com>, lee.jones@linaro.org,
 broonie@kernel.org
References: <1445863883-5187-1-git-send-email-alim.akhtar@samsung.com>
 <1445863883-5187-6-git-send-email-alim.akhtar@samsung.com>
Cc: mturquette@baylibre.com, linux-samsung-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, rtc-linux@googlegroups.com,
 linux-kernel@vger.kernel.org
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56302514.4090407@samsung.com>
Date: Wed, 28 Oct 2015 10:29:56 +0900
MIME-version: 1.0
In-reply-to: <1445863883-5187-6-git-send-email-alim.akhtar@samsung.com>
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
> RTC found in s2mps15 is almost same as one found in s2mps14.
> This patch add required changes to enable s2mps15 rtc timer.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  drivers/rtc/rtc-s5m.c |   14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

NACK.

I don't have S2MPS15 datasheet but looking at the code right now this
looks *exactly the same* device as S2MPS14.

If that's true, then don't add new compatibles, new names etc. Re-use.
No new code needed, no changes needed. Keep it simple.

Best regards,
Krzysztof

> 
> diff --git a/drivers/rtc/rtc-s5m.c b/drivers/rtc/rtc-s5m.c
> index f2504b4eef34..ac3286a267ba 100644
> --- a/drivers/rtc/rtc-s5m.c
> +++ b/drivers/rtc/rtc-s5m.c
> @@ -188,6 +188,7 @@ static inline int s5m_check_peding_alarm_interrupt(struct s5m_rtc_info *info,
>  		ret = regmap_read(info->regmap, S5M_RTC_STATUS, &val);
>  		val &= S5M_ALARM0_STATUS;
>  		break;
> +	case S2MPS15X:
>  	case S2MPS14X:
>  	case S2MPS13X:
>  		ret = regmap_read(info->s5m87xx->regmap_pmic, S2MPS14_REG_ST2,
> @@ -253,6 +254,7 @@ static inline int s5m8767_rtc_set_alarm_reg(struct s5m_rtc_info *info)
>  		data &= ~S5M_RTC_TIME_EN_MASK;
>  		break;
>  	case S2MPS14X:
> +	case S2MPS15X:
>  		data |= S2MPS_RTC_RUDR_MASK;
>  		break;
>  	case S2MPS13X:
> @@ -317,7 +319,8 @@ static int s5m_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  	u8 data[info->regs->regs_count];
>  	int ret;
>  
> -	if (info->device_type == S2MPS14X || info->device_type == S2MPS13X) {
> +	if (info->device_type == S2MPS14X || info->device_type == S2MPS15X ||
> +						info->device_type == S2MPS13X) {
>  		ret = regmap_update_bits(info->regmap,
>  				info->regs->rtc_udr_update,
>  				S2MPS_RTC_RUDR_MASK, S2MPS_RTC_RUDR_MASK);
> @@ -339,6 +342,7 @@ static int s5m_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  		break;
>  
>  	case S5M8767X:
> +	case S2MPS15X:
>  	case S2MPS14X:
>  	case S2MPS13X:
>  		s5m8767_data_to_tm(data, tm, info->rtc_24hr_mode);
> @@ -366,6 +370,7 @@ static int s5m_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  		s5m8763_tm_to_data(tm, data);
>  		break;
>  	case S5M8767X:
> +	case S2MPS15X:
>  	case S2MPS14X:
>  	case S2MPS13X:
>  		ret = s5m8767_tm_to_data(tm, data);
> @@ -414,6 +419,7 @@ static int s5m_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>  		break;
>  
>  	case S5M8767X:
> +	case S2MPS15X:
>  	case S2MPS14X:
>  	case S2MPS13X:
>  		s5m8767_data_to_tm(data, &alrm->time, info->rtc_24hr_mode);
> @@ -463,6 +469,7 @@ static int s5m_rtc_stop_alarm(struct s5m_rtc_info *info)
>  		break;
>  
>  	case S5M8767X:
> +	case S2MPS15X:
>  	case S2MPS14X:
>  	case S2MPS13X:
>  		for (i = 0; i < info->regs->regs_count; i++)
> @@ -508,6 +515,7 @@ static int s5m_rtc_start_alarm(struct s5m_rtc_info *info)
>  		break;
>  
>  	case S5M8767X:
> +	case S2MPS15X:
>  	case S2MPS14X:
>  	case S2MPS13X:
>  		data[RTC_SEC] |= ALARM_ENABLE_MASK;
> @@ -548,6 +556,7 @@ static int s5m_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>  		break;
>  
>  	case S5M8767X:
> +	case S2MPS15X:
>  	case S2MPS14X:
>  	case S2MPS13X:
>  		s5m8767_tm_to_data(&alrm->time, data);
> @@ -631,6 +640,7 @@ static int s5m8767_rtc_init_reg(struct s5m_rtc_info *info)
>  		ret = regmap_raw_write(info->regmap, S5M_ALARM0_CONF, data, 2);
>  		break;
>  
> +	case S2MPS15X:
>  	case S2MPS14X:
>  	case S2MPS13X:
>  		data[0] = (0 << BCD_EN_SHIFT) | (1 << MODEL24_SHIFT);
> @@ -679,6 +689,7 @@ static int s5m_rtc_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	switch (platform_get_device_id(pdev)->driver_data) {
> +	case S2MPS15X:
>  	case S2MPS14X:
>  	case S2MPS13X:
>  		regmap_cfg = &s2mps14_rtc_regmap_config;
> @@ -805,6 +816,7 @@ static const struct platform_device_id s5m_rtc_id[] = {
>  	{ "s5m-rtc",		S5M8767X },
>  	{ "s2mps13-rtc",	S2MPS13X },
>  	{ "s2mps14-rtc",	S2MPS14X },
> +	{ "s2mps15-rtc",	S2MPS15X },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(platform, s5m_rtc_id);
> 

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
