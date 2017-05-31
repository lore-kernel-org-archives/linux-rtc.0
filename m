Return-Path: <linux-rtc-owner@vger.kernel.org>
Date: Wed, 31 May 2017 03:45:15 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Marek Vasut <marex@denx.de>
Cc: rtc-linux@googlegroups.com, Arnd Bergmann <arnd@arndb.de>,
        Felipe Balbi <balbi@ti.com>, Nishanth Menon <nm@ti.com>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] rtc: ds1307: Add support for Epson RX8130CE
Message-ID: <20170531014515.4a7yebud7qssyjok@piout.net>
References: <20170504103346.10842-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170504103346.10842-1-marex@denx.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <rtc-linux.googlegroups.com>

Hi Marek,

On 04/05/2017 at 12:33:46 +0200, Marek Vasut wrote:
> Add support for yet another RTC chip, Epson RX8130CE. This time around,
> the chip has slightly permutated registers and also the register starts
> at 0x10 instead of 0x0 .
> 

Do you mind rebasing on top of rtc-next or linux-next because this
driver now uses regmap for the register accesses.

Thanks!

> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/rtc/rtc-ds1307.c | 179 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 179 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
> index 77339b3d50a1..4a3c41c9e040 100644
> --- a/drivers/rtc/rtc-ds1307.c
> +++ b/drivers/rtc/rtc-ds1307.c
> @@ -43,6 +43,7 @@ enum ds_type {
>  	m41t00,
>  	mcp794xx,
>  	rx_8025,
> +	rx_8130,
>  	last_ds_type /* always last */
>  	/* rs5c372 too?  different address... */
>  };
> @@ -169,6 +170,12 @@ static struct chip_desc chips[last_ds_type] = {
>  	[ds_3231] = {
>  		.alarm		= 1,
>  	},
> +	[rx_8130] = {
> +		.alarm		= 1,
> +		/* this is battery backed SRAM */
> +		.nvram_offset	= 0x20,
> +		.nvram_size	= 4,	/* 32bit (4 word x 8 bit) */
> +	},
>  	[mcp794xx] = {
>  		.alarm		= 1,
>  		/* this is battery backed SRAM */
> @@ -192,6 +199,7 @@ static const struct i2c_device_id ds1307_id[] = {
>  	{ "pt7c4338", ds_1307 },
>  	{ "rx8025", rx_8025 },
>  	{ "isl12057", ds_1337 },
> +	{ "rx8130", rx_8130 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ds1307_id);
> @@ -729,6 +737,169 @@ static const struct rtc_class_ops ds13xx_rtc_ops = {
>  /*----------------------------------------------------------------------*/
>  
>  /*
> + * Alarm support for rx8130 devices.
> + */
> +
> +#define RX8130_REG_ALARM_MIN		0x07
> +#define RX8130_REG_ALARM_HOUR		0x08
> +#define RX8130_REG_ALARM_WEEK_OR_DAY	0x09
> +#define RX8130_REG_EXTENSION		0x0c
> +#define RX8130_REG_EXTENSION_WADA	(1 << 3)
> +#define RX8130_REG_FLAG			0x0d
> +#define RX8130_REG_FLAG_AF		(1 << 3)
> +#define RX8130_REG_CONTROL0		0x0e
> +#define RX8130_REG_CONTROL0_AIE		(1 << 3)
> +
> +static irqreturn_t rx8130_irq(int irq, void *dev_id)
> +{
> +	struct i2c_client       *client = dev_id;
> +	struct ds1307           *ds1307 = i2c_get_clientdata(client);
> +	struct mutex            *lock = &ds1307->rtc->ops_lock;
> +	u8 ctl[3];
> +	int ret;
> +
> +	mutex_lock(lock);
> +
> +	/* Read control registers. */
> +	ret = ds1307->read_block_data(client, RX8130_REG_EXTENSION, 3, ctl);
> +	if (ret < 0)
> +		goto out;
> +	if (!(ctl[1] & RX8130_REG_FLAG_AF))
> +		goto out;
> +	ctl[1] &= ~RX8130_REG_FLAG_AF;
> +	ctl[2] &= ~RX8130_REG_CONTROL0_AIE;
> +
> +	ret = ds1307->write_block_data(client, RX8130_REG_EXTENSION, 3, ctl);
> +	if (ret < 0)
> +		goto out;
> +
> +	rtc_update_irq(ds1307->rtc, 1, RTC_AF | RTC_IRQF);
> +
> +out:
> +	mutex_unlock(lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int rx8130_read_alarm(struct device *dev, struct rtc_wkalrm *t)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct ds1307 *ds1307 = i2c_get_clientdata(client);
> +	u8 ald[3], ctl[3];
> +	int ret;
> +
> +	if (!test_bit(HAS_ALARM, &ds1307->flags))
> +		return -EINVAL;
> +
> +	/* Read alarm registers. */
> +	ret = ds1307->read_block_data(client, RX8130_REG_ALARM_MIN, 3, ald);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Read control registers. */
> +	ret = ds1307->read_block_data(client, RX8130_REG_EXTENSION, 3, ctl);
> +	if (ret < 0)
> +		return ret;
> +
> +	t->enabled = !!(ctl[2] & RX8130_REG_CONTROL0_AIE);
> +	t->pending = !!(ctl[1] & RX8130_REG_FLAG_AF);
> +
> +	/* Report alarm 0 time assuming 24-hour and day-of-month modes. */
> +	t->time.tm_sec = -1;
> +	t->time.tm_min = bcd2bin(ald[0] & 0x7f);
> +	t->time.tm_hour = bcd2bin(ald[1] & 0x7f);
> +	t->time.tm_wday = -1;
> +	t->time.tm_mday = bcd2bin(ald[2] & 0x7f);
> +	t->time.tm_mon = -1;
> +	t->time.tm_year = -1;
> +	t->time.tm_yday = -1;
> +	t->time.tm_isdst = -1;
> +
> +	dev_dbg(dev, "%s, sec=%d min=%d hour=%d wday=%d mday=%d mon=%d enabled=%d\n",
> +		__func__, t->time.tm_sec, t->time.tm_min, t->time.tm_hour,
> +		t->time.tm_wday, t->time.tm_mday, t->time.tm_mon, t->enabled);
> +
> +	return 0;
> +}
> +
> +static int rx8130_set_alarm(struct device *dev, struct rtc_wkalrm *t)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct ds1307 *ds1307 = i2c_get_clientdata(client);
> +	u8 ald[3], ctl[3];
> +	int ret;
> +
> +	if (!test_bit(HAS_ALARM, &ds1307->flags))
> +		return -EINVAL;
> +
> +	dev_dbg(dev, "%s, sec=%d min=%d hour=%d wday=%d mday=%d mon=%d "
> +		"enabled=%d pending=%d\n", __func__,
> +		t->time.tm_sec, t->time.tm_min, t->time.tm_hour,
> +		t->time.tm_wday, t->time.tm_mday, t->time.tm_mon,
> +		t->enabled, t->pending);
> +
> +	/* Read control registers. */
> +	ret = ds1307->read_block_data(client, RX8130_REG_EXTENSION, 3, ctl);
> +	if (ret < 0)
> +		return ret;
> +
> +	ctl[0] &= ~RX8130_REG_EXTENSION_WADA;
> +	ctl[1] |= RX8130_REG_FLAG_AF;
> +	ctl[2] &= ~RX8130_REG_CONTROL0_AIE;
> +
> +	ret = ds1307->write_block_data(client, RX8130_REG_EXTENSION, 3, ctl);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Hardware alarm precision is 1 minute! */
> +	ald[0] = bin2bcd(t->time.tm_min);
> +	ald[1] = bin2bcd(t->time.tm_hour);
> +	ald[2] = bin2bcd(t->time.tm_mday);
> +
> +	ret = ds1307->write_block_data(client, RX8130_REG_ALARM_MIN, 3, ald);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!t->enabled)
> +		return 0;
> +
> +	ctl[2] |= RX8130_REG_CONTROL0_AIE;
> +
> +	return ds1307->write_block_data(client, RX8130_REG_EXTENSION, 3, ctl);
> +}
> +
> +static int rx8130_alarm_irq_enable(struct device *dev, unsigned int enabled)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct ds1307 *ds1307 = i2c_get_clientdata(client);
> +	int reg;
> +
> +	if (!test_bit(HAS_ALARM, &ds1307->flags))
> +		return -EINVAL;
> +
> +	reg = i2c_smbus_read_byte_data(client, RX8130_REG_CONTROL0);
> +	if (reg < 0)
> +		return reg;
> +
> +	if (enabled)
> +		reg |= RX8130_REG_CONTROL0_AIE;
> +	else
> +		reg &= ~RX8130_REG_CONTROL0_AIE;
> +
> +	return i2c_smbus_write_byte_data(client, RX8130_REG_CONTROL0, reg);
> +}
> +
> +static const struct rtc_class_ops rx8130_rtc_ops = {
> +	.read_time	= ds1307_get_time,
> +	.set_time	= ds1307_set_time,
> +	.read_alarm	= rx8130_read_alarm,
> +	.set_alarm	= rx8130_set_alarm,
> +	.alarm_irq_enable = rx8130_alarm_irq_enable,
> +};
> +
> +/*----------------------------------------------------------------------*/
> +
> +/*
>   * Alarm support for mcp794xx devices.
>   */
>  
> @@ -1562,6 +1733,14 @@ static int ds1307_probe(struct i2c_client *client,
>  						  hour);
>  		}
>  		break;
> +	case rx_8130:
> +		ds1307->offset = 0x10; /* Seconds starts at 0x10 */
> +		rtc_ops = &rx8130_rtc_ops;
> +		if (ds1307->client->irq > 0 && chip->alarm) {
> +			irq_handler = rx8130_irq;
> +			want_irq = true;
> +		}
> +		break;
>  	case ds_1388:
>  		ds1307->offset = 1; /* Seconds starts at 1 */
>  		break;
> -- 
> 2.11.0
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
