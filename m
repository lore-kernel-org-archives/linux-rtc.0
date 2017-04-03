Return-Path: <rtc-linux+bncBDA7X7F2WUEBBAFWRHDQKGQERVH7OOY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-wr0-x22e.google.com (mail-wr0-x22e.google.com. [2a00:1450:400c:c0c::22e])
        by gmr-mx.google.com with ESMTPS id k74si1309925wmd.1.2017.04.03.07.24.00
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Apr 2017 07:24:00 -0700 (PDT)
Received: by mail-wr0-x22e.google.com with SMTP id l43so173225187wre.1
        for <rtc-linux@googlegroups.com>; Mon, 03 Apr 2017 07:24:00 -0700 (PDT)
Date: Mon, 3 Apr 2017 15:23:57 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Olof Johansson <olof@lixom.net>,
	bleung@chromium.org, martinez.javier@gmail.com,
	Guenter Roeck <groeck@chromium.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	rtc-linux@googlegroups.com, Vic Yang <victoryang@google.com>
Subject: [rtc-linux] Re: [PATCH 1/7] mfd: cros-ec: Fix host command buffer size
Message-ID: <20170403142357.2usczfylqbg6cgcx@dell>
References: <20170324174407.25401-1-enric.balletbo@collabora.com>
 <20170324174407.25401-2-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170324174407.25401-2-enric.balletbo@collabora.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Fri, 24 Mar 2017, Enric Balletbo i Serra wrote:

> From: Vic Yang <victoryang@google.com>
>=20
> For SPI, we can get up to 32 additional bytes for response preamble.
> The current overhead (2 bytes) may cause problems when we try to receive
> a big response. Update it to 32 bytes.
>=20
> Without this fix we could see a kernel BUG when we receive a big response
> from the Chrome EC when is connected via SPI.
>=20
> Signed-off-by: Vic Yang <victoryang@google.com>
> Tested-by: Enric Balletbo i Serra <enric.balletbo.collabora.com>
> ---
>=20
>   This patch is a FIX, and I think that would be interesting see it merge=
d
> in this release cycle. This should go through the MFD tree and can be pic=
ked
> independently of the other patches. Lee Jones I think this is for you.
>=20
>  include/linux/mfd/cros_ec.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
> index b3e812f..3b16c90 100644
> --- a/include/linux/mfd/cros_ec.h
> +++ b/include/linux/mfd/cros_ec.h
> @@ -35,10 +35,11 @@
>   * Max bus-specific overhead incurred by request/responses.
>   * I2C requires 1 additional byte for requests.
>   * I2C requires 2 additional bytes for responses.
> + * SPI requires up to 32 additional bytes for responses.
>   * */
>  #define EC_PROTO_VERSION_UNKNOWN	0
>  #define EC_MAX_REQUEST_OVERHEAD		1
> -#define EC_MAX_RESPONSE_OVERHEAD	2
> +#define EC_MAX_RESPONSE_OVERHEAD	32
> =20
>  /*
>   * Command interface between EC and AP, for LPC, I2C and SPI interfaces.

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
