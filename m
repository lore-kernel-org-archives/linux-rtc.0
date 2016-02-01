Return-Path: <rtc-linux+bncBDA7X7F2WUEBBIFQXS2QKGQEANDJ3PQ@googlegroups.com>
Received: from mail-wm0-x22c.google.com (mail-wm0-x22c.google.com. [2a00:1450:400c:c09::22c])
        by gmr-mx.google.com with ESMTPS id v7si209356wmg.3.2016.02.01.00.32.31
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2016 00:32:31 -0800 (PST)
Received: by mail-wm0-x22c.google.com with SMTP id r129so57649589wmr.0
        for <rtc-linux@googlegroups.com>; Mon, 01 Feb 2016 00:32:31 -0800 (PST)
Date: Mon, 1 Feb 2016 08:32:28 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, linus.walleij@linaro.org, gnurou@gmail.com,
	broonie@kernel.org, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, lgirdwood@gmail.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, rtc-linux@googlegroups.com,
	swarren@nvidia.com, treding@nvidia.com, k.kozlowski@samsung.com,
	Chaitanya Bandi <bandik@nvidia.com>
Subject: [rtc-linux] Re: [PATCH V5 4/5] gpio: max77620: add gpio driver for MAX77620/MAX20024
Message-ID: <20160201083228.GY3368@x1>
References: <1453903808-29788-1-git-send-email-ldewangan@nvidia.com>
 <1453903808-29788-5-git-send-email-ldewangan@nvidia.com>
 <20160129163035.GA15053@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160129163035.GA15053@rob-hp-laptop>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Fri, 29 Jan 2016, Rob Herring wrote:

> On Wed, Jan 27, 2016 at 07:40:07PM +0530, Laxman Dewangan wrote:
> > MAXIM Semiconductor's PMIC, MAX77620/MAX20024 has 8 GPIO
> > pins. It also supports interrupts from these pins.
> >=20
> > Add GPIO driver for these pins to control via GPIO APIs.
> >=20
> > Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> > Signed-off-by: Chaitanya Bandi <bandik@nvidia.com>
> > ---
> > Changes from V1:
> > - Use the gpiochip_add_data and get the chip data from core APIs.
> > - Cleanups based on comment received on mfd/rtc.
> > - Avoid duplication on error message.
> >=20
> > Changes form V2:
> > - Run coccicheck and checkpatch in strict mode for the alignment.
> > - update based on api changes from core.
> >=20
> > Changes from V3:=20
> > - Change all sys initcall to module driver.
> > - change the max77620_read argument to unisgned int from u8.
> >=20
> > Changes from V4:=20
> > - Added DT binding document as devicetree/bindings/gpio/gpio-max77620.t=
xt
> >=20
> >  .../devicetree/bindings/gpio/gpio-max77620.txt     |  25 ++
> >  drivers/gpio/Kconfig                               |   9 +
> >  drivers/gpio/Makefile                              |   1 +
> >  drivers/gpio/gpio-max77620.c                       | 292 +++++++++++++=
++++++++
> >  4 files changed, 327 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-max7762=
0.txt
> >  create mode 100644 drivers/gpio/gpio-max77620.c
> >=20
> > diff --git a/Documentation/devicetree/bindings/gpio/gpio-max77620.txt b=
/Documentation/devicetree/bindings/gpio/gpio-max77620.txt
> > new file mode 100644
> > index 0000000..410e716
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpio/gpio-max77620.txt
> > @@ -0,0 +1,25 @@
> > +GPIO driver for MAX77620 Power management IC from Maxim Semiconductor.
> > +
> > +Device has 8 GPIO pins which can be configured as GPIO as well as the
> > +special IO functions.
> > +
> > +Required properties:
> > +-------------------
> > +- gpio-controller : 	Marks the device node as a gpio controller.
> > +- #gpio-cells : 	Should be two.  The first cell is the pin number and
> > +			the second cell is used to specify the gpio polarity:
> > +				0 =3D active high
> > +				1 =3D active low
> > +For more details, please refer generic GPIO DT binding document
> > +<devicetree/bindings/gpio/gpio.txt>.
>=20
> I would just fold these 2 properties into the main max77620 document.

As these are simple/generic options, I'm happy to support that.

Also happy to support them staying in their own subsystem doc
i.e. this one, for consistency.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

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
