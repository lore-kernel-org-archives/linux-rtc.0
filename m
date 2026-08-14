Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4340719E96D;
	Fri, 14 Aug 2026 01:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786669366; cv=none; b=RGPkPaELo4Ib6jPJrgPo8VgNyTW9QG69LkDUl58M+21SFWL1Ah8psdoZkOskVXGOV8RcyoRslkqXL/0qCOGTu1Xs1YXJr0j2zOitnYPW4DhcVeZaPcB+zrD+0sZrDmBS5mTFAv8CB/UbZDl5r/WgK86bh6ifXI4U+TY/tfZUWCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786669366; c=relaxed/simple;
	bh=lx69EUVhSVapESfkfYpAkQSbtE9Z9I4UgvXUfz7RNkA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HXYWqGUW8T9F9IgVkG4VTb8GDxg2IUx9RxXP8eYGrnIB5zU5yaj35vbgbAqIsNUO2NC6t37hLGqih3A+M2iqp8AqIE/bAzWsXQKGs9yitYpYyjYh+e1ThulQGDMTrX4o0KWgB0DxDluLrjzL9adq26SFsLSUlMxHkpYeKrFeznQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1F8SW0a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1F8SW0a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248371F000E9;
	Fri, 14 Aug 2026 01:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786669364;
	bh=+ZDDvjWvIQn0fypX16cft1l3TgJEHZQ88mTxrOYGy8U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g1F8SW0a5yLaTCZoYDx6yXuL4QOMtBEJtji/VQp6EX6Enj+CVZ8eGouuUfDcxxcee
	 JG/SYX8LbPXDbfrI8A53XIolsFHX7mOT/a7vQnM2/6g+7ZCl/p9UWljcFL3ZoeJA21
	 btBNsOyNf3DzAg2446eAKLCw+0Kgmyn3YJD/oIbC+ljjxQgYS/LKi2Q2iwpD7D2ckR
	 NO1SiqT49GQpC1h91B9QLqitiJY9HrzI3oqKwj8D1xpibVd6tWbXXYUMPEHFjip/Ci
	 Yoe+2ct3f36gc82GQ2htJFMX3/qzzbVZkMLDVOVJpfMapWjHJzWvazq6mo2Qx/Ulu1
	 1e3Lguc2XF3qA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/9] rtc: abx80x: fix error check after
 i2c_smbus_read in read_alarm()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org
In-Reply-To: <20260810193826.210683-3-apokusinski01@gmail.com>
References: <20260810193826.210683-1-apokusinski01@gmail.com>
 <20260810193826.210683-3-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 01:02:43 +0000
Message-Id: <20260814010244.248371F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The relaxed error check allows short I2C reads to bypass validatio=
n, resulting in uninitialized stack memory being parsed and used.

Pre-existing issues:
- [High] The patch fails to properly fix the issue it claims to address bec=
ause it returns a positive byte count on success, which the RTC subsystem t=
reats as an error.
- [High] Concurrent sysfs accesses can cause data corruption in the hardwar=
e oscillator control register.
- [High] Concurrent NVMEM accesses cause data corruption due to unprotected=
 page register updates.
--

--- Patch [2]: [PATCH v4 2/9] rtc: abx80x: fix error check after i2c_smbus_=
read in read_alarm() ---
commit 0f39bb1c012fd3e70a85b6d2103b11a6c2ce0801
Author: Antoni Pokusinski <apokusinski01@gmail.com>

    rtc: abx80x: fix error check after i2c_smbus_read in read_alarm()
   =20
    i2c_smbus_read_i2c_block_data() returns the number of bytes read on
    success and a negative error code on failure. The existing code treated
    any non-zero return value as an error.
   =20
    Fix the error handling by checking only for negative return values.

> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index 5486d9d0b1e5d..fdf9664ebb6f0 100644
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c
> @@ -294,7 +294,7 @@ static int abx80x_read_alarm(struct device *dev, stru=
ct rtc_wkalrm *t)
> =20
>  	err =3D i2c_smbus_read_i2c_block_data(client, ABX8XX_REG_ASC,
>  					    sizeof(buf), buf);
> -	if (err)
> +	if (err < 0)

[Severity: High]
Does this relaxed error check allow short I2C reads to bypass validation?

If i2c_smbus_read_i2c_block_data() returns a positive byte count less than
sizeof(buf), this check will pass and execution continues. The subsequent c=
ode
will then parse uninitialized stack memory from buf to populate the alarm
configuration, which could cause undefined behavior.

>  		return err;
> =20
>  	irq_mask =3D i2c_smbus_read_byte_data(client, ABX8XX_REG_IRQ);


[Severity: High]
This isn't a bug introduced by this patch, but since err contains the posit=
ive
number of bytes read on success, does returning it unmodified at the end of
abx80x_read_alarm() cause the RTC core to treat the success case as a failu=
re?

drivers/rtc/rtc-abx80x.c:abx80x_read_alarm() {
...
	t->enabled =3D !!(irq_mask & ABX8XX_IRQ_AIE);
	t->pending =3D (buf[6] & ABX8XX_STATUS_AF) && t->enabled;

	return err;
}

Since the caller will still see a positive return value, the alarm feature=
=20
remains broken. Should this be updated to return 0 on success?


[Severity: High]
This is a pre-existing issue, but does abx80x_rtc_read_time() also suffer f=
rom
the same missing length check pattern?

drivers/rtc/rtc-abx80x.c:abx80x_rtc_read_time() {
...
	err =3D i2c_smbus_read_i2c_block_data(client, ABX8XX_REG_HTH,
					    sizeof(buf), buf);
	if (err < 0) {
		dev_err(&client->dev, "Unable to read date\n");
		return -EIO;
	}

	tm->tm_sec =3D bcd2bin(buf[ABX8XX_REG_SC] & 0x7F);
...
}

If a short read occurs, this allows uninitialized stack memory to be used w=
hen
setting the time.


[Severity: High]
This is a pre-existing issue, but can concurrent sysfs accesses cause data
corruption in the hardware oscillator control register?

The operations in abx80x_rtc_set_autocalibration() and oscillator_store() b=
oth
perform lockless read-modify-write on ABX8XX_REG_OSC:

drivers/rtc/rtc-abx80x.c:abx80x_rtc_set_autocalibration() {
...
	flags =3D i2c_smbus_read_byte_data(client, ABX8XX_REG_OSC);
...
	retval =3D i2c_smbus_write_byte_data(client, ABX8XX_REG_OSC, flags);
...
}

drivers/rtc/rtc-abx80x.c:oscillator_store() {
...
	flags =3D  i2c_smbus_read_byte_data(client, ABX8XX_REG_OSC);
...
	retval =3D i2c_smbus_write_byte_data(client, ABX8XX_REG_OSC, flags);
...
}

Because these sysfs operations do not serialize through the RTC core's ops_=
lock,
is it possible for one thread's modification to be clobbered by another?


[Severity: High]
This is a pre-existing issue, but do concurrent NVMEM accesses cause data
corruption due to unprotected page register updates?

In abx80x_nvmem_xfer(), the driver writes to the page register before
performing an I2C block operation:

drivers/rtc/rtc-abx80x.c:abx80x_nvmem_xfer() {
...
		ret =3D i2c_smbus_write_byte_data(priv->client, ABX8XX_REG_EXTRAM,
						extram);
		if (ret)
			return ret;

		if (write) {
			ret =3D i2c_smbus_write_i2c_block_data(priv->client, reg,
							     len, val);
...
}

Since the NVMEM core does not serialize accesses and the driver provides no
internal locking, could concurrent reads or writes from userspace interleav=
e,
causing operations to target the incorrect memory page?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810193826.2106=
83-1-apokusinski01@gmail.com?part=3D2
