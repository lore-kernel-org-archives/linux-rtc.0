Return-Path: <rtc-linux+bncBDA7X7F2WUEBBBVIY6YQKGQEOPEIXNY@googlegroups.com>
Received: from mail-wm0-x22a.google.com (mail-wm0-x22a.google.com. [2a00:1450:400c:c09::22a])
        by gmr-mx.google.com with ESMTPS id t18si195102wme.0.2015.10.29.01.08.38
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2015 01:08:38 -0700 (PDT)
Received: by mail-wm0-x22a.google.com with SMTP id l128so19982411wml.0
        for <rtc-linux@googlegroups.com>; Thu, 29 Oct 2015 01:08:38 -0700 (PDT)
Date: Thu, 29 Oct 2015 08:08:35 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Alim Akhtar <alim.akhtar@samsung.com>
Cc: broonie@kernel.org, k.kozlowski@samsung.com,
	linux-samsung-soc@vger.kernel.org, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Thomas Abraham <thomas.ab@samsung.com>
Subject: [rtc-linux] Re: [PATCH v4 3/4] regulator: s2mps11: add support for
 S2MPS15 regulators
Message-ID: <20151029080835.GM4058@x1>
References: <1446094723-6212-1-git-send-email-alim.akhtar@samsung.com>
 <1446094723-6212-4-git-send-email-alim.akhtar@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1446094723-6212-4-git-send-email-alim.akhtar@samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Thu, 29 Oct 2015, Alim Akhtar wrote:

> From: Thomas Abraham <thomas.ab@samsung.com>
>=20
> The S2MPS15 PMIC is similar in functionality to S2MPS11/14 PMIC. It conta=
ins
> 27 LDO and 10 Buck regulators and allows programming these regulators via=
 a
> I2C interface. This patch adds initial support for LDO/Buck regulators of
> S2MPS15 PMIC.
>=20
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/regulator/Kconfig   |    4 +-
>  drivers/regulator/s2mps11.c |  135 +++++++++++++++++++++++++++++++++++++=
+++++-
>  2 files changed, 136 insertions(+), 3 deletions(-)

[...]

> @@ -1070,6 +1202,7 @@ static const struct platform_device_id s2mps11_pmic=
_id[] =3D {
>  	{ "s2mps11-pmic", S2MPS11X},
>  	{ "s2mps13-pmic", S2MPS13X},
>  	{ "s2mps14-pmic", S2MPS14X},
> +	{ "s2mps15-regulator", S2MPS15X},
>  	{ "s2mpu02-pmic", S2MPU02},
>  	{ },
>  };

Are you going to s/pmic/regulator/ for the existing devices too?

[...]

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
