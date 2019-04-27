Return-Path: <SRS0=fKgR=S5=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3084C43218
	for <linux-rtc@archiver.kernel.org>; Sat, 27 Apr 2019 13:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BADD2087C
	for <linux-rtc@archiver.kernel.org>; Sat, 27 Apr 2019 13:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfD0NA6 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sat, 27 Apr 2019 09:00:58 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:34655 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfD0NA6 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 27 Apr 2019 09:00:58 -0400
Received: from localhost (lfbn-1-3034-80.w90-66.abo.wanadoo.fr [90.66.53.80])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 956EC240002;
        Sat, 27 Apr 2019 13:00:54 +0000 (UTC)
Date:   Sat, 27 Apr 2019 15:00:54 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "Howey, Dylan" <Dylan.Howey@tennantco.com>
Cc:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
Subject: Re: [PATCH 1/2] Port rtc-pcf2123 to regmap
Message-ID: <20190427130054.GY14604@piout.net>
References: <20190426193648.1599-1-Dylan.Howey@tennantco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426193648.1599-1-Dylan.Howey@tennantco.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hello,

Please use a subject consistent with the subsystem style (here rtc:
pcf2123: ... ).

On 26/04/2019 19:37:11+0000, Howey, Dylan wrote:
> Replace all calls to pcf2123_read and _write with regmap.
> 
> Also remove pcf2123_delay_trec. This claimed to add a 30ns delay to SPI
> writes, but I could not see any reference to this requirement in the
> datasheet. Closest thing I could find to a requirement are timings for the
> SPI chip enable line, which cannot be controlled by this driver (the ndelay
> came after the call to spi_write_then_read, which means it would sleep
> after CE has already gone inactive). Things seem to work fine without it.
> 
> Signed-off-by: Dylan Howey <Dylan.Howey@tennantco.com>

This has to match the From: of the email.

