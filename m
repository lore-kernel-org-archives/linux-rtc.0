Return-Path: <rtc-linux+bncBCUJ7YGL3QFBBXNERLEQKGQEUTFXLWQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org. [140.211.169.12])
        by gmr-mx.google.com with ESMTPS id t64si2119106pfa.7.2017.05.22.00.25.16
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 May 2017 00:25:17 -0700 (PDT)
Date: Mon, 22 May 2017 09:25:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee.jones@linaro.org>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Sebastian Reichel <sre@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Felipe Balbi <balbi@kernel.org>,
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
Message-ID: <20170522072504.GB21253@kroah.com>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-4-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <20170521220212.1404-4-wsa@the-dreams.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Mon, May 22, 2017 at 12:02:10AM +0200, Wolfram Sang wrote:
> include/linux/i2c is not for client devices. Move the header file to a
> more appropriate location.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  arch/arm/mach-omap2/common.h            | 2 +-
>  arch/arm/mach-omap2/omap_twl.c          | 2 +-
>  drivers/gpio/gpio-twl4030.c             | 2 +-
>  drivers/iio/adc/twl4030-madc.c          | 2 +-
>  drivers/iio/adc/twl6030-gpadc.c         | 2 +-
>  drivers/input/keyboard/twl4030_keypad.c | 2 +-
>  drivers/input/misc/twl4030-pwrbutton.c  | 2 +-
>  drivers/input/misc/twl4030-vibra.c      | 2 +-
>  drivers/mfd/twl-core.c                  | 6 +++---
>  drivers/mfd/twl4030-audio.c             | 2 +-
>  drivers/mfd/twl4030-irq.c               | 2 +-
>  drivers/mfd/twl4030-power.c             | 2 +-
>  drivers/mfd/twl6030-irq.c               | 2 +-
>  drivers/phy/phy-twl4030-usb.c           | 2 +-
>  drivers/power/supply/twl4030_charger.c  | 2 +-
>  drivers/pwm/pwm-twl-led.c               | 2 +-
>  drivers/pwm/pwm-twl.c                   | 2 +-
>  drivers/regulator/twl-regulator.c       | 2 +-
>  drivers/regulator/twl6030-regulator.c   | 2 +-
>  drivers/rtc/rtc-twl.c                   | 2 +-
>  drivers/usb/phy/phy-twl6030-usb.c       | 2 +-
>  drivers/video/backlight/pandora_bl.c    | 2 +-
>  drivers/watchdog/twl4030_wdt.c          | 2 +-
>  include/linux/{i2c => mfd}/twl.h        | 0
>  sound/soc/codecs/twl4030.c              | 2 +-
>  25 files changed, 26 insertions(+), 26 deletions(-)
>  rename include/linux/{i2c => mfd}/twl.h (100%)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
