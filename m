Return-Path: <rtc-linux+bncBDA7X7F2WUEBBD4ARK5QKGQEZK23TKI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x22a.google.com (mail-wm0-x22a.google.com. [2a00:1450:400c:c09::22a])
        by gmr-mx.google.com with ESMTPS id a186si441757wma.1.2016.06.16.03.31.43
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jun 2016 03:31:43 -0700 (PDT)
Received: by mail-wm0-x22a.google.com with SMTP id f126so44487986wma.1
        for <rtc-linux@googlegroups.com>; Thu, 16 Jun 2016 03:31:43 -0700 (PDT)
Date: Thu, 16 Jun 2016 11:32:24 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Mark Brown <broonie@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@codeaurora.org>, rtc-linux@googlegroups.com,
	linux-kernel <linux-kernel@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-clk <linux-clk@vger.kernel.org>
Subject: [rtc-linux] Re: [PATCH v2 03/10] mfd: ac100: Add driver for X-Powers
 AC100 audio codec / RTC combo IC
Message-ID: <20160616103224.GQ4948@dell>
References: <1465986467-14802-1-git-send-email-wens@csie.org>
 <1465986467-14802-4-git-send-email-wens@csie.org>
 <20160615123646.GD4948@dell>
 <CAGb2v669g6G4aK5UssyLLve1a-AbdVfo4CPYrt+YWmCUURz9qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAGb2v669g6G4aK5UssyLLve1a-AbdVfo4CPYrt+YWmCUURz9qQ@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Wed, 15 Jun 2016, Chen-Yu Tsai wrote:

> On Wed, Jun 15, 2016 at 8:36 PM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Wed, 15 Jun 2016, Chen-Yu Tsai wrote:
> >
> >> The AC100 is a multifunction device with an audio codec subsystem and
> >> an RTC subsystem. These two subsystems share a common register space
> >> and host interface.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >> ---
> >
> > Change log?
>=20
> Change log was in the cover letter. Changes were the addition of the
> codec related register macros and regmap ranges.

Patch specific change logs are more helpful.

> >>  drivers/mfd/Kconfig       |  10 +++
> >>  drivers/mfd/Makefile      |   2 +
> >>  drivers/mfd/ac100.c       | 135 +++++++++++++++++++++++++++++++++++
> >>  include/linux/mfd/ac100.h | 176 +++++++++++++++++++++++++++++++++++++=
+++++++++
> >>  4 files changed, 323 insertions(+)
> >>  create mode 100644 drivers/mfd/ac100.c
> >>  create mode 100644 include/linux/mfd/ac100.h
> >>
> >> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> >> index 1bcf601de5bc..bd83849a0c8d 100644
> >> --- a/drivers/mfd/Kconfig
> >> +++ b/drivers/mfd/Kconfig
> >> @@ -101,6 +101,16 @@ config MFD_BCM590XX
> >>       help
> >>         Support for the BCM590xx PMUs from Broadcom
> >>
> >> +config MFD_AC100
> >> +     tristate "X-Powers AC100"
> >> +     select MFD_CORE
> >> +     depends on SUNXI_RSB
> >> +     help
> >> +       If you say Y here you get support for the X-Powers AC100 audio=
 codec
> >> +       IC.
> >> +       This driver include only the core APIs. You have to select ind=
ividual
> >> +       components like codecs or RTC under the corresponding menus.
> >> +
> >>  config MFD_AXP20X
> >>       tristate
> >>       select MFD_CORE
> >> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> >> index 42a66e19e191..60f9a6b0557c 100644
> >> --- a/drivers/mfd/Makefile
> >> +++ b/drivers/mfd/Makefile
> >> @@ -113,6 +113,8 @@ obj-$(CONFIG_PMIC_DA9052) +=3D da9052-irq.o
> >>  obj-$(CONFIG_PMIC_DA9052)    +=3D da9052-core.o
> >>  obj-$(CONFIG_MFD_DA9052_SPI) +=3D da9052-spi.o
> >>  obj-$(CONFIG_MFD_DA9052_I2C) +=3D da9052-i2c.o
> >> +
> >> +obj-$(CONFIG_MFD_AC100)              +=3D ac100.o
> >>  obj-$(CONFIG_MFD_AXP20X)     +=3D axp20x.o
> >>  obj-$(CONFIG_MFD_AXP20X_I2C) +=3D axp20x-i2c.o
> >>  obj-$(CONFIG_MFD_AXP20X_RSB) +=3D axp20x-rsb.o
> >> diff --git a/drivers/mfd/ac100.c b/drivers/mfd/ac100.c
> >> new file mode 100644
> >> index 000000000000..15d24fa77771
> >> --- /dev/null
> >> +++ b/drivers/mfd/ac100.c
> >> @@ -0,0 +1,135 @@
> >> +/*
> >> + * ac100.c - MFD core driver for X-Powers' AC100 Audio Codec IC
> >
> > Nit: Drop the filename here.
> >
> > Apart from that:
> >   Acked-by: Lee Jones <lee.jones@linaro.org>
>=20
> Thanks.
> ChenYu

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

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
