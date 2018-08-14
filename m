Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:32954 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728978AbeHNTDc (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 14 Aug 2018 15:03:32 -0400
Date: Tue, 14 Aug 2018 18:15:41 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: zhong jiang <zhongjiang@huawei.com>
Cc: a.zummo@towertech.it, baruch@tkos.co.il, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rtc:rtc-digicolor: Use PTR_ERR_OR_ZERO to replace
 the open code
Message-ID: <20180814161541.GP943@piout.net>
References: <1534159885-25364-1-git-send-email-zhongjiang@huawei.com>
 <1534159885-25364-2-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1534159885-25364-2-git-send-email-zhongjiang@huawei.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

On 13/08/2018 19:31:24+0800, zhong jiang wrote:
> PTR_ERR_OR_ZERO has implemented the if(IS_ERR(...)) + PTR_ERR, So
> just replace them rather than duplicating its implement.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/rtc/rtc-digicolor.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-digicolor.c b/drivers/rtc/rtc-digicolor.c
> index b253bf1..fd6850c 100644
> --- a/drivers/rtc/rtc-digicolor.c
> +++ b/drivers/rtc/rtc-digicolor.c
> @@ -202,10 +202,8 @@ static int __init dc_rtc_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, rtc);
>  	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, pdev->name,
>  						&dc_rtc_ops, THIS_MODULE);
> -	if (IS_ERR(rtc->rtc_dev))
> -		return PTR_ERR(rtc->rtc_dev);
>  
> -	return 0;
> +	return PTR_ERR_OR_ZERO(rtc->rtc_dev);

As many other maintainers, I don't find that kind of change useful and
I'm not taking them unless there are other improvements in the driver.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
