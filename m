Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CAEC433F5
	for <linux-rtc@archiver.kernel.org>; Tue, 15 Feb 2022 22:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241149AbiBOW2B (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 15 Feb 2022 17:28:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbiBOW2B (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 15 Feb 2022 17:28:01 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D04F95A0B;
        Tue, 15 Feb 2022 14:27:49 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id CAFEF20002;
        Tue, 15 Feb 2022 22:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644964068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rcDG/pEXhTqGFyte4Xe1d7IY1K/7Jn8oC0T5I0QumNk=;
        b=CoZuzD9ObjgHBzfi8wtsy0/YUMEGHaxg2HhadSVq2OoRhX4a2zh9FXLXPYvxyexsn62MEl
        6jWlO0s5U46emJAewMDTgCNPYHvmrJaGYgKYWWSEOucu3xTLtmIHmjZPc9OSu/mb0mUM7y
        OtXnsYE3GtSDvWqjiBteKndkt6ifbC1vh2CODH6lqOhQZJchmxY9fXVJUVuBThrLXGpVY5
        Fma80UzEJ0eeSUsqSl/0efg7vsc265gA4W6VhVTphMZeRgz5w4t3t9ywkvaBkNBVP5Dl2G
        +HvLA/2Q0bZIVam9JvqgPIVsvaAo+7WBuHsyOc//XVnw40drNWOLnEweMTIEtw==
Date:   Tue, 15 Feb 2022 23:27:46 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: pcf2127: add error checking and message when
 disabling POR0
Message-ID: <Ygwo4iXtE/hCA5IZ@piout.net>
References: <20220117225625.1252233-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117225625.1252233-1-hugo@hugovil.com>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hello,

On 17/01/2022 17:56:24-0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> If PCF2127 device is absent from the I2C bus, or if there is a
> communication problem, disabling POR0 may fail silently and we
> still continue with probing the device. In that case, abort probe
> operation and display an error message.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  drivers/rtc/rtc-pcf2127.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> index 81a5b1f2e68c..e6d0838ccfe3 100644
> --- a/drivers/rtc/rtc-pcf2127.c
> +++ b/drivers/rtc/rtc-pcf2127.c
> @@ -690,8 +690,12 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
>  	 * The "Power-On Reset Override" facility prevents the RTC to do a reset
>  	 * after power on. For normal operation the PORO must be disabled.
>  	 */
> -	regmap_clear_bits(pcf2127->regmap, PCF2127_REG_CTRL1,
> +	ret = regmap_clear_bits(pcf2127->regmap, PCF2127_REG_CTRL1,
>  				PCF2127_BIT_CTRL1_POR_OVRD);
> +	if (ret < 0) {
> +		dev_err(dev, "PORO disabling failed\n");

As discussed on the other patches, please do not add a message here.


> +		return ret;
> +	}
>  
>  	ret = regmap_read(pcf2127->regmap, PCF2127_REG_CLKOUT, &val);
>  	if (ret < 0)
> -- 
> 2.30.2
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
