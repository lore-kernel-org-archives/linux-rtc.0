Return-Path: <rtc-linux+bncBDZLBCXQRACBBRHTUXDAKGQEPIB26FI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Date: Wed, 15 Mar 2017 10:28:34 -0700 (PDT)
From: leonardo.romor@gmail.com
To: rtc-linux <rtc-linux@googlegroups.com>
Message-Id: <2f34f1f9-37f4-4a33-935d-dc7e43a40baf@googlegroups.com>
In-Reply-To: <20160921213541.5lhnhzw6qlgc2udy@piout.net>
References: <20160801155029.32232.56063.stgit@localhost>
 <20160801155034.32232.68458.stgit@localhost>
 <20160921213541.5lhnhzw6qlgc2udy@piout.net>
Subject: [rtc-linux] Re: [PATCH 2/3] rtc: pcf85263: Basic driver
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_4631_234418101.1489598915112"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

------=_Part_4631_234418101.1489598915112
Content-Type: multipart/alternative;
	boundary="----=_Part_4632_1763001965.1489598915114"

------=_Part_4632_1763001965.1489598915114
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,=20
I wanted to inform you that we are using this kernel driver on a beaglebone=
=20
black and we are not having any kind of issue. Thanks for your work


Il giorno mercoled=C3=AC 21 settembre 2016 23:35:42 UTC+2, alexandre.bellon=
i ha=20
scritto:
>
> Hi,=20
>
> Sorry for the very late review.=20
>
> The driver seems good to me but I'd like a review from the DT=20
> maintainers before taking it.=20
>
> On 01/08/2016 at 17:50:34 +0200, Martin Fuzzey wrote :=20
> > Add basic support for NXP PCF85263 I2C RTC chip.=20
> >=20
> > Only RTC and Alarm functions are supported.=20
> >=20
> > Signed-off-by: Martin Fuzzey <mfu...@parkeon.com <javascript:>>=20
> > ---=20
> >  drivers/rtc/Kconfig        |    8 +=20
> >  drivers/rtc/Makefile       |    1=20
> >  drivers/rtc/rtc-pcf85263.c |  655=20
> ++++++++++++++++++++++++++++++++++++++++++++=20
> >  3 files changed, 664 insertions(+)=20
> >  create mode 100644 drivers/rtc/rtc-pcf85263.c=20
> >=20
> > diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig=20
> > index 18639e0..63ec0fc 100644=20
> > --- a/drivers/rtc/Kconfig=20
> > +++ b/drivers/rtc/Kconfig=20
> > @@ -396,6 +396,14 @@ config RTC_DRV_PCF85063=20
> >            This driver can also be built as a module. If so, the module=
=20
> >            will be called rtc-pcf85063.=20
> >  =20
> > +config RTC_DRV_PCF85263=20
> > +        tristate "NXP PCF85263"=20
> > +        help=20
> > +          If you say yes here you get support for the PCF85263 RTC chi=
p=20
> > +=20
> > +          This driver can also be built as a module. If so, the module=
=20
> > +          will be called rtc-pcf85263.=20
> > +=20
> >  config RTC_DRV_PCF8563=20
> >          tristate "Philips PCF8563/Epson RTC8564"=20
> >          help=20
> > diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile=20
> > index ea28337..04f48fd 100644=20
> > --- a/drivers/rtc/Makefile=20
> > +++ b/drivers/rtc/Makefile=20
> > @@ -108,6 +108,7 @@ obj-$(CONFIG_RTC_DRV_PCF2123)        +=3D=20
> rtc-pcf2123.o=20
> >  obj-$(CONFIG_RTC_DRV_PCF2127)        +=3D rtc-pcf2127.o=20
> >  obj-$(CONFIG_RTC_DRV_PCF50633)        +=3D rtc-pcf50633.o=20
> >  obj-$(CONFIG_RTC_DRV_PCF85063)        +=3D rtc-pcf85063.o=20
> > +obj-$(CONFIG_RTC_DRV_PCF85263)        +=3D rtc-pcf85263.o=20
> >  obj-$(CONFIG_RTC_DRV_PCF8523)        +=3D rtc-pcf8523.o=20
> >  obj-$(CONFIG_RTC_DRV_PCF8563)        +=3D rtc-pcf8563.o=20
> >  obj-$(CONFIG_RTC_DRV_PCF8583)        +=3D rtc-pcf8583.o=20
> > diff --git a/drivers/rtc/rtc-pcf85263.c b/drivers/rtc/rtc-pcf85263.c=20
> > new file mode 100644=20
> > index 0000000..997742d=20
> > --- /dev/null=20
> > +++ b/drivers/rtc/rtc-pcf85263.c=20
> > @@ -0,0 +1,655 @@=20
> > +/*=20
> > + * rtc-pcf85263 Driver for the NXP PCF85263 RTC=20
> > + *=20
> > + * Copyright 2016 Parkeon=20
> > + *=20
> > + * This program is free software; you can redistribute it and/or modif=
y=20
> > + * it under the terms of the GNU General Public License version 2 as=
=20
> > + * published by the Free Software Foundation.=20
> > + */=20
> > +=20
> > +#include <linux/module.h>=20
> > +#include <linux/mutex.h>=20
> > +#include <linux/rtc.h>=20
> > +#include <linux/i2c.h>=20
> > +#include <linux/bcd.h>=20
> > +#include <linux/of.h>=20
> > +#include <linux/of_device.h>=20
> > +#include <linux/regmap.h>=20
> > +=20
> > +#include <dt-bindings/rtc/nxp,pcf85263.h>=20
> > +=20
> > +#define DRV_NAME "rtc-pcf85263"=20
> > +=20
> > +#define PCF85263_REG_RTC_SC        0x01        /* Seconds */=20
> > +#define PCF85263_REG_RTC_SC_OS                BIT(7)        /*=20
> Oscilator stopped flag */=20
> > +=20
> > +#define PCF85263_REG_RTC_MN        0x02        /* Minutes */=20
> > +#define PCF85263_REG_RTC_HR        0x03        /* Hours */=20
> > +#define PCF85263_REG_RTC_DT        0x04        /* Day of month 1-31 */=
=20
> > +#define PCF85263_REG_RTC_DW        0x05        /* Day of week 0-6 */=
=20
> > +#define PCF85263_REG_RTC_MO        0x06        /* Month 1-12 */=20
> > +#define PCF85263_REG_RTC_YR        0x07        /* Year 0-99 */=20
> > +=20
> > +#define PCF85263_REG_ALM1_SC        0x08        /* Seconds */=20
> > +#define PCF85263_REG_ALM1_MN        0x09        /* Minutes */=20
> > +#define PCF85263_REG_ALM1_HR        0x0a        /* Hours */=20
> > +#define PCF85263_REG_ALM1_DT        0x0b        /* Day of month 1-31 *=
/=20
> > +#define PCF85263_REG_ALM1_MO        0x0c        /* Month 1-12 */=20
> > +=20
> > +#define PCF85263_REG_ALM_CTL        0x10=20
> > +#define PCF85263_REG_ALM_CTL_ALL_A1E        0x1f /* sec,min,hr,day,mon=
=20
> alarm 1 */=20
> > +=20
> > +#define PCF85263_REG_OSC        0x25=20
> > +#define PCF85263_REG_OSC_CL_MASK        (BIT(0) | BIT(1))=20
> > +#define PCF85263_REG_OSC_CL_SHIFT        0=20
> > +#define PCF85263_REG_OSC_OSCD_MASK        (BIT(2) | BIT(3))=20
> > +#define PCF85263_REG_OSC_OSCD_SHIFT        2=20
> > +#define PCF85263_REG_OSC_LOWJ                BIT(4)=20
> > +#define PCF85263_REG_OSC_12H                BIT(5)=20
> > +=20
> > +#define PCF85263_REG_PINIO        0x27=20
> > +#define PCF85263_REG_PINIO_INTAPM_MASK        (BIT(0) | BIT(1))=20
> > +#define PCF85263_REG_PINIO_INTAPM_SHIFT        0=20
> > +#define PCF85263_INTAPM_INTA        (0x2 <<=20
> PCF85263_REG_PINIO_INTAPM_SHIFT)=20
> > +#define PCF85263_INTAPM_HIGHZ        (0x3 <<=20
> PCF85263_REG_PINIO_INTAPM_SHIFT)=20
> > +#define PCF85263_REG_PINIO_TSPM_MASK        (BIT(2) | BIT(3))=20
> > +#define PCF85263_REG_PINIO_TSPM_SHIFT        2=20
> > +#define PCF85263_TSPM_DISABLED                (0x0 <<=20
> PCF85263_REG_PINIO_TSPM_SHIFT)=20
> > +#define PCF85263_TSPM_INTB                (0x1 <<=20
> PCF85263_REG_PINIO_TSPM_SHIFT)=20
> > +#define PCF85263_REG_PINIO_CLKDISABLE        BIT(7)=20
> > +=20
> > +#define PCF85263_REG_FUNCTION        0x28=20
> > +#define PCF85263_REG_FUNCTION_COF_MASK        0x7=20
> > +#define PCF85263_REG_FUNCTION_COF_OFF        0x7        /* No clock=20
> output */=20
> > +=20
> > +#define PCF85263_REG_INTA_CTL        0x29=20
> > +#define PCF85263_REG_INTB_CTL        0x2A=20
> > +#define PCF85263_REG_INTx_CTL_A1E        BIT(4)        /* Alarm 1 */=
=20
> > +#define PCF85263_REG_INTx_CTL_ILP        BIT(7)        /* 0=3Dpulse,=
=20
> 1=3Dlevel */=20
> > +=20
> > +#define PCF85263_REG_FLAGS        0x2B=20
> > +#define PCF85263_REG_FLAGS_A1F                BIT(5)=20
> > +=20
> > +#define PCF85263_REG_RAM_BYTE        0x2c=20
> > +=20
> > +#define PCF85263_REG_STOPENABLE 0x2e=20
> > +#define PCF85263_REG_STOPENABLE_STOP        BIT(0)=20
> > +=20
> > +#define PCF85263_REG_RESET        0x2f        /* Reset command */=20
> > +#define PCF85263_REG_RESET_CMD_CPR        0xa4        /* Clear=20
> prescaler */=20
> > +=20
> > +#define PCF85263_MAX_REG 0x2f=20
> > +=20
> > +#define PCF85263_HR_PM                BIT(5)=20
> > +=20
> > +enum pcf85263_irqpin {=20
> > +        PCF85263_IRQPIN_NONE,=20
> > +        PCF85263_IRQPIN_INTA,=20
> > +        PCF85263_IRQPIN_INTB=20
> > +};=20
> > +=20
> > +static const char *const pcf85263_irqpin_names[] =3D {=20
> > +        [PCF85263_IRQPIN_NONE] =3D "None",=20
> > +        [PCF85263_IRQPIN_INTA] =3D "INTA",=20
> > +        [PCF85263_IRQPIN_INTB] =3D "INTB"=20
> > +};=20
> > +=20
> > +struct pcf85263 {=20
> > +        struct device *dev;=20
> > +        struct rtc_device *rtc;=20
> > +        struct regmap *regmap;=20
> > +        enum pcf85263_irqpin irq_pin;=20
> > +        int irq;=20
> > +        bool mode_12h;=20
> > +};=20
> > +=20
> > +/*=20
> > + * Helpers to convert 12h to 24h and vice versa.=20
> > + * Values in register are stored in BCD with a PM flag in bit 5=20
> > + *=20
> > + * 23:00 <=3D> 11PM <=3D> 0x31=20
> > + * 00:00 <=3D> 12AM <=3D> 0x12=20
> > + * 01:00 <=3D> 1AM <=3D> 0x01=20
> > + * 12:00 <=3D> 12PM <=3D> 0x32=20
> > + * 13:00 <=3D> 1PM <=3D> 0x21=20
> > + */=20
> > +static int pcf85263_bcd12h_to_bin24h(int regval)=20
> > +{=20
> > +        int hr =3D bcd2bin(regval & 0x1f);=20
> > +        bool pm =3D regval & PCF85263_HR_PM;=20
> > +=20
> > +        if (hr =3D=3D 12)=20
> > +                return pm ? 12 : 0;=20
> > +=20
> > +        return pm ? hr + 12 : hr;=20
> > +}=20
> > +=20
> > +static int pcf85263_bin24h_to_bcd12h(int hr24)=20
> > +{=20
> > +        bool pm =3D hr24 >=3D 12;=20
> > +        int hr12 =3D hr24 % 12;=20
> > +=20
> > +        if (!hr12)=20
> > +                hr12++;=20
> > +=20
> > +        return bin2bcd(hr12) | pm ? 0 : PCF85263_HR_PM;=20
> > +}=20
> > +=20
> > +static int pcf85263_read_time(struct device *dev, struct rtc_time *tm)=
=20
> > +{=20
> > +        struct pcf85263 *pcf85263 =3D dev_get_drvdata(dev);=20
> > +        const int first =3D PCF85263_REG_RTC_SC;=20
> > +        const int last =3D PCF85263_REG_RTC_YR;=20
> > +        const int len =3D last - first + 1;=20
> > +        u8 regs[len];=20
> > +        u8 hr_reg;=20
> > +        int ret;=20
> > +=20
> > +        ret =3D regmap_bulk_read(pcf85263->regmap, first, regs, len);=
=20
> > +        if (ret)=20
> > +                return ret;=20
> > +=20
> > +        if (regs[PCF85263_REG_RTC_SC - first] & PCF85263_REG_RTC_SC_OS=
)=20
> {=20
> > +                dev_warn(dev, "Oscillator stop detected, date/time is=
=20
> not reliable.\n");=20
> > +                return -EINVAL;=20
> > +        }=20
> > +=20
> > +        tm->tm_sec =3D bcd2bin(regs[PCF85263_REG_RTC_SC - first] & 0x7=
f);=20
> > +        tm->tm_min =3D bcd2bin(regs[PCF85263_REG_RTC_MN - first] & 0x7=
f);=20
> > +=20
> > +        hr_reg =3D regs[PCF85263_REG_RTC_HR - first];=20
> > +        if (pcf85263->mode_12h)=20
> > +                tm->tm_hour =3D pcf85263_bcd12h_to_bin24h(hr_reg);=20
> > +        else=20
> > +                tm->tm_hour =3D bcd2bin(hr_reg & 0x3f);=20
> > +=20
> > +        tm->tm_mday =3D bcd2bin(regs[PCF85263_REG_RTC_DT - first]);=20
> > +        tm->tm_wday =3D bcd2bin(regs[PCF85263_REG_RTC_DW - first]);=20
> > +        tm->tm_mon  =3D bcd2bin(regs[PCF85263_REG_RTC_MO - first]) - 1=
;=20
> > +        tm->tm_year =3D bcd2bin(regs[PCF85263_REG_RTC_YR - first]);=20
> > +=20
> > +        tm->tm_year +=3D 100;  /* Assume 21st century */=20
> > +=20
> > +        return 0;=20
> > +}=20
> > +=20
> > +static int pcf85263_set_time(struct device *dev, struct rtc_time *tm)=
=20
> > +{=20
> > +        struct pcf85263 *pcf85263 =3D dev_get_drvdata(dev);=20
> > +=20
> > +        /*=20
> > +         * Before setting time need to stop RTC and disable prescaler=
=20
> > +         * Do this all in a single I2C transaction exploiting=20
> wraparound=20
> > +         * as described in data sheet.=20
> > +         * This means that the array below must be in register order=
=20
> > +         */=20
> > +        u8 regs[] =3D {=20
> > +                PCF85263_REG_STOPENABLE_STOP,        /* STOP */=20
> > +                PCF85263_REG_RESET_CMD_CPR,        /* Disable prescale=
r=20
> */=20
> > +                /* Wrap around to register 0 (1/100s) */=20
> > +                0,                                /* 1/100s always=20
> zero. */=20
> > +                bin2bcd(tm->tm_sec),=20
> > +                bin2bcd(tm->tm_min),=20
> > +                bin2bcd(tm->tm_hour),                /* 24-hour */=20
> > +                bin2bcd(tm->tm_mday),=20
> > +                bin2bcd(tm->tm_wday + 1),=20
> > +                bin2bcd(tm->tm_mon + 1),=20
> > +                bin2bcd(tm->tm_year % 100)=20
> > +        };=20
> > +        int ret;=20
> > +=20
> > +        ret =3D regmap_bulk_write(pcf85263->regmap,=20
> PCF85263_REG_STOPENABLE,=20
> > +                                regs, sizeof(regs));=20
> > +        if (ret)=20
> > +                return ret;=20
> > +=20
> > +        /* As we have set the time in 24H update the hardware for that=
=20
> */=20
> > +        if (pcf85263->mode_12h) {=20
> > +                pcf85263->mode_12h =3D false;=20
> > +                ret =3D regmap_update_bits(pcf85263->regmap,=20
> PCF85263_REG_OSC,=20
> > +                                         PCF85263_REG_OSC_12H, 0);=20
> > +                if (ret)=20
> > +                        return ret;=20
> > +        }=20
> > +=20
> > +        /* Start it again */=20
> > +        return regmap_write(pcf85263->regmap, PCF85263_REG_STOPENABLE,=
=20
> 0);=20
> > +}=20
> > +=20
> > +static int pcf85263_enable_alarm(struct pcf85263 *pcf85263, bool=20
> enable)=20
> > +{=20
> > +        int reg;=20
> > +        int ret;=20
> > +=20
> > +        ret =3D regmap_update_bits(pcf85263->regmap,=20
> PCF85263_REG_ALM_CTL,=20
> > +                                 PCF85263_REG_ALM_CTL_ALL_A1E,=20
> > +                                 enable ? PCF85263_REG_ALM_CTL_ALL_A1E=
=20
> : 0);=20
> > +        if (ret)=20
> > +                return ret;=20
> > +=20
> > +        switch (pcf85263->irq_pin) {=20
> > +        case PCF85263_IRQPIN_NONE:=20
> > +                return 0;=20
> > +=20
> > +        case PCF85263_IRQPIN_INTA:=20
> > +                reg =3D PCF85263_REG_INTA_CTL;=20
> > +                break;=20
> > +=20
> > +        case PCF85263_IRQPIN_INTB:=20
> > +                reg =3D PCF85263_REG_INTB_CTL;=20
> > +                break;=20
> > +=20
> > +        default:=20
> > +                return -EINVAL;=20
> > +        }=20
> > +=20
> > +        return regmap_update_bits(pcf85263->regmap, reg,=20
> > +                                  PCF85263_REG_INTx_CTL_A1E,=20
> > +                                  enable ? PCF85263_REG_INTx_CTL_A1E :=
=20
> 0);=20
> > +}=20
> > +=20
> > +static int pcf85263_read_alarm(struct device *dev, struct rtc_wkalrm=
=20
> *alarm)=20
> > +{=20
> > +        struct pcf85263 *pcf85263 =3D dev_get_drvdata(dev);=20
> > +        struct rtc_time *tm =3D &alarm->time;=20
> > +        const int first =3D PCF85263_REG_ALM1_SC;=20
> > +        const int last =3D PCF85263_REG_ALM1_MO;=20
> > +        const int len =3D last - first + 1;=20
> > +        u8 regs[len];=20
> > +        u8 hr_reg;=20
> > +        unsigned int regval;=20
> > +        int ret;=20
> > +=20
> > +        ret =3D regmap_bulk_read(pcf85263->regmap, first, regs, len);=
=20
> > +        if (ret)=20
> > +                return ret;=20
> > +=20
> > +        tm->tm_sec =3D bcd2bin(regs[PCF85263_REG_ALM1_SC - first] &=20
> 0x7f);=20
> > +        tm->tm_min =3D bcd2bin(regs[PCF85263_REG_ALM1_MN - first] &=20
> 0x7f);=20
> > +=20
> > +        hr_reg =3D regs[PCF85263_REG_ALM1_HR - first];=20
> > +        if (pcf85263->mode_12h)=20
> > +                tm->tm_hour =3D pcf85263_bcd12h_to_bin24h(hr_reg);=20
> > +        else=20
> > +                tm->tm_hour =3D bcd2bin(hr_reg & 0x3f);=20
> > +=20
> > +        tm->tm_mday =3D bcd2bin(regs[PCF85263_REG_ALM1_DT - first]);=
=20
> > +        tm->tm_mon  =3D bcd2bin(regs[PCF85263_REG_ALM1_MO - first]) - =
1;=20
> > +        tm->tm_year =3D -1;=20
> > +        tm->tm_wday =3D -1;=20
> > +=20
> > +        ret =3D regmap_read(pcf85263->regmap, PCF85263_REG_ALM_CTL,=20
> &regval);=20
> > +        if (ret)=20
> > +                return ret;=20
> > +        alarm->enabled =3D !!(regval & PCF85263_REG_ALM_CTL_ALL_A1E);=
=20
> > +=20
> > +        ret =3D regmap_read(pcf85263->regmap, PCF85263_REG_FLAGS,=20
> &regval);=20
> > +        if (ret)=20
> > +                return ret;=20
> > +        alarm->pending =3D !!(regval & PCF85263_REG_FLAGS_A1F);=20
> > +=20
> > +        return 0;=20
> > +}=20
> > +=20
> > +static int pcf85263_set_alarm(struct device *dev, struct rtc_wkalrm=20
> *alarm)=20
> > +{=20
> > +        struct pcf85263 *pcf85263 =3D dev_get_drvdata(dev);=20
> > +        struct rtc_time *tm =3D &alarm->time;=20
> > +        const int first =3D PCF85263_REG_ALM1_SC;=20
> > +        const int last =3D PCF85263_REG_ALM1_MO;=20
> > +        const int len =3D last - first + 1;=20
> > +        u8 regs[len];=20
> > +        int ret;=20
> > +=20
> > +        /* Disable alarm comparison during update */=20
> > +        ret =3D pcf85263_enable_alarm(pcf85263, false);=20
> > +        if (ret)=20
> > +                return ret;=20
> > +=20
> > +        /* Clear any pending alarm (write 0=3D>clr, 1=3D>no change) */=
=20
> > +        ret =3D regmap_write(pcf85263->regmap, PCF85263_REG_FLAGS,=20
> > +                           ~PCF85263_REG_FLAGS_A1F);=20
> > +        if (ret)=20
> > +                return ret;=20
> > +=20
> > +        /* Set the alarm time registers */=20
> > +        regs[PCF85263_REG_ALM1_SC - first] =3D bin2bcd(tm->tm_sec);=20
> > +        regs[PCF85263_REG_ALM1_MN - first] =3D bin2bcd(tm->tm_min);=20
> > +        regs[PCF85263_REG_ALM1_HR - first] =3D pcf85263->mode_12h ?=20
> > +                        pcf85263_bin24h_to_bcd12h(tm->tm_hour) :=20
> > +                        bin2bcd(tm->tm_hour);=20
> > +        regs[PCF85263_REG_ALM1_DT - first] =3D bin2bcd(tm->tm_mday);=
=20
> > +        regs[PCF85263_REG_ALM1_MO - first] =3D bin2bcd(tm->tm_mon + 1)=
;=20
> > +=20
> > +        ret =3D regmap_bulk_write(pcf85263->regmap, first, regs,=20
> sizeof(regs));=20
> > +        if (ret)=20
> > +                return ret;=20
> > +=20
> > +        if (alarm->enabled)=20
> > +                ret =3D pcf85263_enable_alarm(pcf85263, true);=20
> > +=20
> > +        return ret;=20
> > +}=20
> > +=20
> > +static int pcf85263_alarm_irq_enable(struct device *dev, unsigned int=
=20
> enable)=20
> > +{=20
> > +        struct pcf85263 *pcf85263 =3D dev_get_drvdata(dev);=20
> > +=20
> > +        return pcf85263_enable_alarm(pcf85263, !!enable);=20
> > +}=20
> > +=20
> > +static irqreturn_t pcf85263_irq(int irq, void *data)=20
> > +{=20
> > +        struct pcf85263 *pcf85263 =3D data;=20
> > +        unsigned int regval;=20
> > +        int ret;=20
> > +=20
> > +        ret =3D regmap_read(pcf85263->regmap, PCF85263_REG_FLAGS,=20
> &regval);=20
> > +        if (ret)=20
> > +                return IRQ_NONE;=20
> > +=20
> > +        if (regval & PCF85263_REG_FLAGS_A1F) {=20
> > +                regmap_write(pcf85263->regmap, PCF85263_REG_FLAGS,=20
> > +                             ~PCF85263_REG_FLAGS_A1F);=20
> > +=20
> > +                rtc_update_irq(pcf85263->rtc, 1, RTC_IRQF | RTC_AF);=
=20
> > +=20
> > +                return IRQ_HANDLED;=20
> > +        }=20
> > +=20
> > +        return IRQ_NONE;=20
> > +}=20
> > +=20
> > +static int pcf85263_check_osc_stopped(struct pcf85263 *pcf85263)=20
> > +{=20
> > +        unsigned int regval;=20
> > +        int ret;=20
> > +=20
> > +        ret =3D regmap_read(pcf85263->regmap, PCF85263_REG_RTC_SC,=20
> &regval);=20
> > +        if (ret)=20
> > +                return ret;=20
> > +=20
> > +        ret =3D regval & PCF85263_REG_RTC_SC_OS ? 1 : 0;=20
> > +        if (ret)=20
> > +                dev_warn(pcf85263->dev, "Oscillator stop detected,=20
> date/time is not reliable.\n");=20
> > +=20
> > +        return ret;=20
> > +}=20
> > +=20
> > +#ifdef CONFIG_RTC_INTF_DEV=20
> > +static int pcf85263_ioctl(struct device *dev,=20
> > +                          unsigned int cmd, unsigned long arg)=20
> > +{=20
> > +        struct pcf85263 *pcf85263 =3D dev_get_drvdata(dev);=20
> > +        int ret;=20
> > +=20
> > +        switch (cmd) {=20
> > +        case RTC_VL_READ:=20
> > +                ret =3D pcf85263_check_osc_stopped(pcf85263);=20
> > +                if (ret < 0)=20
> > +                        return ret;=20
> > +=20
> > +                if (copy_to_user((void __user *)arg, &ret,=20
> sizeof(int)))=20
> > +                        return -EFAULT;=20
> > +                return 0;=20
> > +=20
> > +        case RTC_VL_CLR:=20
> > +                return regmap_update_bits(pcf85263->regmap,=20
> > +                                          PCF85263_REG_RTC_SC,=20
> > +                                          PCF85263_REG_RTC_SC_OS, 0);=
=20
> > +        default:=20
> > +                return -ENOIOCTLCMD;=20
> > +        }=20
> > +}=20
> > +#else=20
> > +#define pcf85263_ioctl NULL=20
> > +#endif=20
> > +=20
> > +static int pcf85263_init_hw(struct pcf85263 *pcf85263)=20
> > +{=20
> > +        struct device_node *np =3D pcf85263->dev->of_node;=20
> > +        unsigned int regval;=20
> > +        u32 propval;=20
> > +        int ret;=20
> > +=20
> > +        /* Determine if oscilator has been stopped (probably low power=
)=20
> */=20
> > +        ret =3D pcf85263_check_osc_stopped(pcf85263);=20
> > +        if (ret < 0) {=20
> > +                /* Log here since this is the first hw access on probe=
=20
> */=20
> > +                dev_err(pcf85263->dev, "Unable to read register\n");=
=20
> > +=20
> > +                return ret;=20
> > +        }=20
> > +=20
> > +        /* Determine 12/24H mode */=20
> > +        ret =3D regmap_read(pcf85263->regmap, PCF85263_REG_OSC, &regva=
l);=20
> > +        if (ret)=20
> > +                return ret;=20
> > +        pcf85263->mode_12h =3D !!(regval & PCF85263_REG_OSC_12H);=20
> > +=20
> > +        /* Set oscilator register */=20
> > +        regval &=3D ~PCF85263_REG_OSC_12H; /* keep current 12/24 h=20
> setting */=20
> > +=20
> > +        propval =3D PCF85263_QUARTZCAP_12p5pF;=20
> > +        of_property_read_u32(np, "quartz-load-capacitance", &propval);=
=20
> > +        regval |=3D ((propval << PCF85263_REG_OSC_CL_SHIFT)=20
> > +                    & PCF85263_REG_OSC_CL_MASK);=20
> > +=20
> > +        propval =3D PCF85263_QUARTZDRIVE_NORMAL;=20
> > +        of_property_read_u32(np, "quartz-drive-strength", &propval);=
=20
> > +        regval |=3D ((propval << PCF85263_REG_OSC_OSCD_SHIFT)=20
> > +                    & PCF85263_REG_OSC_OSCD_MASK);=20
> > +=20
> > +        if (of_property_read_bool(np, "quartz-low-jitter"))=20
> > +                regval |=3D PCF85263_REG_OSC_LOWJ;=20
> > +=20
> > +        ret =3D regmap_write(pcf85263->regmap, PCF85263_REG_OSC, regva=
l);=20
> > +        if (ret)=20
> > +                return ret;=20
> > +=20
> > +        /* Set function register (RTC mode, 1s tick, clock output=20
> static) */=20
> > +        ret =3D regmap_write(pcf85263->regmap, PCF85263_REG_FUNCTION,=
=20
> > +                           PCF85263_REG_FUNCTION_COF_OFF);=20
> > +        if (ret)=20
> > +                return ret;=20
> > +=20
> > +        /* Set all interrupts to disabled, level mode */=20
> > +        ret =3D regmap_write(pcf85263->regmap, PCF85263_REG_INTA_CTL,=
=20
> > +                           PCF85263_REG_INTx_CTL_ILP);=20
> > +        if (ret)=20
> > +                return ret;=20
> > +        ret =3D regmap_write(pcf85263->regmap, PCF85263_REG_INTB_CTL,=
=20
> > +                           PCF85263_REG_INTx_CTL_ILP);=20
> > +        if (ret)=20
> > +                return ret;=20
> > +=20
> > +        /* Setup IO pin config register */=20
> > +        regval =3D PCF85263_REG_PINIO_CLKDISABLE;=20
> > +        switch (pcf85263->irq_pin) {=20
> > +        case PCF85263_IRQPIN_INTA:=20
> > +                regval |=3D (PCF85263_INTAPM_INTA |=20
> PCF85263_TSPM_DISABLED);=20
> > +                break;=20
> > +        case PCF85263_IRQPIN_INTB:=20
> > +                regval |=3D (PCF85263_INTAPM_HIGHZ | PCF85263_TSPM_INT=
B);=20
> > +                break;=20
> > +        case PCF85263_IRQPIN_NONE:=20
> > +                regval |=3D (PCF85263_INTAPM_HIGHZ |=20
> PCF85263_TSPM_DISABLED);=20
> > +                break;=20
> > +        }=20
> > +        ret =3D regmap_write(pcf85263->regmap, PCF85263_REG_PINIO,=20
> regval);=20
> > +=20
> > +        return ret;=20
> > +}=20
> > +=20
> > +static const struct rtc_class_ops rtc_ops =3D {=20
> > +        .ioctl =3D pcf85263_ioctl,=20
> > +        .read_time =3D pcf85263_read_time,=20
> > +        .set_time =3D pcf85263_set_time,=20
> > +        .read_alarm =3D pcf85263_read_alarm,=20
> > +        .set_alarm =3D pcf85263_set_alarm,=20
> > +        .alarm_irq_enable =3D pcf85263_alarm_irq_enable,=20
> > +};=20
> > +=20
> > +static const struct regmap_config pcf85263_regmap_cfg =3D {=20
> > +        .reg_bits =3D 8,=20
> > +        .val_bits =3D 8,=20
> > +        .max_register =3D PCF85263_MAX_REG,=20
> > +};=20
> > +=20
> > +/*=20
> > + * On some boards the interrupt line may not be wired to the CPU but=
=20
> only to=20
> > + * a power supply circuit.=20
> > + * In that case no interrupt will be specified in the device tree but=
=20
> the=20
> > + * wakeup-source DT property may be used to enable wakeup programming=
=20
> in=20
> > + * sysfs=20
> > + */=20
> > +static bool pcf85263_can_wakeup_machine(struct pcf85263 *pcf85263)=20
> > +{=20
> > +        return pcf85263->irq ||=20
> > +                of_property_read_bool(pcf85263->dev->of_node,=20
> "wakeup-source");=20
> > +}=20
> > +=20
> > +static int pcf85263_probe(struct i2c_client *client,=20
> > +                                const struct i2c_device_id *id)=20
> > +{=20
> > +        struct device *dev =3D &client->dev;=20
> > +        struct pcf85263 *pcf85263;=20
> > +        int ret;=20
> > +=20
> > +        if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C |=
=20
> > +                                     I2C_FUNC_SMBUS_BYTE_DATA |=20
> > +                                     I2C_FUNC_SMBUS_I2C_BLOCK))=20
> > +                return -ENODEV;=20
> > +=20
> > +        pcf85263 =3D devm_kzalloc(dev, sizeof(*pcf85263), GFP_KERNEL);=
=20
> > +        if (!pcf85263)=20
> > +                return -ENOMEM;=20
> > +=20
> > +        pcf85263->dev =3D dev;=20
> > +        pcf85263->irq =3D client->irq;=20
> > +        dev_set_drvdata(dev, pcf85263);=20
> > +=20
> > +        pcf85263->regmap =3D devm_regmap_init_i2c(client,=20
> &pcf85263_regmap_cfg);=20
> > +        if (IS_ERR(pcf85263->regmap)) {=20
> > +                ret =3D PTR_ERR(pcf85263->regmap);=20
> > +                dev_err(dev, "regmap allocation failed (%d)\n", ret);=
=20
> > +=20
> > +                return ret;=20
> > +        }=20
> > +=20
> > +        /* Determine which interrupt pin the board uses */=20
> > +        if (pcf85263_can_wakeup_machine(pcf85263)) {=20
> > +                if (of_property_match_string(dev->of_node,=20
> > +                                             "interrupt-names", "INTB"=
)=20
> >=3D 0)=20
> > +                        pcf85263->irq_pin =3D PCF85263_IRQPIN_INTB;=20
> > +                else=20
> > +                        pcf85263->irq_pin =3D PCF85263_IRQPIN_INTA;=20
> > +        } else {=20
> > +                pcf85263->irq_pin =3D PCF85263_IRQPIN_NONE;=20
> > +        }=20
> > +=20
> > +        ret =3D pcf85263_init_hw(pcf85263);=20
> > +        if (ret)=20
> > +                return ret;=20
> > +=20
> > +        if (pcf85263->irq) {=20
> > +                ret =3D devm_request_threaded_irq(dev, pcf85263->irq,=
=20
> NULL,=20
> > +                                                pcf85263_irq,=20
> > +                                                IRQF_ONESHOT,=20
> > +                                                dev->driver->name,=20
> pcf85263);=20
> > +                if (ret) {=20
> > +                        dev_err(dev, "irq %d unavailable (%d)\n",=20
> > +                                pcf85263->irq, ret);=20
> > +                        pcf85263->irq =3D 0;=20
> > +                }=20
> > +        }=20
> > +=20
> > +        if (pcf85263_can_wakeup_machine(pcf85263))=20
> > +                device_init_wakeup(dev, true);=20
> > +=20
> > +        pcf85263->rtc =3D devm_rtc_device_register(dev,=20
> dev->driver->name,=20
> > +                                                 &rtc_ops,=20
> THIS_MODULE);=20
> > +        ret =3D PTR_ERR_OR_ZERO(pcf85263->rtc);=20
> > +        if (ret)=20
> > +                return ret;=20
> > +=20
> > +        /* We cannot support UIE mode if we do not have an IRQ line */=
=20
> > +        if (!pcf85263->irq)=20
> > +                pcf85263->rtc->uie_unsupported =3D 1;=20
> > +=20
> > +        dev_info(pcf85263->dev,=20
> > +                 "PCF85263 RTC (irqpin=3D%s irq=3D%d)\n",=20
> > +                 pcf85263_irqpin_names[pcf85263->irq_pin],=20
> > +                 pcf85263->irq);=20
> > +=20
> > +        return 0;=20
> > +}=20
> > +=20
> > +static int pcf85263_remove(struct i2c_client *client)=20
> > +{=20
> > +        struct pcf85263 *pcf85263 =3D i2c_get_clientdata(client);=20
> > +=20
> > +        if (pcf85263_can_wakeup_machine(pcf85263))=20
> > +                device_init_wakeup(pcf85263->dev, false);=20
> > +=20
> > +        return 0;=20
> > +}=20
> > +=20
> > +#ifdef CONFIG_PM_SLEEP=20
> > +static int pcf85263_suspend(struct device *dev)=20
> > +{=20
> > +        struct pcf85263 *pcf85263 =3D dev_get_drvdata(dev);=20
> > +        int ret =3D 0;=20
> > +=20
> > +        if (device_may_wakeup(dev))=20
> > +                ret =3D enable_irq_wake(pcf85263->irq);=20
> > +=20
> > +        return ret;=20
> > +}=20
> > +=20
> > +static int pcf85263_resume(struct device *dev)=20
> > +{=20
> > +        struct pcf85263 *pcf85263 =3D dev_get_drvdata(dev);=20
> > +        int ret =3D 0;=20
> > +=20
> > +        if (device_may_wakeup(dev))=20
> > +                ret =3D disable_irq_wake(pcf85263->irq);=20
> > +=20
> > +        return ret;=20
> > +}=20
> > +=20
> > +#endif=20
> > +=20
> > +static const struct i2c_device_id pcf85263_id[] =3D {=20
> > +        { "pcf85263", 0 },=20
> > +        { }=20
> > +};=20
> > +MODULE_DEVICE_TABLE(i2c, pcf85263_id);=20
> > +=20
> > +#ifdef CONFIG_OF=20
> > +static const struct of_device_id pcf85263_of_match[] =3D {=20
> > +        { .compatible =3D "nxp,pcf85263" },=20
> > +        {}=20
> > +};=20
> > +MODULE_DEVICE_TABLE(of, pcf85263_of_match);=20
> > +#endif=20
> > +=20
> > +static SIMPLE_DEV_PM_OPS(pcf85263_pm_ops, pcf85263_suspend,=20
>  pcf85263_resume);=20
> > +=20
> > +static struct i2c_driver pcf85263_driver =3D {=20
> > +        .driver                =3D {=20
> > +                .name        =3D "rtc-pcf85263",=20
> > +                .of_match_table =3D of_match_ptr(pcf85263_of_match),=
=20
> > +                .pm =3D &pcf85263_pm_ops,=20
> > +        },=20
> > +        .probe                =3D pcf85263_probe,=20
> > +        .remove                =3D pcf85263_remove,=20
> > +        .id_table        =3D pcf85263_id,=20
> > +};=20
> > +=20
> > +module_i2c_driver(pcf85263_driver);=20
> > +=20
> > +MODULE_AUTHOR("Martin Fuzzey <mfu...@parkeon.com <javascript:>>");=20
> > +MODULE_DESCRIPTION("PCF85263 RTC Driver");=20
> > +MODULE_LICENSE("GPL");=20
> >=20
>
> --=20
> Alexandre Belloni, Free Electrons=20
> Embedded Linux and Kernel engineering=20
> http://free-electrons.com=20
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

