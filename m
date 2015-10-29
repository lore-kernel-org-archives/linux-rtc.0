Return-Path: <rtc-linux+bncBD747RFBYUPBBR5SY6YQKGQE3YOMCII@googlegroups.com>
Received: from mailout2.samsung.com (mailout2.samsung.com. [203.254.224.25])
        by gmr-mx.google.com with ESMTPS id el2si75914pbb.0.2015.10.29.01.31.03
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 29 Oct 2015 01:31:03 -0700 (PDT)
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NWZ031PS3NPRKC0@mailout2.samsung.com> for
 rtc-linux@googlegroups.com; Thu, 29 Oct 2015 17:31:01 +0900 (KST)
Message-id: <5631D995.2070807@samsung.com>
Date: Thu, 29 Oct 2015 14:02:21 +0530
From: Alim Akhtar <alim.akhtar@samsung.com>
MIME-version: 1.0
To: Lee Jones <lee.jones@linaro.org>
Cc: broonie@kernel.org, k.kozlowski@samsung.com,
 linux-samsung-soc@vger.kernel.org, rtc-linux@googlegroups.com,
 linux-kernel@vger.kernel.org, Thomas Abraham <thomas.ab@samsung.com>
Subject: [rtc-linux] Re: [PATCH v4 2/4] mfd: sec: Add support for S2MPS15 PMIC
References: <1446094723-6212-1-git-send-email-alim.akhtar@samsung.com>
 <1446094723-6212-3-git-send-email-alim.akhtar@samsung.com>
 <20151029080657.GL4058@x1>
In-reply-to: <20151029080657.GL4058@x1>
Content-type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi

On 10/29/2015 01:36 PM, Lee Jones wrote:
> On Thu, 29 Oct 2015, Alim Akhtar wrote:
>
>> From: Thomas Abraham <thomas.ab@samsung.com>
>>
>> Add support for S2MPS15 PMIC which is similar to S2MPS11 PMIC. The S2MPS15
>> PMIC supports 27 LDO regulators, 10 buck regulators, RTC, three 32.768KHz
>> clock outputs and battery charger. This patch adds initial support for
>> LDO and buck regulators of S2MPS15 device.
>>
>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>> [Alim: Added s2mps15_devs like rtc and clk and related changes]
>> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> ---
>>   drivers/mfd/sec-core.c              |   31 +++++++
>>   drivers/mfd/sec-irq.c               |    8 ++
>>   include/linux/mfd/samsung/core.h    |    1 +
>>   include/linux/mfd/samsung/s2mps15.h |  158 +++++++++++++++++++++++++++++++++++
>>   4 files changed, 198 insertions(+)
>>   create mode 100644 include/linux/mfd/samsung/s2mps15.h
>
> Looks good now.
>
> Acked-by: Lee Jones <lee.jones@linaro.org>
>
Thanks!!

>> diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
>> index 2626fc0b5b8c..fbb8a5715597 100644
>> --- a/drivers/mfd/sec-core.c
>> +++ b/drivers/mfd/sec-core.c
>> @@ -29,6 +29,7 @@
>>   #include <linux/mfd/samsung/s2mps11.h>
>>   #include <linux/mfd/samsung/s2mps13.h>
>>   #include <linux/mfd/samsung/s2mps14.h>
>> +#include <linux/mfd/samsung/s2mps15.h>
>>   #include <linux/mfd/samsung/s2mpu02.h>
>>   #include <linux/mfd/samsung/s5m8763.h>
>>   #include <linux/mfd/samsung/s5m8767.h>
>> @@ -96,6 +97,17 @@ static const struct mfd_cell s2mps14_devs[] = {
>>   	}
>>   };
>>
>> +static const struct mfd_cell s2mps15_devs[] = {
>> +	{
>> +		.name = "s2mps15-regulator",
>> +	}, {
>> +		.name = "s2mps15-rtc",
>> +	}, {
>> +		.name = "s2mps13-clk",
>> +		.of_compatible = "samsung,s2mps13-clk",
>> +	},
>> +};
>> +
>>   static const struct mfd_cell s2mpa01_devs[] = {
>>   	{
>>   		.name = "s2mpa01-pmic",
>> @@ -125,6 +137,9 @@ static const struct of_device_id sec_dt_match[] = {
>>   		.compatible = "samsung,s2mps14-pmic",
>>   		.data = (void *)S2MPS14X,
>>   	}, {
>> +		.compatible = "samsung,s2mps15-pmic",
>> +		.data = (void *)S2MPS15X,
>> +	}, {
>>   		.compatible = "samsung,s2mpa01-pmic",
>>   		.data = (void *)S2MPA01,
>>   	}, {
>> @@ -226,6 +241,15 @@ static const struct regmap_config s2mps14_regmap_config = {
>>   	.cache_type = REGCACHE_FLAT,
>>   };
>>
>> +static const struct regmap_config s2mps15_regmap_config = {
>> +	.reg_bits = 8,
>> +	.val_bits = 8,
>> +
>> +	.max_register = S2MPS15_REG_LDODSCH4,
>> +	.volatile_reg = s2mps11_volatile,
>> +	.cache_type = REGCACHE_FLAT,
>> +};
>> +
>>   static const struct regmap_config s2mpu02_regmap_config = {
>>   	.reg_bits = 8,
>>   	.val_bits = 8,
>> @@ -387,6 +411,9 @@ static int sec_pmic_probe(struct i2c_client *i2c,
>>   	case S2MPS14X:
>>   		regmap = &s2mps14_regmap_config;
>>   		break;
>> +	case S2MPS15X:
>> +		regmap = &s2mps15_regmap_config;
>> +		break;
>>   	case S5M8763X:
>>   		regmap = &s5m8763_regmap_config;
>>   		break;
>> @@ -445,6 +472,10 @@ static int sec_pmic_probe(struct i2c_client *i2c,
>>   		sec_devs = s2mps14_devs;
>>   		num_sec_devs = ARRAY_SIZE(s2mps14_devs);
>>   		break;
>> +	case S2MPS15X:
>> +		sec_devs = s2mps15_devs;
>> +		num_sec_devs = ARRAY_SIZE(s2mps15_devs);
>> +		break;
>>   	case S2MPU02:
>>   		sec_devs = s2mpu02_devs;
>>   		num_sec_devs = ARRAY_SIZE(s2mpu02_devs);
>> diff --git a/drivers/mfd/sec-irq.c b/drivers/mfd/sec-irq.c
>> index 806fa8dbb22d..d77de431cc50 100644
>> --- a/drivers/mfd/sec-irq.c
>> +++ b/drivers/mfd/sec-irq.c
>> @@ -407,6 +407,11 @@ static const struct regmap_irq_chip s2mps14_irq_chip = {
>>   	S2MPS1X_IRQ_CHIP_COMMON_DATA,
>>   };
>>
>> +static const struct regmap_irq_chip s2mps15_irq_chip = {
>> +	.name = "s2mps15",
>> +	S2MPS1X_IRQ_CHIP_COMMON_DATA,
>> +};
>> +
>>   static const struct regmap_irq_chip s2mpu02_irq_chip = {
>>   	.name = "s2mpu02",
>>   	.irqs = s2mpu02_irqs,
>> @@ -466,6 +471,9 @@ int sec_irq_init(struct sec_pmic_dev *sec_pmic)
>>   	case S2MPS14X:
>>   		sec_irq_chip = &s2mps14_irq_chip;
>>   		break;
>> +	case S2MPS15X:
>> +		sec_irq_chip = &s2mps15_irq_chip;
>> +		break;
>>   	case S2MPU02:
>>   		sec_irq_chip = &s2mpu02_irq_chip;
>>   		break;
>> diff --git a/include/linux/mfd/samsung/core.h b/include/linux/mfd/samsung/core.h
>> index a06098639399..6bc4bcd488ac 100644
>> --- a/include/linux/mfd/samsung/core.h
>> +++ b/include/linux/mfd/samsung/core.h
>> @@ -44,6 +44,7 @@ enum sec_device_type {
>>   	S2MPS11X,
>>   	S2MPS13X,
>>   	S2MPS14X,
>> +	S2MPS15X,
>>   	S2MPU02,
>>   };
>>
>> diff --git a/include/linux/mfd/samsung/s2mps15.h b/include/linux/mfd/samsung/s2mps15.h
>> new file mode 100644
>> index 000000000000..36d35287c3c0
>> --- /dev/null
>> +++ b/include/linux/mfd/samsung/s2mps15.h
>> @@ -0,0 +1,158 @@
>> +/*
>> + * Copyright (c) 2015 Samsung Electronics Co., Ltd
>> + *              http://www.samsung.com
>> + *
>> + * This program is free software; you can redistribute  it and/or modify it
>> + * under  the terms of  the GNU General  Public License as published by the
>> + * Free Software Foundation;  either version 2 of the  License, or (at your
>> + * option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#ifndef __LINUX_MFD_S2MPS15_H
>> +#define __LINUX_MFD_S2MPS15_H
>> +
>> +/* S2MPS15 registers */
>> +enum s2mps15_reg {
>> +	S2MPS15_REG_ID,
>> +	S2MPS15_REG_INT1,
>> +	S2MPS15_REG_INT2,
>> +	S2MPS15_REG_INT3,
>> +	S2MPS15_REG_INT1M,
>> +	S2MPS15_REG_INT2M,
>> +	S2MPS15_REG_INT3M,
>> +	S2MPS15_REG_ST1,
>> +	S2MPS15_REG_ST2,
>> +	S2MPS15_REG_PWRONSRC,
>> +	S2MPS15_REG_OFFSRC,
>> +	S2MPS15_REG_BU_CHG,
>> +	S2MPS15_REG_RTC_BUF,
>> +	S2MPS15_REG_CTRL1,
>> +	S2MPS15_REG_CTRL2,
>> +	S2MPS15_REG_RSVD1,
>> +	S2MPS15_REG_RSVD2,
>> +	S2MPS15_REG_RSVD3,
>> +	S2MPS15_REG_RSVD4,
>> +	S2MPS15_REG_RSVD5,
>> +	S2MPS15_REG_RSVD6,
>> +	S2MPS15_REG_CTRL3,
>> +	S2MPS15_REG_RSVD7,
>> +	S2MPS15_REG_RSVD8,
>> +	S2MPS15_REG_RSVD9,
>> +	S2MPS15_REG_B1CTRL1,
>> +	S2MPS15_REG_B1CTRL2,
>> +	S2MPS15_REG_B2CTRL1,
>> +	S2MPS15_REG_B2CTRL2,
>> +	S2MPS15_REG_B3CTRL1,
>> +	S2MPS15_REG_B3CTRL2,
>> +	S2MPS15_REG_B4CTRL1,
>> +	S2MPS15_REG_B4CTRL2,
>> +	S2MPS15_REG_B5CTRL1,
>> +	S2MPS15_REG_B5CTRL2,
>> +	S2MPS15_REG_B6CTRL1,
>> +	S2MPS15_REG_B6CTRL2,
>> +	S2MPS15_REG_B7CTRL1,
>> +	S2MPS15_REG_B7CTRL2,
>> +	S2MPS15_REG_B8CTRL1,
>> +	S2MPS15_REG_B8CTRL2,
>> +	S2MPS15_REG_B9CTRL1,
>> +	S2MPS15_REG_B9CTRL2,
>> +	S2MPS15_REG_B10CTRL1,
>> +	S2MPS15_REG_B10CTRL2,
>> +	S2MPS15_REG_BBCTRL1,
>> +	S2MPS15_REG_BBCTRL2,
>> +	S2MPS15_REG_BRAMP,
>> +	S2MPS15_REG_LDODVS1,
>> +	S2MPS15_REG_LDODVS2,
>> +	S2MPS15_REG_LDODVS3,
>> +	S2MPS15_REG_LDODVS4,
>> +	S2MPS15_REG_L1CTRL,
>> +	S2MPS15_REG_L2CTRL,
>> +	S2MPS15_REG_L3CTRL,
>> +	S2MPS15_REG_L4CTRL,
>> +	S2MPS15_REG_L5CTRL,
>> +	S2MPS15_REG_L6CTRL,
>> +	S2MPS15_REG_L7CTRL,
>> +	S2MPS15_REG_L8CTRL,
>> +	S2MPS15_REG_L9CTRL,
>> +	S2MPS15_REG_L10CTRL,
>> +	S2MPS15_REG_L11CTRL,
>> +	S2MPS15_REG_L12CTRL,
>> +	S2MPS15_REG_L13CTRL,
>> +	S2MPS15_REG_L14CTRL,
>> +	S2MPS15_REG_L15CTRL,
>> +	S2MPS15_REG_L16CTRL,
>> +	S2MPS15_REG_L17CTRL,
>> +	S2MPS15_REG_L18CTRL,
>> +	S2MPS15_REG_L19CTRL,
>> +	S2MPS15_REG_L20CTRL,
>> +	S2MPS15_REG_L21CTRL,
>> +	S2MPS15_REG_L22CTRL,
>> +	S2MPS15_REG_L23CTRL,
>> +	S2MPS15_REG_L24CTRL,
>> +	S2MPS15_REG_L25CTRL,
>> +	S2MPS15_REG_L26CTRL,
>> +	S2MPS15_REG_L27CTRL,
>> +	S2MPS15_REG_LDODSCH1,
>> +	S2MPS15_REG_LDODSCH2,
>> +	S2MPS15_REG_LDODSCH3,
>> +	S2MPS15_REG_LDODSCH4,
>> +};
>> +
>> +/* S2MPS15 regulator ids */
>> +enum s2mps15_regulators {
>> +	S2MPS15_LDO1,
>> +	S2MPS15_LDO2,
>> +	S2MPS15_LDO3,
>> +	S2MPS15_LDO4,
>> +	S2MPS15_LDO5,
>> +	S2MPS15_LDO6,
>> +	S2MPS15_LDO7,
>> +	S2MPS15_LDO8,
>> +	S2MPS15_LDO9,
>> +	S2MPS15_LDO10,
>> +	S2MPS15_LDO11,
>> +	S2MPS15_LDO12,
>> +	S2MPS15_LDO13,
>> +	S2MPS15_LDO14,
>> +	S2MPS15_LDO15,
>> +	S2MPS15_LDO16,
>> +	S2MPS15_LDO17,
>> +	S2MPS15_LDO18,
>> +	S2MPS15_LDO19,
>> +	S2MPS15_LDO20,
>> +	S2MPS15_LDO21,
>> +	S2MPS15_LDO22,
>> +	S2MPS15_LDO23,
>> +	S2MPS15_LDO24,
>> +	S2MPS15_LDO25,
>> +	S2MPS15_LDO26,
>> +	S2MPS15_LDO27,
>> +	S2MPS15_BUCK1,
>> +	S2MPS15_BUCK2,
>> +	S2MPS15_BUCK3,
>> +	S2MPS15_BUCK4,
>> +	S2MPS15_BUCK5,
>> +	S2MPS15_BUCK6,
>> +	S2MPS15_BUCK7,
>> +	S2MPS15_BUCK8,
>> +	S2MPS15_BUCK9,
>> +	S2MPS15_BUCK10,
>> +	S2MPS15_BUCK11,
>> +	S2MPS15_REGULATOR_MAX,
>> +};
>> +
>> +#define S2MPS15_LDO_VSEL_MASK		(0x3F)
>> +#define S2MPS15_BUCK_VSEL_MASK		(0xFF)
>> +
>> +#define S2MPS15_ENABLE_SHIFT		(0x06)
>> +#define S2MPS15_ENABLE_MASK		(0x03 << S2MPS15_ENABLE_SHIFT)
>> +
>> +#define S2MPS15_LDO_N_VOLTAGES		(S2MPS15_LDO_VSEL_MASK + 1)
>> +#define S2MPS15_BUCK_N_VOLTAGES	(S2MPS15_BUCK_VSEL_MASK + 1)
>> +
>> +#endif /* __LINUX_MFD_S2MPS15_H */
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
