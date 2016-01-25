Return-Path: <rtc-linux+bncBDA7X7F2WUEBBJEOTC2QKGQEV6UVPOI@googlegroups.com>
Received: from mail-wm0-x22e.google.com (mail-wm0-x22e.google.com. [2a00:1450:400c:c09::22e])
        by gmr-mx.google.com with ESMTPS id h123si405120wmd.0.2016.01.25.03.29.40
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2016 03:29:40 -0800 (PST)
Received: by mail-wm0-x22e.google.com with SMTP id u188so61567532wmu.1
        for <rtc-linux@googlegroups.com>; Mon, 25 Jan 2016 03:29:40 -0800 (PST)
Date: Mon, 25 Jan 2016 11:29:36 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	linus.walleij@linaro.org, gnurou@gmail.com, broonie@kernel.org,
	a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
	lgirdwood@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	rtc-linux@googlegroups.com, swarren@nvidia.com, treding@nvidia.com,
	vreddytalla@nvidia.com, Chaitanya Bandi <bandik@nvidia.com>,
	Mallikarjun Kasoju <mkasoju@nvidia.com>
Subject: [rtc-linux] Re: [PATCH V4 2/5] mfd: max77620: add core driver for MAX77620/MAX20024
Message-ID: <20160125112936.GB3368@x1>
References: <1453198783-28383-1-git-send-email-ldewangan@nvidia.com>
 <1453198783-28383-3-git-send-email-ldewangan@nvidia.com>
 <569F199D.9020207@samsung.com>
 <56A214EB.30905@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <56A214EB.30905@nvidia.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Fri, 22 Jan 2016, Laxman Dewangan wrote:

> Thanks Krzysztof for review.
>=20
> Hi Lee,
> Are you taking the patches from your tree? Or will go in individual
> subsystem?

I can take the set if there are build dependencies.  If there aren't,
then they should be routed via their respective subsystem trees.

> On Wednesday 20 January 2016 10:52 AM, Krzysztof Kozlowski wrote:
> >On 19.01.2016 19:19, Laxman Dewangan wrote:
> >>MAX77620/MAX20024 are Power Management IC from the MAXIM.
> >>It supports RTC, multiple GPIOs, multiple DCDC and LDOs,
> >>watchdog, clock etc.
> >>
> >>Add MFD drier to provides common support for accessing the
> >>device; additional drivers is developed on respected subsystem
> >>in order to use the functionality of the device.
> >>
> >>Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> >>Signed-off-by: Chaitanya Bandi <bandik@nvidia.com>
> >>Signed-off-by: Mallikarjun Kasoju <mkasoju@nvidia.com>
> >>---
> >>Changes from V1:
> >>- Code cleanups per review from V1.
> >>- Move register acccess APIs from header to c file.
> >>- Remove some of non required variable, remove duplication in error mes=
sage
> >>  and simplify some of function implementation.
> >>- Register RTC driver such that it can get the regmap handle form paren=
t device
> >>
> >>Changes from V2:
> >>- Run coccicheck and checkpatch in strict mode for the alignment.
> >>- Drop RTC driver and its i2c client registration.
> >>
> >>Changes from V3:
> >>- Change all sys initcall to module driver.
> >>- change the max77620_read argument to unisgned int from u8.
> >>
> >>  drivers/mfd/Kconfig          |  15 +
> >>  drivers/mfd/Makefile         |   1 +
> >>  drivers/mfd/max77620.c       | 871 ++++++++++++++++++++++++++++++++++=
+++++++++
> >>  include/linux/mfd/max77620.h | 404 ++++++++++++++++++++
> >>  4 files changed, 1291 insertions(+)
> >>  create mode 100644 drivers/mfd/max77620.c
> >>  create mode 100644 include/linux/mfd/max77620.h
> >>
> >
> >Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> >
> >Best regards,
> >Krzysztof
> >
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