> ---
>  drivers/rtc/rtc-pcf2123.c | 156 ++++++++++++++++++--------------------
>  1 file changed, 75 insertions(+), 81 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-pcf2123.c b/drivers/rtc/rtc-pcf2123.c
> index 39da8b214275..4bfcb1e67c9b 100644
> --- a/drivers/rtc/rtc-pcf2123.c
> +++ b/drivers/rtc/rtc-pcf2123.c
> @@ -45,6 +45,7 @@
>  #include <linux/spi/spi.h>
>  #include <linux/module.h>
>  #include <linux/sysfs.h>
> +#include <linux/regmap.h>
>  
>  /* REGISTERS */
>  #define PCF2123_REG_CTRL1	(0x00)	/* Control Register 1 */
> @@ -114,58 +115,29 @@ struct pcf2123_sysfs_reg {
>  
>  struct pcf2123_plat_data {
>  	struct rtc_device *rtc;
> +	struct regmap *map;
>  	struct pcf2123_sysfs_reg regs[16];
>  };
>  
> -/*
> - * Causes a 30 nanosecond delay to ensure that the PCF2123 chip select
> - * is released properly after an SPI write.  This function should be
> - * called after EVERY read/write call over SPI.
> - */
> -static inline void pcf2123_delay_trec(void)
> -{
> -	ndelay(30);
> -}
> -
> -static int pcf2123_read(struct device *dev, u8 reg, u8 *rxbuf, size_t size)
> -{
> -	struct spi_device *spi = to_spi_device(dev);
> -	int ret;
> -
> -	reg |= PCF2123_READ;
> -	ret = spi_write_then_read(spi, &reg, 1, rxbuf, size);
> -	pcf2123_delay_trec();
> -
> -	return ret;
> -}
> -
> -static int pcf2123_write(struct device *dev, u8 *txbuf, size_t size)
> -{
> -	struct spi_device *spi = to_spi_device(dev);
> -	int ret;
> -
> -	txbuf[0] |= PCF2123_WRITE;
> -	ret = spi_write(spi, txbuf, size);
> -	pcf2123_delay_trec();
> -
> -	return ret;
> -}
> -
> -static int pcf2123_write_reg(struct device *dev, u8 reg, u8 val)
> -{
> -	u8 txbuf[2];
> +static const struct regmap_range pcf2123_ranges[] = {
> +	{
> +		.range_min = PCF2123_REG_CTRL1,
> +		.range_max = PCF2123_REG_CTDWN_TMR,
> +	},
> +};
>  
> -	txbuf[0] = reg;
> -	txbuf[1] = val;
> -	return pcf2123_write(dev, txbuf, sizeof(txbuf));
> -}
> +static const struct regmap_access_table pcf2123_access_table = {
> +	.yes_ranges = pcf2123_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(pcf2123_ranges),
> +};

This covers all the registers, I don't think this is necessary.

>  
>  static ssize_t pcf2123_show(struct device *dev, struct device_attribute *attr,
>  			    char *buffer)
>  {
> +	struct pcf2123_plat_data *pdata = dev_get_platdata(dev);
>  	struct pcf2123_sysfs_reg *r;
> -	u8 rxbuf[1];
>  	unsigned long reg;
> +	unsigned int val = 0;
>  	int ret;
>  
>  	r = container_of(attr, struct pcf2123_sysfs_reg, attr);
> @@ -174,16 +146,17 @@ static ssize_t pcf2123_show(struct device *dev, struct device_attribute *attr,
>  	if (ret)
>  		return ret;
>  
> -	ret = pcf2123_read(dev, reg, rxbuf, 1);
> -	if (ret < 0)
> +	ret = regmap_read(pdata->map, reg, &val);
> +	if (ret)
>  		return -EIO;
>  
> -	return sprintf(buffer, "0x%x\n", rxbuf[0]);
> +	return sprintf(buffer, "0x%x\n", val);
>  }
>  
>  static ssize_t pcf2123_store(struct device *dev, struct device_attribute *attr,
>  			     const char *buffer, size_t count)
>  {
> +	struct pcf2123_plat_data *pdata = dev_get_platdata(dev);
>  	struct pcf2123_sysfs_reg *r;
>  	unsigned long reg;
>  	unsigned long val;
> @@ -200,19 +173,20 @@ static ssize_t pcf2123_store(struct device *dev, struct device_attribute *attr,
>  	if (ret)
>  		return ret;
>  
> -	ret = pcf2123_write_reg(dev, reg, val);
> -	if (ret < 0)
> +	ret = regmap_write(pdata->map, reg, val);
> +	if (ret)
>  		return -EIO;
>  	return count;
>  }
>  

You should add a preliminary patch removing that sysfs interface
exposing all the registers. regmap will anyway provide you a debugfs
interface.

>  static int pcf2123_read_offset(struct device *dev, long *offset)
>  {
> +	struct pcf2123_plat_data *pdata = dev_get_platdata(dev);
>  	int ret;
>  	s8 reg;
>  
> -	ret = pcf2123_read(dev, PCF2123_REG_OFFSET, &reg, 1);
> -	if (ret < 0)
> +	ret = regmap_raw_read(pdata->map, PCF2123_REG_OFFSET, &reg, 1);

Do you really need the raw version of regmap_read?

> +	if (ret)
>  		return ret;
>  
>  	if (reg & OFFSET_COARSE)
> @@ -237,6 +211,8 @@ static int pcf2123_read_offset(struct device *dev, long *offset)
>   */
>  static int pcf2123_set_offset(struct device *dev, long offset)
>  {
> +	struct pcf2123_plat_data *pdata = dev_get_platdata(dev);
> +	int ret;
>  	s8 reg;
>  
>  	if (offset > OFFSET_STEP * 127)
> @@ -256,16 +232,18 @@ static int pcf2123_set_offset(struct device *dev, long offset)
>  		reg |= OFFSET_COARSE;
>  	}
>  
> -	return pcf2123_write_reg(dev, PCF2123_REG_OFFSET, reg);
> +	ret = regmap_raw_write(pdata->map, PCF2123_REG_OFFSET, &reg, 1);
> +	return ret;

ret is not necessary here.

>  }
>  
>  static int pcf2123_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  {
> +	struct pcf2123_plat_data *pdata = dev_get_platdata(dev);
>  	u8 rxbuf[7];
>  	int ret;
>  
> -	ret = pcf2123_read(dev, PCF2123_REG_SC, rxbuf, sizeof(rxbuf));
> -	if (ret < 0)
> +	ret = regmap_bulk_read(pdata->map, PCF2123_REG_SC, rxbuf, 7);

you should keep using sizeof(rxbuf).

> +	if (ret)
>  		return ret;
>  
>  	if (rxbuf[0] & OSC_HAS_STOPPED) {
> @@ -294,7 +272,8 @@ static int pcf2123_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  
>  static int pcf2123_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  {
> -	u8 txbuf[8];
> +	struct pcf2123_plat_data *pdata = dev_get_platdata(dev);
> +	u8 txbuf[7];
>  	int ret;
>  
>  	dev_dbg(dev, "%s: tm is secs=%d, mins=%d, hours=%d, "
> @@ -304,27 +283,26 @@ static int pcf2123_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  			tm->tm_mday, tm->tm_mon, tm->tm_year, tm->tm_wday);
>  
>  	/* Stop the counter first */
> -	ret = pcf2123_write_reg(dev, PCF2123_REG_CTRL1, CTRL1_STOP);
> -	if (ret < 0)
> +	ret = regmap_write(pdata->map, PCF2123_REG_CTRL1, CTRL1_STOP);
> +	if (ret)
>  		return ret;
>  
>  	/* Set the new time */
> -	txbuf[0] = PCF2123_REG_SC;
> -	txbuf[1] = bin2bcd(tm->tm_sec & 0x7F);
> -	txbuf[2] = bin2bcd(tm->tm_min & 0x7F);
> -	txbuf[3] = bin2bcd(tm->tm_hour & 0x3F);
> -	txbuf[4] = bin2bcd(tm->tm_mday & 0x3F);
> -	txbuf[5] = tm->tm_wday & 0x07;
> -	txbuf[6] = bin2bcd((tm->tm_mon + 1) & 0x1F); /* rtc mn 1-12 */
> -	txbuf[7] = bin2bcd(tm->tm_year < 100 ? tm->tm_year : tm->tm_year - 100);
> -
> -	ret = pcf2123_write(dev, txbuf, sizeof(txbuf));
> -	if (ret < 0)
> +	txbuf[0] = bin2bcd(tm->tm_sec & 0x7F);
> +	txbuf[1] = bin2bcd(tm->tm_min & 0x7F);
> +	txbuf[2] = bin2bcd(tm->tm_hour & 0x3F);
> +	txbuf[3] = bin2bcd(tm->tm_mday & 0x3F);
> +	txbuf[4] = tm->tm_wday & 0x07;
> +	txbuf[5] = bin2bcd((tm->tm_mon + 1) & 0x1F); /* rtc mn 1-12 */
> +	txbuf[6] = bin2bcd(tm->tm_year < 100 ? tm->tm_year : tm->tm_year - 100);
> +
> +	ret = regmap_bulk_write(pdata->map, PCF2123_REG_SC, txbuf, 7);

Ditto for txbuf

> +	if (ret)
>  		return ret;
>  
>  	/* Start the counter */
> -	ret = pcf2123_write_reg(dev, PCF2123_REG_CTRL1, CTRL1_CLEAR);
> -	if (ret < 0)
> +	ret = regmap_write(pdata->map, PCF2123_REG_CTRL1, CTRL1_CLEAR);
> +	if (ret)
>  		return ret;
>  
>  	return 0;
> @@ -332,33 +310,33 @@ static int pcf2123_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  
>  static int pcf2123_reset(struct device *dev)
>  {
> +	struct pcf2123_plat_data *pdata = dev_get_platdata(dev);
>  	int ret;
> -	u8  rxbuf[2];
> +	unsigned int val = 0;
>  
> -	ret = pcf2123_write_reg(dev, PCF2123_REG_CTRL1, CTRL1_SW_RESET);
> -	if (ret < 0)
> +	ret = regmap_write(pdata->map, PCF2123_REG_CTRL1, CTRL1_SW_RESET);
> +	if (ret)
>  		return ret;
>  
>  	/* Stop the counter */
>  	dev_dbg(dev, "stopping RTC\n");
> -	ret = pcf2123_write_reg(dev, PCF2123_REG_CTRL1, CTRL1_STOP);
> -	if (ret < 0)
> +	ret = regmap_write(pdata->map, PCF2123_REG_CTRL1, CTRL1_STOP);
> +	if (ret)
>  		return ret;
>  
>  	/* See if the counter was actually stopped */
>  	dev_dbg(dev, "checking for presence of RTC\n");
> -	ret = pcf2123_read(dev, PCF2123_REG_CTRL1, rxbuf, sizeof(rxbuf));
> -	if (ret < 0)
> +	ret = regmap_read(pdata->map, PCF2123_REG_CTRL1, &val);
> +	if (ret)
>  		return ret;
>  
> -	dev_dbg(dev, "received data from RTC (0x%02X 0x%02X)\n",
> -		rxbuf[0], rxbuf[1]);
> -	if (!(rxbuf[0] & CTRL1_STOP))
> +	dev_dbg(dev, "received data from RTC (0x%08X)\n", val);
> +	if (!(val & CTRL1_STOP))
>  		return -ENODEV;
>  
>  	/* Start the counter */
> -	ret = pcf2123_write_reg(dev, PCF2123_REG_CTRL1, CTRL1_CLEAR);
> -	if (ret < 0)
> +	ret = regmap_write(pdata->map, PCF2123_REG_CTRL1, CTRL1_CLEAR);
> +	if (ret)
>  		return ret;
>  
>  	return 0;
> @@ -377,7 +355,8 @@ static int pcf2123_probe(struct spi_device *spi)
>  	struct rtc_device *rtc;
>  	struct rtc_time tm;
>  	struct pcf2123_plat_data *pdata;
> -	int ret, i;
> +	struct regmap_config config;
> +	int ret = 0, i;
>  
>  	pdata = devm_kzalloc(&spi->dev, sizeof(struct pcf2123_plat_data),
>  				GFP_KERNEL);
> @@ -385,6 +364,21 @@ static int pcf2123_probe(struct spi_device *spi)
>  		return -ENOMEM;
>  	spi->dev.platform_data = pdata;
>  
> +	memset(&config, 0, sizeof(config));
> +	config.reg_bits = 8;
> +	config.val_bits = 8;
> +	config.read_flag_mask = PCF2123_READ;
> +	config.write_flag_mask = PCF2123_WRITE;
> +	config.max_register = PCF2123_REG_CTDWN_TMR;
> +	config.wr_table = &pcf2123_access_table;
> +

You should probably have the regmap_config as a global static const.
This would make the initialization easier.

> +	pdata->map = devm_regmap_init_spi(spi, &config);
> +
> +	if (IS_ERR(pdata->map)) {
> +		dev_err(&spi->dev, "regmap init failed.\n");
> +		goto kfree_exit;
> +	}
> +
>  	ret = pcf2123_rtc_read_time(&spi->dev, &tm);
>  	if (ret < 0) {
>  		ret = pcf2123_reset(&spi->dev);
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
