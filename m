Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35273 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751758AbdHHCxb (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 7 Aug 2017 22:53:31 -0400
Date: Mon, 7 Aug 2017 19:53:28 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Chen Zhong <chen.zhong@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Jaechul Lee <jcsing.lee@samsung.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 1/5] mfd: mt6397: create irq mappings in mfd core
 driver
Message-ID: <20170808025328.GB12328@dtor-ws>
References: <1502071065-6745-1-git-send-email-chen.zhong@mediatek.com>
 <1502071065-6745-2-git-send-email-chen.zhong@mediatek.com>
 <20170807213244.7hrd3isq5jj44dgd@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170807213244.7hrd3isq5jj44dgd@piout.net>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Mon, Aug 07, 2017 at 11:32:44PM +0200, Alexandre Belloni wrote:
> On 07/08/2017 at 09:57:41 +0800, Chen Zhong wrote:
> > The core driver should create and manage irq mappings instead of
> > leaf drivers. This patch change to pass irq domain to
> > devm_mfd_add_devices() and it will create mapping for irq resources
> > automatically. And remove irq mapping in rtc driver since this has
> > been done in core driver.
> > 
> > Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
> 
> For the RTC part:
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> > ---
> >  drivers/mfd/mt6397-core.c |    4 ++--
> >  drivers/rtc/rtc-mt6397.c  |    2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> > index 04a601f..6546d7f 100644
> > --- a/drivers/mfd/mt6397-core.c
> > +++ b/drivers/mfd/mt6397-core.c
> > @@ -289,7 +289,7 @@ static int mt6397_probe(struct platform_device *pdev)
> >  
> >  		ret = devm_mfd_add_devices(&pdev->dev, -1, mt6323_devs,
> >  					   ARRAY_SIZE(mt6323_devs), NULL,
> > -					   0, NULL);
> > +					   0, pmic->irq_domain);
> >  		break;
> >  
> >  	case MT6397_CID_CODE:
> > @@ -304,7 +304,7 @@ static int mt6397_probe(struct platform_device *pdev)
> >  
> >  		ret = devm_mfd_add_devices(&pdev->dev, -1, mt6397_devs,
> >  					   ARRAY_SIZE(mt6397_devs), NULL,
> > -					   0, NULL);
> > +					   0, pmic->irq_domain);
> >  		break;
> >  
> >  	default:
> > diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
> > index 1a61fa5..22c52f7 100644
> > --- a/drivers/rtc/rtc-mt6397.c
> > +++ b/drivers/rtc/rtc-mt6397.c
> > @@ -323,7 +323,7 @@ static int mtk_rtc_probe(struct platform_device *pdev)
> >  	rtc->addr_base = res->start;
> >  
> >  	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> > -	rtc->irq = irq_create_mapping(mt6397_chip->irq_domain, res->start);
> > +	rtc->irq = res->start;

Why not

	rtc->irq = platform_get_irq(pdev, 0);
	if (rtc->irq < 0)
		return rtc->irq;
?

This way you propagate error properly.

Thanks.

-- 
Dmitry
