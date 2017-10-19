Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:46263 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751404AbdJSKEr (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 19 Oct 2017 06:04:47 -0400
Message-ID: <1508407479.29850.5.camel@mtkswgap22>
Subject: Re: [PATCH v2 2/4] rtc: mediatek: add driver for RTC on MT7622 SoC
From: Sean Wang <sean.wang@mediatek.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Yingjoe Chen <yingjoe.chen@mediatek.com>, <a.zummo@towertech.it>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date: Thu, 19 Oct 2017 18:04:39 +0800
In-Reply-To: <20171019090219.2odtq3xosqk5ytsb@piout.net>
References: <cover.1508231935.git.sean.wang@mediatek.com>
         <2f86eebfd380cf932808df3404e2f4a6f2f0f874.1508231935.git.sean.wang@mediatek.com>
         <1508325126.13340.25.camel@mtksdaap41>
         <20171018125743.kqna6b4lgng674om@piout.net>
         <1508381749.21840.123.camel@mtkswgap22>
         <20171019090219.2odtq3xosqk5ytsb@piout.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, 2017-10-19 at 11:02 +0200, Alexandre Belloni wrote:
> On 19/10/2017 at 10:55:49 +0800, Sean Wang wrote:
> > Hi, both
> > 
> > On Wed, 2017-10-18 at 14:57 +0200, Alexandre Belloni wrote:
> > > On 18/10/2017 at 19:12:06 +0800, Yingjoe Chen wrote:
> > > > On Tue, 2017-10-17 at 17:40 +0800, sean.wang@mediatek.com wrote:
> > > > > From: Sean Wang <sean.wang@mediatek.com>
> > > > > 
> > > > > This patch introduces the driver for the RTC on MT7622 SoC.
> > > > > 
> > > > > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > > > > ---
> > > > >  drivers/rtc/Kconfig      |  10 ++
> > > > >  drivers/rtc/Makefile     |   1 +
> > > > >  drivers/rtc/rtc-mt7622.c | 418 +++++++++++++++++++++++++++++++++++++++++++++++
> > > > >  3 files changed, 429 insertions(+)
> > > > >  create mode 100644 drivers/rtc/rtc-mt7622.c
> > > > > 
> > > > > diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> > > > > index e0e58f3..4226295 100644
> > > > > --- a/drivers/rtc/Kconfig
> > > > > +++ b/drivers/rtc/Kconfig
> > > > > @@ -1705,6 +1705,16 @@ config RTC_DRV_MOXART
> > > > >  	   This driver can also be built as a module. If so, the module
> > > > >  	   will be called rtc-moxart
> > > > >  
> > > > > +config RTC_DRV_MEDIATEK
> > > > 
> > > > How about changing this to RTC_DRV_MT7622 or RTC_DRV_MEDIATEK_SOC?
> > > > It is confusing to have both RTC_DRV_MEDIATEK & RTC_DRV_MT6397 here.
> > > > 
> > > 
> > > Yes, this has to be RTC_DRV_MT7622. It doesn't matter if it support
> > > future SoCs named differently, it will be less confusing than using
> > > anything with only mediatek in it.
> > > 
> > 
> > Agreed on. RTC_DRV_MT7622 will be applied instead to align the usage on
> > MT6397 and to get rid of such kind of confusion.
> > 
> > 
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	/* Keep yr_base used to calculate the calculate year when userspace
> > > > > +	 * queries and extend the maximum year the RTC can count.
> > > > > +	 */
> > > > > +	hw->yr_base[MTK_TC] = tm->tm_year - MTK_RTC_TM_YR_L -
> > > > > +			      (tm->tm_year % MTK_RTC_HW_YR_LIMIT);
> > > > 
> > > > 
> > > > I'm not sure this worth it.
> > > > If maximum year it can hold is 99, I'd bet it won't support leap year
> > > > correctly after 2100. This make the RTC useless after that. 
> > > > 
> > > > Also, yr_base is lost after power cycle, so you can't get correct year
> > > > back anyway.
> > > > 
> > > 
> > > I agree, the best you can do here is to only support 2000 to 2099.
> > > 
> > 
> > O.K. I will remove those yr_base extension and only consider only
> > support from 2000 to 2099 because of no much gain we can get from
> > yr_base.
> > 
> > The only gain is yr_base I thought just allows people have the
> > opportunity to set up rtc after 2100. However, it appears to not much
> > practical to foresee these things after 2100 and rtc must be setup again
> > when either year overflowing or power cycle happens after 2100 as Joe.C
> > mentioned.
> > 
> > In addition, I also found the rtc hardware would take year == 0 as not
> > leap year that works for 2100, 2200, 2300, but not for 2000, 2400,
> > 2800,... and thus 2000 is also needed to be excluded in both set_time
> > and set_alarm if only 2000 to 2099 is supported.
> > 
> 
> So you can make it work from 2001 to 2100 but I'm not sure it is worth
> it.
> 

I prefer to 2001 to 2099 only which can be completely handled in the
common logic. Extra specific logic simply for 2100 seems not be
worthwhile. 
