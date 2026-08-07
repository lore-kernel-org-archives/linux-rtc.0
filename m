Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E935712B94
	for <linux-rtc@vger.kernel.org>; Fri,  7 Aug 2026 01:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786067836; cv=none; b=mf8TmkqeyoDsj8Fd3qPhXXTG9CAdwOoeLHbYb8r3l6vYIsSidO4PJZrQoIPIBlm7YRpnrZ0WOLUrEG1WDLEavhVKIjIzpeS5NPlH5gtWrGGeJsZAwmchcsfybrsSn1OjbmAcTI062B407bzaNTqGK5tggK0firAQROIPUOKZdcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786067836; c=relaxed/simple;
	bh=f2c5LrSvye+pNG26ziPqb0Z58UO90Vo58/+ObRnCru4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hk/c3o1wSwuoK18psXHnY8m2ykyl+MHpZEFvNziGh9mIVyMxHa0MKlWGkIP2bZYWqKBB5FsWllCfyYXFVpN8j6lEX2uOLCITxI9A8h3bNZYH+EAAb6PiyQvu5thJNXWOP6Ae5fGqnklORgGwgNpI6U5qXVQmHA9JAcdAHD+8L+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLfKozXZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLfKozXZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EC31F000E9;
	Fri,  7 Aug 2026 01:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786067834;
	bh=VCud6eO3w3Te48Zgg+8tQTVhF/Vksaa+Lqfr67CEdWg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mLfKozXZ2RkRIiYByWO4UmQxREMhdcl7FtwFDFrtStLx146NqIA/rgYe8KRDt2vlg
	 f2vi3fGH5bMbCg04TZQq/FcgJK8fJnZn9K+MQF2HFxhZFLfW/qwT9N5ncT56DuKOQA
	 J8b/gzwrpTnTWzaPOYDFgiFGG2uhqsB8QZVVphe6OyrJbCKdThxQE6e38MFw3XGLa/
	 q79SfNv7/9Mky1wRifJCjLOAaxs0kjTFZ5VGXl9zE0EOqVpw9BDD9wwUSliVyWTiC7
	 xCVDiUaRbnb/gl4M7JwrASRbAv+QQ08wAL4ETRBhjr4BRp6j9PPpg+nISx0R6cb5lh
	 7Yh2hfGyLDRPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] rtc: m41t80: use watchdog core for watchdog support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuho Choi" <dbgh9129@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260807013915.907604-1-dbgh9129@gmail.com>
References: <20260807013915.907604-1-dbgh9129@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 01:57:13 +0000
Message-Id: <20260807015714.47EC31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] m41t80_wdt_set_timeout() modifies the watchdog timeout before vali=
dating the hardware transfer, and unconditionally starts the hardware timer.
- [Medium] The watchdog device's parent pointer is not assigned before regi=
stration, breaking sysfs topology.
- [Medium] The wdt_margin module parameter's default value shadows the Devi=
ce Tree timeout-sec property.

Pre-existing issues:
- [High] The square-wave clock and OF provider registered during probe are =
never unregistered, causing a Use-After-Free.
- [High] Stack buffers are passed to i2c_transfer, violating DMA constraint=
s.
--

--- Patch [1]: [PATCH v2] rtc: m41t80: use watchdog core for watchdog suppo=
rt ---
commit 71ede3ba0b7d96a1d64a82ae64e6033a3aa277f9
Author: Yuho Choi <dbgh9129@gmail.com>

rtc: m41t80: use watchdog core for watchdog support

The M41T80 watchdog uses a global misc device, reboot notifier, and
save_client pointer. This patch converts the driver to use the watchdog cor=
e,
embedding the watchdog_device in m41t80_data and relying on devres for
registration and cleanup.

> diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
> index 3c8c379392c14..ec2238d9170e0 100644
> --- a/drivers/rtc/rtc-m41t80.c
> +++ b/drivers/rtc/rtc-m41t80.c

[ ... ]

> -static int wdt_margin =3D WD_TIMO;
> +static int wdt_margin =3D M41T80_WDT_DEFAULT_TIMEOUT;
>  module_param(wdt_margin, int, 0);
>  MODULE_PARM_DESC(wdt_margin, "Watchdog timeout in seconds (default 60s)"=
);
> =20
> -static unsigned long wdt_is_open;
> -static int boot_flag;
> +static const struct watchdog_info m41t80_wdt_info =3D {
> +	.options =3D WDIOF_POWERUNDER | WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
> +	.firmware_version =3D 1,
> +	.identity =3D "M41T80 Watchdog",
> +};

[Severity: Medium]
Since wdt_margin is statically initialized to M41T80_WDT_DEFAULT_TIMEOUT (6=
0),
will watchdog_init_timeout() interpret this non-zero value as an explicit
driver override and completely ignore the Device Tree timeout-sec property?

It seems this renders the DT configuration unreachable unless the user
explicitly passes wdt_margin=3D0 at boot.