------=_Part_4632_1763001965.1489598915114
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+SGVsbG8swqA8ZGl2Pkkgd2FudGVkIHRvIGluZm9ybSB5b3UgdGhhdCB3
ZSBhcmUgdXNpbmcgdGhpcyBrZXJuZWwgZHJpdmVyIG9uIGEgYmVhZ2xlYm9uZSBibGFjayBhbmQg
d2UgYXJlIG5vdCBoYXZpbmcgYW55IGtpbmQgb2YgaXNzdWUuIFRoYW5rcyBmb3IgeW91ciB3b3Jr
PGJyPjxicj48L2Rpdj48ZGl2Pjxicj5JbCBnaW9ybm8gbWVyY29sZWTDrCAyMSBzZXR0ZW1icmUg
MjAxNiAyMzozNTo0MiBVVEMrMiwgYWxleGFuZHJlLmJlbGxvbmkgaGEgc2NyaXR0bzo8YmxvY2tx
dW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46IDA7bWFyZ2luLWxlZnQ6IDAu
OGV4O2JvcmRlci1sZWZ0OiAxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6IDFleDsiPkhpLA0K
PGJyPg0KPGJyPlNvcnJ5IGZvciB0aGUgdmVyeSBsYXRlIHJldmlldy4NCjxicj4NCjxicj5UaGUg
ZHJpdmVyIHNlZW1zIGdvb2QgdG8gbWUgYnV0IEkmIzM5O2QgbGlrZSBhIHJldmlldyBmcm9tIHRo
ZSBEVA0KPGJyPm1haW50YWluZXJzIGJlZm9yZSB0YWtpbmcgaXQuDQo8YnI+DQo8YnI+T24gMDEv
MDgvMjAxNiBhdCAxNzo1MDozNCArMDIwMCwgTWFydGluIEZ1enpleSB3cm90ZSA6DQo8YnI+Jmd0
OyBBZGQgYmFzaWMgc3VwcG9ydCBmb3IgTlhQIFBDRjg1MjYzIEkyQyBSVEMgY2hpcC4NCjxicj4m
Z3Q7IA0KPGJyPiZndDsgT25seSBSVEMgYW5kIEFsYXJtIGZ1bmN0aW9ucyBhcmUgc3VwcG9ydGVk
Lg0KPGJyPiZndDsgDQo8YnI+Jmd0OyBTaWduZWQtb2ZmLWJ5OiBNYXJ0aW4gRnV6emV5ICZsdDs8
YSBocmVmPSJqYXZhc2NyaXB0OiIgdGFyZ2V0PSJfYmxhbmsiIGdkZi1vYmZ1c2NhdGVkLW1haWx0
bz0iTUFfOHpoMVpGQUFKIiByZWw9Im5vZm9sbG93IiBvbm1vdXNlZG93bj0idGhpcy5ocmVmPSYj
Mzk7amF2YXNjcmlwdDomIzM5OztyZXR1cm4gdHJ1ZTsiIG9uY2xpY2s9InRoaXMuaHJlZj0mIzM5
O2phdmFzY3JpcHQ6JiMzOTs7cmV0dXJuIHRydWU7Ij5tZnUuLi5AcGFya2Vvbi5jb208L2E+Jmd0
Ow0KPGJyPiZndDsgLS0tDQo8YnI+Jmd0OyDCoGRyaXZlcnMvcnRjL0tjb25maWcgwqAgwqAgwqAg
wqB8IMKgIMKgOCArDQo8YnI+Jmd0OyDCoGRyaXZlcnMvcnRjL01ha2VmaWxlIMKgIMKgIMKgIHwg
wqAgwqAxIA0KPGJyPiZndDsgwqBkcml2ZXJzL3J0Yy9ydGMtcGNmODUyNjMuYyB8IMKgNjU1ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKzx3YnI+KysrKysrKysrKysrKysNCjxicj4mZ3Q7
IMKgMyBmaWxlcyBjaGFuZ2VkLCA2NjQgaW5zZXJ0aW9ucygrKQ0KPGJyPiZndDsgwqBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy9ydGMvcnRjLXBjZjg1MjYzLmMNCjxicj4mZ3Q7IA0KPGJyPiZn
dDsgZGlmZiAtLWdpdCBhL2RyaXZlcnMvcnRjL0tjb25maWcgYi9kcml2ZXJzL3J0Yy9LY29uZmln
DQo8YnI+Jmd0OyBpbmRleCAxODYzOWUwLi42M2VjMGZjIDEwMDY0NA0KPGJyPiZndDsgLS0tIGEv
ZHJpdmVycy9ydGMvS2NvbmZpZw0KPGJyPiZndDsgKysrIGIvZHJpdmVycy9ydGMvS2NvbmZpZw0K
PGJyPiZndDsgQEAgLTM5Niw2ICszOTYsMTQgQEAgY29uZmlnIFJUQ19EUlZfUENGODUwNjMNCjxi
cj4mZ3Q7IMKgwqDCoMKgwqDCoMKgwqDCoCDCoFRoaXMgZHJpdmVyIGNhbiBhbHNvIGJlIGJ1aWx0
IGFzIGEgbW9kdWxlLiBJZiBzbywgdGhlIG1vZHVsZQ0KPGJyPiZndDsgwqDCoMKgwqDCoMKgwqDC
oMKgIMKgd2lsbCBiZSBjYWxsZWQgcnRjLXBjZjg1MDYzLg0KPGJyPiZndDsgwqANCjxicj4mZ3Q7
ICtjb25maWcgUlRDX0RSVl9QQ0Y4NTI2Mw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqB0cmlz
dGF0ZSAmcXVvdDtOWFAgUENGODUyNjMmcXVvdDsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKg
aGVscA0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqAgwqBJZiB5b3Ugc2F5IHllcyBoZXJlIHlv
dSBnZXQgc3VwcG9ydCBmb3IgdGhlIFBDRjg1MjYzIFJUQyBjaGlwDQo8YnI+Jmd0OyArDQo8YnI+
Jmd0OyArwqDCoMKgwqDCoMKgwqDCoCDCoFRoaXMgZHJpdmVyIGNhbiBhbHNvIGJlIGJ1aWx0IGFz
IGEgbW9kdWxlLiBJZiBzbywgdGhlIG1vZHVsZQ0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqAg
wqB3aWxsIGJlIGNhbGxlZCBydGMtcGNmODUyNjMuDQo8YnI+Jmd0OyArDQo8YnI+Jmd0OyDCoGNv
bmZpZyBSVENfRFJWX1BDRjg1NjMNCjxicj4mZ3Q7IMKgwqDCoMKgwqDCoMKgwqDCoHRyaXN0YXRl
ICZxdW90O1BoaWxpcHMgUENGODU2My9FcHNvbiBSVEM4NTY0JnF1b3Q7DQo8YnI+Jmd0OyDCoMKg
wqDCoMKgwqDCoMKgwqBoZWxwDQo8YnI+Jmd0OyBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ydGMvTWFr
ZWZpbGUgYi9kcml2ZXJzL3J0Yy9NYWtlZmlsZQ0KPGJyPiZndDsgaW5kZXggZWEyODMzNy4uMDRm
NDhmZCAxMDA2NDQNCjxicj4mZ3Q7IC0tLSBhL2RyaXZlcnMvcnRjL01ha2VmaWxlDQo8YnI+Jmd0
OyArKysgYi9kcml2ZXJzL3J0Yy9NYWtlZmlsZQ0KPGJyPiZndDsgQEAgLTEwOCw2ICsxMDgsNyBA
QCBvYmotJChDT05GSUdfUlRDX0RSVl9QQ0YyMTIzKcKgPHdicj7CoMKgwqDCoMKgwqDCoCs9IHJ0
Yy1wY2YyMTIzLm8NCjxicj4mZ3Q7IMKgb2JqLSQoQ09ORklHX1JUQ19EUlZfUENGMjEyNyk8d2Jy
PsKgwqDCoMKgwqDCoMKgwqArPSBydGMtcGNmMjEyNy5vDQo8YnI+Jmd0OyDCoG9iai0kKENPTkZJ
R19SVENfRFJWXzx3YnI+UENGNTA2MzMpwqDCoMKgwqDCoMKgwqDCoCs9IHJ0Yy1wY2Y1MDYzMy5v
DQo8YnI+Jmd0OyDCoG9iai0kKENPTkZJR19SVENfRFJWXzx3YnI+UENGODUwNjMpwqDCoMKgwqDC
oMKgwqDCoCs9IHJ0Yy1wY2Y4NTA2My5vDQo8YnI+Jmd0OyArb2JqLSQoQ09ORklHX1JUQ19EUlZf
PHdicj5QQ0Y4NTI2MynCoMKgwqDCoMKgwqDCoMKgKz0gcnRjLXBjZjg1MjYzLm8NCjxicj4mZ3Q7
IMKgb2JqLSQoQ09ORklHX1JUQ19EUlZfUENGODUyMyk8d2JyPsKgwqDCoMKgwqDCoMKgwqArPSBy
dGMtcGNmODUyMy5vDQo8YnI+Jmd0OyDCoG9iai0kKENPTkZJR19SVENfRFJWX1BDRjg1NjMpPHdi
cj7CoMKgwqDCoMKgwqDCoMKgKz0gcnRjLXBjZjg1NjMubw0KPGJyPiZndDsgwqBvYmotJChDT05G
SUdfUlRDX0RSVl9QQ0Y4NTgzKTx3YnI+wqDCoMKgwqDCoMKgwqDCoCs9IHJ0Yy1wY2Y4NTgzLm8N
Cjxicj4mZ3Q7IGRpZmYgLS1naXQgYS9kcml2ZXJzL3J0Yy9ydGMtcGNmODUyNjMuYyBiL2RyaXZl
cnMvcnRjL3J0Yy1wY2Y4NTI2My5jDQo8YnI+Jmd0OyBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPGJy
PiZndDsgaW5kZXggMDAwMDAwMC4uOTk3NzQyZA0KPGJyPiZndDsgLS0tIC9kZXYvbnVsbA0KPGJy
PiZndDsgKysrIGIvZHJpdmVycy9ydGMvcnRjLXBjZjg1MjYzLmMNCjxicj4mZ3Q7IEBAIC0wLDAg
KzEsNjU1IEBADQo8YnI+Jmd0OyArLyoNCjxicj4mZ3Q7ICsgKiBydGMtcGNmODUyNjMgRHJpdmVy
IGZvciB0aGUgTlhQIFBDRjg1MjYzIFJUQw0KPGJyPiZndDsgKyAqDQo8YnI+Jmd0OyArICogQ29w
eXJpZ2h0IDIwMTYgUGFya2Vvbg0KPGJyPiZndDsgKyAqDQo8YnI+Jmd0OyArICogVGhpcyBwcm9n
cmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2Rp
ZnkNCjxicj4mZ3Q7ICsgKiBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1
YmxpYyBMaWNlbnNlIHZlcnNpb24gMiBhcw0KPGJyPiZndDsgKyAqIHB1Ymxpc2hlZCBieSB0aGUg
RnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLg0KPGJyPiZndDsgKyAqLw0KPGJyPiZndDsgKw0KPGJy
PiZndDsgKyNpbmNsdWRlICZsdDtsaW51eC9tb2R1bGUuaCZndDsNCjxicj4mZ3Q7ICsjaW5jbHVk
ZSAmbHQ7bGludXgvbXV0ZXguaCZndDsNCjxicj4mZ3Q7ICsjaW5jbHVkZSAmbHQ7bGludXgvcnRj
LmgmZ3Q7DQo8YnI+Jmd0OyArI2luY2x1ZGUgJmx0O2xpbnV4L2kyYy5oJmd0Ow0KPGJyPiZndDsg
KyNpbmNsdWRlICZsdDtsaW51eC9iY2QuaCZndDsNCjxicj4mZ3Q7ICsjaW5jbHVkZSAmbHQ7bGlu
dXgvb2YuaCZndDsNCjxicj4mZ3Q7ICsjaW5jbHVkZSAmbHQ7bGludXgvb2ZfZGV2aWNlLmgmZ3Q7
DQo8YnI+Jmd0OyArI2luY2x1ZGUgJmx0O2xpbnV4L3JlZ21hcC5oJmd0Ow0KPGJyPiZndDsgKw0K
PGJyPiZndDsgKyNpbmNsdWRlICZsdDtkdC1iaW5kaW5ncy9ydGMvbnhwLHBjZjg1MjYzLjx3YnI+
aCZndDsNCjxicj4mZ3Q7ICsNCjxicj4mZ3Q7ICsjZGVmaW5lIERSVl9OQU1FICZxdW90O3J0Yy1w
Y2Y4NTI2MyZxdW90Ow0KPGJyPiZndDsgKw0KPGJyPiZndDsgKyNkZWZpbmUgUENGODUyNjNfUkVH
X1JUQ19TQ8KgwqDCoMKgwqDCoMKgwqA8d2JyPjB4MDHCoMKgwqDCoMKgwqDCoMKgLyogU2Vjb25k
cyAqLw0KPGJyPiZndDsgKyNkZWZpbmUgUENGODUyNjNfUkVHX1JUQ19TQ19PU8KgwqDCoMKgwqDC
oMKgwqA8d2JyPsKgwqDCoMKgwqDCoMKgwqBCSVQoNynCoMKgwqDCoMKgwqDCoMKgLyogT3NjaWxh
dG9yIHN0b3BwZWQgZmxhZyAqLw0KPGJyPiZndDsgKw0KPGJyPiZndDsgKyNkZWZpbmUgUENGODUy
NjNfUkVHX1JUQ19NTsKgwqDCoMKgwqDCoMKgwqA8d2JyPjB4MDLCoMKgwqDCoMKgwqDCoMKgLyog
TWludXRlcyAqLw0KPGJyPiZndDsgKyNkZWZpbmUgUENGODUyNjNfUkVHX1JUQ19IUsKgwqDCoMKg
wqDCoMKgwqA8d2JyPjB4MDPCoMKgwqDCoMKgwqDCoMKgLyogSG91cnMgKi8NCjxicj4mZ3Q7ICsj
ZGVmaW5lIFBDRjg1MjYzX1JFR19SVENfRFTCoMKgwqDCoMKgwqDCoMKgPHdicj4weDA0wqDCoMKg
wqDCoMKgwqDCoC8qIERheSBvZiBtb250aCAxLTMxICovDQo8YnI+Jmd0OyArI2RlZmluZSBQQ0Y4
NTI2M19SRUdfUlRDX0RXwqDCoMKgwqDCoMKgwqDCoDx3YnI+MHgwNcKgwqDCoMKgwqDCoMKgwqAv
KiBEYXkgb2Ygd2VlayAwLTYgKi8NCjxicj4mZ3Q7ICsjZGVmaW5lIFBDRjg1MjYzX1JFR19SVENf
TU/CoMKgwqDCoMKgwqDCoMKgPHdicj4weDA2wqDCoMKgwqDCoMKgwqDCoC8qIE1vbnRoIDEtMTIg
Ki8NCjxicj4mZ3Q7ICsjZGVmaW5lIFBDRjg1MjYzX1JFR19SVENfWVLCoMKgwqDCoMKgwqDCoMKg
PHdicj4weDA3wqDCoMKgwqDCoMKgwqDCoC8qIFllYXIgMC05OSAqLw0KPGJyPiZndDsgKw0KPGJy
PiZndDsgKyNkZWZpbmUgUENGODUyNjNfUkVHX0FMTTFfU0PCoMKgwqDCoMKgwqDCoMKgPHdicj4w
eDA4wqDCoMKgwqDCoMKgwqDCoC8qIFNlY29uZHMgKi8NCjxicj4mZ3Q7ICsjZGVmaW5lIFBDRjg1
MjYzX1JFR19BTE0xX01OwqDCoMKgwqDCoMKgwqDCoDx3YnI+MHgwOcKgwqDCoMKgwqDCoMKgwqAv
KiBNaW51dGVzICovDQo8YnI+Jmd0OyArI2RlZmluZSBQQ0Y4NTI2M19SRUdfQUxNMV9IUsKgwqDC
oMKgwqDCoMKgwqA8d2JyPjB4MGHCoMKgwqDCoMKgwqDCoMKgLyogSG91cnMgKi8NCjxicj4mZ3Q7
ICsjZGVmaW5lIFBDRjg1MjYzX1JFR19BTE0xX0RUwqDCoMKgwqDCoMKgwqDCoDx3YnI+MHgwYsKg
wqDCoMKgwqDCoMKgwqAvKiBEYXkgb2YgbW9udGggMS0zMSAqLw0KPGJyPiZndDsgKyNkZWZpbmUg
UENGODUyNjNfUkVHX0FMTTFfTU/CoMKgwqDCoMKgwqDCoMKgPHdicj4weDBjwqDCoMKgwqDCoMKg
wqDCoC8qIE1vbnRoIDEtMTIgKi8NCjxicj4mZ3Q7ICsNCjxicj4mZ3Q7ICsjZGVmaW5lIFBDRjg1
MjYzX1JFR19BTE1fQ1RMwqDCoMKgwqDCoMKgwqDCoDx3YnI+MHgxMA0KPGJyPiZndDsgKyNkZWZp
bmUgUENGODUyNjNfUkVHX0FMTV9DVExfQUxMX0ExRcKgwqA8d2JyPsKgwqDCoMKgwqDCoDB4MWYg
Lyogc2VjLG1pbixocixkYXksbW9uIGFsYXJtIDEgKi8NCjxicj4mZ3Q7ICsNCjxicj4mZ3Q7ICsj
ZGVmaW5lIFBDRjg1MjYzX1JFR19PU0PCoMKgwqDCoMKgwqDCoMKgMHgyNQ0KPGJyPiZndDsgKyNk
ZWZpbmUgUENGODUyNjNfUkVHX09TQ19DTF9NQVNLwqDCoMKgwqDCoMKgPHdicj7CoMKgKEJJVCgw
KSB8IEJJVCgxKSkNCjxicj4mZ3Q7ICsjZGVmaW5lIFBDRjg1MjYzX1JFR19PU0NfQ0xfU0hJRlTC
oMKgwqDCoMKgPHdicj7CoMKgwqAwDQo8YnI+Jmd0OyArI2RlZmluZSBQQ0Y4NTI2M19SRUdfT1ND
X09TQ0RfTUFTS8KgwqDCoMKgPHdicj7CoMKgwqDCoChCSVQoMikgfCBCSVQoMykpDQo8YnI+Jmd0
OyArI2RlZmluZSBQQ0Y4NTI2M19SRUdfT1NDX09TQ0RfU0hJRlTCoMKgwqA8d2JyPsKgwqDCoMKg
wqAyDQo8YnI+Jmd0OyArI2RlZmluZSBQQ0Y4NTI2M19SRUdfT1NDX0xPV0rCoMKgwqDCoMKgwqDC
oMKgwqA8d2JyPsKgwqDCoMKgwqDCoMKgQklUKDQpDQo8YnI+Jmd0OyArI2RlZmluZSBQQ0Y4NTI2
M19SRUdfT1NDXzEySMKgwqDCoMKgwqDCoMKgwqDCoMKgPHdicj7CoMKgwqDCoMKgwqBCSVQoNSkN
Cjxicj4mZ3Q7ICsNCjxicj4mZ3Q7ICsjZGVmaW5lIFBDRjg1MjYzX1JFR19QSU5JT8KgwqDCoMKg
wqDCoMKgwqAweDI3DQo8YnI+Jmd0OyArI2RlZmluZSBQQ0Y4NTI2M19SRUdfUElOSU9fSU5UQVBN
Xzx3YnI+TUFTS8KgwqDCoMKgwqDCoMKgwqAoQklUKDApIHwgQklUKDEpKQ0KPGJyPiZndDsgKyNk
ZWZpbmUgUENGODUyNjNfUkVHX1BJTklPX0lOVEFQTV88d2JyPlNISUZUwqDCoMKgwqDCoMKgwqDC
oDANCjxicj4mZ3Q7ICsjZGVmaW5lIFBDRjg1MjYzX0lOVEFQTV9JTlRBwqDCoMKgwqDCoMKgwqDC
oCg8d2JyPjB4MiAmbHQ7Jmx0OyBQQ0Y4NTI2M19SRUdfUElOSU9fSU5UQVBNXzx3YnI+U0hJRlQp
DQo8YnI+Jmd0OyArI2RlZmluZSBQQ0Y4NTI2M19JTlRBUE1fSElHSFrCoMKgwqDCoMKgwqDCoMKg
KDx3YnI+MHgzICZsdDsmbHQ7IFBDRjg1MjYzX1JFR19QSU5JT19JTlRBUE1fPHdicj5TSElGVCkN
Cjxicj4mZ3Q7ICsjZGVmaW5lIFBDRjg1MjYzX1JFR19QSU5JT19UU1BNX01BU0vCoMKgPHdicj7C
oMKgwqDCoMKgwqAoQklUKDIpIHwgQklUKDMpKQ0KPGJyPiZndDsgKyNkZWZpbmUgUENGODUyNjNf
UkVHX1BJTklPX1RTUE1fU0hJRlTCoDx3YnI+wqDCoMKgwqDCoMKgwqAyDQo8YnI+Jmd0OyArI2Rl
ZmluZSBQQ0Y4NTI2M19UU1BNX0RJU0FCTEVEwqDCoMKgwqDCoMKgwqDCoDx3YnI+wqDCoMKgwqDC
oMKgwqDCoCgweDAgJmx0OyZsdDsgUENGODUyNjNfUkVHX1BJTklPX1RTUE1fU0hJRlQpDQo8YnI+
Jmd0OyArI2RlZmluZSBQQ0Y4NTI2M19UU1BNX0lOVELCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA8
d2JyPsKgwqDCoMKgKDB4MSAmbHQ7Jmx0OyBQQ0Y4NTI2M19SRUdfUElOSU9fVFNQTV9TSElGVCkN
Cjxicj4mZ3Q7ICsjZGVmaW5lIFBDRjg1MjYzX1JFR19QSU5JT19DTEtESVNBQkxFwqA8d2JyPsKg
wqDCoMKgwqDCoMKgQklUKDcpDQo8YnI+Jmd0OyArDQo8YnI+Jmd0OyArI2RlZmluZSBQQ0Y4NTI2
M19SRUdfRlVOQ1RJT07CoMKgwqDCoMKgwqDCoMKgPHdicj4weDI4DQo8YnI+Jmd0OyArI2RlZmlu
ZSBQQ0Y4NTI2M19SRUdfRlVOQ1RJT05fQ09GXzx3YnI+TUFTS8KgwqDCoMKgwqDCoMKgwqAweDcN
Cjxicj4mZ3Q7ICsjZGVmaW5lIFBDRjg1MjYzX1JFR19GVU5DVElPTl9DT0ZfT0ZGwqA8d2JyPsKg
wqDCoMKgwqDCoMKgMHg3wqDCoMKgwqDCoMKgwqDCoC8qIE5vIGNsb2NrIG91dHB1dCAqLw0KPGJy
PiZndDsgKw0KPGJyPiZndDsgKyNkZWZpbmUgUENGODUyNjNfUkVHX0lOVEFfQ1RMwqDCoMKgwqDC
oMKgwqDCoDx3YnI+MHgyOQ0KPGJyPiZndDsgKyNkZWZpbmUgUENGODUyNjNfUkVHX0lOVEJfQ1RM
wqDCoMKgwqDCoMKgwqDCoDx3YnI+MHgyQQ0KPGJyPiZndDsgKyNkZWZpbmUgUENGODUyNjNfUkVH
X0lOVHhfQ1RMX0ExRcKgwqDCoMKgwqA8d2JyPsKgwqDCoEJJVCg0KcKgwqDCoMKgwqDCoMKgwqAv
KiBBbGFybSAxICovDQo8YnI+Jmd0OyArI2RlZmluZSBQQ0Y4NTI2M19SRUdfSU5UeF9DVExfSUxQ
wqDCoMKgwqDCoDx3YnI+wqDCoMKgQklUKDcpwqDCoMKgwqDCoMKgwqDCoC8qIDA9cHVsc2UsIDE9
bGV2ZWwgKi8NCjxicj4mZ3Q7ICsNCjxicj4mZ3Q7ICsjZGVmaW5lIFBDRjg1MjYzX1JFR19GTEFH
U8KgwqDCoMKgwqDCoMKgwqAweDJCDQo8YnI+Jmd0OyArI2RlZmluZSBQQ0Y4NTI2M19SRUdfRkxB
R1NfQTFGwqDCoMKgwqDCoMKgwqDCoDx3YnI+wqDCoMKgwqDCoMKgwqDCoEJJVCg1KQ0KPGJyPiZn
dDsgKw0KPGJyPiZndDsgKyNkZWZpbmUgUENGODUyNjNfUkVHX1JBTV9CWVRFwqDCoMKgwqDCoMKg
wqDCoDx3YnI+MHgyYw0KPGJyPiZndDsgKw0KPGJyPiZndDsgKyNkZWZpbmUgUENGODUyNjNfUkVH
X1NUT1BFTkFCTEUgMHgyZQ0KPGJyPiZndDsgKyNkZWZpbmUgUENGODUyNjNfUkVHX1NUT1BFTkFC
TEVfU1RPUMKgwqA8d2JyPsKgwqDCoMKgwqDCoEJJVCgwKQ0KPGJyPiZndDsgKw0KPGJyPiZndDsg
KyNkZWZpbmUgUENGODUyNjNfUkVHX1JFU0VUwqDCoMKgwqDCoMKgwqDCoDx3YnI+MHgyZsKgwqDC
oMKgwqDCoMKgwqAvKiBSZXNldCBjb21tYW5kICovDQo8YnI+Jmd0OyArI2RlZmluZSBQQ0Y4NTI2
M19SRUdfUkVTRVRfQ01EX0NQUsKgwqDCoMKgPHdicj7CoMKgwqDCoDB4YTTCoMKgwqDCoMKgwqDC
oMKgLyogQ2xlYXIgcHJlc2NhbGVyICovDQo8YnI+Jmd0OyArDQo8YnI+Jmd0OyArI2RlZmluZSBQ
Q0Y4NTI2M19NQVhfUkVHIDB4MmYNCjxicj4mZ3Q7ICsNCjxicj4mZ3Q7ICsjZGVmaW5lIFBDRjg1
MjYzX0hSX1BNwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA8d2JyPkJJVCg1KQ0KPGJy
PiZndDsgKw0KPGJyPiZndDsgK2VudW0gcGNmODUyNjNfaXJxcGluIHsNCjxicj4mZ3Q7ICvCoMKg
wqDCoMKgwqDCoMKgUENGODUyNjNfSVJRUElOX05PTkUsDQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKg
wqDCoFBDRjg1MjYzX0lSUVBJTl9JTlRBLA0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqBQQ0Y4
NTI2M19JUlFQSU5fSU5UQg0KPGJyPiZndDsgK307DQo8YnI+Jmd0OyArDQo8YnI+Jmd0OyArc3Rh
dGljIGNvbnN0IGNoYXIgKmNvbnN0IHBjZjg1MjYzX2lycXBpbl9uYW1lc1tdID0gew0KPGJyPiZn
dDsgK8KgwqDCoMKgwqDCoMKgwqBbUENGODUyNjNfSVJRUElOXzx3YnI+Tk9ORV0gPSAmcXVvdDtO
b25lJnF1b3Q7LA0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqBbUENGODUyNjNfSVJRUElOXzx3
YnI+SU5UQV0gPSAmcXVvdDtJTlRBJnF1b3Q7LA0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqBb
UENGODUyNjNfSVJRUElOXzx3YnI+SU5UQl0gPSAmcXVvdDtJTlRCJnF1b3Q7DQo8YnI+Jmd0OyAr
fTsNCjxicj4mZ3Q7ICsNCjxicj4mZ3Q7ICtzdHJ1Y3QgcGNmODUyNjMgew0KPGJyPiZndDsgK8Kg
wqDCoMKgwqDCoMKgwqBzdHJ1Y3QgZGV2aWNlICpkZXY7DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKg
wqDCoHN0cnVjdCBydGNfZGV2aWNlICpydGM7DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoHN0
cnVjdCByZWdtYXAgKnJlZ21hcDsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgZW51bSBwY2Y4
NTI2M19pcnFwaW4gaXJxX3BpbjsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgaW50IGlycTsN
Cjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgYm9vbCBtb2RlXzEyaDsNCjxicj4mZ3Q7ICt9Ow0K
PGJyPiZndDsgKw0KPGJyPiZndDsgKy8qDQo8YnI+Jmd0OyArICogSGVscGVycyB0byBjb252ZXJ0
IDEyaCB0byAyNGggYW5kIHZpY2UgdmVyc2EuDQo8YnI+Jmd0OyArICogVmFsdWVzIGluIHJlZ2lz
dGVyIGFyZSBzdG9yZWQgaW4gQkNEIHdpdGggYSBQTSBmbGFnIGluIGJpdCA1DQo8YnI+Jmd0OyAr
ICoNCjxicj4mZ3Q7ICsgKiAyMzowMCAmbHQ7PSZndDsgMTFQTSAmbHQ7PSZndDsgMHgzMQ0KPGJy
PiZndDsgKyAqIDAwOjAwICZsdDs9Jmd0OyAxMkFNICZsdDs9Jmd0OyAweDEyDQo8YnI+Jmd0OyAr
ICogMDE6MDAgJmx0Oz0mZ3Q7IDFBTSAmbHQ7PSZndDsgMHgwMQ0KPGJyPiZndDsgKyAqIDEyOjAw
ICZsdDs9Jmd0OyAxMlBNICZsdDs9Jmd0OyAweDMyDQo8YnI+Jmd0OyArICogMTM6MDAgJmx0Oz0m
Z3Q7IDFQTSAmbHQ7PSZndDsgMHgyMQ0KPGJyPiZndDsgKyAqLw0KPGJyPiZndDsgK3N0YXRpYyBp
bnQgcGNmODUyNjNfYmNkMTJoX3RvX2JpbjI0aChpbnQgcmVndmFsKQ0KPGJyPiZndDsgK3sNCjxi
cj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgaW50IGhyID0gYmNkMmJpbihyZWd2YWwgJmFtcDsgMHgx
Zik7DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoGJvb2wgcG0gPSByZWd2YWwgJmFtcDsgUENG
ODUyNjNfSFJfUE07DQo8YnI+Jmd0OyArDQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoGlmICho
ciA9PSAxMikNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVy
biBwbSA/IDEyIDogMDsNCjxicj4mZ3Q7ICsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgcmV0
dXJuIHBtID8gaHIgKyAxMiA6IGhyOw0KPGJyPiZndDsgK30NCjxicj4mZ3Q7ICsNCjxicj4mZ3Q7
ICtzdGF0aWMgaW50IHBjZjg1MjYzX2JpbjI0aF90b19iY2QxMmgoaW50IGhyMjQpDQo8YnI+Jmd0
OyArew0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqBib29sIHBtID0gaHIyNCAmZ3Q7PSAxMjsN
Cjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgaW50IGhyMTIgPSBocjI0ICUgMTI7DQo8YnI+Jmd0
OyArDQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoGlmICghaHIxMikNCjxicj4mZ3Q7ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGhyMTIrKzsNCjxicj4mZ3Q7ICsNCjxicj4mZ3Q7
ICvCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIGJpbjJiY2QoaHIxMikgfCBwbSA/IDAgOiBQQ0Y4NTI2
M19IUl9QTTsNCjxicj4mZ3Q7ICt9DQo8YnI+Jmd0OyArDQo8YnI+Jmd0OyArc3RhdGljIGludCBw
Y2Y4NTI2M19yZWFkX3RpbWUoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgcnRjX3RpbWUgKnRt
KQ0KPGJyPiZndDsgK3sNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgc3RydWN0IHBjZjg1MjYz
ICpwY2Y4NTI2MyA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPGJyPiZndDsgK8KgwqDCoMKgwqDC
oMKgwqBjb25zdCBpbnQgZmlyc3QgPSBQQ0Y4NTI2M19SRUdfUlRDX1NDOw0KPGJyPiZndDsgK8Kg
wqDCoMKgwqDCoMKgwqBjb25zdCBpbnQgbGFzdCA9IFBDRjg1MjYzX1JFR19SVENfWVI7DQo8YnI+
Jmd0OyArwqDCoMKgwqDCoMKgwqDCoGNvbnN0IGludCBsZW4gPSBsYXN0IC0gZmlyc3QgKyAxOw0K
PGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqB1OCByZWdzW2xlbl07DQo8YnI+Jmd0OyArwqDCoMKg
wqDCoMKgwqDCoHU4IGhyX3JlZzsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgaW50IHJldDsN
Cjxicj4mZ3Q7ICsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgcmV0ID0gcmVnbWFwX2J1bGtf
cmVhZChwY2Y4NTI2My0mZ3Q7PHdicj5yZWdtYXAsIGZpcnN0LCByZWdzLCBsZW4pOw0KPGJyPiZn
dDsgK8KgwqDCoMKgwqDCoMKgwqBpZiAocmV0KQ0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsNCjxicj4mZ3Q7ICsNCjxicj4mZ3Q7ICvCoMKgwqDC
oMKgwqDCoMKgaWYgKHJlZ3NbUENGODUyNjNfUkVHX1JUQ19TQyAtIGZpcnN0XSAmYW1wOyBQQ0Y4
NTI2M19SRUdfUlRDX1NDX09TKSB7DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBkZXZfd2FybihkZXYsICZxdW90O09zY2lsbGF0b3Igc3RvcCBkZXRlY3RlZCwgZGF0
ZS90aW1lIGlzIG5vdCByZWxpYWJsZS5cbiZxdW90Oyk7DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVJTlZBTDsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKg
wqDCoMKgfQ0KPGJyPiZndDsgKw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqB0bS0mZ3Q7dG1f
c2VjID0gYmNkMmJpbihyZWdzW1BDRjg1MjYzX1JFR19SVENfPHdicj5TQyAtIGZpcnN0XSAmYW1w
OyAweDdmKTsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgdG0tJmd0O3RtX21pbiA9IGJjZDJi
aW4ocmVnc1tQQ0Y4NTI2M19SRUdfUlRDXzx3YnI+TU4gLSBmaXJzdF0gJmFtcDsgMHg3Zik7DQo8
YnI+Jmd0OyArDQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoGhyX3JlZyA9IHJlZ3NbUENGODUy
NjNfUkVHX1JUQ19IUiAtIGZpcnN0XTsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgaWYgKHBj
Zjg1MjYzLSZndDttb2RlXzEyaCkNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHRtLSZndDt0bV9ob3VyID0gcGNmODUyNjNfYmNkMTJoX3RvX2JpbjI0aChocl88d2Jy
PnJlZyk7DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoGVsc2UNCjxicj4mZ3Q7ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRtLSZndDt0bV9ob3VyID0gYmNkMmJpbihocl9yZWcg
JmFtcDsgMHgzZik7DQo8YnI+Jmd0OyArDQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoHRtLSZn
dDt0bV9tZGF5ID0gYmNkMmJpbihyZWdzW1BDRjg1MjYzX1JFR19SVENfPHdicj5EVCAtIGZpcnN0
XSk7DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoHRtLSZndDt0bV93ZGF5ID0gYmNkMmJpbihy
ZWdzW1BDRjg1MjYzX1JFR19SVENfPHdicj5EVyAtIGZpcnN0XSk7DQo8YnI+Jmd0OyArwqDCoMKg
wqDCoMKgwqDCoHRtLSZndDt0bV9tb24gwqA9IGJjZDJiaW4ocmVnc1tQQ0Y4NTI2M19SRUdfUlRD
Xzx3YnI+TU8gLSBmaXJzdF0pIC0gMTsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgdG0tJmd0
O3RtX3llYXIgPSBiY2QyYmluKHJlZ3NbUENGODUyNjNfUkVHX1JUQ188d2JyPllSIC0gZmlyc3Rd
KTsNCjxicj4mZ3Q7ICsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgdG0tJmd0O3RtX3llYXIg
Kz0gMTAwOyDCoC8qIEFzc3VtZSAyMXN0IGNlbnR1cnkgKi8NCjxicj4mZ3Q7ICsNCjxicj4mZ3Q7
ICvCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7DQo8YnI+Jmd0OyArfQ0KPGJyPiZndDsgKw0KPGJy
PiZndDsgK3N0YXRpYyBpbnQgcGNmODUyNjNfc2V0X3RpbWUoc3RydWN0IGRldmljZSAqZGV2LCBz
dHJ1Y3QgcnRjX3RpbWUgKnRtKQ0KPGJyPiZndDsgK3sNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDC
oMKgc3RydWN0IHBjZjg1MjYzICpwY2Y4NTI2MyA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPGJy
PiZndDsgKw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqAvKg0KPGJyPiZndDsgK8KgwqDCoMKg
wqDCoMKgwqAgKiBCZWZvcmUgc2V0dGluZyB0aW1lIG5lZWQgdG8gc3RvcCBSVEMgYW5kIGRpc2Fi
bGUgcHJlc2NhbGVyDQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoCAqIERvIHRoaXMgYWxsIGlu
IGEgc2luZ2xlIEkyQyB0cmFuc2FjdGlvbiBleHBsb2l0aW5nIHdyYXBhcm91bmQNCjxicj4mZ3Q7
ICvCoMKgwqDCoMKgwqDCoMKgICogYXMgZGVzY3JpYmVkIGluIGRhdGEgc2hlZXQuDQo8YnI+Jmd0
OyArwqDCoMKgwqDCoMKgwqDCoCAqIFRoaXMgbWVhbnMgdGhhdCB0aGUgYXJyYXkgYmVsb3cgbXVz
dCBiZSBpbiByZWdpc3RlciBvcmRlcg0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqAgKi8NCjxi
cj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgdTggcmVnc1tdID0gew0KPGJyPiZndDsgK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgUENGODUyNjNfUkVHXzx3YnI+U1RPUEVOQUJMRV9TVE9Q
LMKgwqDCoMKgwqDCoMKgwqAvKiBTVE9QICovDQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBQQ0Y4NTI2M19SRUdfPHdicj5SRVNFVF9DTURfQ1BSLMKgwqDCoMKgwqDC
oMKgwqAvKiBEaXNhYmxlIHByZXNjYWxlciAqLw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgLyogV3JhcCBhcm91bmQgdG8gcmVnaXN0ZXIgMCAoMS8xMDBzKSAqLw0K
PGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgMCzCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgPHdicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAv
KiAxLzEwMHMgYWx3YXlzIHplcm8uICovDQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBiaW4yYmNkKHRtLSZndDs8d2JyPnRtX3NlYyksDQo8YnI+Jmd0OyArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBiaW4yYmNkKHRtLSZndDs8d2JyPnRtX21pbiksDQo8
YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBiaW4yYmNkKHRtLSZndDs8
d2JyPnRtX2hvdXIpLMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyogMjQtaG91ciAq
Lw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYmluMmJjZCh0bS0m
Z3Q7PHdicj50bV9tZGF5KSwNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGJpbjJiY2QodG0tJmd0Ozx3YnI+dG1fd2RheSArIDEpLA0KPGJyPiZndDsgK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYmluMmJjZCh0bS0mZ3Q7PHdicj50bV9tb24gKyAxKSwN
Cjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJpbjJiY2QodG0tJmd0
Ozx3YnI+dG1feWVhciAlIDEwMCkNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgfTsNCjxicj4m
Z3Q7ICvCoMKgwqDCoMKgwqDCoMKgaW50IHJldDsNCjxicj4mZ3Q7ICsNCjxicj4mZ3Q7ICvCoMKg
wqDCoMKgwqDCoMKgcmV0ID0gcmVnbWFwX2J1bGtfd3JpdGUocGNmODUyNjMtJmd0Ozx3YnI+cmVn
bWFwLCBQQ0Y4NTI2M19SRUdfU1RPUEVOQUJMRSwNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPHdicj7CoMKgwqByZWdz
LCBzaXplb2YocmVncykpOw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqBpZiAocmV0KQ0KPGJy
PiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsNCjxicj4m
Z3Q7ICsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgLyogQXMgd2UgaGF2ZSBzZXQgdGhlIHRp
bWUgaW4gMjRIIHVwZGF0ZSB0aGUgaGFyZHdhcmUgZm9yIHRoYXQgKi8NCjxicj4mZ3Q7ICvCoMKg
wqDCoMKgwqDCoMKgaWYgKHBjZjg1MjYzLSZndDttb2RlXzEyaCkgew0KPGJyPiZndDsgK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGNmODUyNjMtJmd0Ozx3YnI+bW9kZV8xMmggPSBm
YWxzZTsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9IHJl
Z21hcF91cGRhdGVfYml0cyhwY2Y4NTI2My0mZ3Q7PHdicj5yZWdtYXAsIFBDRjg1MjYzX1JFR19P
U0MsDQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoDx3YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBQQ0Y4NTI2M19SRUdf
T1NDXzEySCwgMCk7DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBp
ZiAocmV0KQ0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoDx3YnI+cmV0dXJuIHJldDsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgfQ0K
PGJyPiZndDsgKw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqAvKiBTdGFydCBpdCBhZ2FpbiAq
Lw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmVnbWFwX3dyaXRlKHBjZjg1MjYz
LSZndDtyZWdtYXAsIFBDRjg1MjYzX1JFR19TVE9QRU5BQkxFLCAwKTsNCjxicj4mZ3Q7ICt9DQo8
YnI+Jmd0OyArDQo8YnI+Jmd0OyArc3RhdGljIGludCBwY2Y4NTI2M19lbmFibGVfYWxhcm0oc3Ry
dWN0IHBjZjg1MjYzICpwY2Y4NTI2MywgYm9vbCBlbmFibGUpDQo8YnI+Jmd0OyArew0KPGJyPiZn
dDsgK8KgwqDCoMKgwqDCoMKgwqBpbnQgcmVnOw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqBp
bnQgcmV0Ow0KPGJyPiZndDsgKw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqByZXQgPSByZWdt
YXBfdXBkYXRlX2JpdHMocGNmODUyNjMtJmd0Ozx3YnI+cmVnbWFwLCBQQ0Y4NTI2M19SRUdfQUxN
X0NUTCwNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgPHdicj7CoMKgwqAgUENGODUyNjNfUkVHX0FMTV9DVExfQUxMX0Ex
RSwNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgPHdicj7CoMKgwqAgZW5hYmxlID8gUENGODUyNjNfUkVHX0FMTV9DVExf
QUxMX0ExRSA6IDApOw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqBpZiAocmV0KQ0KPGJyPiZn
dDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsNCjxicj4mZ3Q7
ICsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgc3dpdGNoIChwY2Y4NTI2My0mZ3Q7aXJxX3Bp
bikgew0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqBjYXNlIFBDRjg1MjYzX0lSUVBJTl9OT05F
Og0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7DQo8
YnI+Jmd0OyArDQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoGNhc2UgUENGODUyNjNfSVJRUElO
X0lOVEE6DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZWcgPSBQ
Q0Y4NTI2M19SRUdfSU5UQV9DVEw7DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBicmVhazsNCjxicj4mZ3Q7ICsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgY2Fz
ZSBQQ0Y4NTI2M19JUlFQSU5fSU5UQjoNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHJlZyA9IFBDRjg1MjYzX1JFR19JTlRCX0NUTDsNCjxicj4mZ3Q7ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJyZWFrOw0KPGJyPiZndDsgKw0KPGJyPiZndDsgK8Kg
wqDCoMKgwqDCoMKgwqBkZWZhdWx0Og0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmV0dXJuIC1FSU5WQUw7DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoH0NCjxi
cj4mZ3Q7ICsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJlZ21hcF91cGRhdGVf
Yml0cyhwY2Y4NTI2My0mZ3Q7PHdicj5yZWdtYXAsIHJlZywNCjxicj4mZ3Q7ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPHdicj7CoMKg
wqAgwqBQQ0Y4NTI2M19SRUdfSU5UeF9DVExfQTFFLA0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA8d2JyPsKgwqDCoCDC
oGVuYWJsZSA/IFBDRjg1MjYzX1JFR19JTlR4X0NUTF9BMUUgOiAwKTsNCjxicj4mZ3Q7ICt9DQo8
YnI+Jmd0OyArDQo8YnI+Jmd0OyArc3RhdGljIGludCBwY2Y4NTI2M19yZWFkX2FsYXJtKHN0cnVj
dCBkZXZpY2UgKmRldiwgc3RydWN0IHJ0Y193a2Fscm0gKmFsYXJtKQ0KPGJyPiZndDsgK3sNCjxi
cj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgc3RydWN0IHBjZjg1MjYzICpwY2Y4NTI2MyA9IGRldl9n
ZXRfZHJ2ZGF0YShkZXYpOw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgcnRjX3Rp
bWUgKnRtID0gJmFtcDthbGFybS0mZ3Q7dGltZTsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKg
Y29uc3QgaW50IGZpcnN0ID0gUENGODUyNjNfUkVHX0FMTTFfU0M7DQo8YnI+Jmd0OyArwqDCoMKg
wqDCoMKgwqDCoGNvbnN0IGludCBsYXN0ID0gUENGODUyNjNfUkVHX0FMTTFfTU87DQo8YnI+Jmd0
OyArwqDCoMKgwqDCoMKgwqDCoGNvbnN0IGludCBsZW4gPSBsYXN0IC0gZmlyc3QgKyAxOw0KPGJy
PiZndDsgK8KgwqDCoMKgwqDCoMKgwqB1OCByZWdzW2xlbl07DQo8YnI+Jmd0OyArwqDCoMKgwqDC
oMKgwqDCoHU4IGhyX3JlZzsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgdW5zaWduZWQgaW50
IHJlZ3ZhbDsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgaW50IHJldDsNCjxicj4mZ3Q7ICsN
Cjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgcmV0ID0gcmVnbWFwX2J1bGtfcmVhZChwY2Y4NTI2
My0mZ3Q7PHdicj5yZWdtYXAsIGZpcnN0LCByZWdzLCBsZW4pOw0KPGJyPiZndDsgK8KgwqDCoMKg
wqDCoMKgwqBpZiAocmV0KQ0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcmV0dXJuIHJldDsNCjxicj4mZ3Q7ICsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgdG0t
Jmd0O3RtX3NlYyA9IGJjZDJiaW4ocmVnc1tQQ0Y4NTI2M19SRUdfPHdicj5BTE0xX1NDIC0gZmly
c3RdICZhbXA7IDB4N2YpOw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqB0bS0mZ3Q7dG1fbWlu
ID0gYmNkMmJpbihyZWdzW1BDRjg1MjYzX1JFR188d2JyPkFMTTFfTU4gLSBmaXJzdF0gJmFtcDsg
MHg3Zik7DQo8YnI+Jmd0OyArDQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoGhyX3JlZyA9IHJl
Z3NbUENGODUyNjNfUkVHX0FMTTFfSFIgLSBmaXJzdF07DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKg
wqDCoGlmIChwY2Y4NTI2My0mZ3Q7bW9kZV8xMmgpDQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqB0bS0mZ3Q7dG1faG91ciA9IHBjZjg1MjYzX2JjZDEyaF90b19iaW4y
NGgoaHJfPHdicj5yZWcpOw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqBlbHNlDQo8YnI+Jmd0
OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0bS0mZ3Q7dG1faG91ciA9IGJjZDJi
aW4oaHJfcmVnICZhbXA7IDB4M2YpOw0KPGJyPiZndDsgKw0KPGJyPiZndDsgK8KgwqDCoMKgwqDC
oMKgwqB0bS0mZ3Q7dG1fbWRheSA9IGJjZDJiaW4ocmVnc1tQQ0Y4NTI2M19SRUdfPHdicj5BTE0x
X0RUIC0gZmlyc3RdKTsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgdG0tJmd0O3RtX21vbiDC
oD0gYmNkMmJpbihyZWdzW1BDRjg1MjYzX1JFR188d2JyPkFMTTFfTU8gLSBmaXJzdF0pIC0gMTsN
Cjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgdG0tJmd0O3RtX3llYXIgPSAtMTsNCjxicj4mZ3Q7
ICvCoMKgwqDCoMKgwqDCoMKgdG0tJmd0O3RtX3dkYXkgPSAtMTsNCjxicj4mZ3Q7ICsNCjxicj4m
Z3Q7ICvCoMKgwqDCoMKgwqDCoMKgcmV0ID0gcmVnbWFwX3JlYWQocGNmODUyNjMtJmd0O3JlZ21h
cCwgUENGODUyNjNfUkVHX0FMTV9DVEwsICZhbXA7cmVndmFsKTsNCjxicj4mZ3Q7ICvCoMKgwqDC
oMKgwqDCoMKgaWYgKHJldCkNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHJldHVybiByZXQ7DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoGFsYXJtLSZndDtlbmFi
bGVkID0gISEocmVndmFsICZhbXA7IFBDRjg1MjYzX1JFR19BTE1fQ1RMX0FMTF9BMUUpOw0KPGJy
PiZndDsgKw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqByZXQgPSByZWdtYXBfcmVhZChwY2Y4
NTI2My0mZ3Q7cmVnbWFwLCBQQ0Y4NTI2M19SRUdfRkxBR1MsICZhbXA7cmVndmFsKTsNCjxicj4m
Z3Q7ICvCoMKgwqDCoMKgwqDCoMKgaWYgKHJldCkNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHJldHVybiByZXQ7DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoGFs
YXJtLSZndDtwZW5kaW5nID0gISEocmVndmFsICZhbXA7IFBDRjg1MjYzX1JFR19GTEFHU19BMUYp
Ow0KPGJyPiZndDsgKw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsNCjxicj4m
Z3Q7ICt9DQo8YnI+Jmd0OyArDQo8YnI+Jmd0OyArc3RhdGljIGludCBwY2Y4NTI2M19zZXRfYWxh
cm0oc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgcnRjX3drYWxybSAqYWxhcm0pDQo8YnI+Jmd0
OyArew0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgcGNmODUyNjMgKnBjZjg1MjYz
ID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoHN0cnVj
dCBydGNfdGltZSAqdG0gPSAmYW1wO2FsYXJtLSZndDt0aW1lOw0KPGJyPiZndDsgK8KgwqDCoMKg
wqDCoMKgwqBjb25zdCBpbnQgZmlyc3QgPSBQQ0Y4NTI2M19SRUdfQUxNMV9TQzsNCjxicj4mZ3Q7
ICvCoMKgwqDCoMKgwqDCoMKgY29uc3QgaW50IGxhc3QgPSBQQ0Y4NTI2M19SRUdfQUxNMV9NTzsN
Cjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgY29uc3QgaW50IGxlbiA9IGxhc3QgLSBmaXJzdCAr
IDE7DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoHU4IHJlZ3NbbGVuXTsNCjxicj4mZ3Q7ICvC
oMKgwqDCoMKgwqDCoMKgaW50IHJldDsNCjxicj4mZ3Q7ICsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKg
wqDCoMKgLyogRGlzYWJsZSBhbGFybSBjb21wYXJpc29uIGR1cmluZyB1cGRhdGUgKi8NCjxicj4m
Z3Q7ICvCoMKgwqDCoMKgwqDCoMKgcmV0ID0gcGNmODUyNjNfZW5hYmxlX2FsYXJtKDx3YnI+cGNm
ODUyNjMsIGZhbHNlKTsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgaWYgKHJldCkNCjxicj4m
Z3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiByZXQ7DQo8YnI+Jmd0
OyArDQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoC8qIENsZWFyIGFueSBwZW5kaW5nIGFsYXJt
ICh3cml0ZSAwPSZndDtjbHIsIDE9Jmd0O25vIGNoYW5nZSkgKi8NCjxicj4mZ3Q7ICvCoMKgwqDC
oMKgwqDCoMKgcmV0ID0gcmVnbWFwX3dyaXRlKHBjZjg1MjYzLSZndDtyZWdtYXAsIFBDRjg1MjYz
X1JFR19GTEFHUywNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgwqAgflBDRjg1MjYzX1JFR19GTEFHU19BMUYpOw0KPGJyPiZndDsgK8Kg
wqDCoMKgwqDCoMKgwqBpZiAocmV0KQ0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmV0dXJuIHJldDsNCjxicj4mZ3Q7ICsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDC
oMKgLyogU2V0IHRoZSBhbGFybSB0aW1lIHJlZ2lzdGVycyAqLw0KPGJyPiZndDsgK8KgwqDCoMKg
wqDCoMKgwqByZWdzW1BDRjg1MjYzX1JFR188d2JyPkFMTTFfU0MgLSBmaXJzdF0gPSBiaW4yYmNk
KHRtLSZndDt0bV9zZWMpOw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqByZWdzW1BDRjg1MjYz
X1JFR188d2JyPkFMTTFfTU4gLSBmaXJzdF0gPSBiaW4yYmNkKHRtLSZndDt0bV9taW4pOw0KPGJy
PiZndDsgK8KgwqDCoMKgwqDCoMKgwqByZWdzW1BDRjg1MjYzX1JFR188d2JyPkFMTTFfSFIgLSBm
aXJzdF0gPSBwY2Y4NTI2My0mZ3Q7bW9kZV8xMmggPw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDx3YnI+cGNmODUyNjNfYmluMjRoX3Rv
X2JjZDEyaCh0bS0mZ3Q7PHdicj50bV9ob3VyKSA6DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPHdicj5iaW4yYmNkKHRtLSZndDt0bV9o
b3VyKTsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgcmVnc1tQQ0Y4NTI2M19SRUdfPHdicj5B
TE0xX0RUIC0gZmlyc3RdID0gYmluMmJjZCh0bS0mZ3Q7dG1fbWRheSk7DQo8YnI+Jmd0OyArwqDC
oMKgwqDCoMKgwqDCoHJlZ3NbUENGODUyNjNfUkVHXzx3YnI+QUxNMV9NTyAtIGZpcnN0XSA9IGJp
bjJiY2QodG0tJmd0O3RtX21vbiArIDEpOw0KPGJyPiZndDsgKw0KPGJyPiZndDsgK8KgwqDCoMKg
wqDCoMKgwqByZXQgPSByZWdtYXBfYnVsa193cml0ZShwY2Y4NTI2My0mZ3Q7PHdicj5yZWdtYXAs
IGZpcnN0LCByZWdzLCBzaXplb2YocmVncykpOw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqBp
ZiAocmV0KQ0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJu
IHJldDsNCjxicj4mZ3Q7ICsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgaWYgKGFsYXJtLSZn
dDtlbmFibGVkKQ0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0
ID0gcGNmODUyNjNfZW5hYmxlX2FsYXJtKDx3YnI+cGNmODUyNjMsIHRydWUpOw0KPGJyPiZndDsg
Kw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0Ow0KPGJyPiZndDsgK30NCjxi
cj4mZ3Q7ICsNCjxicj4mZ3Q7ICtzdGF0aWMgaW50IHBjZjg1MjYzX2FsYXJtX2lycV9lbmFibGUo
PHdicj5zdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBlbmFibGUpDQo8YnI+Jmd0OyAr
ew0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgcGNmODUyNjMgKnBjZjg1MjYzID0g
ZGV2X2dldF9kcnZkYXRhKGRldik7DQo8YnI+Jmd0OyArDQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKg
wqDCoHJldHVybiBwY2Y4NTI2M19lbmFibGVfYWxhcm0oPHdicj5wY2Y4NTI2MywgISFlbmFibGUp
Ow0KPGJyPiZndDsgK30NCjxicj4mZ3Q7ICsNCjxicj4mZ3Q7ICtzdGF0aWMgaXJxcmV0dXJuX3Qg
cGNmODUyNjNfaXJxKGludCBpcnEsIHZvaWQgKmRhdGEpDQo8YnI+Jmd0OyArew0KPGJyPiZndDsg
K8KgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgcGNmODUyNjMgKnBjZjg1MjYzID0gZGF0YTsNCjxicj4m
Z3Q7ICvCoMKgwqDCoMKgwqDCoMKgdW5zaWduZWQgaW50IHJlZ3ZhbDsNCjxicj4mZ3Q7ICvCoMKg
wqDCoMKgwqDCoMKgaW50IHJldDsNCjxicj4mZ3Q7ICsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDC
oMKgcmV0ID0gcmVnbWFwX3JlYWQocGNmODUyNjMtJmd0O3JlZ21hcCwgUENGODUyNjNfUkVHX0ZM
QUdTLCAmYW1wO3JlZ3ZhbCk7DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoGlmIChyZXQpDQo8
YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gSVJRX05PTkU7
DQo8YnI+Jmd0OyArDQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoGlmIChyZWd2YWwgJmFtcDsg
UENGODUyNjNfUkVHX0ZMQUdTX0ExRikgew0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcmVnbWFwX3dyaXRlKDx3YnI+cGNmODUyNjMtJmd0O3JlZ21hcCwgUENGODUy
NjNfUkVHX0ZMQUdTLA0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCDCoCDCoCB+UENGODUyNjNfUkVHX0ZMQUdTX0ExRik7DQo8YnI+Jmd0
OyArDQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBydGNfdXBkYXRl
Xzx3YnI+aXJxKHBjZjg1MjYzLSZndDtydGMsIDEsIFJUQ19JUlFGIHwgUlRDX0FGKTsNCjxicj4m
Z3Q7ICsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBJ
UlFfSEFORExFRDsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgfQ0KPGJyPiZndDsgKw0KPGJy
PiZndDsgK8KgwqDCoMKgwqDCoMKgwqByZXR1cm4gSVJRX05PTkU7DQo8YnI+Jmd0OyArfQ0KPGJy
PiZndDsgKw0KPGJyPiZndDsgK3N0YXRpYyBpbnQgcGNmODUyNjNfY2hlY2tfb3NjX3N0b3BwZWQo
PHdicj5zdHJ1Y3QgcGNmODUyNjMgKnBjZjg1MjYzKQ0KPGJyPiZndDsgK3sNCjxicj4mZ3Q7ICvC
oMKgwqDCoMKgwqDCoMKgdW5zaWduZWQgaW50IHJlZ3ZhbDsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKg
wqDCoMKgaW50IHJldDsNCjxicj4mZ3Q7ICsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgcmV0
ID0gcmVnbWFwX3JlYWQocGNmODUyNjMtJmd0O3JlZ21hcCwgUENGODUyNjNfUkVHX1JUQ19TQywg
JmFtcDtyZWd2YWwpOw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqBpZiAocmV0KQ0KPGJyPiZn
dDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsNCjxicj4mZ3Q7
ICsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgcmV0ID0gcmVndmFsICZhbXA7IFBDRjg1MjYz
X1JFR19SVENfU0NfT1MgPyAxIDogMDsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgaWYgKHJl
dCkNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldl93YXJuKDx3
YnI+cGNmODUyNjMtJmd0O2RldiwgJnF1b3Q7T3NjaWxsYXRvciBzdG9wIGRldGVjdGVkLCBkYXRl
L3RpbWUgaXMgbm90IHJlbGlhYmxlLlxuJnF1b3Q7KTsNCjxicj4mZ3Q7ICsNCjxicj4mZ3Q7ICvC
oMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsNCjxicj4mZ3Q7ICt9DQo8YnI+Jmd0OyArDQo8YnI+
Jmd0OyArI2lmZGVmIENPTkZJR19SVENfSU5URl9ERVYNCjxicj4mZ3Q7ICtzdGF0aWMgaW50IHBj
Zjg1MjYzX2lvY3RsKHN0cnVjdCBkZXZpY2UgKmRldiwNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgwqB1bnNpZ25lZCBpbnQgY21kLCB1
bnNpZ25lZCBsb25nIGFyZykNCjxicj4mZ3Q7ICt7DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDC
oHN0cnVjdCBwY2Y4NTI2MyAqcGNmODUyNjMgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCjxicj4m
Z3Q7ICvCoMKgwqDCoMKgwqDCoMKgaW50IHJldDsNCjxicj4mZ3Q7ICsNCjxicj4mZ3Q7ICvCoMKg
wqDCoMKgwqDCoMKgc3dpdGNoIChjbWQpIHsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgY2Fz
ZSBSVENfVkxfUkVBRDoNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHJldCA9IHBjZjg1MjYzX2NoZWNrX29zY19zdG9wcGVkKDx3YnI+cGNmODUyNjMpOw0KPGJyPiZn
dDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHJldCAmbHQ7IDApDQo8YnI+
Jmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPHdi
cj5yZXR1cm4gcmV0Ow0KPGJyPiZndDsgKw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgaWYgKGNvcHlfdG9fdXNlcigodm9pZCBfX3VzZXIgKilhcmcsICZhbXA7cmV0
LCBzaXplb2YoaW50KSkpDQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgPHdicj5yZXR1cm4gLUVGQVVMVDsNCjxicj4mZ3Q7ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAwOw0KPGJyPiZndDsgKw0KPGJyPiZndDsg
K8KgwqDCoMKgwqDCoMKgwqBjYXNlIFJUQ19WTF9DTFI6DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmVnbWFwX3VwZGF0ZV9iaXRzKHBjZjg1MjYzLSZn
dDs8d2JyPnJlZ21hcCwNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPHdicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIMKg
UENGODUyNjNfUkVHX1JUQ19TQywNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPHdicj7CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIMKgUENGODUyNjNfUkVHX1JUQ19TQ19PUywgMCk7DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKg
wqDCoGRlZmF1bHQ6DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBy
ZXR1cm4gLUVOT0lPQ1RMQ01EOw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqB9DQo8YnI+Jmd0
OyArfQ0KPGJyPiZndDsgKyNlbHNlDQo8YnI+Jmd0OyArI2RlZmluZSBwY2Y4NTI2M19pb2N0bCBO
VUxMDQo8YnI+Jmd0OyArI2VuZGlmDQo8YnI+Jmd0OyArDQo8YnI+Jmd0OyArc3RhdGljIGludCBw
Y2Y4NTI2M19pbml0X2h3KHN0cnVjdCBwY2Y4NTI2MyAqcGNmODUyNjMpDQo8YnI+Jmd0OyArew0K
PGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gcGNmODUy
NjMtJmd0O2Rldi0mZ3Q7b2Zfbm9kZTsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgdW5zaWdu
ZWQgaW50IHJlZ3ZhbDsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgdTMyIHByb3B2YWw7DQo8
YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoGludCByZXQ7DQo8YnI+Jmd0OyArDQo8YnI+Jmd0OyAr
wqDCoMKgwqDCoMKgwqDCoC8qIERldGVybWluZSBpZiBvc2NpbGF0b3IgaGFzIGJlZW4gc3RvcHBl
ZCAocHJvYmFibHkgbG93IHBvd2VyKSAqLw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqByZXQg
PSBwY2Y4NTI2M19jaGVja19vc2Nfc3RvcHBlZCg8d2JyPnBjZjg1MjYzKTsNCjxicj4mZ3Q7ICvC
oMKgwqDCoMKgwqDCoMKgaWYgKHJldCAmbHQ7IDApIHsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoC8qIExvZyBoZXJlIHNpbmNlIHRoaXMgaXMgdGhlIGZpcnN0IGh3
IGFjY2VzcyBvbiBwcm9iZSAqLw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgZGV2X2Vycig8d2JyPnBjZjg1MjYzLSZndDtkZXYsICZxdW90O1VuYWJsZSB0byByZWFk
IHJlZ2lzdGVyXG4mcXVvdDspOw0KPGJyPiZndDsgKw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKg
fQ0KPGJyPiZndDsgKw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqAvKiBEZXRlcm1pbmUgMTIv
MjRIIG1vZGUgKi8NCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgcmV0ID0gcmVnbWFwX3JlYWQo
cGNmODUyNjMtJmd0O3JlZ21hcCwgUENGODUyNjNfUkVHX09TQywgJmFtcDtyZWd2YWwpOw0KPGJy
PiZndDsgK8KgwqDCoMKgwqDCoMKgwqBpZiAocmV0KQ0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKg
cGNmODUyNjMtJmd0O21vZGVfMTJoID0gISEocmVndmFsICZhbXA7IFBDRjg1MjYzX1JFR19PU0Nf
MTJIKTsNCjxicj4mZ3Q7ICsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgLyogU2V0IG9zY2ls
YXRvciByZWdpc3RlciAqLw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqByZWd2YWwgJmFtcDs9
IH5QQ0Y4NTI2M19SRUdfT1NDXzEySDsgLyoga2VlcCBjdXJyZW50IDEyLzI0IGggc2V0dGluZyAq
Lw0KPGJyPiZndDsgKw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqBwcm9wdmFsID0gUENGODUy
NjNfUVVBUlRaQ0FQXzEycDVwRjsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgb2ZfcHJvcGVy
dHlfcmVhZF91MzIoPHdicj5ucCwgJnF1b3Q7cXVhcnR6LWxvYWQtY2FwYWNpdGFuY2UmcXVvdDss
ICZhbXA7cHJvcHZhbCk7DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoHJlZ3ZhbCB8PSAoKHBy
b3B2YWwgJmx0OyZsdDsgUENGODUyNjNfUkVHX09TQ19DTF9TSElGVCkNCjxicj4mZ3Q7ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCDCoCDCoCZhbXA7IFBDRjg1MjYzX1JFR19PU0Nf
Q0xfTUFTSyk7DQo8YnI+Jmd0OyArDQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoHByb3B2YWwg
PSBQQ0Y4NTI2M19RVUFSVFpEUklWRV9OT1JNQUw7DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDC
oG9mX3Byb3BlcnR5X3JlYWRfdTMyKDx3YnI+bnAsICZxdW90O3F1YXJ0ei1kcml2ZS1zdHJlbmd0
aCZxdW90OywgJmFtcDtwcm9wdmFsKTsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgcmVndmFs
IHw9ICgocHJvcHZhbCAmbHQ7Jmx0OyBQQ0Y4NTI2M19SRUdfT1NDX09TQ0RfU0hJRlQpDQo8YnI+
Jmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgwqAgwqAmYW1wOyBQQ0Y4NTI2
M19SRUdfT1NDX09TQ0RfTUFTSyk7DQo8YnI+Jmd0OyArDQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKg
wqDCoGlmIChvZl9wcm9wZXJ0eV9yZWFkX2Jvb2wobnAsICZxdW90O3F1YXJ0ei1sb3ctaml0dGVy
JnF1b3Q7KSkNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZ3Zh
bCB8PSBQQ0Y4NTI2M19SRUdfT1NDX0xPV0o7DQo8YnI+Jmd0OyArDQo8YnI+Jmd0OyArwqDCoMKg
wqDCoMKgwqDCoHJldCA9IHJlZ21hcF93cml0ZShwY2Y4NTI2My0mZ3Q7cmVnbWFwLCBQQ0Y4NTI2
M19SRUdfT1NDLCByZWd2YWwpOw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqBpZiAocmV0KQ0K
PGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsNCjxi
cj4mZ3Q7ICsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgLyogU2V0IGZ1bmN0aW9uIHJlZ2lz
dGVyIChSVEMgbW9kZSwgMXMgdGljaywgY2xvY2sgb3V0cHV0IHN0YXRpYykgKi8NCjxicj4mZ3Q7
ICvCoMKgwqDCoMKgwqDCoMKgcmV0ID0gcmVnbWFwX3dyaXRlKHBjZjg1MjYzLSZndDtyZWdtYXAs
IFBDRjg1MjYzX1JFR19GVU5DVElPTiwNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgwqAgUENGODUyNjNfUkVHX0ZVTkNUSU9OX0NPRl9P
RkYpPHdicj47DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoGlmIChyZXQpDQo8YnI+Jmd0OyAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0Ow0KPGJyPiZndDsgKw0K
PGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqAvKiBTZXQgYWxsIGludGVycnVwdHMgdG8gZGlzYWJs
ZWQsIGxldmVsIG1vZGUgKi8NCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgcmV0ID0gcmVnbWFw
X3dyaXRlKHBjZjg1MjYzLSZndDtyZWdtYXAsIFBDRjg1MjYzX1JFR19JTlRBX0NUTCwNCjxicj4m
Z3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgwqAg
UENGODUyNjNfUkVHX0lOVHhfQ1RMX0lMUCk7DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoGlm
IChyZXQpDQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4g
cmV0Ow0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqByZXQgPSByZWdtYXBfd3JpdGUocGNmODUy
NjMtJmd0O3JlZ21hcCwgUENGODUyNjNfUkVHX0lOVEJfQ1RMLA0KPGJyPiZndDsgK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCDCoCBQQ0Y4NTI2M19SRUdf
SU5UeF9DVExfSUxQKTsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgaWYgKHJldCkNCjxicj4m
Z3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiByZXQ7DQo8YnI+Jmd0
OyArDQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoC8qIFNldHVwIElPIHBpbiBjb25maWcgcmVn
aXN0ZXIgKi8NCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgcmVndmFsID0gUENGODUyNjNfUkVH
X1BJTklPX0NMS0RJU0FCTEU7DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoHN3aXRjaCAocGNm
ODUyNjMtJmd0O2lycV9waW4pIHsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgY2FzZSBQQ0Y4
NTI2M19JUlFQSU5fSU5UQToNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHJlZ3ZhbCB8PSAoUENGODUyNjNfSU5UQVBNX0lOVEEgfCBQQ0Y4NTI2M19UU1BNX0RJU0FC
TEVEKTsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJyZWFrOw0K
PGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqBjYXNlIFBDRjg1MjYzX0lSUVBJTl9JTlRCOg0KPGJy
PiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVndmFsIHw9IChQQ0Y4NTI2
M19JTlRBUE1fSElHSFogfCBQQ0Y4NTI2M19UU1BNX0lOVEIpOw0KPGJyPiZndDsgK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnJlYWs7DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDC
oGNhc2UgUENGODUyNjNfSVJRUElOX05PTkU6DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqByZWd2YWwgfD0gKFBDRjg1MjYzX0lOVEFQTV9ISUdIWiB8IFBDRjg1MjYz
X1RTUE1fRElTQUJMRUQpOw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgYnJlYWs7DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoH0NCjxicj4mZ3Q7ICvCoMKgwqDC
oMKgwqDCoMKgcmV0ID0gcmVnbWFwX3dyaXRlKHBjZjg1MjYzLSZndDtyZWdtYXAsIFBDRjg1MjYz
X1JFR19QSU5JTywgcmVndmFsKTsNCjxicj4mZ3Q7ICsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDC
oMKgcmV0dXJuIHJldDsNCjxicj4mZ3Q7ICt9DQo8YnI+Jmd0OyArDQo8YnI+Jmd0OyArc3RhdGlj
IGNvbnN0IHN0cnVjdCBydGNfY2xhc3Nfb3BzIHJ0Y19vcHMgPSB7DQo8YnI+Jmd0OyArwqDCoMKg
wqDCoMKgwqDCoC5pb2N0bCA9IHBjZjg1MjYzX2lvY3RsLA0KPGJyPiZndDsgK8KgwqDCoMKgwqDC
oMKgwqAucmVhZF90aW1lID0gcGNmODUyNjNfcmVhZF90aW1lLA0KPGJyPiZndDsgK8KgwqDCoMKg
wqDCoMKgwqAuc2V0X3RpbWUgPSBwY2Y4NTI2M19zZXRfdGltZSwNCjxicj4mZ3Q7ICvCoMKgwqDC
oMKgwqDCoMKgLnJlYWRfYWxhcm0gPSBwY2Y4NTI2M19yZWFkX2FsYXJtLA0KPGJyPiZndDsgK8Kg
wqDCoMKgwqDCoMKgwqAuc2V0X2FsYXJtID0gcGNmODUyNjNfc2V0X2FsYXJtLA0KPGJyPiZndDsg
K8KgwqDCoMKgwqDCoMKgwqAuYWxhcm1faXJxX2VuYWJsZSA9IHBjZjg1MjYzX2FsYXJtX2lycV9l
bmFibGUsDQo8YnI+Jmd0OyArfTsNCjxicj4mZ3Q7ICsNCjxicj4mZ3Q7ICtzdGF0aWMgY29uc3Qg
c3RydWN0IHJlZ21hcF9jb25maWcgcGNmODUyNjNfcmVnbWFwX2NmZyA9IHsNCjxicj4mZ3Q7ICvC
oMKgwqDCoMKgwqDCoMKgLnJlZ19iaXRzID0gOCwNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKg
LnZhbF9iaXRzID0gOCwNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgLm1heF9yZWdpc3RlciA9
IFBDRjg1MjYzX01BWF9SRUcsDQo8YnI+Jmd0OyArfTsNCjxicj4mZ3Q7ICsNCjxicj4mZ3Q7ICsv
Kg0KPGJyPiZndDsgKyAqIE9uIHNvbWUgYm9hcmRzIHRoZSBpbnRlcnJ1cHQgbGluZSBtYXkgbm90
IGJlIHdpcmVkIHRvIHRoZSBDUFUgYnV0IG9ubHkgdG8NCjxicj4mZ3Q7ICsgKiBhIHBvd2VyIHN1
cHBseSBjaXJjdWl0Lg0KPGJyPiZndDsgKyAqIEluIHRoYXQgY2FzZSBubyBpbnRlcnJ1cHQgd2ls
bCBiZSBzcGVjaWZpZWQgaW4gdGhlIGRldmljZSB0cmVlIGJ1dCB0aGUNCjxicj4mZ3Q7ICsgKiB3
YWtldXAtc291cmNlIERUIHByb3BlcnR5IG1heSBiZSB1c2VkIHRvIGVuYWJsZSB3YWtldXAgcHJv
Z3JhbW1pbmcgaW4NCjxicj4mZ3Q7ICsgKiBzeXNmcw0KPGJyPiZndDsgKyAqLw0KPGJyPiZndDsg
K3N0YXRpYyBib29sIHBjZjg1MjYzX2Nhbl93YWtldXBfbWFjaGluZSg8d2JyPnN0cnVjdCBwY2Y4
NTI2MyAqcGNmODUyNjMpDQo8YnI+Jmd0OyArew0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqBy
ZXR1cm4gcGNmODUyNjMtJmd0O2lycSB8fA0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgb2ZfcHJvcGVydHlfPHdicj5yZWFkX2Jvb2wocGNmODUyNjMtJmd0O2Rldi0m
Z3Q7b2ZfPHdicj5ub2RlLCAmcXVvdDt3YWtldXAtc291cmNlJnF1b3Q7KTsNCjxicj4mZ3Q7ICt9
DQo8YnI+Jmd0OyArDQo8YnI+Jmd0OyArc3RhdGljIGludCBwY2Y4NTI2M19wcm9iZShzdHJ1Y3Qg
aTJjX2NsaWVudCAqY2xpZW50LA0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA8d2JyPsKgwqDCoGNvbnN0IHN0cnVjdCBp
MmNfZGV2aWNlX2lkICppZCkNCjxicj4mZ3Q7ICt7DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDC
oHN0cnVjdCBkZXZpY2UgKmRldiA9ICZhbXA7Y2xpZW50LSZndDtkZXY7DQo8YnI+Jmd0OyArwqDC
oMKgwqDCoMKgwqDCoHN0cnVjdCBwY2Y4NTI2MyAqcGNmODUyNjM7DQo8YnI+Jmd0OyArwqDCoMKg
wqDCoMKgwqDCoGludCByZXQ7DQo8YnI+Jmd0OyArDQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDC
oGlmICghaTJjX2NoZWNrX2Z1bmN0aW9uYWxpdHkoPHdicj5jbGllbnQtJmd0O2FkYXB0ZXIsIEky
Q19GVU5DX0kyQyB8DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDx3YnI+wqDCoMKgIMKgIMKgIEkyQ19GVU5DX1NNQlVT
X0JZVEVfREFUQSB8DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDx3YnI+wqDCoMKgIMKgIMKgIEkyQ19GVU5DX1NNQlVT
X0kyQ19CTE9DSykpDQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBy
ZXR1cm4gLUVOT0RFVjsNCjxicj4mZ3Q7ICsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgcGNm
ODUyNjMgPSBkZXZtX2t6YWxsb2MoZGV2LCBzaXplb2YoKnBjZjg1MjYzKSwgR0ZQX0tFUk5FTCk7
DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoGlmICghcGNmODUyNjMpDQo8YnI+Jmd0OyArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVOT01FTTsNCjxicj4mZ3Q7ICsN
Cjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgcGNmODUyNjMtJmd0O2RldiA9IGRldjsNCjxicj4m
Z3Q7ICvCoMKgwqDCoMKgwqDCoMKgcGNmODUyNjMtJmd0O2lycSA9IGNsaWVudC0mZ3Q7aXJxOw0K
PGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqBkZXZfc2V0X2RydmRhdGEoZGV2LCBwY2Y4NTI2Myk7
DQo8YnI+Jmd0OyArDQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoHBjZjg1MjYzLSZndDtyZWdt
YXAgPSBkZXZtX3JlZ21hcF9pbml0X2kyYyhjbGllbnQsICZhbXA7cGNmODUyNjNfcmVnbWFwX2Nm
Zyk7DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoGlmIChJU19FUlIocGNmODUyNjMtJmd0O3Jl
Z21hcCkpIHsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9
IFBUUl9FUlIocGNmODUyNjMtJmd0O3JlZ21hcCk7DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBkZXZfZXJyKGRldiwgJnF1b3Q7cmVnbWFwIGFsbG9jYXRpb24gZmFp
bGVkICglZClcbiZxdW90OywgcmV0KTsNCjxicj4mZ3Q7ICsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiByZXQ7DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKg
wqDCoH0NCjxicj4mZ3Q7ICsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgLyogRGV0ZXJtaW5l
IHdoaWNoIGludGVycnVwdCBwaW4gdGhlIGJvYXJkIHVzZXMgKi8NCjxicj4mZ3Q7ICvCoMKgwqDC
oMKgwqDCoMKgaWYgKHBjZjg1MjYzX2Nhbl93YWtldXBfbWFjaGluZSg8d2JyPnBjZjg1MjYzKSkg
ew0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKG9mX3Byb3Bl
cnR5X21hdGNoX3N0cmluZyhkZXYtPHdicj4mZ3Q7b2Zfbm9kZSwNCjxicj4mZ3Q7ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPHdicj7C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIMKgIMKgICZxdW90O2ludGVycnVwdC1uYW1lcyZxdW90Oywg
JnF1b3Q7SU5UQiZxdW90OykgJmd0Oz0gMCkNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA8d2JyPnBjZjg1MjYzLSZndDtpcnFfcGluID0g
UENGODUyNjNfSVJRUElOX0lOVEI7DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBlbHNlDQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgPHdicj5wY2Y4NTI2My0mZ3Q7aXJxX3BpbiA9IFBDRjg1MjYzX0lSUVBJ
Tl9JTlRBOw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqB9IGVsc2Ugew0KPGJyPiZndDsgK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGNmODUyNjMtJmd0Ozx3YnI+aXJxX3BpbiA9
IFBDRjg1MjYzX0lSUVBJTl9OT05FOw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqB9DQo8YnI+
Jmd0OyArDQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoHJldCA9IHBjZjg1MjYzX2luaXRfaHco
cGNmODUyNjMpOw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqBpZiAocmV0KQ0KPGJyPiZndDsg
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsNCjxicj4mZ3Q7ICsN
Cjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgaWYgKHBjZjg1MjYzLSZndDtpcnEpIHsNCjxicj4m
Z3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9IGRldm1fcmVxdWVzdF90
aHJlYWRlZF9pcnEoZGV2LCBwY2Y4NTI2My0mZ3Q7aXJxLCBOVUxMLA0KPGJyPiZndDsgK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA8d2Jy
PsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGNmODUyNjNfPHdicj5pcnEs
DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoDx3YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBJ
UlFGXzx3YnI+T05FU0hPVCwNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPHdicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGRldi0mZ3Q7PHdicj5kcml2ZXItJmd0O25hbWUsIHBjZjg1MjYzKTsN
Cjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChyZXQpIHsNCjxi
cj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBk
ZXZfPHdicj5lcnIoZGV2LCAmcXVvdDtpcnEgJWQgdW5hdmFpbGFibGUgKCVkKVxuJnF1b3Q7LA0K
PGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqA8d2JyPsKgwqDCoHBjZjg1MjYzLSZndDtpcnEsIHJldCk7DQo8YnI+Jmd0OyAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPHdicj5wY2Y4
NTI2My0mZ3Q7aXJxID0gMDsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoH0NCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgfQ0KPGJyPiZndDsgKw0KPGJyPiZndDsg
K8KgwqDCoMKgwqDCoMKgwqBpZiAocGNmODUyNjNfY2FuX3dha2V1cF9tYWNoaW5lKDx3YnI+cGNm
ODUyNjMpKQ0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2aWNl
X2luaXRfPHdicj53YWtldXAoZGV2LCB0cnVlKTsNCjxicj4mZ3Q7ICsNCjxicj4mZ3Q7ICvCoMKg
wqDCoMKgwqDCoMKgcGNmODUyNjMtJmd0O3J0YyA9IGRldm1fcnRjX2RldmljZV9yZWdpc3Rlcihk
ZXYsIGRldi0mZ3Q7ZHJpdmVyLSZndDtuYW1lLA0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA8d2JyPsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZhbXA7cnRjX29wcywgVEhJU19NT0RVTEUpOw0K
PGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqByZXQgPSBQVFJfRVJSX09SX1pFUk8ocGNmODUyNjMt
Jmd0O3J0Yyk8d2JyPjsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgaWYgKHJldCkNCjxicj4m
Z3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiByZXQ7DQo8YnI+Jmd0
OyArDQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoC8qIFdlIGNhbm5vdCBzdXBwb3J0IFVJRSBt
b2RlIGlmIHdlIGRvIG5vdCBoYXZlIGFuIElSUSBsaW5lICovDQo8YnI+Jmd0OyArwqDCoMKgwqDC
oMKgwqDCoGlmICghcGNmODUyNjMtJmd0O2lycSkNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHBjZjg1MjYzLSZndDs8d2JyPnJ0Yy0mZ3Q7dWllX3Vuc3VwcG9ydGVk
ID0gMTsNCjxicj4mZ3Q7ICsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgZGV2X2luZm8ocGNm
ODUyNjMtJmd0Ozx3YnI+ZGV2LA0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICZxdW90O1BDRjg1MjYzIFJUQyAoaXJxcGluPSVzIGlycT0lZClcbiZxdW90OywNCjxi
cj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwY2Y4NTI2M19pcnFwaW5f
bmFtZXNbPHdicj5wY2Y4NTI2My0mZ3Q7aXJxX3Bpbl0sDQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgcGNmODUyNjMtJmd0O2lycSk7DQo8YnI+Jmd0OyArDQo8YnI+
Jmd0OyArwqDCoMKgwqDCoMKgwqDCoHJldHVybiAwOw0KPGJyPiZndDsgK30NCjxicj4mZ3Q7ICsN
Cjxicj4mZ3Q7ICtzdGF0aWMgaW50IHBjZjg1MjYzX3JlbW92ZShzdHJ1Y3QgaTJjX2NsaWVudCAq
Y2xpZW50KQ0KPGJyPiZndDsgK3sNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgc3RydWN0IHBj
Zjg1MjYzICpwY2Y4NTI2MyA9IGkyY19nZXRfY2xpZW50ZGF0YShjbGllbnQpOw0KPGJyPiZndDsg
Kw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqBpZiAocGNmODUyNjNfY2FuX3dha2V1cF9tYWNo
aW5lKDx3YnI+cGNmODUyNjMpKQ0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgZGV2aWNlX2luaXRfPHdicj53YWtldXAocGNmODUyNjMtJmd0O2RldiwgZmFsc2UpOw0K
PGJyPiZndDsgKw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsNCjxicj4mZ3Q7
ICt9DQo8YnI+Jmd0OyArDQo8YnI+Jmd0OyArI2lmZGVmIENPTkZJR19QTV9TTEVFUA0KPGJyPiZn
dDsgK3N0YXRpYyBpbnQgcGNmODUyNjNfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo8YnI+
Jmd0OyArew0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgcGNmODUyNjMgKnBjZjg1
MjYzID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoGlu
dCByZXQgPSAwOw0KPGJyPiZndDsgKw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqBpZiAoZGV2
aWNlX21heV93YWtldXAoZGV2KSkNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHJldCA9IGVuYWJsZV9pcnFfd2FrZShwY2Y4NTI2My0mZ3Q7aXJxKTx3YnI+Ow0KPGJy
PiZndDsgKw0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0Ow0KPGJyPiZndDsg
K30NCjxicj4mZ3Q7ICsNCjxicj4mZ3Q7ICtzdGF0aWMgaW50IHBjZjg1MjYzX3Jlc3VtZShzdHJ1
Y3QgZGV2aWNlICpkZXYpDQo8YnI+Jmd0OyArew0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqBz
dHJ1Y3QgcGNmODUyNjMgKnBjZjg1MjYzID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo8YnI+Jmd0
OyArwqDCoMKgwqDCoMKgwqDCoGludCByZXQgPSAwOw0KPGJyPiZndDsgKw0KPGJyPiZndDsgK8Kg
wqDCoMKgwqDCoMKgwqBpZiAoZGV2aWNlX21heV93YWtldXAoZGV2KSkNCjxicj4mZ3Q7ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9IGRpc2FibGVfaXJxX3dha2UocGNmODUy
NjMtJmd0Ozx3YnI+aXJxKTsNCjxicj4mZ3Q7ICsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKg
cmV0dXJuIHJldDsNCjxicj4mZ3Q7ICt9DQo8YnI+Jmd0OyArDQo8YnI+Jmd0OyArI2VuZGlmDQo8
YnI+Jmd0OyArDQo8YnI+Jmd0OyArc3RhdGljIGNvbnN0IHN0cnVjdCBpMmNfZGV2aWNlX2lkIHBj
Zjg1MjYzX2lkW10gPSB7DQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoHsgJnF1b3Q7cGNmODUy
NjMmcXVvdDssIDAgfSwNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgeyB9DQo8YnI+Jmd0OyAr
fTsNCjxicj4mZ3Q7ICtNT0RVTEVfREVWSUNFX1RBQkxFKGkyYywgcGNmODUyNjNfaWQpOw0KPGJy
PiZndDsgKw0KPGJyPiZndDsgKyNpZmRlZiBDT05GSUdfT0YNCjxicj4mZ3Q7ICtzdGF0aWMgY29u
c3Qgc3RydWN0IG9mX2RldmljZV9pZCBwY2Y4NTI2M19vZl9tYXRjaFtdID0gew0KPGJyPiZndDsg
K8KgwqDCoMKgwqDCoMKgwqB7IC5jb21wYXRpYmxlID0gJnF1b3Q7bnhwLHBjZjg1MjYzJnF1b3Q7
IH0sDQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoHt9DQo8YnI+Jmd0OyArfTsNCjxicj4mZ3Q7
ICtNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBwY2Y4NTI2M19vZl9tYXRjaCk7DQo8YnI+Jmd0OyAr
I2VuZGlmDQo8YnI+Jmd0OyArDQo8YnI+Jmd0OyArc3RhdGljIFNJTVBMRV9ERVZfUE1fT1BTKHBj
Zjg1MjYzX3BtXzx3YnI+b3BzLCBwY2Y4NTI2M19zdXNwZW5kLCDCoHBjZjg1MjYzX3Jlc3VtZSk7
DQo8YnI+Jmd0OyArDQo8YnI+Jmd0OyArc3RhdGljIHN0cnVjdCBpMmNfZHJpdmVyIHBjZjg1MjYz
X2RyaXZlciA9IHsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgLmRyaXZlcsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqA8d2JyPsKgwqA9IHsNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoC5uYW1lwqDCoMKgwqDCoMKgwqDCoDx3YnI+PSAmcXVvdDtydGMtcGNm
ODUyNjMmcXVvdDssDQo8YnI+Jmd0OyArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAu
b2ZfbWF0Y2hfPHdicj50YWJsZSA9IG9mX21hdGNoX3B0cihwY2Y4NTI2M19vZl88d2JyPm1hdGNo
KSwNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5wbSA9ICZhbXA7
cGNmODUyNjNfcG1fb3BzLA0KPGJyPiZndDsgK8KgwqDCoMKgwqDCoMKgwqB9LA0KPGJyPiZndDsg
K8KgwqDCoMKgwqDCoMKgwqAucHJvYmXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA8d2Jy
PsKgPSBwY2Y4NTI2M19wcm9iZSwNCjxicj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgLnJlbW92ZcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA8d2JyPsKgwqA9IHBjZjg1MjYzX3JlbW92ZSwNCjxi
cj4mZ3Q7ICvCoMKgwqDCoMKgwqDCoMKgLmlkX3RhYmxlwqDCoMKgwqDCoMKgwqDCoD0gcGNmODUy
NjNfaWQsDQo8YnI+Jmd0OyArfTsNCjxicj4mZ3Q7ICsNCjxicj4mZ3Q7ICttb2R1bGVfaTJjX2Ry
aXZlcihwY2Y4NTI2M188d2JyPmRyaXZlcik7DQo8YnI+Jmd0OyArDQo8YnI+Jmd0OyArTU9EVUxF
X0FVVEhPUigmcXVvdDtNYXJ0aW4gRnV6emV5ICZsdDs8YSBocmVmPSJqYXZhc2NyaXB0OiIgdGFy
Z2V0PSJfYmxhbmsiIGdkZi1vYmZ1c2NhdGVkLW1haWx0bz0iTUFfOHpoMVpGQUFKIiByZWw9Im5v
Zm9sbG93IiBvbm1vdXNlZG93bj0idGhpcy5ocmVmPSYjMzk7amF2YXNjcmlwdDomIzM5OztyZXR1
cm4gdHJ1ZTsiIG9uY2xpY2s9InRoaXMuaHJlZj0mIzM5O2phdmFzY3JpcHQ6JiMzOTs7cmV0dXJu
IHRydWU7Ij5tZnUuLi5AcGFya2Vvbi5jb208L2E+Jmd0OyZxdW90Oyk7DQo8YnI+Jmd0OyArTU9E
VUxFX0RFU0NSSVBUSU9OKCZxdW90O1BDRjg1MjYzIFJUQyBEcml2ZXImcXVvdDspOw0KPGJyPiZn
dDsgK01PRFVMRV9MSUNFTlNFKCZxdW90O0dQTCZxdW90Oyk7DQo8YnI+Jmd0OyANCjxicj4NCjxi
cj4tLSANCjxicj5BbGV4YW5kcmUgQmVsbG9uaSwgRnJlZSBFbGVjdHJvbnMNCjxicj5FbWJlZGRl
ZCBMaW51eCBhbmQgS2VybmVsIGVuZ2luZWVyaW5nDQo8YnI+PGEgaHJlZj0iaHR0cDovL2ZyZWUt
ZWxlY3Ryb25zLmNvbSIgdGFyZ2V0PSJfYmxhbmsiIHJlbD0ibm9mb2xsb3ciIG9ubW91c2Vkb3du
PSJ0aGlzLmhyZWY9JiMzOTtodHRwOi8vd3d3Lmdvb2dsZS5jb20vdXJsP3FceDNkaHR0cCUzQSUy
RiUyRmZyZWUtZWxlY3Ryb25zLmNvbVx4MjZzYVx4M2REXHgyNnNudHpceDNkMVx4MjZ1c2dceDNk
QUZRakNOR0M4QzlwVDd4S0pFYWJJVExHTDVjcXRvbGlmUSYjMzk7O3JldHVybiB0cnVlOyIgb25j
bGljaz0idGhpcy5ocmVmPSYjMzk7aHR0cDovL3d3dy5nb29nbGUuY29tL3VybD9xXHgzZGh0dHAl
M0ElMkYlMkZmcmVlLWVsZWN0cm9ucy5jb21ceDI2c2FceDNkRFx4MjZzbnR6XHgzZDFceDI2dXNn
XHgzZEFGUWpDTkdDOEM5cFQ3eEtKRWFiSVRMR0w1Y3F0b2xpZlEmIzM5OztyZXR1cm4gdHJ1ZTsi
Pmh0dHA6Ly9mcmVlLWVsZWN0cm9ucy5jb208L2E+DQo8YnI+PC9ibG9ja3F1b3RlPjwvZGl2Pjwv
ZGl2Pg0KDQo8cD48L3A+CgotLSA8YnIgLz4KWW91IHJlY2VpdmVkIHRoaXMgbWVzc2FnZSBiZWNh
dXNlIHlvdSBhcmUgc3Vic2NyaWJlZCB0byAmcXVvdDtydGMtbGludXgmcXVvdDsuPGJyIC8+DQpN
ZW1iZXJzaGlwIG9wdGlvbnMgYXQgPGEgaHJlZj0iaHR0cDovL2dyb3Vwcy5nb29nbGUuY29tL2dy
b3VwL3J0Yy1saW51eCI+aHR0cDovL2dyb3Vwcy5nb29nbGUuY29tL2dyb3VwL3J0Yy1saW51eDwv
YT4gLjxiciAvPg0KUGxlYXNlIHJlYWQgPGEgaHJlZj0iaHR0cDovL2dyb3Vwcy5nb29nbGUuY29t
L2dyb3VwL3J0Yy1saW51eC93ZWIvY2hlY2tsaXN0Ij5odHRwOi8vZ3JvdXBzLmdvb2dsZS5jb20v
Z3JvdXAvcnRjLWxpbnV4L3dlYi9jaGVja2xpc3Q8L2E+PGJyIC8+DQpiZWZvcmUgc3VibWl0dGlu
ZyBhIGRyaXZlci48YnIgLz4KLS0tIDxiciAvPgpZb3UgcmVjZWl2ZWQgdGhpcyBtZXNzYWdlIGJl
Y2F1c2UgeW91IGFyZSBzdWJzY3JpYmVkIHRvIHRoZSBHb29nbGUgR3JvdXBzICZxdW90O3J0Yy1s
aW51eCZxdW90OyBncm91cC48YnIgLz4KVG8gdW5zdWJzY3JpYmUgZnJvbSB0aGlzIGdyb3VwIGFu
ZCBzdG9wIHJlY2VpdmluZyBlbWFpbHMgZnJvbSBpdCwgc2VuZCBhbiBlbWFpbCB0byA8YSBocmVm
PSJtYWlsdG86cnRjLWxpbnV4K3Vuc3Vic2NyaWJlQGdvb2dsZWdyb3Vwcy5jb20iPnJ0Yy1saW51
eCt1bnN1YnNjcmliZUBnb29nbGVncm91cHMuY29tPC9hPi48YnIgLz4KRm9yIG1vcmUgb3B0aW9u
cywgdmlzaXQgPGEgaHJlZj0iaHR0cHM6Ly9ncm91cHMuZ29vZ2xlLmNvbS9kL29wdG91dCI+aHR0
cHM6Ly9ncm91cHMuZ29vZ2xlLmNvbS9kL29wdG91dDwvYT4uPGJyIC8+Cg==
------=_Part_4632_1763001965.1489598915114--

------=_Part_4631_234418101.1489598915112--
