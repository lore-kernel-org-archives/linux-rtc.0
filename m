Return-Path: <rtc-linux+bncBDUOXGMN6YKBBHNGYS5QKGQEAE6JTGA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com. [2a00:1450:4010:c07::243])
        by gmr-mx.google.com with ESMTPS id c135si52397wme.2.2016.06.27.04.50.52
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jun 2016 04:50:53 -0700 (PDT)
Received: by mail-lf0-x243.google.com with SMTP id l184so28366914lfl.1
        for <rtc-linux@googlegroups.com>; Mon, 27 Jun 2016 04:50:52 -0700 (PDT)
Message-ID: <1467028249.3182.11.camel@gmail.com>
Subject: [rtc-linux] Re: [PATCH v2 1/2] rtc: ds1302: add register access
 abstraction layer
From: Sergei Ianovich <ynvich@gmail.com>
To: Akinobu Mita <akinobu.mita@gmail.com>, rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org
Cc: Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni
	 <alexandre.belloni@free-electrons.com>
Date: Mon, 27 Jun 2016 14:50:49 +0300
In-Reply-To: <1467026362-29446-2-git-send-email-akinobu.mita@gmail.com>
References: <1467026362-29446-1-git-send-email-akinobu.mita@gmail.com>
	 <1467026362-29446-2-git-send-email-akinobu.mita@gmail.com>
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

On Mon, 2016-06-27 at 20:19 +0900, Akinobu Mita wrote:
> The rtc-ds1302 driver now implemented using SPI 3wire mode.
> But I would like to access it with using three wires connected to
> GPIO
> lines.
>=20
> This adds abstraction layer for DS1302 register access in order to
> prepare to support for using GPIO lines.=C2=A0=C2=A0This enables to share
> common
> code between SPI driver and GPIO driver.

I don't think this is the right way. DS-1302 is an SPI device, not a
GPIO one. It can be connected to a hardware SPI controller or a
software one (on top of GPIO or memory).

Your patch re-adds Microwire SPI control logic to RTC subsystem, which
was cleared by my rewrite of drivers/rtc/rtc-ds1302.c. The logic is
already present in=C2=A0bitbang_txrx_be_cpha0_lsb() in=C2=A0drivers/spi/spi=
-
lp8841-rtc.c.

I still think you need to implement=C2=A0spi-gpio-3wire with LSB-first
support in SPI subsystem instead. It wasn't done when I was adding
LP8841 support, because LP8841 was the only use case of Microwire SPI
control logic. If you add it, drivers/spi/spi-lp8841-rtc.c can be
removed and replaced by a GPIO driver to host a new spi-gpio-3wire
device.

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
