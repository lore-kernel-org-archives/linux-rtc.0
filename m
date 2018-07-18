Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.micronovasrl.com ([212.103.203.10]:43558 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729462AbeGROtj (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 18 Jul 2018 10:49:39 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id CEF98B00756
        for <linux-rtc@vger.kernel.org>; Wed, 18 Jul 2018 16:11:32 +0200 (CEST)
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4joy4Q-buIDc for <linux-rtc@vger.kernel.org>;
        Wed, 18 Jul 2018 16:11:32 +0200 (CEST)
Subject: Re: [PATCH v10 4/4] rtc: ds1307: add frequency_test_enable sysfs
 attribute to check tick on m41txx
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM"
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <CAHp75VcaALb8fYJExnZ=Ye=GcNHc3aPXgFihVK+rAu_a1A01Sg@mail.gmail.com>
 <20180718140946.115093-1-giulio.benetti@micronovasrl.com>
 <20180718140946.115093-3-giulio.benetti@micronovasrl.com>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <a16db824-636d-2186-1f07-0bbeb1b607ab@micronovasrl.com>
Date: Wed, 18 Jul 2018 16:11:30 +0200
MIME-Version: 1.0
In-Reply-To: <20180718140946.115093-3-giulio.benetti@micronovasrl.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Add Andy in Cc

Il 18/07/2018 16:09, Giulio Benetti ha scritto:
> On m41txx you can enable open-drain OUT pin to check if offset is ok.
> Enabling OUT pin with frequency_test_enable attribute, OUT pin will tick
> 512 times faster than 1s tick base.
> 
> Enable or Disable FT bit on CONTROL register if freq_test is 1 or 0.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>   drivers/rtc/rtc-ds1307.c | 94 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 94 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
> index c6d871456f25..2efe55f43774 100644
> --- a/drivers/rtc/rtc-ds1307.c
> +++ b/drivers/rtc/rtc-ds1307.c
> @@ -1050,6 +1050,94 @@ static int m41txx_rtc_set_offset(struct device *dev, long offset)
>   				  ctrl_reg);
>   }
>   
> +static ssize_t frequency_test_enable_store(struct device *dev,
> +					   struct device_attribute *attr,
> +					   const char *buf, size_t count)
> +{
> +	struct ds1307 *ds1307 = dev_get_drvdata(dev);
> +	bool freq_test_en;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &freq_test_en);
> +	if (ret == -EINVAL) {
> +		dev_err(dev, "Failed to store RTC Frequency Test attribute\n");
> +		return ret;
> +	}
> +
> +	regmap_update_bits(ds1307->regmap, M41TXX_REG_CONTROL, M41TXX_BIT_FT,
> +			   freq_test_en ? M41TXX_BIT_FT : 0);
> +
> +	return count;
> +}
> +
> +static ssize_t frequency_test_enable_show(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	struct ds1307 *ds1307 = dev_get_drvdata(dev);
> +	unsigned int ctrl_reg;
> +
> +	regmap_read(ds1307->regmap, M41TXX_REG_CONTROL, &ctrl_reg);
> +
> +	return scnprintf(buf, PAGE_SIZE, (ctrl_reg & M41TXX_BIT_FT) ? "on\n" :
> +			"off\n");
> +}
> +
> +static DEVICE_ATTR_RW(frequency_test_enable);
> +
> +static struct attribute *rtc_freq_test_attrs[] = {
> +	&dev_attr_frequency_test_enable.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group rtc_freq_test_attr_group = {
> +	.attrs		= rtc_freq_test_attrs,
> +};
> +
> +static void rtc_calib_remove_sysfs_group(void *_dev)
> +{
> +	struct device *dev = _dev;
> +
> +	sysfs_remove_group(&dev->kobj, &rtc_freq_test_attr_group);
> +}
> +
> +static int ds1307_add_frequency_test(struct ds1307 *ds1307)
> +{
> +	int err;
> +
> +	switch (ds1307->type) {
> +	case m41t0:
> +	case m41t00:
> +	case m41t11:
> +		/* Export sysfs entries */
> +		err = sysfs_create_group(&(ds1307->dev)->kobj,
> +					 &rtc_freq_test_attr_group);
> +		if (err) {
> +			dev_err(ds1307->dev,
> +				"Failed to create sysfs group: %d\n",
> +				err);
> +			return err;
> +		}
> +
> +		err = devm_add_action_or_reset(ds1307->dev,
> +					       rtc_calib_remove_sysfs_group,
> +					       ds1307->dev);
> +		if (err) {
> +			dev_err(ds1307->dev,
> +				"Failed to add sysfs cleanup action: %d\n",
> +				err);
> +			sysfs_remove_group(&(ds1307->dev)->kobj,
> +					   &rtc_freq_test_attr_group);
> +			return err;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
>   /*----------------------------------------------------------------------*/
>   
>   static int ds1307_nvram_read(void *priv, unsigned int offset, void *val,
> @@ -1792,6 +1880,12 @@ static int ds1307_probe(struct i2c_client *client,
>   	if (err)
>   		return err;
>   
> +	err = ds1307_add_frequency_test(ds1307);
> +	if (err) {
> +		rtc_device_unregister(ds1307->rtc);
> +		return err;
> +	}
> +
>   	if (chip->nvram_size) {
>   		struct nvmem_config nvmem_cfg = {
>   			.name = "ds1307_nvram",
> 


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
