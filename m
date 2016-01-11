Return-Path: <rtc-linux+bncBDA7X7F2WUEBBLMDZW2AKGQEBGPPALI@googlegroups.com>
Received: from mail-wm0-x22f.google.com (mail-wm0-x22f.google.com. [2a00:1450:400c:c09::22f])
        by gmr-mx.google.com with ESMTPS id 5si274561wmm.2.2016.01.10.21.46.21
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jan 2016 21:46:21 -0800 (PST)
Received: by mail-wm0-x22f.google.com with SMTP id u188so200476382wmu.1
        for <rtc-linux@googlegroups.com>; Sun, 10 Jan 2016 21:46:21 -0800 (PST)
Date: Mon, 11 Jan 2016 05:46:18 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Linux Kernel <linuxkernelmails@gmail.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	linus.walleij@linaro.org, gnurou@gmail.com, broonie@kernel.org,
	a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
	lgirdwood@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	rtc-linux@googlegroups.com, swarren@nvidia.com, treding@nvidia.com,
	Chaitanya Bandi <bandik@nvidia.com>
Subject: [rtc-linux] Re: [PATCH 5/6] rtc: max77620: add support for
 max77620/max20024 RTC driver
Message-ID: <20160111054618.GA3331@x1>
References: <1452177524-23192-1-git-send-email-ldewangan@nvidia.com>
 <1452177524-23192-6-git-send-email-ldewangan@nvidia.com>
 <568F0BD3.8080000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <568F0BD3.8080000@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

From: Linux Kernel <linuxkernelmails@gmail.com>

Really?  Why the shroud of secrecy?

Any reason why you're not using your real name?

On Fri, 08 Jan 2016, Linux Kernel wrote:
> On Thursday 07 January 2016 08:08 PM, Laxman Dewangan wrote:
>=20
> >Maxim Semiconductor's PMIC MAX77620/MAX20024 has on chip
> >RTC  module. This support for setting alarm and time.
> >
> >Add RTC driver to access this chip's RTC module via RTC
> >APIs.
> >
> >Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> >Signed-off-by: Chaitanya Bandi <bandik@nvidia.com>
> >Tested-by: Venkat Reddy Talla <vreddytalla@nvidia.com>
> >---
> >  drivers/rtc/Kconfig        |   9 +
> >  drivers/rtc/Makefile       |   1 +
> >  drivers/rtc/rtc-max77620.c | 574 +++++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 584 insertions(+)
> >  create mode 100644 drivers/rtc/rtc-max77620.c
> >
> (...)
>=20
> >+static struct platform_driver max77620_rtc_driver =3D {
> >+	.probe =3D max77620_rtc_probe,
> >+	.remove =3D max77620_rtc_remove,
> >+	.id_table =3D max77620_rtc_devtype,
> >+	.driver =3D {
> >+			.name =3D "max77620-rtc",
> >+			.owner =3D THIS_MODULE,
>=20
> Drop this line, .owner will be populated by driver core.
>=20
> >+			.pm =3D &max77620_rtc_pm_ops,
> >+	},
> >+};
> >+
> >+module_platform_driver(max77620_rtc_driver);
> >+
> >+MODULE_DESCRIPTION("max77620 RTC driver");
> >+MODULE_AUTHOR("Chaitanya Bandi <bandik@nvidia.com>");
> >+MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
> >+MODULE_ALIAS("platform:max77620-rtc");
> >+MODULE_LICENSE("GPL v2");

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
