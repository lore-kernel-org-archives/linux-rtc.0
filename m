Return-Path: <rtc-linux+bncBDA7X7F2WUEBBSX3YC4QKGQEH4WQKAA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x22d.google.com (mail-wm0-x22d.google.com. [2a00:1450:400c:c09::22d])
        by gmr-mx.google.com with ESMTPS id k143si885337wmg.1.2016.05.09.00.35.38
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 May 2016 00:35:38 -0700 (PDT)
Received: by mail-wm0-x22d.google.com with SMTP id a17so170518479wme.0
        for <rtc-linux@googlegroups.com>; Mon, 09 May 2016 00:35:38 -0700 (PDT)
Date: Mon, 9 May 2016 08:35:49 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Richard Purdie <rpurdie@rpsys.net>,
	Jacek Anaszewski <j.anaszewski@samsung.com>,
	Sebastian Reichel <sre@kernel.org>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org, rtc-linux@googlegroups.com,
	r.baldyga@hackerion.com,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [rtc-linux] Re: [PATCH v6 0/9] mfd: max8997: Add regmap support
Message-ID: <20160509073549.GC8324@dell>
References: <1462519289-2356-1-git-send-email-k.kozlowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1462519289-2356-1-git-send-email-k.kozlowski@samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Fri, 06 May 2016, Krzysztof Kozlowski wrote:
> This is a rebase and extension of old Robert Baldyga's work. [0]
>=20
> Robert no longer works in Samsung.
>=20
> From the original cover letter:
> "This patchset modifies max8997 driver and associated function drivers to=
 use
> register maps instead of operating directly on i2c bus. This change allow=
ed
> to simplify irq handling, and to move some initializations to individual
> function drivers. Hence now when some functions are not enabled, their i2=
c
> clients, regmaps and irqs are not registered."
>=20
>=20
> My changes (since Robert's v5)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> 1. Rebase on v4.6-rc6.
> 2. Collect more acks.
> 3. Add few fixes:
>    a. Haptic fix from Marek,
>    b. Extcon and RTC fix from me,
>    c. DTS fixes from Marek.
>=20
> DTS changes are independent but rest of them (extcon/input/MFD) rely
> on each other.
>=20
> One way of merging would be to pick everything (except DTS) through
> one tree. Or use tags.

I'd be happy to take the set, once you have collected all Acks.

> Best regards,
> Krzysztof
>=20
> [0] http://lkml.iu.edu/hypermail//linux/kernel/1411.1/03152.html
>=20
>=20
> Krzysztof Kozlowski (3):
>   extcon: max8997: Fix handling error code of regmap_irq_get_virq()
>   rtc: max8997: Check for ERRNO of regmap_irq_get_virq()
>   extcon: max8997: Fix inconsistent indenting
>=20
> Marek Szyprowski (3):
>   input: max8997-haptic: Fix NULL pointer dereference
>   ARM: dts: exynos: Fix regulator name to avoid forbidden character on
>     exynos4210-trats
>   ARM: dts: exynos: Add interrupt line to MAX8997 PMIC on
>     exynos4210-trats
>=20
> Robert Baldyga (3):
>   mfd: max8997: Use regmap to access registers
>   mfd: max8997: handle IRQs using regmap
>   mfd: max8997: Change irq names to upper case
>=20
>  arch/arm/boot/dts/exynos4210-trats.dts |   4 +-
>  drivers/extcon/extcon-max8997.c        |  72 ++++---
>  drivers/input/misc/max8997_haptic.c    |  40 ++--
>  drivers/leds/leds-max8997.c            |  13 +-
>  drivers/mfd/Kconfig                    |   3 +-
>  drivers/mfd/Makefile                   |   2 +-
>  drivers/mfd/max8997-irq.c              | 383 ---------------------------=
------
>  drivers/mfd/max8997.c                  | 245 ++++++++++++++-------
>  drivers/power/max8997_charger.c        |  33 +--
>  drivers/regulator/max8997.c            |  87 ++++----
>  drivers/rtc/rtc-max8997.c              |  60 +++---
>  include/linux/mfd/max8997-private.h    |  82 +++++--
>  12 files changed, 392 insertions(+), 632 deletions(-)
>  delete mode 100644 drivers/mfd/max8997-irq.c
>=20

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
