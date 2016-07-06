Return-Path: <rtc-linux+bncBDL7D5HRQMJRB3MP6O5QKGQEG4RNDTY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from regular1.263xmail.com (regular1.263xmail.com. [211.150.99.141])
        by gmr-mx.google.com with ESMTPS id c11si352719pfc.2.2016.07.06.01.57.16
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 06 Jul 2016 01:57:17 -0700 (PDT)
Subject: [rtc-linux] Re: [RESEND PATCH v5 1/5] mfd: RK808: Add RK818 support
To: Wadim Egorov <w.egorov@phytec.de>, Lee Jones <lee.jones@linaro.org>
References: <1464850228-17244-1-git-send-email-w.egorov@phytec.de>
 <20160608141735.GE14888@dell> <5759277D.7090101@phytec.de>
 <577C77DF.9060706@rock-chips.com> <577CBB62.8080806@phytec.de>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, a.zummo@towertech.it,
 pawel.moll@arm.com, rtc-linux@googlegroups.com,
 ijc+devicetree@hellion.org.uk, mturquette@baylibre.com,
 sboyd@codeaurora.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
 linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
 alexandre.belloni@free-electrons.com, broonie@kernel.org,
 dianders@chromium.org, galak@codeaurora.org, zyw@rock-chips.com,
 linux-clk@vger.kernel.org
From: Andy Yan <andy.yan@rock-chips.com>
Message-ID: <577CC7D0.2040402@rock-chips.com>
Date: Wed, 6 Jul 2016 16:56:48 +0800
MIME-Version: 1.0
In-Reply-To: <577CBB62.8080806@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Wadim:

