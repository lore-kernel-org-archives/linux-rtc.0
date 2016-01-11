Return-Path: <rtc-linux+bncBDA7X7F2WUEBBNUDZW2AKGQEQVRNFMY@googlegroups.com>
Received: from mail-wm0-x231.google.com (mail-wm0-x231.google.com. [2a00:1450:400c:c09::231])
        by gmr-mx.google.com with ESMTPS id s132si304116wmd.1.2016.01.10.21.46.30
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jan 2016 21:46:30 -0800 (PST)
Received: by mail-wm0-x231.google.com with SMTP id f206so197613909wmf.0
        for <rtc-linux@googlegroups.com>; Sun, 10 Jan 2016 21:46:30 -0800 (PST)
Date: Mon, 11 Jan 2016 05:46:27 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: rtc-linux@googlegroups.com, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, linus.walleij@linaro.org, gnurou@gmail.com,
	broonie@kernel.org, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, lgirdwood@gmail.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, swarren@nvidia.com, treding@nvidia.com,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Chaitanya Bandi <bandik@nvidia.com>,
	Mallikarjun Kasoju <mkasoju@nvidia.com>
Subject: Re: [rtc-linux] [PATCH 2/6] mfd: max77620: add core driver for MAX77620/MAX20024
Message-ID: <20160111054627.GB3331@x1>
References: <1452177524-23192-1-git-send-email-ldewangan@nvidia.com>
 <1452177524-23192-3-git-send-email-ldewangan@nvidia.com>
 <CAJKOXPfa0jjRWE6LKvNmwCRcG9Es7=36_03kTqCx-aB1wENx0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAJKOXPfa0jjRWE6LKvNmwCRcG9Es7=36_03kTqCx-aB1wENx0g@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Fri, 08 Jan 2016, Krzysztof Kozlowski wrote:

Thanks for taking the time to review.

> ()2016-01-07 23:38 GMT+09:00 Laxman Dewangan <ldewangan@nvidia.com>:
> > MAX77620/MAX20024 are Power Management IC from the MAXIM.
> > It supports RTC, multiple GPIOs, multiple DCDC and LDOs,
> > watchdog, clock etc.
> >
> > Add MFD drier to provides common support for accessing the
> > device; additional drivers is developed on respected subsystem
> > in order to use the functionality of the device.
> >
> > Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> > Signed-off-by: Chaitanya Bandi <bandik@nvidia.com>
> > Signed-off-by: Mallikarjun Kasoju <mkasoju@nvidia.com>
> > Tested-by: Venkat Reddy Talla <vreddytalla@nvidia.com>
>=20
> The Testing and Reviewed are statements (see SubmittingPatches) so
> they should be made explicitly by people. As this is v1 how they could
> make a public statement so far?

SubmittingPatches bears no mention that Reviewed-by/Tested-by
statements have to be provided on one of the public mailing lists.
These can be provided privately prior to upstream submission v1.

> > ---
> >  drivers/mfd/Kconfig          |  15 +
> >  drivers/mfd/Makefile         |   1 +
> >  drivers/mfd/max77620.c       | 926 +++++++++++++++++++++++++++++++++++=
++++++++
> >  include/linux/mfd/max77620.h | 503 +++++++++++++++++++++++
> >  4 files changed, 1445 insertions(+)
> >  create mode 100644 drivers/mfd/max77620.c
> >  create mode 100644 include/linux/mfd/max77620.h

[...]
=20
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
