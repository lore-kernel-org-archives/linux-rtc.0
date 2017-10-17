Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:5891 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754506AbdJQDYf (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 16 Oct 2017 23:24:35 -0400
Message-ID: <1508210661.21840.86.camel@mtkswgap22>
Subject: Re: [PATCH 2/4] rtc: mediatek: add driver for RTC on MT7622 SoC
From: Sean Wang <sean.wang@mediatek.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: <a.zummo@towertech.it>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-rtc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date: Tue, 17 Oct 2017 11:24:21 +0800
In-Reply-To: <1508141876.21840.75.camel@mtkswgap22>
References: <cover.1506049341.git.sean.wang@mediatek.com>
         <5b2a7e5c9c5bc179f89e48fb614b2ae789be4254.1506049341.git.sean.wang@mediatek.com>
         <20171012212052.xkhbgdjrghmnvcfe@piout.net>
         <1508141876.21840.75.camel@mtkswgap22>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Mon, 2017-10-16 at 16:17 +0800, Sean Wang wrote:
> Hi Alexandre,
> 
> Thanks for your valuable suggestions on the driver.
> 
> I added comments inline and will have following-ups in the next version
> 
> 	Sean
> 
> On Thu, 2017-10-12 at 23:20 +0200, Alexandre Belloni wrote:
> > Hi,
> > 
> > On 22/09/2017 at 11:33:15 +0800, sean.wang@mediatek.com wrote:
> > > diff --git a/drivers/rtc/rtc-mediatek.c b/drivers/rtc/rtc-mediatek.c
> > 
> > I'm pretty sure this should be named rtc-mt7622.c instead of
> > rtc-mediatek.c, exactly for the same reason you have patch 3/4.
> > 
> 
> It's okay for naming with rtc-mt7622.c at this moment. But if more SoCs
> support gets into the driver, I will consider again to give a more
> generic name for the driver.
> 
> > > +static void mtk_w32(struct mtk_rtc *rtc, u32 reg, u32 val)
> > > +{
> > > +	__raw_writel(val, rtc->base + reg);
> > 
> > Do you really need the __raw accessors? What about running your SoC in
> > BE mode? I guess the _relaxed version are fast enough.
> > 
> 
> SoC runs on LE mode. I also think it's fine and enough to use _relaxed
> version instead of __raw version.
> 
> > > +}
> > > +
> > > +static u32 mtk_r32(struct mtk_rtc *rtc, u32 reg)
> > > +{
> > > +	return __raw_readl(rtc->base + reg);
> > > +}
> > > +
> > 
> > 
> > > +static void mtk_rtc_hw_init(struct mtk_rtc *hw)
> > > +{
> > > +	/* The setup of the init sequence is for allowing RTC got to work */
> > > +	mtk_w32(hw, MTK_RTC_PWRCHK1, RTC_PWRCHK1_MAGIC);
> > > +	mtk_w32(hw, MTK_RTC_PWRCHK2, RTC_PWRCHK2_MAGIC);
> > > +	mtk_w32(hw, MTK_RTC_KEY, RTC_KEY_MAGIC);
> > > +	mtk_w32(hw, MTK_RTC_PROT1, RTC_PROT1_MAGIC);
> > > +	mtk_w32(hw, MTK_RTC_PROT2, RTC_PROT2_MAGIC);
> > > +	mtk_w32(hw, MTK_RTC_PROT3, RTC_PROT3_MAGIC);
> > > +	mtk_w32(hw, MTK_RTC_PROT4, RTC_PROT4_MAGIC);
> > > +	mtk_rmw(hw, MTK_RTC_DEBNCE, RTC_DEBNCE_MASK, 0);
> > > +	mtk_clr(hw, MTK_RTC_CTL, RTC_RC_STOP);
> > > +}
> > > +
> > > +static void mtk_rtc_get_alarm_or_time(struct mtk_rtc *hw, struct rtc_time *tm,
> > > +				      int time_alarm)
> > > +{
> > > +	u32 year, mon, mday, wday, hour, min, sec;
> > > +
> > > +	/*
> > > +	 * Read again until all fields are not changed for all fields in the
> > > +	 * consistent state.
> > > +	 */
> > > +	do {
> > > +		year = mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_YEA));
> > > +		mon = mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_MON));
> > > +		wday = mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_DOW));
> > > +		mday = mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_DOM));
> > > +		hour = mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_HOU));
> > > +		min = mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_MIN));
> > > +		sec = mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_SEC));
> > > +	} while (year != mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_YEA)) ||
> > > +		 mon != mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_MON))  ||
> > > +		 mday != mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_DOM))	||
> > > +		 wday != mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_DOW))	||
> > > +		 hour != mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_HOU))	||
> > > +		 min != mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_MIN))	||
> > > +		 sec != mtk_r32(hw, MTK_RTC_TREG(time_alarm, MTK_SEC))
> > > +		);
> > 
> > I'm pretty sure only checking sec is enough because it is highly
> > unlikely that 7 reads take a minute.
> > 
> 
> You're right. I made something stupid here. Only checking on sec is
> enough and will give simpler and better code.
> 
> > > +static irqreturn_t mtk_rtc_alarmirq(int irq, void *id)
> > > +{
> > > +	struct mtk_rtc *hw = (struct mtk_rtc *)id;
> > > +	u32 irq_sta;
> > > +
> > > +	/* Stop alarm also implicitly disable the alarm interrupt */
> > > +	mtk_w32(hw, MTK_RTC_AL_CTL, 0);
> > 
> > You stop the alarm here, before testing whether the alarm really
> > happened.
> > 
> 
> Okay. I will exchange the order for alarm stopping and the examination
> whether the alarm is really expired. 
> 
> > > +	irq_sta = mtk_r32(hw, MTK_RTC_INT);
> > > +	if (irq_sta & RTC_INT_AL_STA) {
> > > +		rtc_update_irq(hw->rtc, 1, RTC_IRQF | RTC_AF);
> > > +
> > > +		/* Ack alarm interrupt status */
> > > +		mtk_w32(hw, MTK_RTredundantC_INT, RTC_INT_AL_STA);
> > > +		return IRQ_HANDLED;
> > > +	}
> > > +
> > > +	return IRQ_NONE;
> > > +}
> > > +
> > > +static int mtk_rtc_gettime(struct device *dev, struct rtc_time *tm)
> > > +{
> > > +	struct mtk_rtc *hw = dev_get_drvdata(dev);
> > > +
> > > +	mtk_rtc_get_alarm_or_time(hw, tm, MTK_TC);
> > > +
> > > +	return rtc_valid_tm(tm);
> > > +}
> > > +
> > > +static int mtk_rtc_settime(struct device *dev, struct rtc_time *tm)
> > > +{
> > > +	struct mtk_rtc *hw = dev_get_drvdata(dev);
> > > +
> > > +	/* Stop time counter before setting a new one*/
> > > +	mtk_set(hw, MTK_RTC_CTL, RTC_RC_STOP);
> > > +
> > > +	/* Epoch == 1900 */
> > > +	if (tm->tm_year < 100 || tm->tm_year > 199)
> > > +		return -EINVAL;
> > 
> > Year is a 32 bits register, what makes the RTC fail in 2100? Is it
> > because of the leap year handling?
> > 
> 
> I made something stupid again here: rtc hardware doesn't have such the
> limitation. I just felt alarm set up prior to 2100 is enough in my
> initial thought, but it seemed I shouldn't do this. I will remove the
> sanity condition.
> 
Sorry for that I gave incorrect information for the RTC in the previous
reply: After check again the usage of the register, the maximum number
of the year the RTC can hold is 99 and then wraparound to 0 when
overflow occurs although the year register is a 32 bits register.

Therefore, the sanity for tm->tm_year is still required for the both
setup handler on alarm and rtc to ensure the user input data is valid,
where the current driver assume it's valid when tm->tm_year is between
2000 and 2099. I'll add more comments for the hardware limitation.

	Sean
> 
> > > +static int mtk_rtc_setalarm(struct device *dev, struct rtc_wkalrm *wkalrm)
> > > +{
> > > +	struct mtk_rtc *hw = dev_get_drvdata(dev);
> > > +	struct rtc_time *alrm_tm = &wkalrm->time;
> > > +
> > > +	/* Epoch == 1900 */
> > > +	if (alrm_tm->tm_year < 100 || alrm_tm->tm_year > 199)
> > > +		return -EINVAL;
> > > +
> > 
> > Ditto.
> > 
> Ditto. those condition will be removed.
> 
> > > +
> > > +	dev_info(&pdev->dev, "MediaTek SoC based RTC enabled\n");
> > > +
> > 
> > I think the rtc core is verbose enough that this message is not needed.
> > 
> 
> Okay. the redundant and specific log prompt would be removed as well.
> 
> 
> > 
> 
