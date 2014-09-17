Return-Path: <boris.brezillon@free-electrons.com>
Date: Wed, 17 Sep 2014 19:57:27 +0200
From: Boris BREZILLON <boris.brezillon@free-electrons.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe
 Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni
 <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>,
 Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com, Johan
 Hovold <jhovold@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
 devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell
 <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Rob Herring
 <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 9/9] mfd: syscon: add Atmel GPBR DT bindings
 documention
Message-ID: <20140917195727.1c75a062@bbrezillon>
In-Reply-To: <20140917163405.GM30918@lee--X1>
References: <1410441525-25258-1-git-send-email-boris.brezillon@free-electrons.com>
	<1410441525-25258-10-git-send-email-boris.brezillon@free-electrons.com>
	<20140917163405.GM30918@lee--X1>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <rtc-linux.googlegroups.com>

Hi Lee,

On Wed, 17 Sep 2014 09:34:05 -0700
Lee Jones <lee.jones@linaro.org> wrote:

> On Thu, 11 Sep 2014, Boris BREZILLON wrote:
> 
> > The GPBR block provides a set of battery-backed registers that can be used
> > to save data which need to be kept when the system is powered down and
> > VDD-core is maintained by an external battery.
> > 
> > A typical usage is the RTT block (when used as an RTC) which needs one of
> > those registers to save the current time.
> > 
> > Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/atmel,gpbr.txt | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/atmel,gpbr.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/atmel,gpbr.txt b/Documentation/devicetree/bindings/mfd/atmel,gpbr.txt
> > new file mode 100644
> > index 0000000..a285695
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/atmel,gpbr.txt
> > @@ -0,0 +1,15 @@
> > +* Device tree bindings for Atmel GPBR (General Purpose Backup Registers)
> > +
> > +The GPBR are a set of battery-backed registers.
> > +
> > +Required properties:
> > +- compatible:		"atmel,at91sam9260-gpbr", "syscon"
> > +- reg:			contains offset/length value of the GPBR memory
> > +			region.
> > +
> > +Example:
> > +
> > +gpbr: gpbr@fffffd50 {
> 
> Is something referencing this node via phandle?  If not, please remove
> the label.

Yes, the rtt device is referencing it in its atmel,rtt-rtc-time-reg
property (see patch 8 of this series).

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
