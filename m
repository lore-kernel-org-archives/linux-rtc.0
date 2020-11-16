Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA867C2D0A3
	for <linux-rtc@archiver.kernel.org>; Mon, 16 Nov 2020 17:26:55 +0000 (UTC)
Received: from vger.kernel.org (unknown [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D2EF221FD
	for <linux-rtc@archiver.kernel.org>; Mon, 16 Nov 2020 17:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2EF221FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbgKPR0z (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 16 Nov 2020 12:26:55 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:48401 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731195AbgKPR0z (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 16 Nov 2020 12:26:55 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 5A424240002;
        Mon, 16 Nov 2020 17:26:53 +0000 (UTC)
Date:   Mon, 16 Nov 2020 18:26:53 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: mxc: Remove unused .id_table support
Message-ID: <20201116172653.GU4556@piout.net>
References: <20201116154303.15055-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116154303.15055-1-festevam@gmail.com>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hello,

On 16/11/2020 12:43:03-0300, Fabio Estevam wrote:
> Since 5.10-rc1 i.MX is a devicetree-only platform and the existing
> .id_table support in this driver was only useful for old non-devicetree
> platforms.
> 
> Get rid of the .id_table since it is no longer used.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  drivers/rtc/rtc-mxc.c | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-mxc.c b/drivers/rtc/rtc-mxc.c
> index a8cfbde048f4..78d7fba00895 100644
> --- a/drivers/rtc/rtc-mxc.c
> +++ b/drivers/rtc/rtc-mxc.c
> @@ -70,19 +70,6 @@ struct rtc_plat_data {
>  	enum imx_rtc_type devtype;
>  };
>  
> -static const struct platform_device_id imx_rtc_devtype[] = {
> -	{
> -		.name = "imx1-rtc",
> -		.driver_data = IMX1_RTC,
> -	}, {
> -		.name = "imx21-rtc",
> -		.driver_data = IMX21_RTC,
> -	}, {
> -		/* sentinel */
> -	}
> -};
> -MODULE_DEVICE_TABLE(platform, imx_rtc_devtype);
> -
>  #ifdef CONFIG_OF

Is this #ifdef still necessary?

>  static const struct of_device_id imx_rtc_dt_ids[] = {
>  	{ .compatible = "fsl,imx1-rtc", .data = (const void *)IMX1_RTC },
> @@ -438,7 +425,6 @@ static struct platform_driver mxc_rtc_driver = {
>  		   .name	= "mxc_rtc",
>  		   .of_match_table = of_match_ptr(imx_rtc_dt_ids),
>  	},
> -	.id_table = imx_rtc_devtype,
>  	.probe = mxc_rtc_probe,
>  };
>  
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
