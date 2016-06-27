Return-Path: <rtc-linux+bncBDUOXGMN6YKBBCEGYW5QKGQEQJQ6CEY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-lf0-x241.google.com (mail-lf0-x241.google.com. [2a00:1450:4010:c07::241])
        by gmr-mx.google.com with ESMTPS id a6si514780wma.1.2016.06.27.08.15.20
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jun 2016 08:15:20 -0700 (PDT)
Received: by mail-lf0-x241.google.com with SMTP id l188so29064076lfe.0
        for <rtc-linux@googlegroups.com>; Mon, 27 Jun 2016 08:15:20 -0700 (PDT)
Message-ID: <1467040517.3182.34.camel@gmail.com>
Subject: [rtc-linux] Re: [PATCH v2 1/2] rtc: ds1302: add register access
 abstraction layer
From: Sergei Ianovich <ynvich@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>
Date: Mon, 27 Jun 2016 18:15:17 +0300
In-Reply-To: <20160627124432.GI29249@piout.net>
References: <1467026362-29446-1-git-send-email-akinobu.mita@gmail.com>	
 <1467026362-29446-2-git-send-email-akinobu.mita@gmail.com>	
 <1467028249.3182.11.camel@gmail.com> <20160627124432.GI29249@piout.net>
Content-Type: text/plain; charset=UTF-8
Mime-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Mon, 2016-06-27 at 14:44 +0200, Alexandre Belloni wrote:
> On 27/06/2016 at 14:50:49 +0300, Sergei Ianovich wrote :
> > I don't think this is the right way. DS-1302 is an SPI device, not
> > a
> > GPIO one. It can be connected to a hardware SPI controller or a
> > software one (on top of GPIO or memory).
> >=20
> > Your patch re-adds Microwire SPI control logic to RTC subsystem, which
> > was cleared by my rewrite of drivers/rtc/rtc-ds1302.c. The logic is
> > already present in=C2=A0bitbang_txrx_be_cpha0_lsb() in=C2=A0drivers/spi=
/spi-
> > lp8841-rtc.c.
> >=20
> > I still think you need to implement=C2=A0spi-gpio-3wire with LSB-first
> > support in SPI subsystem instead. It wasn't done when I was adding
> > LP8841 support, because LP8841 was the only use case of Microwire SPI
> > control logic. If you add it, drivers/spi/spi-lp8841-rtc.c can be
> > removed and replaced by a GPIO driver to host a new spi-gpio-3wire
> > device.
>=20
> Well, back in April, we concluded it was not easily doable after
> discussing with Mark and there was still issues after implementing it in
> spi-gpio.

> My understanding is that while microwire seems compatible with SPI mode
> 0, it actually isn't and this should be treated as a different mode.
> If we want to do something generic, I think we should have a
> microwire-gpio driver. Maybe in the SPI subsystem?

I've seen Akinobu Mita report that he added support for 3wire to spi-
gpio, and it didn't work. That's not a big difference from where we are
now, when there is just no support for 3wire. Adding a working support
for 3wire to spi-gpio needs 2^4 - 2^2 =3D 12 new bitbang functions to
handle 3wire and lsb-first modes. It is a bit difficult to test all of
them. I don't have enough hardware for example. In addition, it is
unlikely that a 3wire GPIO SPI master would host more than a single
device. That's why I think it is easier to add a new spi-gpio-3wire (or
spi-gpio-microwire) driver.

> How do yo currently select microwire mode for PX270?

I didn't say I use PXA270 to drive this RTC. I just say it is possible.
The driver needs to set bits 5:4 of SSCR0_1/2/3 register to 0b10.
Microwire mode will be selected for a built-in SPI port. All bitbanging
will be done by the chip, the driver will just need to set up DMA
transfer. This is an example of a pretty sophisticated hardware
controller.

I actually use a simple software controller in LP8841. The driver is
in=C2=A0drivers/spi/spi-lp8841-rtc.c.

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
