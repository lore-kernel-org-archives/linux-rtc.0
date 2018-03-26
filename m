Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:6802 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750981AbeCZCWP (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 25 Mar 2018 22:22:15 -0400
Message-ID: <1522030927.18424.11.camel@mtkswgap22>
Subject: Re: [PATCH v1 08/16] rtc: mediatek: remove unnecessary
 irq_dispose_mapping
From: Sean Wang <sean.wang@mediatek.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <sre@kernel.org>,
        <lee.jones@linaro.org>, <a.zummo@towertech.it>,
        <eddie.huang@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date: Mon, 26 Mar 2018 10:22:07 +0800
In-Reply-To: <20180323103801.GH3417@piout.net>
References: <cover.1521794176.git.sean.wang@mediatek.com>
         <96f39ce7f57a4dcd7653e049eebc87c83bcbdfc9.1521794177.git.sean.wang@mediatek.com>
         <20180323103801.GH3417@piout.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Fri, 2018-03-23 at 11:38 +0100, Alexandre Belloni wrote:
> On 23/03/2018 at 17:15:05 +0800, sean.wang@mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > It's unnecessary doing irq_dispose_mapping as a reverse operation for
> > platform_get_irq.
> > 
> > Ususally, irq_dispose_mapping should be called in error path or module
> > removal to release the resources for irq_of_parse_and_map requested.
> > 
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> >  drivers/rtc/rtc-mt6397.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
> > index b62eaa8..cefb83b 100644
> > --- a/drivers/rtc/rtc-mt6397.c
> > +++ b/drivers/rtc/rtc-mt6397.c
> > @@ -17,7 +17,6 @@
> >  #include <linux/module.h>
> >  #include <linux/regmap.h>
> >  #include <linux/rtc.h>
> > -#include <linux/irqdomain.h>
> >  #include <linux/jiffies.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/of_address.h>
> > @@ -336,7 +335,7 @@ static int mtk_rtc_probe(struct platform_device *pdev)
> >  	if (ret) {
> >  		dev_err(&pdev->dev, "Failed to request alarm IRQ: %d: %d\n",
> >  			rtc->irq, ret);
> > -		goto out_dispose_irq;
> > +		return ret;
> >  	}
> >  
> >  	device_init_wakeup(&pdev->dev, 1);
> > @@ -353,8 +352,7 @@ static int mtk_rtc_probe(struct platform_device *pdev)
> >  
> >  out_free_irq:
> >  	free_irq(rtc->irq, rtc->rtc_dev);
> > -out_dispose_irq:
> > -	irq_dispose_mapping(rtc->irq);
> > +
> 
> Don't you still have a irq_create_mapping?
> 

Sorry for that I didn't mention in the beginning that the series must
depend on another patch [1]. With the patch, the job irq_create_mapping
had been moved from rtc to mfd, so here it should be better to cleanup
up irq_dispose_mapping in all paths.

[1] https://patchwork.kernel.org/patch/9954643/

> >  	return ret;
> >  }
> >  
> > @@ -364,7 +362,6 @@ static int mtk_rtc_remove(struct platform_device *pdev)
> >  
> >  	rtc_device_unregister(rtc->rtc_dev);
> >  	free_irq(rtc->irq, rtc->rtc_dev);
> > -	irq_dispose_mapping(rtc->irq);
> >  
> >  	return 0;
> >  }
> > -- 
> > 2.7.4
> > 
> 