On 2016=E5=B9=B407=E6=9C=8806=E6=97=A5 16:03, Wadim Egorov wrote:
> Hi Andy,
>
> On 06.07.2016 05:15, Andy Yan wrote:
>> Hi Wadim:
>>
>> On 2016=E5=B9=B406=E6=9C=8809=E6=97=A5 16:23, Wadim Egorov wrote:
>>> Hi,
>>>
>>> On 08.06.2016 16:17, Lee Jones wrote:
>>>> On Thu, 02 Jun 2016, Wadim Egorov wrote:
>>>>
>>>>> The RK818 chip is a power management IC for multimedia and handheld
>>>> "Power Management IC (PMIC)"
>>>>
>>>>> devices. It contains the following components:
>>>>>
>>>>> - Regulators
>>>>> - RTC
>>>>> - Clkout
>>>> Clocking
>>>>
>>>>> - battery support
>>>> Battery support
>>>>
>>>>> Both chips RK808 and RK818 are using a similar register map.
>>>> "Both RK808 ad RK818 chips"
>>>>
>>>>> So we can reuse the RTC and Clkout functionality.
>>>> Swap '.' for ','.
>>>>
>>>>> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
>>>>> ---
>>>>>    drivers/mfd/Kconfig       |   4 +-
>>>>>    drivers/mfd/rk808.c       | 231
>>>>> ++++++++++++++++++++++++++++++++++++++--------
>>>>>    include/linux/mfd/rk808.h | 162 ++++++++++++++++++++++++++++++--
>>>>>    3 files changed, 350 insertions(+), 47 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>>>>> index 1bcf601..7ba464b 100644
>>>>> --- a/drivers/mfd/Kconfig
>>>>> +++ b/drivers/mfd/Kconfig
>>>>> @@ -839,13 +839,13 @@ config MFD_RC5T583
>>>>>          different functionality of the device.
>>>>>      config MFD_RK808
>>>>> -    tristate "Rockchip RK808 Power Management chip"
>>>>> +    tristate "Rockchip RK808/RK818 Power Management chip"
>>>> "Chip"
>>>>
>>>>>        depends on I2C && OF
>>>>>        select MFD_CORE
>>>>>        select REGMAP_I2C
>>>>>        select REGMAP_IRQ
>>>>>        help
>>>>> -      If you say yes here you get support for the RK808
>>>>> +      If you say yes here you get support for the RK808 and RK818
>>>>>          Power Management chips.
>>>>>          This driver provides common support for accessing the device
>>>>>          through I2C interface. The device supports multiple
>>>>> sub-devices
>>>>> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
>>>>> index 49d7f62..3cf9724 100644
>>>>> --- a/drivers/mfd/rk808.c
>>>>> +++ b/drivers/mfd/rk808.c
>>>>> @@ -1,11 +1,15 @@
>>>>>    /*
>>>>> - * MFD core driver for Rockchip RK808
>>>>> + * MFD core driver for Rockchip RK808/RK818
>>>>>     *
>>>>>     * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
>>>>>     *
>>>>>     * Author: Chris Zhong <zyw@rock-chips.com>
>>>>>     * Author: Zhang Qing <zhangqing@rock-chips.com>
>>>>>     *
>>>>> + * Copyright (C) 2016 PHYTEC Messtechnik GmbH
>>>>> + *
>>>>> + * Author: Wadim Egorov <w.egorov@phytec.de>
>>>>> + *
>>>>>     * This program is free software; you can redistribute it and/or
>>>>> modify it
>>>>>     * under the terms and conditions of the GNU General Public Licens=
e,
>>>>>     * version 2, as published by the Free Software Foundation.
>>>>> @@ -22,12 +26,7 @@
>>>>>    #include <linux/mfd/core.h>
>>>>>    #include <linux/module.h>
>>>>>    #include <linux/regmap.h>
>>>>> -
>>>>> -struct rk808_reg_data {
>>>>> -    int addr;
>>>>> -    int mask;
>>>>> -    int value;
>>>>> -};
>>>> Why are you moving this to the header?
>>> It is now part of the rk808 struct.
>>>
>>>>> +#include <linux/of_device.h>
>>>>>      static bool rk808_is_volatile_reg(struct device *dev, unsigned
>>>>> int reg)
>>>>>    {
>>>>> @@ -57,6 +56,14 @@ static bool rk808_is_volatile_reg(struct device
>>>>> *dev, unsigned int reg)
>>>>>        return false;
>>>>>    }
>>>>>    +static const struct regmap_config rk818_regmap_config =3D {
>>>>> +    .reg_bits =3D 8,
>>>>> +    .val_bits =3D 8,
>>>>> +    .max_register =3D RK818_USB_CTRL_REG,
>>>>> +    .cache_type =3D REGCACHE_RBTREE,
>>>>> +    .volatile_reg =3D rk808_is_volatile_reg,
>>>>> +};
>>>>> +
>>>>>    static const struct regmap_config rk808_regmap_config =3D {
>>>>>        .reg_bits =3D 8,
>>>>>        .val_bits =3D 8,
>>>>> @@ -83,7 +90,17 @@ static const struct mfd_cell rk808s[] =3D {
>>>>>        },
>>>>>    };
>>>>>    -static const struct rk808_reg_data pre_init_reg[] =3D {
>>>>> +static const struct mfd_cell rk818s[] =3D {
>>>>> +    { .name =3D "rk808-clkout", },
>>>> How does this differ to a normal -clock driver?
>>> I don't know. It is a normal clock driver.
>>>
>>>>> +    { .name =3D "rk808-regulator", },
>>>>> +    {
>>>>> +        .name =3D "rk808-rtc",
>>>>> +        .num_resources =3D ARRAY_SIZE(rtc_resources),
>>>>> +        .resources =3D &rtc_resources[0],
>>>> .resources =3D rtc_resources,  ?
>>>>
>>>>> +    },
>>>>> +};
>>>>> +
>>>>> +static const struct rk8xx_reg_data rk808_pre_init_reg[] =3D {
>>>>>        { RK808_BUCK3_CONFIG_REG, BUCK_ILMIN_MASK,  BUCK_ILMIN_150MA }=
,
>>>>>        { RK808_BUCK4_CONFIG_REG, BUCK_ILMIN_MASK,  BUCK_ILMIN_200MA }=
,
>>>>>        { RK808_BOOST_CONFIG_REG, BOOST_ILMIN_MASK, BOOST_ILMIN_100MA =
},
>>>>> @@ -94,6 +111,22 @@ static const struct rk808_reg_data
>>>>> pre_init_reg[] =3D {
>>>>>                                VB_LO_SEL_3500MV },
>>>>>    };
>>>>>    +static const struct rk8xx_reg_data rk818_pre_init_reg[] =3D {
>>>>> +    { RK818_USB_CTRL_REG,    RK818_USB_ILIM_SEL_MASK,
>>>>> +                        RK818_USB_ILMIN_2000MA },
>>>>> +    /* close charger when usb lower then 3.4V */
>>>>> +    { RK818_USB_CTRL_REG,    RK818_USB_CHG_SD_VSEL_MASK, (0x7 <<
>>>>> 4) },
>>>>> +    /* no action when vref */
>>>>> +    { RK818_H5V_EN_REG,    BIT(1),        RK818_REF_RDY_CTRL },
>>>>> +    /* enable HDMI 5V */
>>>>> +    { RK818_H5V_EN_REG,    BIT(0),        RK818_H5V_EN },
>>>>> +    /* improve efficiency */
>>>>> +    { RK818_BUCK2_CONFIG_REG, BUCK2_RATE_MASK,    BUCK_ILMIN_250MA }=
,
>>>>> +    { RK818_BUCK4_CONFIG_REG, BUCK_ILMIN_MASK,    BUCK_ILMIN_250MA }=
,
>>>>> +    { RK818_BOOST_CONFIG_REG, BOOST_ILMIN_MASK,
>>>>> BOOST_ILMIN_100MA },
>>>>> +    { RK808_VB_MON_REG,    MASK_ALL,    VB_LO_ACT |
>>>>> VB_LO_SEL_3500MV },
>>>>> +};
>>>> The alignment here looks odd.
>>> I will fix it in the next version.
>>>
>>>>>    static const struct regmap_irq rk808_irqs[] =3D {
>>>>>        /* INT_STS */
>>>>>        [RK808_IRQ_VOUT_LO] =3D {
>>>>> @@ -136,6 +169,76 @@ static const struct regmap_irq rk808_irqs[] =3D =
{
>>>>>        },
>>>>>    };
>>>>>    +static const struct regmap_irq rk818_irqs[] =3D {
>>>>> +    /* INT_STS */
>>>>> +    [RK818_IRQ_VOUT_LO] =3D {
>>>>> +        .mask =3D RK818_IRQ_VOUT_LO_MSK,
>>>>> +        .reg_offset =3D 0,
>>>>> +    },
>>>>> +    [RK818_IRQ_VB_LO] =3D {
>>>>> +        .mask =3D RK818_IRQ_VB_LO_MSK,
>>>>> +        .reg_offset =3D 0,
>>>>> +    },
>>>>> +    [RK818_IRQ_PWRON] =3D {
>>>>> +        .mask =3D RK818_IRQ_PWRON_MSK,
>>>>> +        .reg_offset =3D 0,
>>>>> +    },
>>>>> +    [RK818_IRQ_PWRON_LP] =3D {
>>>>> +        .mask =3D RK818_IRQ_PWRON_LP_MSK,
>>>>> +        .reg_offset =3D 0,
>>>>> +    },
>>>>> +    [RK818_IRQ_HOTDIE] =3D {
>>>>> +        .mask =3D RK818_IRQ_HOTDIE_MSK,
>>>>> +        .reg_offset =3D 0,
>>>>> +    },
>>>>> +    [RK818_IRQ_RTC_ALARM] =3D {
>>>>> +        .mask =3D RK818_IRQ_RTC_ALARM_MSK,
>>>>> +        .reg_offset =3D 0,
>>>>> +    },
>>>>> +    [RK818_IRQ_RTC_PERIOD] =3D {
>>>>> +        .mask =3D RK818_IRQ_RTC_PERIOD_MSK,
>>>>> +        .reg_offset =3D 0,
>>>>> +    },
>>>>> +    [RK818_IRQ_USB_OV] =3D {
>>>>> +        .mask =3D RK818_IRQ_USB_OV_MSK,
>>>>> +        .reg_offset =3D 0,
>>>>> +    },
>>>>> +
>>>>> +    /* INT_STS2 */
>>>>> +    [RK818_IRQ_PLUG_IN] =3D {
>>>>> +        .mask =3D RK818_IRQ_PLUG_IN_MSK,
>>>>> +        .reg_offset =3D 1,
>>>>> +    },
>>>>> +    [RK818_IRQ_PLUG_OUT] =3D {
>>>>> +        .mask =3D RK818_IRQ_PLUG_OUT_MSK,
>>>>> +        .reg_offset =3D 1,
>>>>> +    },
>>>>> +    [RK818_IRQ_CHG_OK] =3D {
>>>>> +        .mask =3D RK818_IRQ_CHG_OK_MSK,
>>>>> +        .reg_offset =3D 1,
>>>>> +    },
>>>>> +    [RK818_IRQ_CHG_TE] =3D {
>>>>> +        .mask =3D RK818_IRQ_CHG_TE_MSK,
>>>>> +        .reg_offset =3D 1,
>>>>> +    },
>>>>> +    [RK818_IRQ_CHG_TS1] =3D {
>>>>> +        .mask =3D RK818_IRQ_CHG_TS1_MSK,
>>>>> +        .reg_offset =3D 1,
>>>>> +    },
>>>>> +    [RK818_IRQ_TS2] =3D {
>>>>> +        .mask =3D RK818_IRQ_TS2_MSK,
>>>>> +        .reg_offset =3D 1,
>>>>> +    },
>>>>> +    [RK818_IRQ_CHG_CVTLIM] =3D {
>>>>> +        .mask =3D RK818_IRQ_CHG_CVTLIM_MSK,
>>>>> +        .reg_offset =3D 1,
>>>>> +    },
>>>>> +    [RK818_IRQ_DISCHG_ILIM] =3D {
>>>>> +        .mask =3D RK818_IRQ_DISCHG_ILIM_MSK,
>>>>> +        .reg_offset =3D 1,
>>>>> +    },
>>>>> +};
>>>>> +
>>>>>    static struct regmap_irq_chip rk808_irq_chip =3D {
>>>>>        .name =3D "rk808",
>>>>>        .irqs =3D rk808_irqs,
>>>>> @@ -148,6 +251,18 @@ static struct regmap_irq_chip rk808_irq_chip =3D=
 {
>>>>>        .init_ack_masked =3D true,
>>>>>    };
>>>>>    +static struct regmap_irq_chip rk818_irq_chip =3D {
>>>>> +    .name =3D "rk818",
>>>>> +    .irqs =3D rk818_irqs,
>>>>> +    .num_irqs =3D ARRAY_SIZE(rk818_irqs),
>>>>> +    .num_regs =3D 2,
>>>>> +    .irq_reg_stride =3D 2,
>>>>> +    .status_base =3D RK818_INT_STS_REG1,
>>>>> +    .mask_base =3D RK818_INT_STS_MSK_REG1,
>>>>> +    .ack_base =3D RK818_INT_STS_REG1,
>>>>> +    .init_ack_masked =3D true,
>>>>> +};
>>>>> +
>>>>>    static struct i2c_client *rk808_i2c_client;
>>>>>    static void rk808_device_shutdown(void)
>>>>>    {
>>>>> @@ -167,6 +282,48 @@ static void rk808_device_shutdown(void)
>>>>>            dev_err(&rk808_i2c_client->dev, "power off error!\n");
>>>>>    }
>>>>>    +static const struct of_device_id rk808_of_match[] =3D {
>>>>> +    { .compatible =3D "rockchip,rk808", .data =3D (void *) RK808_ID =
},
>>>>> +    { .compatible =3D "rockchip,rk818", .data =3D (void *) RK818_ID =
},
>>>>> +    { },
>>>>> +};
>>>>> +MODULE_DEVICE_TABLE(of, rk808_of_match);
>>>>> +
>>>>> +static int rk8xx_match_device(struct rk808 *rk808, struct device
>>>>> *dev)
>>>> If you're going to do it this way, please switch these parameters.
>>>>
>>>> It's more common to return the pointer however.
>>> If it's more common I will return a pointer to rk808.
>>>
>>>>> +{
>>>>> +    const struct of_device_id *of_id;
>>>>> +
>>>>> +    of_id =3D of_match_device(rk808_of_match, dev);
>>>>> +    if (!of_id) {
>>>>> +        dev_err(dev, "Unable to match OF ID\n");
>>>>> +        return -ENODEV;
>>>>> +    }
>>>>> +    rk808->variant =3D (long) of_id->data;
>>>>> +
>>>>> +    switch (rk808->variant) {
>>>>> +    case RK808_ID:
>>>>> +        rk808->nr_cells =3D ARRAY_SIZE(rk808s);
>>>>> +        rk808->cells =3D rk808s;
>>>>> +        rk808->regmap_cfg =3D &rk808_regmap_config;
>>>>> +        rk808->regmap_irq_chip =3D &rk808_irq_chip;
>>>>> +        rk808->pre_init_reg =3D rk808_pre_init_reg;
>>>>> +        rk808->nr_pre_init_regs =3D ARRAY_SIZE(rk808_pre_init_reg);
>>>>> +        break;
>>>>> +    case RK818_ID:
>>>>> +        rk808->nr_cells =3D ARRAY_SIZE(rk818s);
>>>>> +        rk808->cells =3D rk818s;
>>>>> +        rk808->regmap_cfg =3D &rk818_regmap_config;
>>>>> +        rk808->regmap_irq_chip =3D &rk818_irq_chip;
>>>>> +        rk808->pre_init_reg =3D rk818_pre_init_reg;
>>>>> +        rk808->nr_pre_init_regs =3D ARRAY_SIZE(rk818_pre_init_reg);
>>>>> +        break;
>>>>> +    default:
>>>>> +        dev_err(dev, "unsupported RK8XX ID %lu\n", rk808->variant);
>>>>> +        return -EINVAL;
>>>>> +    }
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>>    static int rk808_probe(struct i2c_client *client,
>>>>>                   const struct i2c_device_id *id)
>>>>>    {
>>>>> @@ -176,46 +333,52 @@ static int rk808_probe(struct i2c_client
>>>>> *client,
>>>>>        int ret;
>>>>>        int i;
>>>>>    -    if (!client->irq) {
>>>>> -        dev_err(&client->dev, "No interrupt support, no core IRQ\n")=
;
>>>>> -        return -EINVAL;
>>>>> -    }
>>>>> -
>>>>>        rk808 =3D devm_kzalloc(&client->dev, sizeof(*rk808), GFP_KERNE=
L);
>>>>>        if (!rk808)
>>>>>            return -ENOMEM;
>>>>>    -    rk808->regmap =3D devm_regmap_init_i2c(client,
>>>>> &rk808_regmap_config);
>>>>> +    ret =3D rk8xx_match_device(rk808, &client->dev);
>>>> Is there a way to dynamically probe the device?  No device ID you can
>>>> read directly from the silicon?
>>> AFAIK there is no device ID register. At least it is not documented in
>>> the manual.
>> register 0x17 and 0x18 is the ID register, 0x17 is the MSB, 0x18 is LSB
>>
>> for RK818, register 0x17 is 0x81, 0x18 is 0x81
> thank you for sharing this information. I have no RK808 PMIC device
> here, so I would also need the IDs for RK808.

    I have checked with the RK808 IC designer, the values of register=20
0x17 and 0x18 are both 0x00.
>
> Lee, you have already applied this series. But I can't find the patches
> in your kernel tree.
> I would like to read the device ID from the register in the probe functio=
n.
> Do you want me to base my changes on top of this series or send a new
> version?
>
>
>


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
