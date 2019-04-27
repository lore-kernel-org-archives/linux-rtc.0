Return-Path: <SRS0=fKgR=S5=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B44C43218
	for <linux-rtc@archiver.kernel.org>; Sat, 27 Apr 2019 13:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64964208C2
	for <linux-rtc@archiver.kernel.org>; Sat, 27 Apr 2019 13:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfD0NLZ (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sat, 27 Apr 2019 09:11:25 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:34867 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD0NLZ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 27 Apr 2019 09:11:25 -0400
X-Originating-IP: 90.66.53.80
Received: from localhost (lfbn-1-3034-80.w90-66.abo.wanadoo.fr [90.66.53.80])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 36DE5E0004;
        Sat, 27 Apr 2019 13:11:21 +0000 (UTC)
Date:   Sat, 27 Apr 2019 15:11:21 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "Howey, Dylan" <Dylan.Howey@tennantco.com>
Cc:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
Subject: Re: [PATCH 2/2] Add alarm support to rtc-pcf2123
Message-ID: <20190427131121.GZ14604@piout.net>
References: <20190426193648.1599-1-Dylan.Howey@tennantco.com>
 <20190426193648.1599-2-Dylan.Howey@tennantco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426193648.1599-2-Dylan.Howey@tennantco.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 26/04/2019 19:37:15+0000, Howey, Dylan wrote:
> +static int pcf2123_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
> +{
> +	struct pcf2123_plat_data *pdata = dev_get_platdata(dev);
> +	u8 rxbuf[4];
> +	int ret;
> +	unsigned int val = 0;
> +
> +	ret = regmap_bulk_read(pdata->map, PCF2123_REG_ALRM_MN, rxbuf, 4);

sizeof(rxbuf) instead of 4.

> +	if (ret)
> +		return ret;
> +
> +	alm->time.tm_min = bcd2bin(rxbuf[0] & 0x7F);
> +	alm->time.tm_hour = bcd2bin(rxbuf[1] & 0x3F);
> +	alm->time.tm_mday = bcd2bin(rxbuf[2] & 0x3F);
> +	alm->time.tm_wday = bcd2bin(rxbuf[3] & 0x07);
> +
> +	dev_dbg(dev, "%s: alm is secs=%d, mins=%d, hours=%d mday=%d, mon=%d, year=%d, wday=%d\n",
> +			__func__,
> +			alm->time.tm_sec, alm->time.tm_min, alm->time.tm_hour,
> +			alm->time.tm_mday, alm->time.tm_mon, alm->time.tm_year,
> +			alm->time.tm_wday);
> +

Please use %ptR.

> +	ret = regmap_read(pdata->map, PCF2123_REG_CTRL2, &val);
> +	if (ret)
> +		return ret;
> +
> +	alm->enabled = !!(val & CTRL2_AIE);
> +
> +	return 0;
> +}
> +
> +static int pcf2123_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
> +{
> +	struct pcf2123_plat_data *pdata = dev_get_platdata(dev);
> +	u8 txbuf[4];
> +	int ret;
> +	unsigned int val = 0;
> +
> +	dev_dbg(dev, "%s: alm is secs=%d, mins=%d, hours=%d, mday=%d, mon=%d, year=%d, wday=%d\n",
> +			__func__,
> +			alm->time.tm_sec, alm->time.tm_min, alm->time.tm_hour,
> +			alm->time.tm_mday, alm->time.tm_mon, alm->time.tm_year,
> +			alm->time.tm_wday);
> +

Ditto

> +	/* Disable alarm */
> +	ret = regmap_read(pdata->map, PCF2123_REG_CTRL2, &val);
> +	if (ret)
> +		return ret;
> +
> +	val &= ~(CTRL2_AIE);
> +	ret = regmap_write(pdata->map, PCF2123_REG_CTRL2, val);
> +
Please use regmap_update_bits

> +	/* Set new alarm */
> +	txbuf[0] = bin2bcd(alm->time.tm_min & 0x7F);
> +	txbuf[1] = bin2bcd(alm->time.tm_hour & 0x3F);
> +	txbuf[2] = bin2bcd(alm->time.tm_mday & 0x3F);
> +	txbuf[3] = bin2bcd(alm->time.tm_wday & 0x07);
> +
> +	ret = regmap_bulk_write(pdata->map, PCF2123_REG_ALRM_MN, txbuf, 4);

sizeof(txbuf)

> +	if (ret)
> +		return ret;
> +
> +	if (alm->enabled)	{
> +		ret = regmap_read(pdata->map, PCF2123_REG_CTRL2, &val);
> +		if (ret)
> +			return ret;
> +
> +		val |= CTRL2_AIE;
> +		ret = regmap_write(pdata->map, PCF2123_REG_CTRL2, val);
> +		if (ret)
> +			return ret;

Use regmap_update_bits

> +	}
> +
> +	return 0;
> +}
> +
> +static irqreturn_t pcf2123_rtc_irq(int irq, void *dev)
> +{
> +	struct pcf2123_plat_data *pdata = dev_get_platdata(dev);
> +	struct mutex *lock = &pdata->rtc->ops_lock;
> +	unsigned int val = 0;
> +	int ret = IRQ_NONE;
> +
> +	mutex_lock(lock);
> +	regmap_read(pdata->map, PCF2123_REG_CTRL2, &val);
> +
> +	/* Alarm? */
> +	if (val & CTRL2_AF) {
> +		ret = IRQ_HANDLED;
> +
> +		val &= ~(CTRL2_AF);
> +		regmap_write(pdata->map, PCF2123_REG_CTRL2, val);
> +
> +		rtc_update_irq(pdata->rtc, 1, RTC_IRQF | RTC_AF);
> +	}
> +
> +	mutex_unlock(lock);
> +
> +	return ret;
> +}
> +
>  static int pcf2123_reset(struct device *dev)
>  {
>  	struct pcf2123_plat_data *pdata = dev_get_platdata(dev);
> @@ -347,6 +448,8 @@ static const struct rtc_class_ops pcf2123_rtc_ops = {
>  	.set_time	= pcf2123_rtc_set_time,
>  	.read_offset	= pcf2123_read_offset,
>  	.set_offset	= pcf2123_set_offset,
> +	.read_alarm = pcf2123_rtc_read_alarm,
> +	.set_alarm = pcf2123_rtc_set_alarm,

Please keep that struct aligned

>  
>  };
>  
> @@ -391,6 +494,8 @@ static int pcf2123_probe(struct spi_device *spi)
>  	dev_info(&spi->dev, "spiclk %u KHz.\n",
>  			(spi->max_speed_hz + 500) / 1000);
>  
> +	device_init_wakeup(&spi->dev, true);
> +

This should be done only when you have an irq and the irq handler was
properly registered.

>  	/* Finalize the initialization */
>  	rtc = devm_rtc_device_register(&spi->dev, pcf2123_driver.driver.name,
>  			&pcf2123_rtc_ops, THIS_MODULE);
> @@ -418,6 +523,16 @@ static int pcf2123_probe(struct spi_device *spi)
>  		}
>  	}
>  
> +	/* Register alarm irq */
> +	if (spi->irq >= 0)	{
> +		ret = devm_request_threaded_irq(&spi->dev, spi->irq, NULL,
> +				pcf2123_rtc_irq,
> +				IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +				pcf2123_driver.driver.name, &spi->dev);
> +		if (ret)
> +			dev_err(&spi->dev, "could not request irq.\n");
> +	}
> +

As this RTC only has a minute granularity, you must set uie_unsupported
to get the UIE emulation working. You should probably run rtctest, this
would have uncovered the issue.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
