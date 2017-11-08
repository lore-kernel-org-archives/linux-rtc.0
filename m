Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:54113 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753029AbdKHF3W (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 8 Nov 2017 00:29:22 -0500
Received: by mail-oi0-f65.google.com with SMTP id h6so1143715oia.10
        for <linux-rtc@vger.kernel.org>; Tue, 07 Nov 2017 21:29:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171108034409.cm65hvuhz67hmz3b@piout.net>
References: <7037c5053a533505f38fc036290a398989cfdafc.1510051749.git.baolin.wang@spreadtrum.com>
 <b053858c3325e7c35436f35adf09b5df90106d42.1510051749.git.baolin.wang@spreadtrum.com>
 <20171108034409.cm65hvuhz67hmz3b@piout.net>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Wed, 8 Nov 2017 13:29:21 +0800
Message-ID: <CAMz4kuK=7W7t63Axi=jcqLPYz-L=MF=uE-8rNNf9LhqP1E=hXw@mail.gmail.com>
Subject: Re: [PATCH 2/2] rtc: sprd: Add Spreadtrum RTC driver
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Baolin Wang <baolin.wang@spreadtrum.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-rtc@vger.kernel.org, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi Alexandre,

On 8 November 2017 at 11:44, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Hi,
>
> On 07/11/2017 at 19:34:08 +0800, Baolin Wang wrote:
>> This patch adds the Spreadtrum RTC driver, which embedded in the
>> Spreadtrum SC27xx PMIC series.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@spreadtrum.com>
>> ---
>>  drivers/rtc/Kconfig    |    7 +
>>  drivers/rtc/Makefile   |    1 +
>>  drivers/rtc/rtc-sprd.c |  673 ++++++++++++++++++++++++++++++++++++++++++++++++
>
> I would prefer that filename to be more specific. What if at some point
> one of your SoC includes an RTC that is not handled by this driver. This
> will become a naming nightmare.

Make sense, I will change the filename to 'rtc-sc27xx.c'.

>
>>  3 files changed, 681 insertions(+)
>>  create mode 100644 drivers/rtc/rtc-sprd.c
>>
>> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
>> index e0e58f3..c3059fa 100644
>> --- a/drivers/rtc/Kconfig
>> +++ b/drivers/rtc/Kconfig
>> @@ -1182,6 +1182,13 @@ config RTC_DRV_SPEAR
>>        If you say Y here you will get support for the RTC found on
>>        spear
>>
>> +config RTC_DRV_SPRD
>> +     tristate "Spreadtrum SC27xx RTC"
>> +     depends on ARCH_SPRD || COMPILE_TEST
>
> the commit message says this is a PMIC RTC, not a SoC RTC. I don't think
> you need to depend on ARCH_SPRD. But you probably need to depend on the
> MFD parent.

Right. Will fix it in next version.

>
>> +     help
>> +      If you say Y here you will get support for the RTC found on
>> +      Spreadtrum.
>
> Be mor precise here.

OK.

>
>> +
>>  config RTC_DRV_PCF50633
>>       depends on MFD_PCF50633
>>       tristate "NXP PCF50633 RTC"
>> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
>> index 7230014..ec5cb75 100644
>> --- a/drivers/rtc/Makefile
>> +++ b/drivers/rtc/Makefile
>> @@ -147,6 +147,7 @@ obj-$(CONFIG_RTC_DRV_SH)  += rtc-sh.o
>>  obj-$(CONFIG_RTC_DRV_SIRFSOC)        += rtc-sirfsoc.o
>>  obj-$(CONFIG_RTC_DRV_SNVS)   += rtc-snvs.o
>>  obj-$(CONFIG_RTC_DRV_SPEAR)  += rtc-spear.o
>> +obj-$(CONFIG_RTC_DRV_SPRD)   += rtc-sprd.o
>>  obj-$(CONFIG_RTC_DRV_STARFIRE)       += rtc-starfire.o
>>  obj-$(CONFIG_RTC_DRV_STK17TA8)       += rtc-stk17ta8.o
>>  obj-$(CONFIG_RTC_DRV_STM32)  += rtc-stm32.o
>> diff --git a/drivers/rtc/rtc-sprd.c b/drivers/rtc/rtc-sprd.c
>> new file mode 100644
>> index 0000000..6b2477f
>> --- /dev/null
>> +++ b/drivers/rtc/rtc-sprd.c
>> @@ -0,0 +1,673 @@
>> +/*
>> + * Copyright (C) 2017 Spreadtrum Communications Inc.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0
>> + */
>> +
>> +#include <linux/bitops.h>
>> +#include <linux/delay.h>
>> +#include <linux/err.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/rtc.h>
>> +
>> +#define SPRD_RTC_SEC_CNT_VALUE               0x0
>> +#define SPRD_RTC_MIN_CNT_VALUE               0x4
>> +#define SPRD_RTC_HOUR_CNT_VALUE              0x8
>> +#define SPRD_RTC_DAY_CNT_VALUE               0xc
>> +#define SPRD_RTC_SEC_CNT_UPD         0x10
>> +#define SPRD_RTC_MIN_CNT_UPD         0x14
>> +#define SPRD_RTC_HOUR_CNT_UPD                0x18
>> +#define SPRD_RTC_DAY_CNT_UPD         0x1c
>> +#define SPRD_RTC_SEC_ALM_UPD         0x20
>> +#define SPRD_RTC_MIN_ALM_UPD         0x24
>> +#define SPRD_RTC_HOUR_ALM_UPD                0x28
>> +#define SPRD_RTC_DAY_ALM_UPD         0x2c
>> +#define SPRD_RTC_INT_EN                      0x30
>> +#define SPRD_RTC_INT_RAW_STS         0x34
>> +#define SPRD_RTC_INT_CLR             0x38
>> +#define SPRD_RTC_INT_MASK_STS                0x3C
>> +#define SPRD_RTC_SEC_ALM_VALUE               0x40
>> +#define SPRD_RTC_MIN_ALM_VALUE               0x44
>> +#define SPRD_RTC_HOUR_ALM_VALUE              0x48
>> +#define SPRD_RTC_DAY_ALM_VALUE               0x4c
>> +#define SPRD_RTC_SPG_VALUE           0x50
>> +#define SPRD_RTC_SPG_UPD             0x54
>> +#define SPRD_RTC_SEC_AUXALM_UPD              0x60
>> +#define SPRD_RTC_MIN_AUXALM_UPD              0x64
>> +#define SPRD_RTC_HOUR_AUXALM_UPD     0x68
>> +#define SPRD_RTC_DAY_AUXALM_UPD              0x6c
>> +
>> +/* BIT & MASK definition for SPRD_RTC_INT_* registers */
>> +#define SPRD_RTC_SEC_EN                      BIT(0)
>> +#define SPRD_RTC_MIN_EN                      BIT(1)
>> +#define SPRD_RTC_HOUR_EN             BIT(2)
>> +#define SPRD_RTC_DAY_EN                      BIT(3)
>> +#define SPRD_RTC_ALARM_EN            BIT(4)
>> +#define SPRD_RTC_HRS_FORMAT_EN               BIT(5)
>> +#define SPRD_RTC_AUXALM_EN           BIT(6)
>> +#define SPRD_RTC_SPG_UPD_EN          BIT(7)
>> +#define SPRD_RTC_SEC_UPD_EN          BIT(8)
>> +#define SPRD_RTC_MIN_UPD_EN          BIT(9)
>> +#define SPRD_RTC_HOUR_UPD_EN         BIT(10)
>> +#define SPRD_RTC_DAY_UPD_EN          BIT(11)
>> +#define SPRD_RTC_ALMSEC_UPD_EN               BIT(12)
>> +#define SPRD_RTC_ALMMIN_UPD_EN               BIT(13)
>> +#define SPRD_RTC_ALMHOUR_UPD_EN              BIT(14)
>> +#define SPRD_RTC_ALMDAY_UPD_EN               BIT(15)
>> +#define SPRD_RTC_INT_MASK            GENMASK(15, 0)
>> +
>> +#define SPRD_RTC_TIME_INT_MASK                               \
>> +     (SPRD_RTC_SEC_UPD_EN | SPRD_RTC_MIN_UPD_EN |    \
>> +      SPRD_RTC_HOUR_UPD_EN | SPRD_RTC_DAY_UPD_EN)
>> +
>> +#define SPRD_RTC_ALMTIME_INT_MASK                            \
>> +     (SPRD_RTC_ALMSEC_UPD_EN | SPRD_RTC_ALMMIN_UPD_EN |      \
>> +      SPRD_RTC_ALMHOUR_UPD_EN | SPRD_RTC_ALMDAY_UPD_EN)
>> +
>> +#define SPRD_RTC_ALM_INT_MASK                        \
>> +     (SPRD_RTC_SEC_EN | SPRD_RTC_MIN_EN |    \
>> +      SPRD_RTC_HOUR_EN | SPRD_RTC_DAY_EN |   \
>> +      SPRD_RTC_ALARM_EN | SPRD_RTC_AUXALM_EN)
>> +
>> +/* second/minute/hour/day values mask definition */
>> +#define SPRD_RTC_SEC_MASK            GENMASK(5, 0)
>> +#define SPRD_RTC_MIN_MASK            GENMASK(5, 0)
>> +#define SPRD_RTC_HOUR_MASK           GENMASK(4, 0)
>> +#define SPRD_RTC_DAY_MASK            GENMASK(15, 0)
>> +
>> +/* alarm lock definition for SPRD_RTC_SPG_UPD register */
>> +#define SPRD_RTC_ALMLOCK_MASK                GENMASK(7, 0)
>> +#define SPRD_RTC_ALM_UNLOCK          0xa5
>> +#define SPRD_RTC_ALM_LOCK            (~SPRD_RTC_ALM_UNLOCK & SPRD_RTC_ALMLOCK_MASK)
>> +
>> +/* SPG values definition for SPRD_RTC_SPG_UPD register */
>> +#define SPRD_RTC_POWEROFF_ALM_FLAG   BIT(8)
>> +#define SPRD_RTC_POWER_RESET_FLAG    BIT(9)
>> +
>> +/* timeout of synchronizing time and alarm registers (us) */
>> +#define SPRD_RTC_POLL_TIMEOUT                200000
>> +#define SPRD_RTC_POLL_DELAY_US               20000
>> +#define SPRD_RTC_START_YEAR          2017
>> +
>> +struct sprd_rtc {
>> +     struct rtc_device       *rtc;
>> +     struct regmap           *regmap;
>> +     struct device           *dev;
>> +     u32                     base;
>> +     int                     irq;
>> +};
>> +
>> +/*
>> + * The Spreadtrum RTC controller has 3 groups registers, including time, normal
>> + * alarm and auxiliary alarm. The time group registers are used to set RTC time,
>> + * the normal alarm registers are used to set normal alarm, and the auxiliary
>> + * alarm registers are used to set auxiliary alarm. Both alarm event and
>> + * auxiliary alarm event can wake up system from deep sleep, but only alarm
>> + * event can power up system from power down status.
>> + */
>> +enum sprd_rtc_reg_types {
>> +     SPRD_RTC_TIME,
>> +     SPRD_RTC_ALARM,
>> +     SPRD_RTC_AUX_ALARM,
>> +};
>> +
>> +static int sprd_rtc_read(struct sprd_rtc *rtc, u32 reg, u32 *val)
>> +{
>> +     return regmap_read(rtc->regmap, rtc->base + reg, val);
>> +}
>> +
>> +static int sprd_rtc_write(struct sprd_rtc *rtc, u32 reg, u32 val)
>> +{
>> +     return regmap_write(rtc->regmap, rtc->base + reg, val);
>> +}
>> +
>> +static int sprd_rtc_update(struct sprd_rtc *rtc, u32 reg, u32 mask, u32 val)
>> +{
>> +     return regmap_update_bits(rtc->regmap, rtc->base + reg, mask, val);
>> +}
>> +
>> +static int sprd_rtc_read_poll(struct sprd_rtc *rtc, u32 reg, u32 mask)
>> +{
>> +     u32 val;
>> +
>> +     return regmap_read_poll_timeout(rtc->regmap, rtc->base + reg, val,
>> +                                     ((val & mask) == mask),
>> +                                     SPRD_RTC_POLL_DELAY_US,
>> +                                     SPRD_RTC_POLL_TIMEOUT);
>> +}
>> +
>
> All those functions are only wrappers around regmap, they are useless,
> please use regmap_* directly.

OK, I will do as you suggested.

>> +static int sprd_rtc_read_aux_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>> +{
>> +     struct sprd_rtc *rtc = dev_get_drvdata(dev);
>> +     time64_t secs;
>> +     u32 val;
>> +     int ret;
>> +
>> +     ret = sprd_rtc_get_secs(rtc, SPRD_RTC_AUX_ALARM, &secs);
>> +     if (ret)
>> +             return ret;
>> +
>> +     rtc_time64_to_tm(secs, &alrm->time);
>> +
>> +     ret = sprd_rtc_read(rtc, SPRD_RTC_INT_EN, &val);
>> +     if (ret)
>> +             return ret;
>> +
>> +     alrm->enabled = !!(val & SPRD_RTC_AUXALM_EN);
>> +
>> +     ret = sprd_rtc_read(rtc, SPRD_RTC_INT_RAW_STS, &val);
>> +     if (ret)
>> +             return ret;
>> +
>> +     alrm->pending = !!(val & SPRD_RTC_AUXALM_EN);
>> +     return 0;
>> +}
>> +
>> +static int sprd_rtc_set_aux_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>> +{
>> +     struct sprd_rtc *rtc = dev_get_drvdata(dev);
>> +     int ret;
>> +
>> +     /* clear the auxiliary alarm interrupt status */
>> +     ret = sprd_rtc_write(rtc, SPRD_RTC_INT_CLR, SPRD_RTC_AUXALM_EN);
>> +     if (ret)
>> +             return ret;
>> +
>> +     if (alrm->enabled) {
>> +             time64_t secs = rtc_tm_to_time64(&alrm->time);
>> +
>> +             /* enable the auxiliary alarm interrupt */
>> +             ret = sprd_rtc_update(rtc, SPRD_RTC_INT_EN, SPRD_RTC_AUXALM_EN,
>> +                                   SPRD_RTC_AUXALM_EN);
>> +             if (ret)
>> +                     return ret;
>> +
>> +             ret = sprd_rtc_set_secs(rtc, SPRD_RTC_AUX_ALARM, secs);
>> +             if (ret) {
>> +                     sprd_rtc_update(rtc, SPRD_RTC_INT_EN,
>> +                                     SPRD_RTC_AUXALM_EN, 0);
>> +             }
>> +     } else {
>> +             /* disable the auxiliary alarm interrupt */
>> +             ret = sprd_rtc_update(rtc, SPRD_RTC_INT_EN,
>> +                                   SPRD_RTC_AUXALM_EN, 0);
>
> This is not setting the alarm registers properly. What if the alarm is
> enabled at a later time by sprd_rtc_alarm_irq_enable()?

Ok, I understand your meaning, I will modify the logic in next version.

>> +static int sprd_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>> +{
>> +     struct sprd_rtc *rtc = dev_get_drvdata(dev);
>> +     struct rtc_time aie_time =
>> +             rtc_ktime_to_tm(rtc->rtc->aie_timer.node.expires);
>> +     int ret;
>> +
>> +     /*
>> +      * We have 2 groups alarms: normal alarm and auxiliary alarm. Since
>> +      * both normal alarm event and auxiliary alarm event can wake up system
>> +      * from deep sleep, but only alarm event can power up system from power
>> +      * down status. Moreover we do not need to poll about 125ms when
>> +      * updating auxiliary alarm registers. Thus we usually set auxiliary
>> +      * alarm when wake up system from deep sleep, and for other scenarios,
>> +      * we should set normal alarm with polling status.
>> +      *
>> +      * So here we check if the alarm time is set by aie_timer, if yes, we
>> +      * should set normal alarm, if not, we should set auxiliary alarm which
>> +      * means it is just a wake event.
>> +      */
>> +     if (!rtc->rtc->aie_timer.enabled || rtc_tm_sub(&aie_time, &alrm->time))
>> +             return sprd_rtc_set_aux_alarm(dev, alrm);
>> +
>> +     /* clear the alarm interrupt status firstly */
>> +     ret = sprd_rtc_write(rtc, SPRD_RTC_INT_CLR, SPRD_RTC_ALARM_EN);
>> +     if (ret)
>> +             return ret;
>> +
>> +     if (alrm->enabled) {
>> +             time64_t secs = rtc_tm_to_time64(&alrm->time);
>> +
>> +             /* enable the alarm interrupt */
>> +             ret = sprd_rtc_update(rtc, SPRD_RTC_INT_EN, SPRD_RTC_ALARM_EN,
>> +                                   SPRD_RTC_ALARM_EN);
>> +             if (ret)
>> +                     return ret;
>> +
>> +             ret = sprd_rtc_set_secs(rtc, SPRD_RTC_ALARM, secs);
>> +             if (ret)
>> +                     goto err;
>> +
>> +             /* unlock the alarm to enable the alarm function. */
>> +             ret = sprd_rtc_unlock_alarm(rtc);
>> +             if (ret)
>> +                     goto err;
>> +     } else {
>
> ditto.
>
>> +             /* disable the alarm interrupt */
>> +             ret = sprd_rtc_update(rtc, SPRD_RTC_INT_EN,
>> +                                   SPRD_RTC_ALARM_EN, 0);
>> +             if (ret)
>> +                     return ret;
>> +
>> +             /*
>> +              * Lock the alarm function in case fake alarm event will power
>> +              * up systems.
>> +              */
>> +             ret = sprd_rtc_lock_alarm(rtc);
>> +     }
>> +
>> +     return ret;
>> +
>> +err:
>> +     sprd_rtc_update(rtc, SPRD_RTC_INT_EN, SPRD_RTC_ALARM_EN, 0);
>> +     return ret;
>> +}
>> +
>> +static int sprd_rtc_set_mmss(struct device *dev, time64_t secs)
>> +{
>> +     struct sprd_rtc *rtc = dev_get_drvdata(dev);
>> +
>> +     return sprd_rtc_set_secs(rtc, SPRD_RTC_TIME, secs);
>> +}
>
> Because set_time is defined, this function will never be called, please
> remove it.

Ah, yes, I will remove it.

>> +
>> +static int sprd_rtc_init_time(struct sprd_rtc *rtc)
>> +{
>> +     time64_t secs = mktime64(SPRD_RTC_START_YEAR, 1, 1, 0, 0, 0);
>> +
>> +     dev_dbg(rtc->dev, "RTC power down and reset time.\n");
>> +     return sprd_rtc_set_secs(rtc, SPRD_RTC_TIME, secs);
>> +}
>> +
>> +static int sprd_rtc_check_power_down(struct sprd_rtc *rtc)
>> +{
>> +     int ret;
>> +     u32 val;
>> +
>> +     ret = sprd_rtc_read(rtc, SPRD_RTC_SPG_VALUE, &val);
>> +     if (ret)
>> +             return ret;
>> +
>> +     if (val & SPRD_RTC_POWER_RESET_FLAG)
>> +             return 0;
>> +
>> +     ret = sprd_rtc_init_time(rtc);
>
> Don't do that. This is a valuable information. If you know the time is
> invalid, return -EINVAL in read_time(). What your are doing here is
> confusing the system by making it believe your fake date is the correct
> time.

Usually for mobile device, we should give one reasonable start time if
the RTC powered down. Anyway I can remove this feature now.
Very appreciated for your helpful comments.

-- 
Baolin.wang
Best Regards
