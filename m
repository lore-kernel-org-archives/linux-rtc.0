Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBJXR725QKGQEJDZV5LY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 65si121461wmr.3.2016.07.08.07.28.54
        for <rtc-linux@googlegroups.com>;
        Fri, 08 Jul 2016 07:28:54 -0700 (PDT)
Date: Fri, 8 Jul 2016 16:28:53 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Rob Herring <robh@kernel.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org, Sergey Yanovich <ynvich@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>
Subject: [rtc-linux] Re: [PATCH v2 2/2] rtc: ds1302: support control with
 using GPIO lines
Message-ID: <20160708142853.GJ22202@piout.net>
References: <1467026362-29446-1-git-send-email-akinobu.mita@gmail.com>
 <1467026362-29446-3-git-send-email-akinobu.mita@gmail.com>
 <20160628205704.GT3737@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160628205704.GT3737@rob-hp-laptop>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 28/06/2016 at 15:57:04 -0500, Rob Herring wrote :
> On Mon, Jun 27, 2016 at 08:19:22PM +0900, Akinobu Mita wrote:
> > This adds support control with GPIO lines connected to the DS1302
> > which can communicate with three wires.
> > 
> > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> > Cc: Sergey Yanovich <ynvich@gmail.com>
> > Cc: Alessandro Zummo <a.zummo@towertech.it>
> > Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > ---
> >  .../devicetree/bindings/rtc/maxim-ds1302.txt       |  13 +
> >  drivers/rtc/Kconfig                                |  17 +-
> >  drivers/rtc/rtc-ds1302.c                           | 320 ++++++++++++++++++++-
> >  3 files changed, 331 insertions(+), 19 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/maxim-ds1302.txt b/Documentation/devicetree/bindings/rtc/maxim-ds1302.txt
> > index ba470c5..d489753 100644
> > --- a/Documentation/devicetree/bindings/rtc/maxim-ds1302.txt
> > +++ b/Documentation/devicetree/bindings/rtc/maxim-ds1302.txt
> > @@ -27,6 +27,12 @@ Required SPI properties:
> >  - spi-cs-high: DS-1302 has active high chip select line. This is
> >    required unless inverted in hardware.
> >  
> > +Required properties when using GPIO lines:
> > +
> > +- gpio-ce: GPIO connected to CE pin
> > +- gpio-io: GPIO connected to I/O pin
> > +- gpio-reset: GPIO connected to SCLK pin
> > +
> 
> IIRC, we got rid of the direct gpio bit-banging in this driver (or a 
> similar one) and replaced it with SPI GPIO driver. We should do that 
> here.
> 

Well, the fact is that it is not actually SPI but microwire which has
different timings and we didn't reach a conclusion yet with Mark.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
