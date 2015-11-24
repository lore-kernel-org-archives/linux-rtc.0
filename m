Return-Path: <rtc-linux+bncBDS7HNEFSALRBO6D2OZAKGQERHUSIQI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id w187si92196wmw.1.2015.11.24.14.16.27
        for <rtc-linux@googlegroups.com>;
        Tue, 24 Nov 2015 14:16:27 -0800 (PST)
Date: Tue, 24 Nov 2015 23:16:26 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Joshua Clayton <stillcompiling@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 3/9] rtc-pcf2123: clean up writes to the rtc chip
Message-ID: <20151124221626.GE3950@piout.net>
References: <cover.1446587705.git.stillcompiling@gmail.com>
 <813a6fe306c384c59418495605236927b9d00940.1446587705.git.stillcompiling@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <813a6fe306c384c59418495605236927b9d00940.1446587705.git.stillcompiling@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 04/11/2015 at 07:36:34 -0800, Joshua Clayton wrote :
> +static int pcf2123_write(struct device *dev, u8 *txbuf, size_t size)
> +{
> +	struct spi_device *spi = to_spi_device(dev);
> +	int ret;
> +
> +	if (txbuf[0] > PCF2123_REG_MAX)
> +		return -EFAULT;
> +

Is that test really necessary? From what I understand the driver always
controls which register is written.

> +	txbuf[0] |= PCF2123_WRITE;
> +	ret = spi_write(spi, txbuf, size);
> +	pcf2123_delay_trec();
> +
> +	return ret;
> +}
> +
> +static int pcf2123_write_reg(struct device *dev, u8 reg, u8 val)
> +{
> +	u8 txbuf[2];
> +
> +	txbuf[0] = reg;
> +	txbuf[1] = val;
> +	return pcf2123_write(dev, txbuf, sizeof(txbuf));
> +}
> +
>  static ssize_t pcf2123_show(struct device *dev, struct device_attribute *attr,
>  			    char *buffer)
>  {
> @@ -142,9 +166,7 @@ static ssize_t pcf2123_show(struct device *dev, struct device_attribute *attr,
>  
>  static ssize_t pcf2123_store(struct device *dev, struct device_attribute *attr,
>  			     const char *buffer, size_t count) {
> -	struct spi_device *spi = to_spi_device(dev);
>  	struct pcf2123_sysfs_reg *r;
> -	u8 txbuf[2];
>  	unsigned long reg;
>  	unsigned long val;
>  
> @@ -160,12 +182,9 @@ static ssize_t pcf2123_store(struct device *dev, struct device_attribute *attr,
>  	if (ret)
>  		return ret;
>  
> -	txbuf[0] = PCF2123_WRITE | reg;
> -	txbuf[1] = val;
> -	ret = spi_write(spi, txbuf, sizeof(txbuf));
> +	pcf2123_write_reg(dev, reg, val);
>  	if (ret < 0)
>  		return -EIO;
> -	pcf2123_delay_trec();
>  	return count;
>  }
>  
> @@ -205,7 +224,6 @@ static int pcf2123_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  
>  static int pcf2123_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  {
> -	struct spi_device *spi = to_spi_device(dev);
>  	u8 txbuf[8];
>  	int ret;
>  
> @@ -216,15 +234,12 @@ static int pcf2123_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  			tm->tm_mday, tm->tm_mon, tm->tm_year, tm->tm_wday);
>  
>  	/* Stop the counter first */
> -	txbuf[0] = PCF2123_WRITE | PCF2123_REG_CTRL1;
> -	txbuf[1] = 0x20;
> -	ret = spi_write(spi, txbuf, 2);
> +	ret = pcf2123_write_reg(dev, PCF2123_REG_CTRL1, 0x20);
>  	if (ret < 0)
>  		return ret;
> -	pcf2123_delay_trec();
>  
>  	/* Set the new time */
> -	txbuf[0] = PCF2123_WRITE | PCF2123_REG_SC;
> +	txbuf[0] = PCF2123_REG_SC;
>  	txbuf[1] = bin2bcd(tm->tm_sec & 0x7F);
>  	txbuf[2] = bin2bcd(tm->tm_min & 0x7F);
>  	txbuf[3] = bin2bcd(tm->tm_hour & 0x3F);
> @@ -233,18 +248,14 @@ static int pcf2123_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  	txbuf[6] = bin2bcd((tm->tm_mon + 1) & 0x1F); /* rtc mn 1-12 */
>  	txbuf[7] = bin2bcd(tm->tm_year < 100 ? tm->tm_year : tm->tm_year - 100);
>  
> -	ret = spi_write(spi, txbuf, sizeof(txbuf));
> +	ret = pcf2123_write(dev, txbuf, sizeof(txbuf));
>  	if (ret < 0)
>  		return ret;
> -	pcf2123_delay_trec();
>  
>  	/* Start the counter */
> -	txbuf[0] = PCF2123_WRITE | PCF2123_REG_CTRL1;
> -	txbuf[1] = 0x00;
> -	ret = spi_write(spi, txbuf, 2);
> +	ret = pcf2123_write_reg(dev, PCF2123_REG_CTRL1, 0x00);
>  	if (ret < 0)
>  		return ret;
> -	pcf2123_delay_trec();
>  
>  	return 0;
>  }
> @@ -258,7 +269,7 @@ static int pcf2123_probe(struct spi_device *spi)
>  {
>  	struct rtc_device *rtc;
>  	struct pcf2123_plat_data *pdata;
> -	u8 txbuf[2], rxbuf[2];
> +	u8  rxbuf[2];
>  	int ret, i;
>  
>  	pdata = devm_kzalloc(&spi->dev, sizeof(struct pcf2123_plat_data),
> @@ -268,24 +279,16 @@ static int pcf2123_probe(struct spi_device *spi)
>  	spi->dev.platform_data = pdata;
>  
>  	/* Send a software reset command */
> -	txbuf[0] = PCF2123_WRITE | PCF2123_REG_CTRL1;
> -	txbuf[1] = 0x58;
> -	dev_dbg(&spi->dev, "resetting RTC (0x%02X 0x%02X)\n",
> -			txbuf[0], txbuf[1]);
> -	ret = spi_write(spi, txbuf, 2 * sizeof(u8));
> +	dev_dbg(&spi->dev, "resetting RTC\n");
> +	ret = pcf2123_write_reg(&spi->dev, PCF2123_REG_CTRL1, 0x58);
>  	if (ret < 0)
>  		goto kfree_exit;
> -	pcf2123_delay_trec();
>  
>  	/* Stop the counter */
> -	txbuf[0] = PCF2123_WRITE | PCF2123_REG_CTRL1;
> -	txbuf[1] = 0x20;
> -	dev_dbg(&spi->dev, "stopping RTC (0x%02X 0x%02X)\n",
> -			txbuf[0], txbuf[1]);
> -	ret = spi_write(spi, txbuf, 2 * sizeof(u8));
> +	dev_dbg(&spi->dev, "stopping RTC\n");
> +	ret = pcf2123_write_reg(&spi->dev, PCF2123_REG_CTRL1, 0x20);
>  	if (ret < 0)
>  		goto kfree_exit;
> -	pcf2123_delay_trec();
>  
>  	/* See if the counter was actually stopped */
>  	dev_dbg(&spi->dev, "checking for presence of RTC\n");
> @@ -306,12 +309,9 @@ static int pcf2123_probe(struct spi_device *spi)
>  			(spi->max_speed_hz + 500) / 1000);
>  
>  	/* Start the counter */
> -	txbuf[0] = PCF2123_WRITE | PCF2123_REG_CTRL1;
> -	txbuf[1] = 0x00;
> -	ret = spi_write(spi, txbuf, sizeof(txbuf));
> +	ret = pcf2123_write_reg(&spi->dev, PCF2123_REG_CTRL1, 0x00);
>  	if (ret < 0)
>  		goto kfree_exit;
> -	pcf2123_delay_trec();
>  
>  	/* Finalize the initialization */
>  	rtc = devm_rtc_device_register(&spi->dev, pcf2123_driver.driver.name,
> -- 
> 2.5.0
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
