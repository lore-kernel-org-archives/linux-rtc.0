Return-Path: <rtc-linux+bncBAABBA5XUWZQKGQECUINN7I@googlegroups.com>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id d185si970886wmf.0.2015.12.10.03.01.23
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Dec 2015 03:01:23 -0800 (PST)
Date: Thu, 10 Dec 2015 12:01:19 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
	rtc-linux@googlegroups.com, Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
	Kumar Gala <galak@codeaurora.org>
Subject: [rtc-linux] Re: [PATCH v3 2/2] rtc: add driver for RX6110SA real time clock
Message-ID: <20151210110119.GD20212@pengutronix.de>
References: <1449568461-26016-1-git-send-email-s.trumtrar@pengutronix.de>
 <1449568461-26016-2-git-send-email-s.trumtrar@pengutronix.de>
 <1449570621.18374.1.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1449570621.18374.1.camel@pengutronix.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi!

On Tue, Dec 08, 2015 at 11:30:21AM +0100, Philipp Zabel wrote:
> Am Dienstag, den 08.12.2015, 10:54 +0100 schrieb Steffen Trumtrar:
> > The RX6110 comes in two different variants: SPI and I2C.
> > This driver only supports the SPI variant.
> > 
> > If the need ever arises to also support the I2C variant, this driver
> > could easily be refactored to support both cases.
> > 
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> 
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> I have a few suggestions:
> 
> [...]
> > diff --git a/drivers/rtc/rtc-rx6110.c b/drivers/rtc/rtc-rx6110.c
> > new file mode 100644
> > index 000000000000..aa9d89d5d2de
> > --- /dev/null
> > +++ b/drivers/rtc/rtc-rx6110.c
> > @@ -0,0 +1,438 @@
> > +/*
> > + * Driver for the Epson RTC module RX-6110 SA
> > + *
> > + * Copyright(C) 2015 Pengutronix, Steffen Trumtrar <kernel@pengutronix.de>
> > + * Copyright(C) SEIKO EPSON CORPORATION 2013. All rights reserved.
> > + *
> > + * This driver software is distributed as is, without any warranty of any kind,
> > + * either express or implied as further specified in the GNU Public License.
> > + * This software may be used and distributed according to the terms of the GNU
> > + * Public License, version 2 as published by the Free Software Foundation.
> > + * See the file COPYING in the main directory of this archive for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License along with
> > + * this program. If not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#include <linux/bcd.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> 
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_gpio.h>
> 
> I think these three can be dropped.
> 

Okay.

> > +#include <linux/regmap.h>
> > +#include <linux/rtc.h>
> > +#include <linux/spi/spi.h>
> > +
> > +/* RX-6110 Register definitions */
> [...]
> > +
> > +static struct spi_driver rx6110_driver;
> 
> Several drivers do this. Instead of the forward declaration and using
> rx6110_driver.driver.name in devm_rtc_device_register below, why not
> just have a #define RX6110_DRIVER_NAME "rx6110-rtc" and reuse that?
> Actually, I think the "-rtc" suffix is superfluous in the rtc name.
> I'd just use "rx6110" as a parameter to devm_rtc_device_register.
>

Yeah, why not. The define seems to be a cleaner solution than the
forward declaration. Changed.

> > +struct rx6110_data {
> > +	struct rtc_device *rtc;
> > +	struct regmap *regmap;
> > +};
> [...]
> > +/**
> > + * rx6110_init - initialize the rx6110 registers
> > + *
> > + * @rx6110: pointer to the rx6110 struct in use
> > + *
> > + */
> > +static int rx6110_init(struct rx6110_data *rx6110)
> > +{
> > +	struct rtc_device *rtc = rx6110->rtc;
> > +	int ext;
> > +	int flags;
> > +	int ctrl;
> 
> ctrl is unused, except in the dev_dbg to print 0 below.
> 
> > +	int ret;
> > +
> > +	/* set reserved register 0x17 with specified value of 0xB8 */
> > +	ret = regmap_write(rx6110->regmap, RX6110_REG_RES1, 0xB8);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* set reserved register 0x30 with specified value of 0x00 */
> > +	ret = regmap_write(rx6110->regmap, RX6110_REG_RES2, 0x00);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* set reserved register 0x31 with specified value of 0x10 */
> > +	ret = regmap_write(rx6110->regmap, RX6110_REG_RES3, 0x10);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_write(rx6110->regmap, RX6110_REG_IRQ, 0x0);
> > +	if (ret)
> > +		return ret;
> 
> Maybe combine those using regmap_multi_reg_write? Not sure if the
> sequence can be reordered to also include the writes below.
>

Never heard of it, but it sounds like a good idea.

(...)

> > +/**
> > + * rx6110_probe - initialize rtc driver
> > + * @spi: pointer to spi device
> > + */
> > +static int rx6110_probe(struct spi_device *spi)
> > +{
> > +	struct rx6110_data *rx6110;
> > +	int err;
> > +
> > +	if ((spi->bits_per_word && spi->bits_per_word != 8)
> > +	    || (spi->max_speed_hz > 2000000)
> > +	    || (spi->mode != (SPI_CS_HIGH | SPI_CPOL | SPI_CPHA))) {
> > +		dev_warn(&spi->dev, "SPI settings: bits_per_word: %d, max_speed_hz: %d, mode: %xh\n",
> > +			spi->bits_per_word, spi->max_speed_hz, spi->mode);
> > +		dev_warn(&spi->dev, "driving device in an unsupported mode");
> > +	}
> > +
> > +	rx6110 = devm_kzalloc(&spi->dev, sizeof(*rx6110), GFP_KERNEL);
> > +	if (!rx6110)
> > +		return -ENOMEM;
> > +
> > +	rx6110->regmap = devm_regmap_init_spi(spi, &regmap_spi_config);
> > +	if (IS_ERR(rx6110->regmap)) {
> > +		dev_err(&spi->dev, "regmap init failed for rtc rx6110\n");
> 
> Maybe print the error code.
> 

Done.

Thanks,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

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
