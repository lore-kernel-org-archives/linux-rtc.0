Date: Tue, 3 May 2016 14:09:41 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: venkat.prashanth2498@gmail.com
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	inux-kernel@vger.kernel.org
Subject: Re: [rtc-linux] [PATCH] rtc: add support for maxim rtc max6916
Message-ID: <20160503120941.GH2335@piout.net>
References: <1462273240-2050-1-git-send-email-venkat.prashanth2498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1462273240-2050-1-git-send-email-venkat.prashanth2498@gmail.com>
List-ID: <rtc-linux.googlegroups.com>

Hi,

Please use checkpatch before submitting.

On 03/05/2016 at 04:00:40 -0700, venkat.prashanth2498@gmail.com wrote :
> From: venkat-prashanth <venkat.prashanth2498@gmail.com>
> 
> This is a patch to add support for
> maxim rtc max6916
> 
> Signed-off-by:Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
> ---
> ---
>  rtc-max6916.c | 157 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

This will not apply, that driver has to be in drivers/rtc

>  txtfile       |  11 ++++

What is that file?

>  2 files changed, 168 insertions(+)
>  create mode 100644 rtc-max6916.c
>  create mode 100644 txtfile
> 
> diff --git a/rtc-max6916.c b/rtc-max6916.c
> new file mode 100644
> index 0000000..7fabaa2
> --- /dev/null
> +++ b/rtc-max6916.c
> @@ -0,0 +1,157 @@
> +/* rtc-max6916.c
> + *
> + * Driver for MAXIM  max6916 Low Current, SPI Compatible
> + * Real Time Clock
> + *
> + * Author : Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/rtc.h>
> +#include <linux/spi/spi.h>
> +#include <linux/bcd.h>
> +
> +/* Registers in max6916 rtc */
> +
> +#define MAX6916_SECONDS_REG	0x01
> +#define MAX6916_MINUTES_REG	0x02
> +#define MAX6916_HOURS_REG	0x03
> +#define MAX6916_DATE_REG	0x04
> +#define MAX6916_MONTH_REG	0x05
> +#define MAX6916_DAY_REG	0x06
> +#define MAX6916_YEAR_REG	0x07
> +#define MAX6916_CONTROL_REG	0x08
> +#define MAX6916_STATUS_REG	0x0C
> +#define MAX6916_CLOCK_BURST	0x00
> +#define ADDRESS_REG            0x70
> +#define DATA_REG               0x71
> +#define ADDRESS_REG_MASK       0xe0
> +
> +static unsigned char get_rtc(unsigned char addr)
> +{
> +	outb(addr, ADDRESS_REG);
> +	return inb(DATA_REG);

What is the use of those port IOs?

> +}
> +
> +static int max6916_read_reg(struct device *dev, unsigned char address,unsigned char *data)
> +{
> +	struct spi_device *spi = to_spi_device(dev);
> +	*data = address | 0x80;
> +	return spi_write_then_read(spi, data, 1, data, 1);
> +}
> +
> +static int max6916_write_reg(struct device *dev, unsigned char address,unsigned char data)
> +{
> +	struct spi_device *spi = to_spi_device(dev);
> +	unsigned char buf[2];
> +	buf[0] = address & 0x7F;
> +	buf[1] = data;
> +	return spi_write_then_read(spi, buf, 2, NULL, 0);
> +}
> +
> +static int max6916_read_time(struct device *dev, struct rtc_time *dt)
> +{
> +	struct spi_device *spi = to_spi_device(dev);
> +	int err;
> +	unsigned char buf[8];
> +	buf[0] = MAX6916_CLOCK_BURST | 0x80;
> +	err = spi_write_then_read(spi, buf, 1, buf, 8);
> +	if (err)
> +	return err;
> +	dt->tm_sec = get_rtc(buf[0]);
> +	dt->tm_min = get_rtc(buf[1]);
> +	dt->tm_hour = get_rtc(buf[2] & 0x00);

How can that work?

> +	dt->tm_mday = get_rtc(buf[3]);
> +	dt->tm_mon = get_rtc(buf[4]) - 1;
> +	dt->tm_wday = get_rtc(buf[5]) - 1;
> +	dt->tm_year = get_rtc(buf[6]) + 100;
> +	return rtc_valid_tm(dt);
> +}
> +
> +static int max6916_set_time(struct device *dev, struct rtc_time *dt)
> +{
> +	struct spi_device *spi = to_spi_device(dev);
> +	unsigned char buf[9];
> +
> +	buf[0] = MAX6916_CLOCK_BURST & 0x7F;
> +	buf[1] = bcd2bin(dt->tm_sec);
> +	buf[2] = bcd2bin(dt->tm_min);
> +	buf[3] = (bcd2bin(dt->tm_hour) & 0x00);

Same question, this is always setting 0...

> +	buf[4] = bcd2bin(dt->tm_mday);
> +	buf[5] = bcd2bin(dt->tm_mon + 1);
> +	buf[6] = bcd2bin(dt->tm_wday + 1);
> +
> +	/* year in linux is from 1900 i.e in range of 100
> +	in rtc it is from 00 to 99 */
> +	dt->tm_year = dt->tm_year % 100;

You should enforce the year range instead of accepting any value.

> +
> +	buf[7] = bcd2bin(dt->tm_year);
> +	buf[8] = bcd2bin(0x00);
> +
> +	/* write the rtc settings */
> +	return spi_write_then_read(spi, buf, 9, NULL, 0);
> +}
> +
> +static const struct rtc_class_ops max6916_rtc_ops = {
> +	.read_time = max6916_read_time,
> +	.set_time = max6916_set_time,
> +};
> +
> +static int max6916_probe(struct spi_device *spi)
> +{
> +	struct rtc_device *rtc;
> +	unsigned char data;
> +	int res;
> +
> +	/* spi setup with max6916 in mode 3 and bits per word as 8 */
> +	spi->mode = SPI_MODE_3;
> +	spi->bits_per_word = 8;
> +	spi_setup(spi);
> +
> +	/* RTC Settings */
> +	res = max6916_read_reg(&spi->dev, MAX6916_SECONDS_REG, &data);
> +	if (res)
> +	return res;
> +	/* Disable the write protect of rtc */
> +	max6916_read_reg(&spi->dev, MAX6916_CONTROL_REG, &data);
> +	data = data & ~(1<<7);
> +	max6916_write_reg(&spi->dev, MAX6916_CONTROL_REG, data);
> +	/* Enable the oscillator , disable the oscillator stop flag,
> +	 and glitch filter to reduce current consumption */
> +	max6916_read_reg(&spi->dev, MAX6916_STATUS_REG, &data);
> +	data = data & 0x1B;
> +	max6916_write_reg(&spi->dev, MAX6916_STATUS_REG, data);
> +	/* display the settings */
> +	max6916_read_reg(&spi->dev, MAX6916_CONTROL_REG, &data);
> +	dev_info(&spi->dev, "MAX6916 RTC CTRL Reg = 0x%02x\n", data);
> +	max6916_read_reg(&spi->dev, MAX6916_STATUS_REG, &data);
> +	dev_info(&spi->dev, "MAX6916 RTC Status Reg = 0x%02x\n", data);
> +	rtc = devm_rtc_device_register(&spi->dev, "max6916",&max6916_rtc_ops, THIS_MODULE);
> +	if (IS_ERR(rtc))
> +	return PTR_ERR(rtc);
> +	spi_set_drvdata(spi, rtc);
> +
> +	return 0;
> +}
> +static struct spi_driver max6916_driver = {
> +	.driver = {
> +	.name = "max6916",
> +	},
> +	.probe = max6916_probe,
> +};
> +static void __exit rtc_exit(void)
> +{
> +	pr_info("rtc module unloaded\n");
> +}
> +
> +module_spi_driver(max6916_driver);
> +MODULE_DESCRIPTION("MAX6916 SPI RTC DRIVER");
> +MODULE_AUTHOR("Venkat Prashanth B U <venkat.prashanth2498@gmail.com>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/txtfile b/txtfile
> new file mode 100644
> index 0000000..1604409
> --- /dev/null
> +++ b/txtfile
> @@ -0,0 +1,11 @@
> +config RTC_DRV_MAX6916
> +tristate "Maxim MAX6916"
> +
> +help 
> +  If you say yes here you get support for the 
> +  Maxim MAX6916 chips. 
> +  This driver only supports the RTC feature, and not other chip
> +  features such as alarms.
> +  This driver can also be built as a module. If so, the module
> +  will be called rtc‐max6916.

Ok, this should go in drivers/rtc/Kconfig

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
