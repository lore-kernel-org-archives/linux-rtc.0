Return-Path: <rtc-linux+bncBDS7HNEFSALRBFEL5K4AKGQEV35UUFA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id e78si123333wmc.3.2016.04.22.13.12.04
        for <rtc-linux@googlegroups.com>;
        Fri, 22 Apr 2016 13:12:04 -0700 (PDT)
Date: Fri, 22 Apr 2016 22:11:53 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Rob Herring <robh@kernel.org>
Cc: Jeppe Ledet-Pedersen <jlp@gomspace.com>, lee.jones@linaro.org,
	arnd@arndb.de, gregkh@linuxfoundation.org, a.zummo@towertech.it,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 1/3] mfd: add Cypress FM33256B Processor
 Companion driver
Message-ID: <20160422201153.GB17051@piout.net>
References: <1461150471-23163-1-git-send-email-jlp@gomspace.com>
 <1461150471-23163-2-git-send-email-jlp@gomspace.com>
 <20160422193232.GA9737@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160422193232.GA9737@rob-hp-laptop>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 22/04/2016 at 14:32:32 -0500, Rob Herring wrote :
> On Wed, Apr 20, 2016 at 01:07:49PM +0200, Jeppe Ledet-Pedersen wrote:
> > This patch adds support for the Cypress Semiconductor FM33256B processor
> > companion. The device contains a 256 kbit FRAM, an RTC, a supply voltage
> > monitor, and a watchdog timer.
> > 
> > Signed-off-by: Jeppe Ledet-Pedersen <jlp@gomspace.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/fm33256b.txt |  30 ++
> >  MAINTAINERS                                        |   6 +
> >  drivers/mfd/Kconfig                                |  16 +
> >  drivers/mfd/Makefile                               |   1 +
> >  drivers/mfd/fm33256b.c                             | 488 +++++++++++++++++++++
> >  include/linux/mfd/fm33256b.h                       |  76 ++++
> >  6 files changed, 617 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/fm33256b.txt
> >  create mode 100644 drivers/mfd/fm33256b.c
> >  create mode 100644 include/linux/mfd/fm33256b.h
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/fm33256b.txt b/Documentation/devicetree/bindings/mfd/fm33256b.txt
> > new file mode 100644
> > index 0000000..6591c94
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/fm33256b.txt
> > @@ -0,0 +1,30 @@
> > +Device-tree bindings for Cypress Semiconductor FM33256B Processor Companion
> > +---------------------------------------------------------------------------
> > +
> > +Required properties:
> > +- compatible: must be "cypress,fm33256b".
> > +- reg: SPI chip select
> > +- spi-max-frequency: Max SPI frequency to use (< 16000000)
> > +
> > +Optional properties:
> > +- cypress,charge-enabled: enable trickle charger
> 
> What does the driver do if charging is disabled? Would using 'status = 
> "disabled"' be any different?
>  

Good catch, I didn't look at this patch but it includes a lot of code
that should be going to the RTC driver.
If trickle charging is not enabled, I guess the RTC will not charge its
backup battery.

> > +- cypress,charge-fast: enable fast (1 mA) charging
> 
> What does fast mean?
> 
> I think it is time for a common binding here. There's all sorts of 
> variations on setting the charge current in bindings. Add something like 
> "charge-current-microamp" in power_supply.txt and use it here. Then 
> 1000uA implies "fast charge".

Well, this is not a power supply, it is an RTC.

I think both properties should got to the RTC subdevice and be parsed in
the RTC driver.

Note that for trickle charging, we currently have the following
properties:
 - trickle-resistor-ohms
 - trickle-diode-disable
 - abracon,tc-diode
 - abracon,tc-resistor

abracon,tc-resistor can be replaced by trickle-resistor-ohms, I'll make
a patch but abracon,tc-diode allows to select a diode type (and in
particular a voltage drop).

I think we could add a trickle-current-microamp like you suggested and
trickle-diode-disable can be reused.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
