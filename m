Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:12209 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751871AbdHKHSf (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 11 Aug 2017 03:18:35 -0400
Message-ID: <1502435908.28466.21.camel@mhfsdcap03>
Subject: Re: [PATCH v2 5/5] mfd: mt6397: Add PMIC keys support to MT6397
 driver
From: Chen Zhong <chen.zhong@mediatek.com>
To: Lee Jones <lee.jones@linaro.org>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Jaechul Lee <jcsing.lee@samsung.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Javier Martinez Canillas" <javier@osg.samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>
Date: Fri, 11 Aug 2017 15:18:28 +0800
In-Reply-To: <20170808111556.dmx2s6bcwnsccrkn@dell>
References: <1502071065-6745-1-git-send-email-chen.zhong@mediatek.com>
         <1502071065-6745-6-git-send-email-chen.zhong@mediatek.com>
         <20170808111556.dmx2s6bcwnsccrkn@dell>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Tue, 2017-08-08 at 12:15 +0100, Lee Jones wrote:
> On Mon, 07 Aug 2017, Chen Zhong wrote:
> 
> > This patch adds compatible strings and interrupts for pmic keys
> > which serves as child device of MFD.
> > 
> > Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
> > ---
> >  drivers/mfd/mt6397-core.c |   36 +++++++++++++++++++++++++++++++++++-
> >  1 file changed, 35 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> > index 6546d7f..3c6a765 100644
> > --- a/drivers/mfd/mt6397-core.c
> > +++ b/drivers/mfd/mt6397-core.c
> > @@ -43,6 +43,30 @@
> >  	},
> >  };
> >  
> > +static const struct resource mt6323_keys_resources[] = {
> > +	{
> > +		.start = MT6323_IRQ_STATUS_PWRKEY,
> > +		.end   = MT6323_IRQ_STATUS_PWRKEY,
> > +		.flags = IORESOURCE_IRQ,
> > +	}, {
> > +		.start = MT6323_IRQ_STATUS_FCHRKEY,
> > +		.end   = MT6323_IRQ_STATUS_FCHRKEY,
> > +		.flags = IORESOURCE_IRQ,
> > +	},
> > +};
> > +
> > +static const struct resource mt6397_keys_resources[] = {
> > +	{
> > +		.start = MT6397_IRQ_PWRKEY,
> > +		.end   = MT6397_IRQ_PWRKEY,
> > +		.flags = IORESOURCE_IRQ,
> > +	}, {
> > +		.start = MT6397_IRQ_HOMEKEY,
> > +		.end   = MT6397_IRQ_HOMEKEY,
> > +		.flags = IORESOURCE_IRQ,
> > +	},
> > +};
> 
> We have better ways to define these now.
> 
> Please grep for "DEFINE_RES_"

I'll define these with "DEFINE_RES_IRQ" here, Thank you for your
suggestion.

> 
> >  static const struct mfd_cell mt6323_devs[] = {
> >  	{
> >  		.name = "mt6323-regulator",
> > @@ -50,6 +74,11 @@
> >  	}, {
> >  		.name = "mt6323-led",
> >  		.of_compatible = "mediatek,mt6323-led"
> > +	}, {
> > +		.name = "mtk-pmic-keys",
> > +		.num_resources = ARRAY_SIZE(mt6323_keys_resources),
> > +		.resources = mt6323_keys_resources,
> > +		.of_compatible = "mediatek,mt6323-keys"
> >  	},
> >  };
> >  
> > @@ -71,7 +100,12 @@
> >  	}, {
> >  		.name = "mt6397-pinctrl",
> >  		.of_compatible = "mediatek,mt6397-pinctrl",
> > -	},
> > +	}, {
> > +		.name = "mtk-pmic-keys",
> > +		.num_resources = ARRAY_SIZE(mt6397_keys_resources),
> > +		.resources = mt6397_keys_resources,
> > +		.of_compatible = "mediatek,mt6397-keys"
> > +	}
> >  };
> >  
> >  static void mt6397_irq_lock(struct irq_data *data)
> 
