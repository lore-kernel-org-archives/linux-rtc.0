Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:38309 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729443AbeHNHD3 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Tue, 14 Aug 2018 03:03:29 -0400
Date: Tue, 14 Aug 2018 07:18:05 +0300
From: Baruch Siach <baruch@tkos.co.il>
To: zhong jiang <zhongjiang@huawei.com>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rtc:rtc-digicolor: Use PTR_ERR_OR_ZERO to replace
 the open code
Message-ID: <20180814041805.666uaxe2gf75r3wr@sapphire.tkos.co.il>
References: <1534159885-25364-1-git-send-email-zhongjiang@huawei.com>
 <1534159885-25364-2-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1534159885-25364-2-git-send-email-zhongjiang@huawei.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi zhong,

On Mon, Aug 13, 2018 at 07:31:24PM +0800, zhong jiang wrote:
> PTR_ERR_OR_ZERO has implemented the if(IS_ERR(...)) + PTR_ERR, So
> just replace them rather than duplicating its implement.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Acked-by: Baruch Siach <baruch@tkos.co.il>

Thanks,
baruch

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
>  }
>  
>  static const struct of_device_id dc_dt_ids[] = {

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
