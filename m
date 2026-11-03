Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746849;
	b=T2ohxEDbuKhFhuxyVy+IFc+G8n60KXdV4s6bfU9WZTKi3N7R/DuPUMfUMbKd/VLHBgQZ
	 Fxv4iC9mwgzqZoo+N+d2higMi/uU3/wWf+z/FmPcioxe53k2F84WRvoGGnXX+NjovViob
	 nI2Y1PBy79+l27XTOQAJqhln8fz2x+M/hIVVBn9xDNl7xq9sC4rAciILoAMvf4Y50Pzdu
	 UokksMLfe5Q2nWHQhEb/xnr7Z9/wrHQ1VoHD3UK9xuRRHojjD3a3nfGzT6+QbZmURk16u
	 Ms1kTSRytS8sTsDtEJ2+3rrNx9LF2z3C4Jtof7ahqSWV4vcSQA60CotbQvqevVpZwwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746849;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+lwcmsvdBfLxxdrKvsUZFS79Op+BgiCcJ2w7KVc8dVk=;
	b=WvFIga0G8Tlwi118yFtmpmwHQuzI1NnbmNVCn3xGlfZcGWe/WSEoMT0YRYyDO2LPpEk6
	 nyn/Y0p/YDUGbNffq2ASnPsy6yTl+vBYcWR4pd7XpAVZxJnyIFr/WM42C/kEIa1TlHzMq
	 7kgIooqyEvMbK5TI7ondjq8WaWF2knHTGwpHYhMkxXfUcr/9X9smRbjvrN5PlvT071Zrb
	 07huzPhcvUYxeRiXjSRZBV+/4xYjCq1RDP1EuPhCjBjRYBUxeeigQR6dAEYzUz3ARdFWz
	 0qI++mNBXA2k77NxmUPEs5Cd18+O7IB7PMTAKKsIhFTsHCw9vAOGaMdwL8JlV+2FUEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L0yqj9kt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482F9606A31B
	for <linux-rtc@vger.kernel.org>; Tue,  3 Nov 2026 23:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L0yqj9kt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DB41F000C1;
	Tue,  3 Nov 2026 23:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793746848;
	bh=+lwcmsvdBfLxxdrKvsUZFS79Op+BgiCcJ2w7KVc8dVk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L0yqj9kt+XMMrG1nTtEBm2PWIcWuByUWXW+bnoFbPeKm97G+b6VFC2fl4mgjem3mL
	 /623SsPctDW+vYYXqOP04O8QXjstXPkmEdBnQelw1Vca4OGBRjCCI4v6lioCxxaESw
	 wh4zhpPY1of4Np6qm0ANCASZoOqialROz6fWFbfy7rMx1Ma6/oiigPNrQg1Iq+llCl
	 mI8xb5BBP9WTlCCnke2OeC1VD89IB10QRfUlXiAvtGlIe0mjr2kyJf5h0uVPL3+O+7
	 D2amqoWBlbm9KKIhTXDne1AceSYPg4TLfoZtAcwDFyfVRopDVwDq4KaxtLodX6LNGj
	 GPj2UUKxoAYpQ==
Message-ID: <sashiko-outbox-196169@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC] rtc: m41t80: Support SMBus adapters without I2C
 block transfers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fainelli" <f.fainelli@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlJFQUwgVElNRSBDTE9DSyAoUlRDKSBTVUJTWVNURU0=?= <linux-rtc@vger.kernel.org>, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261103225027.1248035-1-f.fainelli@gmail.com>
References: <20261103225027.1248035-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 23:00:48 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] rtc: m41t80: raw i2c_transfer() in wdt_ping() and wdt_disable() =
fails on SMBus
--

commit b3f3c10491b061e74e177e35683431f79685d1f4
Author: Florian Fainelli <f.fainelli@gmail.com>

rtc: m41t80: Support SMBus adapters without I2C block transfers

This commit allows rtc-m41t80 to probe on SMBus adapters that only support
SMBus byte and word transactions (such as the SiByte SMBus controller with =
an
M41T81) by falling back to byte writes and emulated block reads, with a
seconds recheck loop when block reads are unavailable.

Link: https://lkml.rescloud.iu.edu/hypermail/linux/kernel/0805.1/1778.html
Link: https://lkml.rescloud.iu.edu/1811.1/07408.html

> diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
> index 1385cb43864ba..23d02b95a606b 100644
> --- a/drivers/rtc/rtc-m41t80.c
> +++ b/drivers/rtc/rtc-m41t80.c

[ ... ]

> @@ -906,9 +949,9 @@ static int m41t80_probe(struct i2c_client *client)
>  	struct m41t80_data *m41t80_data =3D NULL;
>  	bool wakeup_source =3D false;
> =20
> -	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_I2C_BLOCK |
> +	if (!i2c_check_functionality(client->adapter,
>  				     I2C_FUNC_SMBUS_BYTE_DATA)) {
> -		dev_err(&adapter->dev, "doesn't support I2C_FUNC_SMBUS_BYTE_DATA | I2C=
_FUNC_SMBUS_I2C_BLOCK\n");
> +		dev_err(&adapter->dev, "doesn't support I2C_FUNC_SMBUS_BYTE_DATA\n");
>  		return -ENODEV;
>  	}

[Severity: Medium]
With m41t80_probe() now accepting SMBus-only adapters that only support
I2C_FUNC_SMBUS_BYTE_DATA and lack master_xfer (such as i2c-sibyte), what
happens when CONFIG_RTC_DRV_M41T80_WDT is enabled on an M41T80_FEATURE_HT
chip like the M41T81?

Later in m41t80_probe(), the watchdog miscdevice and reboot notifier are
still registered unconditionally for M41T80_FEATURE_HT devices:

drivers/rtc/rtc-m41t80.c:m41t80_probe() {
	...
#ifdef CONFIG_RTC_DRV_M41T80_WDT
	if (m41t80_data->features & M41T80_FEATURE_HT) {
		save_client =3D client;
		rc =3D misc_register(&wdt_dev);
		if (rc)
			return rc;
		rc =3D register_reboot_notifier(&wdt_notifier);
	...
}

However, wdt_ping() and wdt_disable() in drivers/rtc/rtc-m41t80.c still use
raw i2c_transfer() messages to access register 0x09 and ignore the return
value:

drivers/rtc/rtc-m41t80.c:wdt_ping() {
	...
	i2c_data[0] =3D 0x09;		/* watchdog register */
	...
	i2c_transfer(save_client->adapter, msgs1, 1);
}

drivers/rtc/rtc-m41t80.c:wdt_disable() {
	...
	i2c_data[0] =3D 0x09;
	i2c_transfer(save_client->adapter, msgs0, 2);

	i2c_data[0] =3D 0x09;
	i2c_data[1] =3D 0x00;
	i2c_transfer(save_client->adapter, msgs1, 1);
}

On an SMBus-only adapter where adapter->algo->master_xfer is NULL,
i2c_transfer() fails with -EOPNOTSUPP, so watchdog keepalives, ioctl
operations, and reboot/shutdown disable notifications via wdt_notify_sys() =
->
wdt_disable() will silently fail to reach the hardware.

Should wdt_ping() and wdt_disable() be converted to use
i2c_smbus_write_byte_data() and i2c_smbus_read_byte_data() as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103225027.1248=
035-1-f.fainelli@gmail.com?part=3D1
