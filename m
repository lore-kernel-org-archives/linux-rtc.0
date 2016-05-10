Return-Path: <rtc-linux+bncBDS7HNEFSALRBOGAY64QKGQERY6WE5Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id u18si725972wmd.1.2016.05.10.06.20.56
        for <rtc-linux@googlegroups.com>;
        Tue, 10 May 2016 06:20:56 -0700 (PDT)
Date: Tue, 10 May 2016 15:20:55 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: venkat.prashanth2498@gmail.com
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, marcus.folkesson@gmail.com
Subject: [rtc-linux] Re: [PATCH] rtc: add support to maxim rtc max6916 v2.0
Message-ID: <20160510132055.GU2890@piout.net>
References: <1462526164-6086-1-git-send-email-venkat.prashanth2498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1462526164-6086-1-git-send-email-venkat.prashanth2498@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

Again, please use checkpatch.pl --strict before sending a patch.

On 06/05/2016 at 02:16:04 -0700, venkat.prashanth2498@gmail.com wrote :
> From: venkat-prashanth <venkat.prashanth2498@gmail.com>
>=20
> This is a patch to add=20
> support for maxim rtc MAX6916
>=20
> Signed-off-by : Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
> ---

The changelog should appear here, not in a separate file.

>  Kconfig       |  10 ++++
>  changeLOG     |  36 ++++++++++++
>  rtc-max6916.c | 172 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++

You are missing modifications in the Makefile.

>  3 files changed, 218 insertions(+)
>=20
> diff --git a/drivers/rtcKconfig b/drivers/rtc/Kconfig
> index e69de29..81aaa1e 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -0,0 +1,10 @@
> +config RTC_DRV_MAX6916
> +tristate "Maxim MAX6916"
> +
> +help
> +If you say yes here you get support for the
> +Maxim MAX6916 chips.
> +This driver only supports the RTC feature, and not other chip
> +features such as alarms.
> +This driver can also be built as a module. If so, the module
> +will be called rtc=E2=80=90max6916.

This is badly indented.

