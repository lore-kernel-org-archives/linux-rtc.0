Return-Path: <rtc-linux+bncBAABBG7S2WZAKGQEERGK3AA@googlegroups.com>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id q80si159668wmg.0.2015.11.25.01.02.18
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 25 Nov 2015 01:02:18 -0800 (PST)
Date: Wed, 25 Nov 2015 10:02:14 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
	rtc-linux@googlegroups.com, Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
	Kumar Gala <galak@codeaurora.org>
Subject: [rtc-linux] Re: [PATCH 1/2] Documentation: devicetree: add epson
 rx6110 binding
Message-ID: <20151125090214.GE14709@pengutronix.de>
References: <1448361533-10728-1-git-send-email-s.trumtrar@pengutronix.de>
 <1448363561.3346.57.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1448363561.3346.57.camel@pengutronix.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Tue, Nov 24, 2015 at 12:12:41PM +0100, Philipp Zabel wrote:
> Am Dienstag, den 24.11.2015, 11:38 +0100 schrieb Steffen Trumtrar:
> > Add the binding documentation for the Epson RX6110 RTC.
> > 
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > ---
> > I'm not sure what the current policy for such simple SPI bindings is.
> > Are they necessary?
> 
> Like for i2c there is trivial-devices.txt? Although in this case it's
> not just a compatible. Here you have a certain spi configuration that is
> necessary for the rtc to work.
> 
> >  .../devicetree/bindings/rtc/epson,rtc-rx6110.txt   | 25 ++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/rtc/epson,rtc-rx6110.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/epson,rtc-rx6110.txt b/Documentation/devicetree/bindings/rtc/epson,rtc-rx6110.txt
> > new file mode 100644
> > index 000000000000..7ce7ae761657
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rtc/epson,rtc-rx6110.txt
> > @@ -0,0 +1,25 @@
> > +Epson RX6110 Real Time Clock
> > +============================
> > +
> > +The Epson RX6110 can be used with SPI or I2C busses. The kind of
> > +bus depends on the SPISEL pin and can not be configured via software.
> > +
> > +SPI mode
> > +--------
> > +
> > +Required properties:
> > +- compatible: should be: "epson,rtc-rx6110"
> 
> Should this just be "epson,rx6110" ?
> 
> > +- reg: chip select number
> > +- spi-cs-high: RX6110 needs chipselect high
> > +- spi-cpha: RX6110 works with SPI shifted clock phase
> > +- spi-cpol: RX6110 works with SPI inverse clock polarity
> > +
> > +Example:
> > +
> > +	rtc: rtc@3 {
> > +		compatible = "epson,rtc-rx6110"
> > +		reg = <3>
> > +		spi-cs-high;
> > +		spi-cpba;
> 
> s/b/h/

I thought I copy-pasted this; seems I didn't =-o

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
