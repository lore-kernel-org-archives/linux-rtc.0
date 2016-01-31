Return-Path: <rtc-linux+bncBDGNBOVQQEOBB4FIXC2QKGQEBXFM57Q@googlegroups.com>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id c140si236362wmh.0.2016.01.31.06.04.32
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 31 Jan 2016 06:04:32 -0800 (PST)
Date: Sun, 31 Jan 2016 15:04:18 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
	rtc-linux@googlegroups.com, kernel@pengutronix.de
Subject: [rtc-linux] Re: [PATCH v4 2/2] rtc: add driver for RX6110SA real time clock
Message-ID: <20160131140418.GD11885@pengutronix.de>
References: <1451927075-8656-1-git-send-email-s.trumtrar@pengutronix.de>
 <1451927075-8656-2-git-send-email-s.trumtrar@pengutronix.de>
 <20160131115457.GL20165@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160131115457.GL20165@piout.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Sun, Jan 31, 2016 at 12:54:57PM +0100, Alexandre Belloni wrote:
> On 04/01/2016 at 18:04:35 +0100, Steffen Trumtrar wrote :
> > The RX6110 comes in two different variants: SPI and I2C.
> > This driver only supports the SPI variant.
> > 
> > If the need ever arises to also support the I2C variant, this driver
> > could easily be refactored to support both cases.
> > 
> > Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > ---
> > 
> > Changes since v3:
> >     - remove old copyright infos
> >     - use the BIT() macro
> >     - replace rx6110_get_week_day() with ffs()
> >     - replace hardcoded offsets with enum
> >     - use regmap_bulk_write in set_time
> >     - use regmap_register_patch in init function
> >     - return -EINVAL instead of "fixing" time in the rtc
> > 
> >  drivers/rtc/Kconfig      |   9 ++
> >  drivers/rtc/Makefile     |   1 +
> >  drivers/rtc/rtc-rx6110.c | 402 +++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 412 insertions(+)
> >  create mode 100644 drivers/rtc/rtc-rx6110.c
> > 
> Applied, after realigning some lines in rx6110_probe().
> 

Thanks :-)

Regards,
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
