Return-Path: <rtc-linux+bncBAABBV6J3K6QKGQEYZGKU6Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from root.phytec.de (mail.phytec.de. [217.6.246.34])
        by gmr-mx.google.com with ESMTP id i193si139073wmg.1.2016.08.18.23.19.02
        for <rtc-linux@googlegroups.com>;
        Thu, 18 Aug 2016 23:19:02 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH v7 1/4] mfd: RK808: Add RK818 support
To: Lee Jones <lee.jones@linaro.org>
References: <1470819907-11237-1-git-send-email-w.egorov@phytec.de>
 <1470819907-11237-2-git-send-email-w.egorov@phytec.de>
 <20160818143440.GG4254@dell>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, dianders@chromium.org, zyw@rock-chips.com, robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com
From: Wadim Egorov <w.egorov@phytec.de>
Message-ID: <57B6A4D1.20108@phytec.de>
Date: Fri, 19 Aug 2016 08:18:57 +0200
MIME-Version: 1.0
In-Reply-To: <20160818143440.GG4254@dell>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>



On 18.08.2016 16:34, Lee Jones wrote:
> On Wed, 10 Aug 2016, Wadim Egorov wrote:
>
>> The RK818 chip is a Power Management IC (PMIC) for multimedia and handheld
>> devices. It contains the following components:
>>
>> - Regulators
>> - RTC
>> - Clocking
>> - Battery support
>>
>> Both RK808 and RK818 chips are using a similar register map,
>> so we can reuse the RTC and Clocking functionality.
>>
>> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
>> Tested-by: Andy Yan <andy.yan@rock-chips.com>
>> ---
>> Changes since v6:
>> - Squashed in the patch
>>   mfd: RK808: Fetch PMIC variant from chip id register
>>
>> ---
>>  drivers/mfd/Kconfig       |   4 +-
>>  drivers/mfd/rk808.c       | 226 +++++++++++++++++++++++++++++++++++++++-------
>>  include/linux/mfd/rk808.h | 154 +++++++++++++++++++++++++++++--
>>  3 files changed, 342 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index 2d1fb64..a55be95 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -852,13 +852,13 @@ config MFD_RC5T583
>>  	  different functionality of the device.
>>  
>>  config MFD_RK808
>> -	tristate "Rockchip RK808 Power Management chip"
>> +	tristate "Rockchip RK808/RK818 Power Management Chip"
>>  	depends on I2C && OF
>>  	select MFD_CORE
>>  	select REGMAP_I2C
>>  	select REGMAP_IRQ
>>  	help
>> -	  If you say yes here you get support for the RK808
>> +	  If you say yes here you get support for the RK808 and RK818
>>  	  Power Management chips.
>>  	  This driver provides common support for accessing the device
>>  	  through I2C interface. The device supports multiple sub-devices
>> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
>> index 49d7f62..fbec1d8 100644
>> --- a/drivers/mfd/rk808.c
>> +++ b/drivers/mfd/rk808.c
>> @@ -1,11 +1,15 @@
>>  /*
>> - * MFD core driver for Rockchip RK808
>> + * MFD core driver for Rockchip RK808/RK818
>>   *
>>   * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
>>   *
>>   * Author: Chris Zhong <zyw@rock-chips.com>
>>   * Author: Zhang Qing <zhangqing@rock-chips.com>
>>   *
>> + * Copyright (C) 2016 PHYTEC Messtechnik GmbH
>> + *
>> + * Author: Wadim Egorov <w.egorov@phytec.de>
>> + *
>>   * This program is free software; you can redistribute it and/or modify it
>>   * under the terms and conditions of the GNU General Public License,
>>   * version 2, as published by the Free Software Foundation.
>> @@ -22,6 +26,7 @@
>>  #include <linux/mfd/core.h>
>>  #include <linux/module.h>
>>  #include <linux/regmap.h>
>> +#include <linux/of_device.h>
> Alphabetical.

ok

>
>>  struct rk808_reg_data {
>>  	int addr;
>> @@ -57,6 +62,14 @@ static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
>>  	return false;
>>  }
>>  
>> +static const struct regmap_config rk818_regmap_config = {
>> +	.reg_bits = 8,
>> +	.val_bits = 8,
>> +	.max_register = RK818_USB_CTRL_REG,
>> +	.cache_type = REGCACHE_RBTREE,
>> +	.volatile_reg = rk808_is_volatile_reg,
>> +};
>> +
>>  static const struct regmap_config rk808_regmap_config = {
>>  	.reg_bits = 8,
>>  	.val_bits = 8,
>> @@ -79,11 +92,21 @@ static const struct mfd_cell rk808s[] = {
>>  	{
>>  		.name = "rk808-rtc",
>>  		.num_resources = ARRAY_SIZE(rtc_resources),
>> -		.resources = &rtc_resources[0],
>> +		.resources = rtc_resources,
> ?

you told me to change this

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
