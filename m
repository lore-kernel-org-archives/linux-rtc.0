Return-Path: <SRS0=RSfM=QR=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F78C282C2
	for <linux-rtc@archiver.kernel.org>; Sun, 10 Feb 2019 21:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE452145D
	for <linux-rtc@archiver.kernel.org>; Sun, 10 Feb 2019 21:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfBJVMm (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sun, 10 Feb 2019 16:12:42 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:57979 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfBJVMm (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 10 Feb 2019 16:12:42 -0500
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 6DE9C1BF208;
        Sun, 10 Feb 2019 21:12:39 +0000 (UTC)
Date:   Sun, 10 Feb 2019 22:12:39 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH 2/3] rtc: isl1208: Support more chip variations
Message-ID: <20190210211239.GH23062@piout.net>
References: <20190201194147.25885-1-tpiepho@impinj.com>
 <20190201194147.25885-2-tpiepho@impinj.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201194147.25885-2-tpiepho@impinj.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi,

Very few comments below:

On 01/02/2019 19:42:12+0000, Trent Piepho wrote:
> Add more support in the driver for dealing with differences in is1208
> compatible chips.  Put the 1208, 1209, 1218, and 1219 in the list and
> encode information about nvram size, tamper, and timestamp features.
> 
> This adds support for the isl1209, which has a tamper detect but no
> timestamp feature.
> 
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Trent Piepho <tpiepho@impinj.com>
> ---
>  drivers/rtc/rtc-isl1208.c | 78 ++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 56 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
> index d8e0670e12fc..77912ee58011 100644
> --- a/drivers/rtc/rtc-isl1208.c
> +++ b/drivers/rtc/rtc-isl1208.c
> @@ -73,15 +73,49 @@
>  static struct i2c_driver isl1208_driver;
>  
>  /* ISL1208 various variants */
> -enum {
> +enum isl1208_id {
>  	TYPE_ISL1208 = 0,
>  	TYPE_ISL1218,
>  	TYPE_ISL1219,
> +	TYPE_ISL1209,

I would keep that list ordered.

> +	ISL_LAST_ID
>  };
>  
> +/* Chip capabilities table */
> +static const struct isl1208_config {
> +	const char	name[8];
> +	unsigned int	nvmem_length;
> +	unsigned	has_tamper:1;
> +	unsigned	has_timestamp:1;
> +} isl1208_configs[] = {
> +	[TYPE_ISL1208] = { "isl1208", 2, false, false },
> +	[TYPE_ISL1209] = { "isl1209", 2, true,  false },
> +	[TYPE_ISL1218] = { "isl1218", 8, false, false },
> +	[TYPE_ISL1219] = { "isl1219", 2, true,  true },
> +};
> +
> +static const struct i2c_device_id isl1208_id[] = {
> +	{ "isl1208", TYPE_ISL1208 },
> +	{ "isl1209", TYPE_ISL1209 },
> +	{ "isl1218", TYPE_ISL1218 },
> +	{ "isl1219", TYPE_ISL1219 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, isl1208_id);
> +
> +static const struct of_device_id isl1208_of_match[] = {
> +	{ .compatible = "isil,isl1208", .data = &isl1208_configs[TYPE_ISL1208] },
> +	{ .compatible = "isil,isl1209", .data = &isl1208_configs[TYPE_ISL1209] },

This compatible needs to be documented.

> +	{ .compatible = "isil,isl1218", .data = &isl1208_configs[TYPE_ISL1218] },
> +	{ .compatible = "isil,isl1219", .data = &isl1208_configs[TYPE_ISL1219] },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, isl1208_of_match);
> +
>  /* Device state */
>  struct isl1208_state {
>  	struct rtc_device *rtc;
> +	const struct isl1208_config *config;
>  };
>  
>  /* block read */
> @@ -602,11 +636,12 @@ isl1208_rtc_interrupt(int irq, void *data)
>  			return err;
>  	}
>  
> -	if (sr & ISL1208_REG_SR_EVT) {
> -		sysfs_notify(&isl1208->rtc->dev.kobj, NULL,
> -			     dev_attr_timestamp0.attr.name);
> +	if (isl1208->config->has_tamper && (sr & ISL1208_REG_SR_EVT)) {
>  		dev_warn(&client->dev, "event detected");
>  		handled = 1;
> +		if (isl1208->config->has_timestamp)
> +			sysfs_notify(&isl1208->rtc->dev.kobj, NULL,
> +				     dev_attr_timestamp0.attr.name);
>  	}
>  
>  	return handled ? IRQ_HANDLED : IRQ_NONE;
> @@ -743,6 +778,19 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  		return -ENOMEM;
>  	i2c_set_clientdata(client, isl1208);
>  
> +	/* Determine which chip we have */
> +	if (client->dev.of_node) {
> +		const struct of_device_id *match =
> +			of_match_node(isl1208_of_match, client->dev.of_node);
> +		if (!match)

This will never happen, else the driver would not be probed.

> +			return -EINVAL;
> +		isl1208->config = match->data;

Maybe you should use of_device_get_match_data anyway.

> +	} else {
> +		if (id->driver_data >= ISL_LAST_ID)
> +			return -EINVAL;

This should be -ENODEV.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
