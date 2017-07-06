Return-Path: <rtc-linux+bncBDA7X7F2WUEBBXGB67FAKGQEIDFRN5Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wr0-x22a.google.com (mail-wr0-x22a.google.com. [2a00:1450:400c:c0c::22a])
        by gmr-mx.google.com with ESMTPS id f140si7716788wme.4.2017.07.06.00.03.55
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jul 2017 00:03:55 -0700 (PDT)
Received: by mail-wr0-x22a.google.com with SMTP id 77so15352048wrb.1
        for <rtc-linux@googlegroups.com>; Thu, 06 Jul 2017 00:03:55 -0700 (PDT)
Date: Thu, 6 Jul 2017 08:03:52 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Sebastian Reichel <sre@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Felipe Balbi <balbi@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
	rtc-linux@googlegroups.com, linux-usb@vger.kernel.org,
	linux-fbdev@vger.kernel.org, linux-watchdog@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: [rtc-linux] Re: [PATCH 3/3] mfd: twl: move header file out of I2C realm
Message-ID: <20170706070352.xdecvsnremwqed72@dell>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-4-wsa@the-dreams.de>
 <20170706064453.GH16144@ulmo.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <20170706064453.GH16144@ulmo.fritz.box>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Thu, 06 Jul 2017, Thierry Reding wrote:

> On Mon, May 22, 2017 at 12:02:10AM +0200, Wolfram Sang wrote:
> > include/linux/i2c is not for client devices. Move the header file to a
> > more appropriate location.
> >=20
> > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> > ---
> >  arch/arm/mach-omap2/common.h            | 2 +-
> >  arch/arm/mach-omap2/omap_twl.c          | 2 +-
> >  drivers/gpio/gpio-twl4030.c             | 2 +-
> >  drivers/iio/adc/twl4030-madc.c          | 2 +-
> >  drivers/iio/adc/twl6030-gpadc.c         | 2 +-
> >  drivers/input/keyboard/twl4030_keypad.c | 2 +-
> >  drivers/input/misc/twl4030-pwrbutton.c  | 2 +-
> >  drivers/input/misc/twl4030-vibra.c      | 2 +-
> >  drivers/mfd/twl-core.c                  | 6 +++---
> >  drivers/mfd/twl4030-audio.c             | 2 +-
> >  drivers/mfd/twl4030-irq.c               | 2 +-
> >  drivers/mfd/twl4030-power.c             | 2 +-
> >  drivers/mfd/twl6030-irq.c               | 2 +-
> >  drivers/phy/phy-twl4030-usb.c           | 2 +-
> >  drivers/power/supply/twl4030_charger.c  | 2 +-
> >  drivers/pwm/pwm-twl-led.c               | 2 +-
> >  drivers/pwm/pwm-twl.c                   | 2 +-
> >  drivers/regulator/twl-regulator.c       | 2 +-
> >  drivers/regulator/twl6030-regulator.c   | 2 +-
> >  drivers/rtc/rtc-twl.c                   | 2 +-
> >  drivers/usb/phy/phy-twl6030-usb.c       | 2 +-
> >  drivers/video/backlight/pandora_bl.c    | 2 +-
> >  drivers/watchdog/twl4030_wdt.c          | 2 +-
> >  include/linux/{i2c =3D> mfd}/twl.h        | 0
> >  sound/soc/codecs/twl4030.c              | 2 +-
> >  25 files changed, 26 insertions(+), 26 deletions(-)
> >  rename include/linux/{i2c =3D> mfd}/twl.h (100%)
>=20
> I didn't see this get applied yet, so just in case anyone was waiting
> for me (this is trivial, so I don't think there's a need):

You're not the last. :)

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
