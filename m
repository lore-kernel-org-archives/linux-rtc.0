Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.micronovasrl.com ([212.103.203.10]:60430 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935561AbeEISqN (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 9 May 2018 14:46:13 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id 3E753B00AE1
        for <linux-rtc@vger.kernel.org>; Wed,  9 May 2018 20:46:12 +0200 (CEST)
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 45Hupgh8EJR2 for <linux-rtc@vger.kernel.org>;
        Wed,  9 May 2018 20:46:11 +0200 (CEST)
Subject: Re: [PATCH v2 4/4] rtc: ds1307: add freq_test sysfs attribute to
 check tick on m41txx
To: a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180509182812.17646-1-giulio.benetti@micronovasrl.com>
 <20180509182812.17646-4-giulio.benetti@micronovasrl.com>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <de96728f-c5c6-0d2e-4814-21105c0683ed@micronovasrl.com>
Date: Wed, 9 May 2018 20:46:09 +0200
MIME-Version: 1.0
In-Reply-To: <20180509182812.17646-4-giulio.benetti@micronovasrl.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Sorry everybody,

Il 09/05/2018 20:28, Giulio Benetti ha scritto:
>   static int ds1307_probe(struct i2c_client *client,
>   			const struct i2c_device_id *id)
>   {
> @@ -1783,6 +1851,24 @@ static int ds1307_probe(struct i2c_client *client,
>   	if (err)
>   		return err;
>   
> +	/* Export sysfs entries */
> +	err = sysfs_create_group(&(&client->dev)->kobj, &rtc_calib_attr_group);
> +	if (err) {
> +		dev_err(&client->dev, "Failed to create sysfs group: %d\n",
> +			err);
> +		return err;
> +	}
> +
> +	err = devm_add_action_or_reset(&client->dev,
> +				       rtc_calib_remove_sysfs_group,
> +				       &client->dev);
> +	if (err) {
> +		dev_err(&client->dev,
> +			"Failed to add sysfs cleanup action: %d\n",
> +			err);
> +		return err;
> +	}
> +
>   	if (chip->nvram_size) {
>   		struct nvmem_config nvmem_cfg = {
>   			.name = "ds1307_nvram",
> 

Adding sysfs must be done only for mt41xx series.
I correct and submit V3 patchest.
Sorry again.

-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale ¤ 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
