Return-Path: <SRS0=pWyL=RS=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3AFC10F00
	for <linux-rtc@archiver.kernel.org>; Fri, 15 Mar 2019 13:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83072218AC
	for <linux-rtc@archiver.kernel.org>; Fri, 15 Mar 2019 13:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbfCONmz (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:42:55 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:47519 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbfCONmy (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 15 Mar 2019 09:42:54 -0400
X-Originating-IP: 109.213.80.250
Received: from localhost (alyon-652-1-57-250.w109-213.abo.wanadoo.fr [109.213.80.250])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id C9E5A4000F;
        Fri, 15 Mar 2019 13:42:51 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] rtc: mv: convert to devm_rtc_allocate_device
In-Reply-To: <20190315133513.9909-2-alexandre.belloni@bootlin.com>
References: <20190315133513.9909-1-alexandre.belloni@bootlin.com> <20190315133513.9909-2-alexandre.belloni@bootlin.com>
Date:   Fri, 15 Mar 2019 14:42:51 +0100
Message-ID: <87d0mstfs4.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi Alexandre,
 
 On ven., mars 15 2019, Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> This allows further improvement of the driver.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Tested-by: Gregory CLEMENT <gregory.clement@bootlin.com>

on Armada XP GP

Thanks,

Gregory

> ---
>  drivers/rtc/rtc-mv.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/rtc/rtc-mv.c b/drivers/rtc/rtc-mv.c
> index d13d06ea6709..ef704aef8663 100644
> --- a/drivers/rtc/rtc-mv.c
> +++ b/drivers/rtc/rtc-mv.c
> @@ -254,15 +254,7 @@ static int __init mv_rtc_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, pdata);
>  
> -	if (pdata->irq >= 0) {
> -		device_init_wakeup(&pdev->dev, 1);
> -		pdata->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
> -						 &mv_rtc_alarm_ops,
> -						 THIS_MODULE);
> -	} else {
> -		pdata->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
> -						 &mv_rtc_ops, THIS_MODULE);
> -	}
> +	pdata->rtc = devm_rtc_allocate_device(&pdev->dev);
>  	if (IS_ERR(pdata->rtc)) {
>  		ret = PTR_ERR(pdata->rtc);
>  		goto out;
> @@ -278,7 +270,16 @@ static int __init mv_rtc_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	return 0;
> +	if (pdata->irq >= 0) {
> +		device_init_wakeup(&pdev->dev, 1);
> +		pdata->rtc->ops = &mv_rtc_alarm_ops;
> +	} else {
> +		pdata->rtc->ops = &mv_rtc_ops;
> +	}
> +
> +	ret = rtc_register_device(pdata->rtc);
> +	if (!ret)
> +		return 0;
>  out:
>  	if (!IS_ERR(pdata->clk))
>  		clk_disable_unprepare(pdata->clk);
> -- 
> 2.20.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
