Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C47A45FFAD;
	Fri, 21 Aug 2026 10:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787307913; cv=none; b=JGWqFwUjBTklreu0hCxSt2I8jP37ZbslK+N+ZxFhZERKzZG3e92WCnPNWh4SnNIf5AkdCFX3CITkEqDKdHaxD5lxvfdw1h+Aijcx5qXKHhmnj9uhOOgJyoC5h7BIpbt9Hb50WukYvicDw+WOifQkFqnK+nNw0a6/LYIj/hPLWO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787307913; c=relaxed/simple;
	bh=8w4slWG1zvQSvAUTYTqpua9ZHjZstrFMX29GOnEWpT4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hdh5iCr99OPX0OJG9Og/UF0dqgGcmR8F7B/lYrNN0b4Hw5D6as617T2LoMmeFJyU7RKtR7vHaNbaccXuzKZPMFgfOQ1POkFmhPxver8T0JD1q0vcCY2in3aC+dg6lxa2u2VJZmWN7igBGUl5ZJBgnbo/op4LS9pqTErVilM+fFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOPOumCc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOPOumCc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79ADA1F000E9;
	Fri, 21 Aug 2026 10:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787307904;
	bh=d+iPz2R3iu+FVv3Ba37P3wWOk2poGBppSVZkdrZH+v8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UOPOumCczqJsa23VgveGYYNO4CJ3AznTpxcKeOMm0k1JEjuxaEH5TcOVmdrK4yJmR
	 94dC7WAJiBvLCuTFBumYg5ntT6iRH4LT9EGSp4V+fUWvbgatPhJaKhDjPvEmd4k0vA
	 8Epz6AY2wE40iJdC5rEJ2uBBBeqonU6CSSQbI8wTZnfVFOz7xfqvmUItKqOGHcFgu/
	 gmcWRQrTqfOCGv40K15QKv0sjaf7j985lJI2NWUzNRO8wV9SuXY7jIaAAA7f+befpt
	 zB6Z1ZDrRymcWcuhCw7LDCFu/xX/VY1Cnaqij4m1XeyZtwDwUrS22eTHF6EYBuE0jj
	 rTdrWlCrqeBLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] rtc: m41t80: Make sure clk_init_data is fully
 initialized
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geert Uytterhoeven" <geert+renesas@glider.be>
Cc: linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <c5290fb9a28b45d6bcec724d5897f8bcbf96ea50.1787241693.git.geert+renesas@glider.be>
References: <cover.1787241693.git.geert+renesas@glider.be>
 <c5290fb9a28b45d6bcec724d5897f8bcbf96ea50.1787241693.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 10:25:04 +0000
Message-Id: <20260821102504.79ADA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cleanup of clock registration and OF provider on probe fai=
lure and device unbind leads to memory leaks and Use-After-Free.
- [High] Missing cleanup of watchdog device and reboot notifier on probe fa=
ilure causes resource leaks and Use-After-Free.
- [High] The seconds register is corrupted with the flags register value du=
ring time setting.
- [High] Clock operations race with RTC operations causing I2C register cor=
ruption.
--

--- Patch [2]: [PATCH 2/5] rtc: m41t80: Make sure clk_init_data is fully in=
itialized ---
commit 11533c947dd31e7928f8df0ec766e6dae1e6ced8
Author: Geert Uytterhoeven <geert+renesas@glider.be>

rtc: m41t80: Make sure clk_init_data is fully initialized

The clk_init_data structure contains several mutually-exclusive members for
different methods to specify the possible parents of a clock, prompting
drivers to initialize only the members they need. Make sure all members are
fully initialized, to avoid bugs and prevent future breakage.

> diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
> index 3c8c379392c14..ec86ca3f2c4c8 100644
> --- a/drivers/rtc/rtc-m41t80.c
> +++ b/drivers/rtc/rtc-m41t80.c
> @@ -574,8 +574,8 @@ static struct clk *m41t80_sqw_register_clk(struct m41=
t80_data *m41t80)
>  	struct i2c_client *client =3D m41t80->client;
>  	struct device_node *node =3D client->dev.of_node;
>  	struct device_node *fixed_clock;
> +	struct clk_init_data init =3D {};
>  	struct clk *clk;
> -	struct clk_init_data init;
>  	int ret;

[Severity: High]
This is a pre-existing issue, but does m41t80_sqw_register_clk() leak the
registered clock and OF provider?

If devm_rtc_register_device() fails in m41t80_probe(), or when the driver
unbinds and calls m41t80_remove(), the m41t80_data struct is freed. However,
the clock and its OF provider remain registered:

m41t80_sqw_register_clk() {
    ...
    clk =3D clk_register(&client->dev, &m41t80->sqw);
    if (!IS_ERR(clk))
        of_clk_add_provider(node, of_clk_src_simple_get, clk);
    ...
}

Will subsequent clock operations dereference the freed m41t80->sqw field?

[Severity: High]
This is a pre-existing issue, but is there a missing cleanup of the watchdog
device and reboot notifier on probe failure?

In m41t80_probe(), the watchdog device and reboot notifier are registered:

m41t80_probe() {
    ...
    rc =3D misc_register(&wdt_dev);
    if (rc)
        return rc;
    rc =3D register_reboot_notifier(&wdt_notifier);
    ...
}

If devm_rtc_register_device() subsequently fails, the driver returns the
error directly without deregistering the watchdog device or the reboot
notifier:

m41t80_probe() {
    ...
    rc =3D devm_rtc_register_device(m41t80_data->rtc);
    if (rc)
        return rc;
    ...
}

Could this lead to a use-after-free if userspace then accesses /dev/watchdo=
g,
causing wdt_ping() to dereference the freed clientdata memory?

[Severity: High]
This is a pre-existing issue, but does m41t80_rtc_set_time() inadvertently
corrupt the seconds register?

During time setting, when attempting to clear the STOP bit in the seconds
register, it writes the flags variable instead:

m41t80_rtc_set_time() {
    ...
    err =3D i2c_smbus_write_byte_data(client, M41T80_REG_SEC,
                                    flags & ~M41T80_SEC_ST);
    ...
}

Since flags is populated earlier by reading the FLAGS register
(M41T80_REG_FLAGS), would this write the raw value of the FLAGS register in=
to
the seconds register, overwriting the previously set time?

[Severity: High]
This is a pre-existing issue, but can clock operations race with RTC
operations and corrupt I2C registers?

The CCF clock callbacks perform read-modify-write sequences on the
M41T80_REG_ALARM_MON and M41T80_REG_WDAY registers without holding a lock
that protects against concurrent time-setting operations:

m41t80_sqw_control() {
    ...
    int ret =3D i2c_smbus_read_byte_data(client, M41T80_REG_ALARM_MON);
    ...
    ret =3D i2c_smbus_write_byte_data(client, M41T80_REG_ALARM_MON, ret);
    ...
}

m41t80_sqw_set_rate() {
    ...
    reg =3D i2c_smbus_read_byte_data(client, reg_sqw);
    ...
    ret =3D i2c_smbus_write_byte_data(client, reg_sqw, reg);
    ...
}

Meanwhile, the RTC core callbacks modify these same registers under the
protection of the RTC subsystem's rtc_lock.

Since the CCF operations execute asynchronously under clock framework locks
and do not acquire the rtc_lock, could concurrent modifications by both
subsystems clobber the shared I2C registers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787241693.gi=
t.geert+renesas@glider.be?part=3D2
