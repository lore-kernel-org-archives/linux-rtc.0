Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:49208 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751376AbdJRM5o (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 18 Oct 2017 08:57:44 -0400
Date: Wed, 18 Oct 2017 14:57:43 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Yingjoe Chen <yingjoe.chen@mediatek.com>
Cc: sean.wang@mediatek.com, a.zummo@towertech.it, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] rtc: mediatek: add driver for RTC on MT7622 SoC
Message-ID: <20171018125743.kqna6b4lgng674om@piout.net>
References: <cover.1508231935.git.sean.wang@mediatek.com>
 <2f86eebfd380cf932808df3404e2f4a6f2f0f874.1508231935.git.sean.wang@mediatek.com>
 <1508325126.13340.25.camel@mtksdaap41>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1508325126.13340.25.camel@mtksdaap41>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 18/10/2017 at 19:12:06 +0800, Yingjoe Chen wrote:
> On Tue, 2017-10-17 at 17:40 +0800, sean.wang@mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > This patch introduces the driver for the RTC on MT7622 SoC.
> > 
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> >  drivers/rtc/Kconfig      |  10 ++
> >  drivers/rtc/Makefile     |   1 +
> >  drivers/rtc/rtc-mt7622.c | 418 +++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 429 insertions(+)
> >  create mode 100644 drivers/rtc/rtc-mt7622.c
> > 
> > diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> > index e0e58f3..4226295 100644
> > --- a/drivers/rtc/Kconfig
> > +++ b/drivers/rtc/Kconfig
> > @@ -1705,6 +1705,16 @@ config RTC_DRV_MOXART
> >  	   This driver can also be built as a module. If so, the module
> >  	   will be called rtc-moxart
> >  
> > +config RTC_DRV_MEDIATEK
> 
> How about changing this to RTC_DRV_MT7622 or RTC_DRV_MEDIATEK_SOC?
> It is confusing to have both RTC_DRV_MEDIATEK & RTC_DRV_MT6397 here.
> 

Yes, this has to be RTC_DRV_MT7622. It doesn't matter if it support
future SoCs named differently, it will be less confusing than using
anything with only mediatek in it.

> > +		return -EINVAL;
> > +
> > +	/* Keep yr_base used to calculate the calculate year when userspace
> > +	 * queries and extend the maximum year the RTC can count.
> > +	 */
> > +	hw->yr_base[MTK_TC] = tm->tm_year - MTK_RTC_TM_YR_L -
> > +			      (tm->tm_year % MTK_RTC_HW_YR_LIMIT);
> 
> 
> I'm not sure this worth it.
> If maximum year it can hold is 99, I'd bet it won't support leap year
> correctly after 2100. This make the RTC useless after that. 
> 
> Also, yr_base is lost after power cycle, so you can't get correct year
> back anyway.
> 

I agree, the best you can do here is to only support 2000 to 2099.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
