Return-Path: <rtc-linux+bncBDUOXGMN6YKBBWG7VG4AKGQE5DNSPBY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com. [2a00:1450:4010:c07::243])
        by gmr-mx.google.com with ESMTPS id f7si583712lbf.0.2016.04.10.08.23.04
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Apr 2016 08:23:04 -0700 (PDT)
Received: by mail-lf0-x243.google.com with SMTP id p64so5301894lfg.0
        for <rtc-linux@googlegroups.com>; Sun, 10 Apr 2016 08:23:04 -0700 (PDT)
Message-ID: <1460301781.17404.171.camel@gmail.com>
Subject: [rtc-linux] Re: [PATCH 0/4] support control with using GPIO lines
From: Sergei Ianovich <ynvich@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Akinobu Mita
	 <akinobu.mita@gmail.com>
Cc: rtc-linux@googlegroups.com, devicetree@vger.kernel.org, Alessandro Zummo
	 <a.zummo@towertech.it>
Date: Sun, 10 Apr 2016 18:23:01 +0300
In-Reply-To: <20160410151237.GD5377@piout.net>
References: <1460300366-25248-1-git-send-email-akinobu.mita@gmail.com>
	 <20160410151237.GD5377@piout.net>
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

On Sun, 2016-04-10 at 17:12 +0200, Alexandre Belloni wrote:
> Hi,
>=20
> On 10/04/2016 at 23:59:22 +0900, Akinobu Mita wrote :
> >=20
> > This series adds support access to DS1302 with GPIO lines.
> >=20
> > Recently rtc-ds1302 is rewritten using SPI 3wire mode.=C2=A0=C2=A0This =
adds
> > another platform driver using GPIO while supporting both modes.
> >=20
> > Thie series first fixes two problems I found while tesing, secondly
> > introduces the abstraction layer for the register access which
> > enables
> > to share the most code between spi and platform driver, and adds
> > the platform driver using GPIO.
> >=20
> Well, isn't spi-gpio fitting for that use case? I'd like to avoid
> open
> coding gpio bitbanging in the driver.

No, unfortunately. I've investigated this possibility for my platform.
spi-gpio doesn't support LSB-first and 3-wire options. Adding support
there is a very big change. The best way to add GPIO support is to
create spi-gpio-3wire with LSB-first support.

--=20
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
