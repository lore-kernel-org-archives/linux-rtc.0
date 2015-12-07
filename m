Return-Path: <rtc-linux+bncBAABBZ7LSWZQKGQEIA5GWBY@googlegroups.com>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id e201si701808wma.3.2015.12.07.04.04.55
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 07 Dec 2015 04:04:55 -0800 (PST)
Date: Mon, 7 Dec 2015 13:04:42 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
To: Rob Herring <robh@kernel.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
	rtc-linux@googlegroups.com, kernel@pengutronix.de
Subject: [rtc-linux] Re: [PATCH v2 1/2] Documentation: devicetree: add epson
 rx6110 binding
Message-ID: <20151207120442.GD32453@pengutronix.de>
References: <1448977700-10924-1-git-send-email-s.trumtrar@pengutronix.de>
 <20151203145552.GA3635@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20151203145552.GA3635@rob-hp-laptop>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Thu, Dec 03, 2015 at 08:55:52AM -0600, Rob Herring wrote:
> On Tue, Dec 01, 2015 at 02:48:19PM +0100, Steffen Trumtrar wrote:
> > Add the binding documentation for the Epson RX6110 RTC.
> > 
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > ---
> > Changes since v1:
> > 	- added i2c binding
> > 	- compatible: "epson,rtc-rx6110" -> "epson,rx6110"
> > 	- fixed typo
> > 
> >  .../devicetree/bindings/rtc/epson,rx6110.txt       | 39 ++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/rtc/epson,rx6110.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/epson,rx6110.txt b/Documentation/devicetree/bindings/rtc/epson,rx6110.txt
> > new file mode 100644
> > index 000000000000..8c3d06f117e8
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
> > +  - reg : offset and length of the register set for the device
> 
> For i2c, there is no size cell. Otherwise,

Okay. I removed it from the binding documentation.

> 
> Acked-by: Rob Herring <robh@kernel.org>
> 

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
