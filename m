Return-Path: <rtc-linux+bncBDA7X7F2WUEBBBMBRO5QKGQE7QLYCDA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wm0-x22a.google.com (mail-wm0-x22a.google.com. [2a00:1450:400c:c09::22a])
        by gmr-mx.google.com with ESMTPS id a6si500392wma.1.2016.06.16.08.06.45
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jun 2016 08:06:45 -0700 (PDT)
Received: by mail-wm0-x22a.google.com with SMTP id m124so73183076wme.1
        for <rtc-linux@googlegroups.com>; Thu, 16 Jun 2016 08:06:45 -0700 (PDT)
Date: Thu, 16 Jun 2016 16:07:27 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Mark Brown <broonie@kernel.org>, Kukjin Kim <kgene@kernel.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Richard Purdie <rpurdie@rpsys.net>,
	Jacek Anaszewski <j.anaszewski@samsung.com>,
	Sebastian Reichel <sre@kernel.org>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org, rtc-linux@googlegroups.com,
	r.baldyga@hackerion.com,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [rtc-linux] Re: [PATCH v7 1/6] mfd: max8997: Use regmap to access registers
Message-ID: <20160616150727.GF4948@dell>
References: <1464773339-756-1-git-send-email-k.kozlowski@samsung.com>
 <1464774841-1439-1-git-send-email-k.kozlowski@samsung.com>
 <20160608142621.GG14888@dell>
 <57582C1F.5040306@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <57582C1F.5040306@samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Wed, 08 Jun 2016, Krzysztof Kozlowski wrote:

> On 06/08/2016 04:26 PM, Lee Jones wrote:
> > On Wed, 01 Jun 2016, Krzysztof Kozlowski wrote:
> >=20
> >> From: Robert Baldyga <r.baldyga@samsung.com>
> >>
> >> This patch modifies max8997 driver and each associated function driver=
,
> >> to use regmap instead of operating directly on i2c bus. It will allow =
to
> >> simplify IRQ handling using regmap-irq.
> >>
> >> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
> >> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> >>
> >> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> >> Acked-by: Bryan Wu <cooloney@gmail.com>
> >> Acked-by: Lee Jones <lee.jones@linaro.org>
> >> Acked-by: Sebastian Reichel <sre@kernel.org>
> >> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> >> [k.kozlowski: Collect acks, rebase on v4.6-rc6]
> >> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> >> Acked-by: Jacek Anaszewski <j.anaszewski@samsung.com>
> >> ---
> >>  drivers/extcon/extcon-max8997.c       |  31 ++++----
> >>  drivers/input/misc/max8997_haptic.c   |  34 ++++----
> >>  drivers/leds/leds-max8997.c           |  13 ++--
> >>  drivers/mfd/Kconfig                   |   1 +
> >>  drivers/mfd/max8997-irq.c             |  64 ++++++---------
> >>  drivers/mfd/max8997.c                 | 141 +++++++++++++++----------=
---------
> >>  drivers/power/max8997_charger.c       |  33 ++++----
> >>  drivers/regulator/max8997-regulator.c |  87 ++++++++++-----------
> >=20
> > Is it just Mark's Ack you require?
>=20
> Yes, only Mark's is missing here. All other patches got everything they
> need.

I think you'd better re-submit and get Mark's attention.

Also indicate that his Ack is all you need.

Once received, I can take the set.

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
