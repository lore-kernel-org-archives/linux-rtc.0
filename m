Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:47613 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbeHOLML (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 15 Aug 2018 07:12:11 -0400
Date: Wed, 15 Aug 2018 10:20:55 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: zhong jiang <zhongjiang@huawei.com>
Cc: a.zummo@towertech.it, baruch@tkos.co.il, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rtc:rtc-digicolor: Use PTR_ERR_OR_ZERO to replace
 the open code
Message-ID: <20180815082055.GV943@piout.net>
References: <1534159885-25364-1-git-send-email-zhongjiang@huawei.com>
 <1534159885-25364-2-git-send-email-zhongjiang@huawei.com>
 <20180814161541.GP943@piout.net>
 <5B73D368.5010205@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5B73D368.5010205@huawei.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 15/08/2018 15:16:56+0800, zhong jiang wrote:
> On 2018/8/15 0:15, Alexandre Belloni wrote:
> > Hi,
> >
> > On 13/08/2018 19:31:24+0800, zhong jiang wrote:
> >> PTR_ERR_OR_ZERO has implemented the if(IS_ERR(...)) + PTR_ERR, So
> >> just replace them rather than duplicating its implement.
> >>
> >> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> >> ---
> >>  drivers/rtc/rtc-digicolor.c | 4 +---
> >>  1 file changed, 1 insertion(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/rtc/rtc-digicolor.c b/drivers/rtc/rtc-digicolor.c
> >> index b253bf1..fd6850c 100644
> >> --- a/drivers/rtc/rtc-digicolor.c
> >> +++ b/drivers/rtc/rtc-digicolor.c
> >> @@ -202,10 +202,8 @@ static int __init dc_rtc_probe(struct platform_device *pdev)
> >>  	platform_set_drvdata(pdev, rtc);
> >>  	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, pdev->name,
> >>  						&dc_rtc_ops, THIS_MODULE);
> >> -	if (IS_ERR(rtc->rtc_dev))
> >> -		return PTR_ERR(rtc->rtc_dev);
> >>  
> >> -	return 0;
> >> +	return PTR_ERR_OR_ZERO(rtc->rtc_dev);
> > As many other maintainers, I don't find that kind of change useful and
> > I'm not taking them unless there are other improvements in the driver.
> >
> >
> Hi,  Alexandre
> 
> The issue is detected with the help of  Coccinelle.  It simplify the code with specific
> function rather than duplicating its implementation.
> 
> The patch clean up the code.   of course,  it is not a bug.  if you do not care about it.
> I am ok with that.
> 

But this does not simplify or make the code clearer and as soon as you
need to add code between the devm_rtc_device_register call and the end
of the function, the patch will need to be undone.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
