Return-Path: <SRS0=M17z=QH=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE22C169C4
	for <linux-rtc@archiver.kernel.org>; Thu, 31 Jan 2019 15:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81342085B
	for <linux-rtc@archiver.kernel.org>; Thu, 31 Jan 2019 15:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfAaPaU (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:30:20 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:48495 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfAaPaU (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 31 Jan 2019 10:30:20 -0500
X-Originating-IP: 109.213.13.254
Received: from localhost (alyon-652-1-30-254.w109-213.abo.wanadoo.fr [109.213.13.254])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 17778E0002;
        Thu, 31 Jan 2019 15:30:15 +0000 (UTC)
Date:   Thu, 31 Jan 2019 16:30:12 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 2/2] rtc: x1205: Add DT probing support
Message-ID: <20190131153012.GA15115@piout.net>
References: <20190131150642.26289-1-linus.walleij@linaro.org>
 <20190131150642.26289-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131150642.26289-2-linus.walleij@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi Linus,

On 31/01/2019 16:06:42+0100, Linus Walleij wrote:
> This makes it possible to probe the X1205 RTC from the
> device tree. This is needed when adding device tree boot
> support for the IXP4xx-based NSLU2 which has this RTC.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/rtc/rtc-x1205.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-x1205.c b/drivers/rtc/rtc-x1205.c
> index f08f18e4fcdf..c2b64c9363da 100644
> --- a/drivers/rtc/rtc-x1205.c
> +++ b/drivers/rtc/rtc-x1205.c
> @@ -673,9 +673,15 @@ static const struct i2c_device_id x1205_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, x1205_id);
>  
> +static const struct of_device_id x1205_dt_ids[] = {
> +	{ .compatible = "xircom,x1205", },
> +};
> +MODULE_DEVICE_TABLE(of, x1205_dt_ids);
> +

I think this is not necessary and this will probe without the
of_match_table but it doesn't hurt either.

>  static struct i2c_driver x1205_driver = {
>  	.driver		= {
>  		.name	= "rtc-x1205",
> +		.of_match_table = x1205_dt_ids,
>  	},
>  	.probe		= x1205_probe,
>  	.remove		= x1205_remove,
> -- 
> 2.20.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
