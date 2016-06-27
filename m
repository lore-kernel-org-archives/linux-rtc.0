Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBYN7YS5QKGQE3TIY3RI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id f138si468852wmf.3.2016.06.27.05.45.20
        for <rtc-linux@googlegroups.com>;
        Mon, 27 Jun 2016 05:45:20 -0700 (PDT)
Date: Mon, 27 Jun 2016 14:45:20 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Sergei Ianovich <ynvich@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>
Subject: [rtc-linux] Re: [PATCH v2 1/2] rtc: ds1302: add register access
 abstraction layer
Message-ID: <20160627124520.GJ29249@piout.net>
References: <1467026362-29446-1-git-send-email-akinobu.mita@gmail.com>
 <1467026362-29446-2-git-send-email-akinobu.mita@gmail.com>
 <1467028249.3182.11.camel@gmail.com>
 <20160627124432.GI29249@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160627124432.GI29249@piout.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Forgot to add Mark in Cc:

On 27/06/2016 at 14:44:32 +0200, Alexandre Belloni wrote :
> On 27/06/2016 at 14:50:49 +0300, Sergei Ianovich wrote :
> > On Mon, 2016-06-27 at 20:19 +0900, Akinobu Mita wrote:
> > > The rtc-ds1302 driver now implemented using SPI 3wire mode.
> > > But I would like to access it with using three wires connected to
> > > GPIO
> > > lines.
> > >=20
> > > This adds abstraction layer for DS1302 register access in order to
> > > prepare to support for using GPIO lines.=C2=A0=C2=A0This enables to s=
hare
> > > common
> > > code between SPI driver and GPIO driver.
> >=20
> > I don't think this is the right way. DS-1302 is an SPI device, not a
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
>=20
> My understanding is that while microwire seems compatible with SPI mode
> 0, it actually isn't and this should be treated as a different mode.
> If we want to do something generic, I think we should have a
> microwire-gpio driver. Maybe in the SPI subsystem?
>=20
> How do yo currently select microwire mode for PX270?
>=20
> --=20
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com

--=20
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