> diff --git a/changeLOG b/changeLOG
> index e69de29..6aa0a76 100644
> --- a/drivers/rtc/changeLOG
> +++ b/drivers/rtc/changeLOG
> @@ -0,0 +1,36 @@
> +Changes incorporated after pre-commit review
> +
> +1./*created folders=20
> +drivers/rtc/rtc-max6916.c
> +drivers/rtc/Kconfig/
> +
> +2./*deleted the port i/o's since it does not add=20
> +any significance in overall system design aspect*/
> +/*=20
> +#define ADDRESS_REG      0x70
> +#define DATA_REG         0x71
> +#define ADDRESS_REG_MASK 0xe0
> +
> +static unsigned char get_rtc(unsigned char addr)
> +{
> +outb(addr, ADDRESS_REG);
> +return inb(DATA_REG);
> +}*/
> +
> +3./* Clock burst value is modified from 0X00 to 0X3F and=20
> +further get_rtc() function is replaced with bcd2bin()=20
> +since the time in Linux is in binary format so the conversion is done*/
> +
> +
> +4./*enforced the year range instead of accepting any value
> +which is as follows:
> +/* starting from year 2000,limit to 100 years from now
> +that is subtract the year by 100 */
> +dt->tm_year =3D dt->tm_year % 100;
> +if(dt->tm_year >=3D 100)
> +dt->tm_year -=3D 100;
> +
> +if (dt->tm_year < 100 || dt->tm_year > 199) {
> +		dev_err(&spi->dev, "Year must be between 2000 and 2099. It's %d.\n",dt=
->tm_year + 1900);
> +		return -EINVAL;
> +}*/
> diff --git a/drivers/rtc/rtc-max6916.c b/drivers/rtc/rtc-max6916.c
> index e69de29..f5e396f 100644
> --- a/drivers/rtc/rtc-max6916.c
> +++ b/drivers/rtc/rtc-max6916.c
> @@ -0,0 +1,172 @@
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
> +=20
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
> +#define MAX6916_HOURS_REG	   0x03
> +#define MAX6916_DATE_REG	   0x04
> +#define MAX6916_MONTH_REG	   0x05
> +#define MAX6916_DAY_REG		   0x06
> +#define MAX6916_YEAR_REG	   0x07
> +#define MAX6916_CONTROL_REG	0x08
> +#define MAX6916_STATUS_REG	   0x0C
> +#define MAX6916_CLOCK_BURST	0x3F
> +
> +static int max6916_read_reg(struct device *dev, unsigned char address,=
=20
> +				                       unsigned char *data)
> +{
> +	struct spi_device *spi =3D to_spi_device(dev);
> +
> +	*data =3D address | 0x80;
> +
> +	return spi_write_then_read(spi, data, 1, data, 1);
> +}
> +
> +static int max6916_write_reg(struct device *dev, unsigned char address,=
=20
> +				                        unsigned char data)
> +{
> +	struct spi_device *spi =3D to_spi_device(dev);
> +	unsigned char buf[2];
> +
> +	buf[0] =3D address&0x7F;
> +	buf[1] =3D data;
> +
> +	return spi_write_then_read(spi, buf, 2, NULL, 0);
> +}
> +
> +static int max6916_read_time(struct device *dev, struct rtc_time *dt)
> +{
> +	struct spi_device *spi =3D to_spi_device(dev);
> +	int err;
> +	unsigned char buf[8];
> +
> +	buf[0] =3D MAX6916_CLOCK_BURST | 0x80;
> +=09
> +	err =3D spi_write_then_read(spi, buf, 1, buf, 8);
> +	if (err)
> +		return err;
> +	=09
> +	dt->tm_sec =3D bcd2bin(buf[0]);
> +	dt->tm_min =3D bcd2bin(buf[1]);
> +	dt->tm_hour =3D bcd2bin(buf[2] & 0x3F);
> +	dt->tm_mday =3D bcd2bin(buf[3]);
> +	dt->tm_mon =3D bcd2bin(buf[4]) - 1;
> +	dt->tm_wday =3D bcd2bin(buf[5]) - 1;
> +	dt->tm_year =3D bcd2bin(buf[6]) + 100;
> +
> +	return rtc_valid_tm(dt);
> +}
> +
> +static int max6916_set_time(struct device *dev, struct rtc_time *dt)
> +{
> +	struct spi_device *spi =3D to_spi_device(dev);
> +	unsigned char buf[9];
> +
> +	buf[0] =3D MAX6916_CLOCK_BURST & 0x7F;
> +	buf[1] =3D bin2bcd(dt->tm_sec);
> +	buf[2] =3D bin2bcd(dt->tm_min);
> +	buf[3] =3D (bin2bcd(dt->tm_hour)& 0X3F);
> +	buf[4] =3D bin2bcd(dt->tm_mday);
> +	buf[5] =3D bin2bcd(dt->tm_mon + 1);
> +	buf[6] =3D bin2bcd(dt->tm_wday + 1);
> +
> +	/* starting from year 2000,limit to 100 years=20
> +	from now that is subtract the year by 100 */
> +	dt->tm_year =3D dt->tm_year % 100;

This is unnecessary

> +	if(dt->tm_year >=3D 100)

You don't need that test if the range is properly enforced.

> +		dt->tm_year -=3D 100;
> +	=09
> +	if (dt->tm_year < 100 || dt->tm_year > 199) {
> +		dev_err(&spi->dev,"Year must be between 2000 and 2099. It's %d.\n", dt=
->tm_year + 1900);
> +		return -EINVAL;
> +	}

This test should go at the beginning of the function.

> + =09
> +	buf[7] =3D bin2bcd(dt->tm_year);
> +	buf[8] =3D bin2bcd(0x00);
> +=09
> +	/* write the rtc settings */
> +	return spi_write_then_read(spi, buf, 9, NULL, 0);
> +}
> +
> +static const struct rtc_class_ops max6916_rtc_ops =3D {
> +	.read_time =3D max6916_read_time,
> +	.set_time =3D max6916_set_time,
> +};
> +
> +static int max6916_probe(struct spi_device *spi)
> +{
> +	struct rtc_device *rtc;
> +	unsigned char data;
> +	int res;
> +
> +	/* spi setup with max6916 in mode 3 and bits per word as 8 */
> +	spi->mode =3D SPI_MODE_3;
> +	spi->bits_per_word =3D 8;
> +	spi_setup(spi);
> +
> +	/* RTC Settings */
> +	res =3D max6916_read_reg(&spi->dev, MAX6916_SECONDS_REG , &data);
> +=09
> +	if (res)
> +		return res;
> +
> +	/* Disable the write protect of rtc */
> +	max6916_read_reg(&spi->dev, MAX6916_CONTROL_REG, &data);
> +	data =3D data & ~(1<<7);

Please use defines instead of magic values

> +	max6916_write_reg(&spi->dev, MAX6916_CONTROL_REG, data);
> +
> +	/*Enable the oscillator,disable the oscillator stop flag, and glitch fi=
lter to reduce current consumption*/
> +	max6916_read_reg(&spi->dev, MAX6916_STATUS_REG, &data);
> +	data =3D data & 0x1B;

Also use a define instead of 0x1B.


--=20
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--=20
--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
