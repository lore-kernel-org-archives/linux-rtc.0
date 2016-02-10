Return-Path: <rtc-linux+bncBDA7X7F2WUEBBLGB5W2QKGQEBQYBN7Q@googlegroups.com>
Received: from mail-wm0-x236.google.com (mail-wm0-x236.google.com. [2a00:1450:400c:c09::236])
        by gmr-mx.google.com with ESMTPS id w197si146047wmw.3.2016.02.10.08.09.16
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Feb 2016 08:09:16 -0800 (PST)
Received: by mail-wm0-x236.google.com with SMTP id c200so34857069wme.0
        for <rtc-linux@googlegroups.com>; Wed, 10 Feb 2016 08:09:16 -0800 (PST)
Date: Wed, 10 Feb 2016 16:09:12 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: alexandre.belloni@free-electrons.com, k.kozlowski@samsung.com,
	javier@osg.samsung.com, broonie@kernel.org,
	gregkh@linuxfoundation.org, a.zummo@towertech.it,
	cw00.choi@samsung.com, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH V7 4/5] mfd: max77686: do not set i2c client
 data for rtc i2c client
Message-ID: <20160210160912.GF26950@x1>
References: <1455038794-9921-1-git-send-email-ldewangan@nvidia.com>
 <1455038794-9921-5-git-send-email-ldewangan@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1455038794-9921-5-git-send-email-ldewangan@nvidia.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, 09 Feb 2016, Laxman Dewangan wrote:

> There is different RTC I2C address for RTC block in MAX77686.
> Driver is creating dummy i2c client for this address to access
> the register of this IP block.
>=20
> As there is no call to i2c_get_clientdata() for rtc_i2c client,
> there is no need to store pointer and hence removing the call
> to set client data for rtc i2c client.
>=20
> Suggested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> CC: Javier Martinez Canillas <javier@osg.samsung.com>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
>=20
> ---
> This is new in this series based on review comment from V1.
>=20
> Changes from V2:
> - Rephrase description.
> - Added reviewed by.
>=20
> Changes from V3:
> - None, become 5th on series.
>=20
> Changes from V4:
> None
>=20
> Changes from V5:
> None
>=20
> Changes from V6:
> Make this as 4th of series as regmap change applied independently.
>=20
>  drivers/mfd/max77686.c | 1 -
>  1 file changed, 1 deletion(-)

Appart from the subject line being wrong:

Acked-by: Lee Jones <lee.jones@linaro.org>

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
