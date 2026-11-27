Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.119.170.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795780312;
	b=bwl0Wmjqd0SwwSkYPFIhKXz5WINkAyPyv9S2BA0JPuNvTDc6jOjV/KW5xKknih3jhLoo
	 Js/sDjgMkHAiettd1cj5K6Ib5d4oj2ZmoBrmG3rrTAERz9EMTJ0JilGSwecQY0YXRiLNs
	 wpI4cH37dsV1fglm+kiWO1364zDvqiDHxq+CfaZTnMnU9jE3wAlwXx8C0sVmUtwCYDGcX
	 qvViSYAaCKyxR/BsqVcThxN5t0Ipl0DsxRdTm8ebwhvOrCl78WMrAPoIg+KCECKWIHfMS
	 Tik3+it1ka2kFhYSYuWQLzlJ8wQpQKnTdR1bQUSbg2V9T9Ethv7Xl38JvU7xgLaH90w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780312;
	h=DMARC-Filter:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=GRH6CSorxqDpIqiIUjJPzDBfv1+01N2UQf89mAPKCcw=;
	b=N3OBw5izLgms0DYxMxbNcVmqkLF/miTy3HuO3c7W5JijsWu36DOkPSDY0obCdiI7/rFA
	 kYPI7ULrYTwiI+Il9XmzGfxPnqOf89Kvanqmgnts5iZHPzZVDOtEypYwVXVyZVjzepjba
	 ye+A4Hy5uP9TwzYTYZ/lNy+cR1EFXoOZL7/7BQDLwwbrFvaiiMT7/w57/fqdKzQKaEFKy
	 /EkC6JAZHkUsanwb+rh1rEC2E2AMZ70ZOGWk+CBYl/3ovdWsD0MH7yVUsZCnrnkE+NezY
	 FHMdpVhBcQV4hKXKathIcCj3QW9KMCg4Ytsz+YlpqjGDxe1dVZaMmytL/66Z5IEJMVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crapouillou.net;
	spf=pass smtp.mailfrom=crapouillou.net;
	arc=none smtp.remote-ip=185.119.170.32
Received: from aposti.net (aposti.net [185.119.170.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EC1606A31C;
	Fri, 27 Nov 2026 11:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45EC1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
Message-ID: <92fb93bdf8f6b5c66fa551a27aa099bf8630fa38.camel@crapouillou.net>
Subject: Re: [PATCH] rtc: jz4740: Register the power-off handler with devres
From: Paul Cercueil <paul@crapouillou.net>
To: Tian Xuechen <202300460064@mail.sdu.edu.cn>, 
	alexandre.belloni@bootlin.com, maarten@treewalker.org
Cc: linux-mips@vger.kernel.org, linux-rtc@vger.kernel.org
Date: Fri, 27 Nov 2026 12:51:39 +0100
In-Reply-To: <20261127113337.390592-1-202300460064@mail.sdu.edu.cn>
References: <20261127113337.390592-1-202300460064@mail.sdu.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi,

Overall a nice cleanup, I like that it finally gets rid of the
"dev_for_power_off" variable.

One comment below though.

Le vendredi 27 novembre 2026 =C3=A0 19:33 +0800, Tian Xuechen a =C3=A9crit=
=C2=A0:
> From: Tian Xuechen <202300460064@mail.sdu.edu.cn>
>=20
> A clock registration failure or driver removal leaves the power-off
> callback pointing at the old RTC. Register a managed handler with
> the device as its callback argument.
>=20
> This issue was found by our static analysis tool under development.
>=20
> Fixes: f9eb69d1ae2f ("rtc: jz4740: Add support for acting as the system p=
ower
> controller")
> Signed-off-by: Tian Xuechen <202300460064@mail.sdu.edu.cn>
> ---
> =C2=A0drivers/rtc/rtc-jz4740.c | 22 ++++++++++------------
> =C2=A01 file changed, 10 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
> index 32c331f3feb3..63ef067eb824 100644
> --- a/drivers/rtc/rtc-jz4740.c
> +++ b/drivers/rtc/rtc-jz4740.c
> @@ -68,7 +68,6 @@ struct jz4740_rtc {
> =C2=A0	spinlock_t lock;
> =C2=A0};
> =C2=A0
> -static struct device *dev_for_power_off;
> =C2=A0
> =C2=A0static inline uint32_t jz4740_rtc_reg_read(struct jz4740_rtc *rtc, =
size_t
> reg)
> =C2=A0{
> @@ -253,10 +252,12 @@ static void jz4740_rtc_poweroff(struct device *dev)
> =C2=A0	jz4740_rtc_reg_write(rtc, JZ_REG_RTC_HIBERNATE, 1);
> =C2=A0}
> =C2=A0
> -static void jz4740_rtc_power_off(void)
> +static int jz4740_rtc_power_off(struct sys_off_data *data)
> =C2=A0{
> -	jz4740_rtc_poweroff(dev_for_power_off);
> +	jz4740_rtc_poweroff(data->dev);
> =C2=A0	kernel_halt();
> +
> +	return NOTIFY_DONE;

After kernel_halt() runs the hardware should be shut down, so if we get the=
re we
have a problem... I think it would make sense to:

return notifier_from_errno(-EIO);

Cheers,
-Paul

> =C2=A0}
> =C2=A0
> =C2=A0static const struct of_device_id jz4740_rtc_of_match[] =3D {
> @@ -396,15 +397,6 @@ static int jz4740_rtc_probe(struct platform_device *=
pdev)
> =C2=A0	if (ret)
> =C2=A0		return dev_err_probe(dev, ret, "Failed to request rtc
> irq\n");
> =C2=A0
> -	if (of_device_is_system_power_controller(np)) {
> -		dev_for_power_off =3D dev;
> -
> -		if (!pm_power_off)
> -			pm_power_off =3D jz4740_rtc_power_off;
> -		else
> -			dev_warn(dev, "Poweroff handler already present!\n");
> -	}
> -
> =C2=A0	if (device_property_present(dev, "#clock-cells")) {
> =C2=A0		rtc->clk32k.init =3D CLK_HW_INIT_HW("clk32k",
> __clk_get_hw(clk),
> =C2=A0						=C2=A0 &jz4740_rtc_clk32k_ops, 0);
> @@ -421,6 +413,12 @@ static int jz4740_rtc_probe(struct platform_device *=
pdev)
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 "Unable to register clk32k clock
> provider\n");
> =C2=A0	}
> =C2=A0
> +	if (of_device_is_system_power_controller(np)) {
> +		ret =3D devm_register_power_off_handler(dev,
> jz4740_rtc_power_off, NULL);
> +		if (ret)
> +			dev_warn(dev, "Failed to register power-off handler:
> %d\n", ret);
> +	}
> +
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
>=20
> base-commit: 4dce97c6c265544342e716e62fd24bbb232590c5