[ ... ]

> +static int m41t80_wdt_ping(struct watchdog_device *wdt)
>  {
> +	struct m41t80_data *m41t80 =3D watchdog_get_drvdata(wdt);
> +	struct i2c_client *client =3D m41t80->client;
>  	unsigned char i2c_data[2];
> -	struct i2c_msg msgs1[1] =3D {
> -		{
> -			.addr	=3D save_client->addr,
> -			.flags	=3D 0,
> -			.len	=3D 2,
> -			.buf	=3D i2c_data,
> -		},
> +	struct i2c_msg msg =3D {
> +		.addr =3D client->addr,
> +		.flags =3D 0,
> +		.len =3D 2,
> +		.buf =3D i2c_data,
>  	};

[Severity: High]
This is a pre-existing issue, but are these stack-allocated buffers safe for
I2C transfers?

In modern kernels with VMAP_STACK, the stack is not physically contiguous. =
If
the underlying I2C adapter relies on DMA for transfers, passing stack memory
(like i2c_data here, and i2c_buf in m41t80_wdt_stop) directly to i2c_transf=
er()
could cause memory corruption or kernel panics.

[ ... ]

> +static int m41t80_wdt_set_timeout(struct watchdog_device *wdt, unsigned =
int timeout)
>  {
> +	wdt->timeout =3D timeout;
> =20
> -	mutex_lock(&m41t80_rtc_mutex);
> -	ret =3D wdt_ioctl(file, cmd, arg);
> -	mutex_unlock(&m41t80_rtc_mutex);
> -
> -	return ret;
> +	return m41t80_wdt_ping(wdt);
>  }

[Severity: High]
If the underlying I2C transfer fails in m41t80_wdt_ping(), won't the hardwa=
re
retain its old timeout while the watchdog core and driver retain the new,
unapplied wdt->timeout, causing an inconsistent state?

Also, if the watchdog was previously stopped, wouldn't unconditionally
calling m41t80_wdt_ping() here activate the hardware timer without setting
WDOG_ACTIVE in the watchdog core? This could lead to an unexpected system
reboot since the core won't ping an inactive watchdog.

[ ... ]

> @@ -1011,19 +842,26 @@ static int m41t80_probe(struct i2c_client *client)
>  	if (rc)
>  		return rc;
> =20
> -	return 0;
> -}
> -
> -static void m41t80_remove(struct i2c_client *client)
> -{
>  #ifdef CONFIG_RTC_DRV_M41T80_WDT
> -	struct m41t80_data *clientdata =3D i2c_get_clientdata(client);
> -
> -	if (clientdata->features & M41T80_FEATURE_HT) {
> -		misc_deregister(&wdt_dev);
> -		unregister_reboot_notifier(&wdt_notifier);
> +	if (m41t80_data->features & M41T80_FEATURE_HT) {
> +		m41t80_data->wdt.info =3D &m41t80_wdt_info;
> +		m41t80_data->wdt.ops =3D &m41t80_wdt_ops;
> +		m41t80_data->wdt.timeout =3D M41T80_WDT_DEFAULT_TIMEOUT;
> +		m41t80_data->wdt.min_timeout =3D M41T80_WDT_MIN_TIMEOUT;
> +		m41t80_data->wdt.max_timeout =3D M41T80_WDT_MAX_TIMEOUT;

[Severity: Medium]
Is it intentional to omit setting the watchdog device's parent pointer
(m41t80_data->wdt.parent =3D &client->dev)?

Failing to set this will cause the watchdog core to create the device at the
root of the virtual sysfs hierarchy rather than nesting it under the physic=
al
I2C client device, which can break sysfs topology and power management
ordering.

> +
> +		watchdog_init_timeout(&m41t80_data->wdt, wdt_margin, &client->dev);
> +		watchdog_stop_on_reboot(&m41t80_data->wdt);
> +		watchdog_stop_on_unregister(&m41t80_data->wdt);
> +		watchdog_set_drvdata(&m41t80_data->wdt, m41t80_data);
> +
> +		rc =3D devm_watchdog_register_device(&client->dev, &m41t80_data->wdt);
> +		if (rc)
> +			return rc;
>  	}
>  #endif

[Severity: High]
This is a pre-existing issue, but if devm_watchdog_register_device() fails =
and
returns an error, won't this leak Common Clock Framework pointers?

Earlier in probe, m41t80_sqw_register_clk() registers a clock and an OF
provider using non-managed APIs:

	clk =3D clk_register(&client->dev, &m41t80->sqw);
	if (!IS_ERR(clk))
		of_clk_add_provider(node, of_clk_src_simple_get, clk);

Neither the probe error paths nor the device unbind mechanism unregisters
these. If probe fails here, devres will automatically free the m41t80_data
struct, leaving CCF with dangling pointers to the embedded m41t80_data->sqw
and causing a use-after-free on subsequent clock accesses.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807013915.9076=
04-1-dbgh9129@gmail.com?part=3D1
