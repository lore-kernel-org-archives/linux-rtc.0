Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:40285 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbeGRIt5 (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 18 Jul 2018 04:49:57 -0400
Date: Wed, 18 Jul 2018 10:13:13 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Denis OSTERLAND <denis.osterland@diehl.com>
Cc: "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v4 2/5] rtc: isl1208: add support for isl1219 with tamper
 detection
Message-ID: <20180718081313.GI3211@piout.net>
References: <20180710090710.9066-1-Denis.Osterland@diehl.com>
 <20180710090710.9066-3-Denis.Osterland@diehl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180710090710.9066-3-Denis.Osterland@diehl.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 10/07/2018 09:44:15+0000, Denis OSTERLAND wrote:
>  static int
>  isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  {
> @@ -642,6 +744,7 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	rtc->ops = &isl1208_rtc_ops;
> 
>  	i2c_set_clientdata(client, rtc);
> +	dev_set_drvdata(&rtc->dev, client);
> 
>  	rc = isl1208_i2c_get_sr(client);
>  	if (rc < 0) {
> @@ -653,6 +756,18 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  		dev_warn(&client->dev, "rtc power failure detected, "
>  			 "please set clock.\n");
> 
> +	if (id->driver_data == TYPE_ISL1219) {
> +		rc = ISL1219_REG_EV_EVEN;
> +		rc = i2c_smbus_write_byte_data(client, ISL1219_REG_EV, rc);

I'd pass ISL1219_REG_EV_EVEN directly instead of assigning it to rc.

> +		if (rc < 0) {
> +			dev_err(&client->dev, "could not enable tamper detection\n");
> +			return rc;
> +		}
> +		rc = rtc_add_group(rtc, &isl1219_rtc_sysfs_files);
> +		if (rc)
> +			return rc;
> +	}
> +
>  	rc = sysfs_create_group(&client->dev.kobj, &isl1208_rtc_sysfs_files);
>  	if (rc)
>  		return rc;
> @@ -686,8 +801,9 @@ isl1208_remove(struct i2c_client *client)
>  }
> 
>  static const struct i2c_device_id isl1208_id[] = {
> -	{ "isl1208", 0 },
> -	{ "isl1218", 0 },
> +	{ "isl1208", TYPE_ISL1208 },
> +	{ "isl1218", TYPE_ISL1218 },
> +	{ "isl1219", TYPE_ISL1219 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, isl1208_id);
> @@ -695,6 +811,7 @@ MODULE_DEVICE_TABLE(i2c, isl1208_id);
>  static const struct of_device_id isl1208_of_match[] = {
>  	{ .compatible = "isil,isl1208" },
>  	{ .compatible = "isil,isl1218" },
> +	{ .compatible = "isil,isl1219" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, isl1208_of_match);
> --
> 2.18.0
> 
> 
> 
> Diehl Connectivity Solutions GmbH
> Geschäftsführung: Horst Leonberger
> Sitz der Gesellschaft: Nürnberg - Registergericht: Amtsgericht
> Nürnberg: HRB 32315
> ___________________________________________________________________________________________________
> 
> Der Inhalt der vorstehenden E-Mail ist nicht rechtlich bindend. Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen.
> Informieren Sie uns bitte, wenn Sie diese E-Mail faelschlicherweise erhalten haben. Bitte loeschen Sie in diesem Fall die Nachricht.
> Jede unerlaubte Form der Reproduktion, Bekanntgabe, Aenderung, Verteilung und/oder Publikation dieser E-Mail ist strengstens untersagt.
> The contents of the above mentioned e-mail is not legally binding. This e-mail contains confidential and/or legally protected information. Please inform us if you have received this e-mail by
> mistake and delete it in such a case. Each unauthorized reproduction, disclosure, alteration, distribution and/or publication of this e-mail is strictly prohibited.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
