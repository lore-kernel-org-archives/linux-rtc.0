Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:44173 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752027AbdJRLML (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 18 Oct 2017 07:12:11 -0400
Message-ID: <1508325126.13340.25.camel@mtksdaap41>
Subject: Re: [PATCH v2 2/4] rtc: mediatek: add driver for RTC on MT7622 SoC
From: Yingjoe Chen <yingjoe.chen@mediatek.com>
To: <sean.wang@mediatek.com>
CC: <a.zummo@towertech.it>, <alexandre.belloni@free-electrons.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date: Wed, 18 Oct 2017 19:12:06 +0800
In-Reply-To: <2f86eebfd380cf932808df3404e2f4a6f2f0f874.1508231935.git.sean.wang@mediatek.com>
References: <cover.1508231935.git.sean.wang@mediatek.com>
         <2f86eebfd380cf932808df3404e2f4a6f2f0f874.1508231935.git.sean.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Tue, 2017-10-17 at 17:40 +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> This patch introduces the driver for the RTC on MT7622 SoC.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/rtc/Kconfig      |  10 ++
>  drivers/rtc/Makefile     |   1 +
>  drivers/rtc/rtc-mt7622.c | 418 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 429 insertions(+)
>  create mode 100644 drivers/rtc/rtc-mt7622.c
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index e0e58f3..4226295 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1705,6 +1705,16 @@ config RTC_DRV_MOXART
>  	   This driver can also be built as a module. If so, the module
>  	   will be called rtc-moxart
>  
> +config RTC_DRV_MEDIATEK

How about changing this to RTC_DRV_MT7622 or RTC_DRV_MEDIATEK_SOC?
It is confusing to have both RTC_DRV_MEDIATEK & RTC_DRV_MT6397 here.

> +	tristate "MediaTek SoC based RTC"
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	help
> +	  This enables support for the real time clock built in the MediaTek
> +	  SoCs.
> +
> +	  This drive can also be built as a module. If so, the module
> +	  will be called rtc-mediatek.
> +
>  config RTC_DRV_MT6397
>  	tristate "Mediatek Real Time Clock driver"
>  	depends on MFD_MT6397 || (COMPILE_TEST && IRQ_DOMAIN)
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index 7230014..593a02c 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -101,6 +101,7 @@ obj-$(CONFIG_RTC_DRV_MOXART)	+= rtc-moxart.o
>  obj-$(CONFIG_RTC_DRV_MPC5121)	+= rtc-mpc5121.o
>  obj-$(CONFIG_RTC_DRV_VRTC)	+= rtc-mrst.o
>  obj-$(CONFIG_RTC_DRV_MSM6242)	+= rtc-msm6242.o
> +obj-$(CONFIG_RTC_DRV_MEDIATEK)	+= rtc-mt7622.o
>  obj-$(CONFIG_RTC_DRV_MT6397)	+= rtc-mt6397.o
>  obj-$(CONFIG_RTC_DRV_MV)	+= rtc-mv.o
>  obj-$(CONFIG_RTC_DRV_MXC)	+= rtc-mxc.o
> diff --git a/drivers/rtc/rtc-mt7622.c b/drivers/rtc/rtc-mt7622.c
> new file mode 100644
> index 0000000..1f00494
> --- /dev/null
> +++ b/drivers/rtc/rtc-mt7622.c
> @@ -0,0 +1,418 @@
> +/*
> + * Driver for MediaTek SoC based RTC
> + *
> + * Copyright (C) 2017 Sean Wang <sean.wang@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/rtc.h>
> +
> +#define MTK_RTC_DEV KBUILD_MODNAME
> +
> +#define MTK_RTC_PWRCHK1		0x4
> +#define	RTC_PWRCHK1_MAGIC	0xc6
> +
> +#define MTK_RTC_PWRCHK2		0x8
> +#define	RTC_PWRCHK2_MAGIC	0x9a
> +
> +#define MTK_RTC_KEY		0xc
> +#define	RTC_KEY_MAGIC		0x59
> +
> +#define MTK_RTC_PROT1		0x10
> +#define	RTC_PROT1_MAGIC		0xa3
> +
> +#define MTK_RTC_PROT2		0x14
> +#define	RTC_PROT2_MAGIC		0x57
> +
> +#define MTK_RTC_PROT3		0x18
> +#define	RTC_PROT3_MAGIC		0x67
> +
> +#define MTK_RTC_PROT4		0x1c
> +#define	RTC_PROT4_MAGIC		0xd2
> +
> +#define MTK_RTC_CTL		0x20
> +#define	RTC_RC_STOP		BIT(0)
> +
> +#define MTK_RTC_DEBNCE		0x2c
> +#define	RTC_DEBNCE_MASK		GENMASK(2, 0)
> +
> +#define MTK_RTC_INT		0x30
> +#define RTC_INT_AL_STA		BIT(4)
> +
> +/* Ranges from 0x40 to 0x78 provide RTC time setup for year, month,
> + * day of month, day of week, hour, minute and second.
> + */
> +#define MTK_RTC_TREG(_t, _f)	(0x40 + (0x4 * (_f)) + ((_t) * 0x20))
> +
> +#define MTK_RTC_AL_CTL		0x7c
> +#define	RTC_AL_EN		BIT(0)
> +#define	RTC_AL_ALL		GENMASK(7, 0)
> +
> +#define MTK_RTC_TM_YR_L		100
> +
> +/* The maximum years the RTC can support is 99, For MT7622 */
> +#define MTK_RTC_HW_YR_LIMIT	100
> +
> +/* Types of the function the RTC provides are time counter and alarm. */
> +enum {
> +	MTK_TC,
> +	MTK_AL,
> +	MTK_TYPE_MAX,
> +};
> +
> +/* Indexes are used for the pointer to relevant registers in MTK_RTC_TREG */
> +enum {
> +	MTK_YEA,
> +	MTK_MON,
> +	MTK_DOM,
> +	MTK_DOW,
> +	MTK_HOU,
> +	MTK_MIN,
> +	MTK_SEC
> +};
> +
> +struct mtk_rtc {
> +	struct rtc_device *rtc;
> +	void __iomem *base;
> +	int irq;
> +	struct clk *clk;
> +	u32 yr_base[MTK_TYPE_MAX];
> +};
> +
> +static void mtk_w32(struct mtk_rtc *rtc, u32 reg, u32 val)
> +{
> +	writel_relaxed(val, rtc->base + reg);
> +}
> +
> +static u32 mtk_r32(struct mtk_rtc *rtc, u32 reg)
> +{
> +	return readl_relaxed(rtc->base + reg);
> +}
> +
> +static void mtk_rmw(struct mtk_rtc *rtc, u32 reg, u32 mask, u32 set)
> +{
> +	u32 val;
> +
> +	val = mtk_r32(rtc, reg);
> +	val &= ~mask;
> +	val |= set;
> +	mtk_w32(rtc, reg, val);
> +}
> +
> +static void mtk_set(struct mtk_rtc *rtc, u32 reg, u32 val)
> +{
> +	mtk_rmw(rtc, reg, 0, val);
> +}
> +
> +static void mtk_clr(struct mtk_rtc *rtc, u32 reg, u32 val)
> +{
> +	mtk_rmw(rtc, reg, val, 0);
> +}
> +
> +static void mtk_rtc_hw_init(struct mtk_rtc *hw)
> +{
> +	/* The setup of the init sequence is for allowing RTC got to work */
> +	mtk_w32(hw, MTK_RTC_PWRCHK1, RTC_PWRCHK1_MAGIC);
> +	mtk_w32(hw, MTK_RTC_PWRCHK2, RTC_PWRCHK2_MAGIC);
> +	mtk_w32(hw, MTK_RTC_KEY, RTC_KEY_MAGIC);
> +	mtk_w32(hw, MTK_RTC_PROT1, RTC_PROT1_MAGIC);
> +	mtk_w32(hw, MTK_RTC_PROT2, RTC_PROT2_MAGIC);
> +	mtk_w32(hw, MTK_RTC_PROT3, RTC_PROT3_MAGIC);
> +	mtk_w32(hw, MTK_RTC_PROT4, RTC_PROT4_MAGIC);
> +	mtk_rmw(hw, MTK_RTC_DEBNCE, RTC_DEBNCE_MASK, 0);
> +	mtk_clr(hw, MTK_RTC_CTL, RTC_RC_STOP);
> +}
> +
> +static void mtk_rtc_get_alarm_or_time(struct mtk_rtc *hw, struct rtc_time *tm,
> +				      int time_alarm)
> +{
> +	u32 year, mon, mday, wday, hour, min, sec;
> +
> +	/*
> +	 * Read again until the field of the second is not changed which
> +	 * ensures all fields in the consistent state.
> +	 */
> +	do {
> +		year = mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_YEA));
> +		mon = mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_MON));
> +		wday = mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_DOW));
> +		mday = mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_DOM));
> +		hour = mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_HOU));
> +		min = mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_MIN));
> +		sec = mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_SEC));
> +	} while (sec != mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_SEC)));
> +
> +	tm->tm_sec  = sec;
> +	tm->tm_min  = min;
> +	tm->tm_hour = hour;
> +	tm->tm_wday = wday;
> +	tm->tm_mday = mday;
> +	tm->tm_mon  = mon - 1;
> +
> +	/* Rebase to the absolute year which userspace requires */
> +	tm->tm_year = year + MTK_RTC_TM_YR_L + hw->yr_base[time_alarm];
> +}
> +
> +static void mtk_rtc_set_alarm_or_time(struct mtk_rtc *hw, struct rtc_time *tm,
> +				      int time_alarm)
> +{
> +	u32 year;
> +
> +	/* Rebase to the relative year which RTC hardware requires */
> +	year = tm->tm_year - MTK_RTC_TM_YR_L - hw->yr_base[time_alarm];
> +
> +	mtk_w32(hw, MTK_RTC_TREG(time_alarm, MTK_YEA), year);
> +	mtk_w32(hw, MTK_RTC_TREG(time_alarm, MTK_MON), tm->tm_mon + 1);
> +	mtk_w32(hw, MTK_RTC_TREG(time_alarm, MTK_DOW), tm->tm_wday);
> +	mtk_w32(hw, MTK_RTC_TREG(time_alarm, MTK_DOM), tm->tm_mday);
> +	mtk_w32(hw, MTK_RTC_TREG(time_alarm, MTK_HOU), tm->tm_hour);
> +	mtk_w32(hw, MTK_RTC_TREG(time_alarm, MTK_MIN), tm->tm_min);
> +	mtk_w32(hw, MTK_RTC_TREG(time_alarm, MTK_SEC), tm->tm_sec);
> +}
> +
> +static irqreturn_t mtk_rtc_alarmirq(int irq, void *id)
> +{
> +	struct mtk_rtc *hw = (struct mtk_rtc *)id;
> +	u32 irq_sta;
> +
> +	irq_sta = mtk_r32(hw, MTK_RTC_INT);
> +	if (irq_sta & RTC_INT_AL_STA) {
> +		/* Stop alarm also implicitly disables the alarm interrupt */
> +		mtk_w32(hw, MTK_RTC_AL_CTL, 0);
> +		rtc_update_irq(hw->rtc, 1, RTC_IRQF | RTC_AF);
> +
> +		/* Ack alarm interrupt status */
> +		mtk_w32(hw, MTK_RTC_INT, RTC_INT_AL_STA);
> +		return IRQ_HANDLED;
> +	}
> +
> +	return IRQ_NONE;
> +}
> +
> +static int mtk_rtc_gettime(struct device *dev, struct rtc_time *tm)
> +{
> +	struct mtk_rtc *hw = dev_get_drvdata(dev);
> +
> +	mtk_rtc_get_alarm_or_time(hw, tm, MTK_TC);
> +
> +	return rtc_valid_tm(tm);
> +}
> +
> +static int mtk_rtc_settime(struct device *dev, struct rtc_time *tm)
> +{
> +	struct mtk_rtc *hw = dev_get_drvdata(dev);
> +
> +	/* Epoch == 1900, and the driver assumes that tm->tm_year has to be
> +	 * at least MTK_RTC_TM_YR_L.
> +	 */
> +	if (tm->tm_year <  MTK_RTC_TM_YR_L)

nit: extra space after <

> +		return -EINVAL;
> +
> +	/* Keep yr_base used to calculate the calculate year when userspace
> +	 * queries and extend the maximum year the RTC can count.
> +	 */
> +	hw->yr_base[MTK_TC] = tm->tm_year - MTK_RTC_TM_YR_L -
> +			      (tm->tm_year % MTK_RTC_HW_YR_LIMIT);


I'm not sure this worth it.
If maximum year it can hold is 99, I'd bet it won't support leap year
correctly after 2100. This make the RTC useless after that. 

Also, yr_base is lost after power cycle, so you can't get correct year
back anyway.

Joe.C
