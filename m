Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:51996 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751961AbdJLVUy (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 12 Oct 2017 17:20:54 -0400
Date: Thu, 12 Oct 2017 23:20:52 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: sean.wang@mediatek.com
Cc: a.zummo@towertech.it, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] rtc: mediatek: add driver for RTC on MT7622 SoC
Message-ID: <20171012212052.xkhbgdjrghmnvcfe@piout.net>
References: <cover.1506049341.git.sean.wang@mediatek.com>
 <5b2a7e5c9c5bc179f89e48fb614b2ae789be4254.1506049341.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5b2a7e5c9c5bc179f89e48fb614b2ae789be4254.1506049341.git.sean.wang@mediatek.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

On 22/09/2017 at 11:33:15 +0800, sean.wang@mediatek.com wrote:
> diff --git a/drivers/rtc/rtc-mediatek.c b/drivers/rtc/rtc-mediatek.c

I'm pretty sure this should be named rtc-mt7622.c instead of
rtc-mediatek.c, exactly for the same reason you have patch 3/4.

> +static void mtk_w32(struct mtk_rtc *rtc, u32 reg, u32 val)
> +{
> +	__raw_writel(val, rtc->base + reg);

Do you really need the __raw accessors? What about running your SoC in
BE mode? I guess the _relaxed version are fast enough.

> +}
> +
> +static u32 mtk_r32(struct mtk_rtc *rtc, u32 reg)
> +{
> +	return __raw_readl(rtc->base + reg);
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
> +	 * Read again until all fields are not changed for all fields in the
> +	 * consistent state.
> +	 */
> +	do {
> +		year = mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_YEA));
> +		mon = mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_MON));
> +		wday = mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_DOW));
> +		mday = mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_DOM));
> +		hour = mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_HOU));
> +		min = mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_MIN));
> +		sec = mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_SEC));
> +	} while (year != mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_YEA)) ||
> +		 mon != mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_MON))  ||
> +		 mday != mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_DOM))	||
> +		 wday != mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_DOW))	||
> +		 hour != mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_HOU))	||
> +		 min != mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_MIN))	||
> +		 sec != mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_SEC))
> +		);

I'm pretty sure only checking sec is enough because it is highly
unlikely that 7 reads take a minute.

> +static irqreturn_t mtk_rtc_alarmirq(int irq, void *id)
> +{
> +	struct mtk_rtc *hw = (struct mtk_rtc *)id;
> +	u32 irq_sta;
> +
> +	/* Stop alarm also implicitly disable the alarm interrupt */
> +	mtk_w32(hw, MTK_RTC_AL_CTL, 0);

You stop the alarm here, before testing whether the alarm really
happened.

> +	irq_sta = mtk_r32(hw, MTK_RTC_INT);
> +	if (irq_sta & RTC_INT_AL_STA) {
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
> +	/* Stop time counter before setting a new one*/
> +	mtk_set(hw, MTK_RTC_CTL, RTC_RC_STOP);
> +
> +	/* Epoch == 1900 */
> +	if (tm->tm_year < 100 || tm->tm_year > 199)
> +		return -EINVAL;

Year is a 32 bits register, what makes the RTC fail in 2100? Is it
because of the leap year handling?

> +static int mtk_rtc_setalarm(struct device *dev, struct rtc_wkalrm *wkalrm)
> +{
> +	struct mtk_rtc *hw = dev_get_drvdata(dev);
> +	struct rtc_time *alrm_tm = &wkalrm->time;
> +
> +	/* Epoch == 1900 */
> +	if (alrm_tm->tm_year < 100 || alrm_tm->tm_year > 199)
> +		return -EINVAL;
> +

Ditto.

> +
> +	dev_info(&pdev->dev, "MediaTek SoC based RTC enabled\n");
> +

I think the rtc core is verbose enough that this message is not needed.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
