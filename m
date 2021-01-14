Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AC7C433E0
	for <linux-rtc@archiver.kernel.org>; Thu, 14 Jan 2021 09:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2D53239EB
	for <linux-rtc@archiver.kernel.org>; Thu, 14 Jan 2021 09:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbhANJun (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 14 Jan 2021 04:50:43 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:54303 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbhANJum (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 14 Jan 2021 04:50:42 -0500
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id DD4F4E0013;
        Thu, 14 Jan 2021 09:50:08 +0000 (UTC)
Date:   Thu, 14 Jan 2021 10:50:08 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Philipp Rosenberger <p.rosenberger@kunbus.com>
Cc:     dan.carpenter@oracle.com, u.kleine-koenig@pengutronix.de,
        biwen.li@nxp.com, lvb@xiphos.com, bruno.thomsen@gmail.com,
        l.sanfilippo@kunbus.com, Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rtc: pcf2127: Run a OTP refresh if not done before
Message-ID: <20210114095008.GV3654@piout.net>
References: <20210113112742.7354-1-p.rosenberger@kunbus.com>
 <20210113112742.7354-3-p.rosenberger@kunbus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113112742.7354-3-p.rosenberger@kunbus.com>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 13/01/2021 12:27:42+0100, Philipp Rosenberger wrote:
> The datasheet of the PCF2127 states,it is recommended to process an OTP
> refresh once the power is up and the oscillator is operating stable. The
> OTP refresh takes less than 100 ms to complete.
> 
> Signed-off-by: Philipp Rosenberger <p.rosenberger@kunbus.com>
> ---
>  drivers/rtc/rtc-pcf2127.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
> index 378b1ce812d6..ca56dba64e79 100644
> --- a/drivers/rtc/rtc-pcf2127.c
> +++ b/drivers/rtc/rtc-pcf2127.c
> @@ -58,6 +58,9 @@
>  #define PCF2127_REG_ALARM_DM		0x0D
>  #define PCF2127_REG_ALARM_DW		0x0E
>  #define PCF2127_BIT_ALARM_AE			BIT(7)
> +/* CLKOUT control register */
> +#define PCF2127_REG_CLKOUT		0x0f
> +#define PCF2127_BIT_CLKOUT_OTPR			BIT(5)
>  /* Watchdog registers */
>  #define PCF2127_REG_WD_CTL		0x10
>  #define PCF2127_BIT_WD_CTL_TF0			BIT(0)
> @@ -630,6 +633,19 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
>  		dev_warn(dev, "Watchdog and alarm functions might not work properly\n");
>  	}
>  
> +	/*
> +	 * Set the OTP refresh bit unconditionally. If an OTP refresh was
> +	 * already done the bit is already set and will not rerun the refresh
> +	 * operation.
> +	 */
> +	ret = regmap_set_bits(pcf2127->regmap, PCF2127_REG_CLKOUT,
> +			      PCF2127_BIT_CLKOUT_OTPR);
> +	if (ret < 0) {
> +		dev_err(dev, "%s: OTP refresh (clkout_ctrl) failed.\n", __func__);

Please drop this error message.

> +		return ret;
> +	}
> +	msleep(100);

Maybe this should be done just before setting the time. Or if you want
to keep it in probe, then you could optimise by not waiting but ensuring
the time between pcf2127_probe and the first pcf2127_rtc_set_time is
more than 100ms.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
