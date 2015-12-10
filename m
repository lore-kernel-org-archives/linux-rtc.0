Return-Path: <rtc-linux+bncBAABBAVVUWZQKGQET3HVYEQ@googlegroups.com>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id q80si171791wmg.0.2015.12.10.02.57.06
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Dec 2015 02:57:06 -0800 (PST)
Date: Thu, 10 Dec 2015 11:56:59 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
	rtc-linux@googlegroups.com, Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
	Kumar Gala <galak@codeaurora.org>
Subject: [rtc-linux] Re: [PATCH v3 1/2] Documentation: devicetree: add epson
 rx6110 binding
Message-ID: <20151210105659.GC20212@pengutronix.de>
References: <1449568461-26016-1-git-send-email-s.trumtrar@pengutronix.de>
 <1449570566.3691.31.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1449570566.3691.31.camel@pengutronix.de>
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

On Tue, Dec 08, 2015 at 11:29:26AM +0100, Philipp Zabel wrote:
> Am Dienstag, den 08.12.2015, 10:54 +0100 schrieb Steffen Trumtrar:
> > Add the binding documentation for the Epson RX6110 RTC.
> > 
> > Acked-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> 
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> although I'd like a small change to be made below:
> 
> > ---
> > Changes since v2:
> > 	- removed the size field in i2c binding
> > 
> >  .../devicetree/bindings/rtc/epson,rx6110.txt       | 39 ++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/rtc/epson,rx6110.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/epson,rx6110.txt b/Documentation/devicetree/bindings/rtc/epson,rx6110.txt
> > new file mode 100644
> > index 000000000000..71353542a59d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rtc/epson,rx6110.txt
> > @@ -0,0 +1,39 @@
> > +Epson RX6110 Real Time Clock
> > +============================
> > +
> > +The Epson RX6110 can be used with SPI or I2C busses. The kind of
> > +bus depends on the SPISEL pin and can not be configured via software.
> > +
> > +I2C mode
> > +--------
> > +
> > +Required properties:
> > +  - compatible: should be: "epson,rx6110"
> > +  - reg : offset of the register set of the device
> 
> That should be the I2C address of the device, as in:
> 	git grep "reg.*I2C address" Documentation/
> 

Sounds reasonable. Changed.

Thanks,
Steffen Trumtrar

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
