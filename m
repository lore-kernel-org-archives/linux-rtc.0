Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C971369208;
	Mon,  7 Sep 2026 20:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788814159; cv=none; b=kLlfR0nYv4tKnc9cZMJEaOZ2LyoSVURChQuybg+DbvnvhS2YzGfF2OahpJWYglj92mXVodaNHARj90gGsZIgO3Y1ph3B/EHcEvFD7pMoex85bIL/LWy+3wmQBkjIdrPfG5ODFPevwkPkIWc2MgzMmrq+ciEhcMawXtG5kLBBLvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788814159; c=relaxed/simple;
	bh=ogstAv/AMgczpAlaNRJOsqwWTkQ1E3lHLcBTEBuEY2k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iICpoAFk6Tsq1nZXUHtvPYEHU5SSeuTLkqvvCQ3ath3cZ2HerN89EbS+m5qX37VxIErbgO6TuF55Km0OUs4GRLpHuvaXHvs/hiS6SFFDzjSX3cf0apM+MTbXZZwNrZZyUSvXI2dff8d5afmcMhwpC13TajrPJkKktTLwMa+WoXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WO1qg/zL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WO1qg/zL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C68E1F00A3A;
	Mon,  7 Sep 2026 20:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788814157;
	bh=XTztXfTKX3FubkiCZJcaB6v7ydG5D/MQI98jHftds3M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WO1qg/zLsE80hdPHIaK44R2UlenOzTYwQhNnO1rrpvMrwBsy0FrnmWYm5JKzYzl1K
	 Aaln8N1HNFSRUgv6HS8kv2IaKMfHetZDT1thiYUZOzMGCPQ8eIMAyc3Jp10zgXHyJW
	 mBP4NC6ChkAe0nw8sBcp8Y9rW5iAeX7g/uSZCbhXNFT0JjiuxDkuHPSIpIaNT9JPh/
	 CGxpMOETGVG5VRtzsly2BySAocwb8RcVWuJD8GAZozjsDVN1jytxDKoAGT/YtyPQK5
	 JBBv0Ifl+2R+PPcuHi82tylkoD1lN/VGzBuJ6gTeTBsdqwApGtTBfSb5ezcUB6Dw6u
	 UXa4imigzksxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/9] rtc: abx80x: add irq to struct abx80x_priv
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, robh@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260907203216.53192-6-apokusinski01@gmail.com>
References: <20260907203216.53192-1-apokusinski01@gmail.com>
 <20260907203216.53192-6-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 20:49:16 +0000
Message-Id: <20260907204917.4C68E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unprotected I2C reads in `abx80x_rtc_read_time`, `abx80x_read_alar=
m`, and sysfs show functions can interleave with and break multi-transactio=
n I2C sequences protected by `priv->lock`.
- [High] `abx80x_ioctl(RTC_VL_CLR)` is vulnerable to a TOCTOU race with the=
 hardware that can unintentionally clear unrelated interrupts like `ABX8XX_=
STATUS_AF`.
--

commit b245a6cf28d590ef87d1389ee95de3f0f3c0348b
Author: Antoni Pokusinski <apokusinski01@gmail.com>

rtc: abx80x: add irq to struct abx80x_priv

This patch adds the irq number to struct abx80x_priv so it is not tied to
the i2c_client. This allows the irq to be easily accessed also in the case
of ABX81X SPI clocks.

> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index 8f9211bfb7e24..529f63e024f8d 100644
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c

[ ... ]

> @@ -305,11 +306,12 @@ static irqreturn_t abx80x_handle_irq(int irq, void =
*dev_id)
>  static int abx80x_read_alarm(struct device *dev, struct rtc_wkalrm *t)
>  {
>  	struct i2c_client *client =3D to_i2c_client(dev);
> +	struct abx80x_priv *priv =3D i2c_get_clientdata(client);
>  	unsigned char buf[7];
> =20
>  	int irq_mask, err;
> =20
> -	if (client->irq <=3D 0)
> +	if (priv->irq <=3D 0)
>  		return -EINVAL;
> =20
>  	err =3D i2c_smbus_read_i2c_block_data(client, ABX8XX_REG_ASC,

[Severity: High]
This isn't a bug introduced by this patch, but this pre-existing issue
performs I2C reads here in abx80x_read_alarm() without acquiring priv->lock.

Could concurrent execution of these lockless I2C reads via userspace ioctls
interleave with multi-transaction I2C sequences protected by priv->lock?

For example, if this read interrupts the sequence between writing a config
key and a target register in functions like abx80x_rtc_set_autocalibration()
or oscillator_store(), would it reset the hardware config key and cause the
subsequent register write to fail silently?

A similar issue also exists in abx80x_rtc_read_time() and the sysfs show
functions.

[ ... ]


While reviewing this driver, I noticed another pre-existing issue in the
unmodified abx80x_ioctl() code:

drivers/rtc/rtc-abx80x.c:abx80x_ioctl() {
    ...
	case RTC_VL_CLR:
		scoped_guard(mutex, &priv->lock) {
			status =3D i2c_smbus_read_byte_data(client, ABX8XX_REG_STATUS);
			if (status < 0)
				return status;

			status &=3D ~ABX8XX_STATUS_BLF;

			tmp =3D i2c_smbus_write_byte_data(client, ABX8XX_REG_STATUS,
							status);
    ...
}

[Severity: High]
This is a pre-existing issue, but does this read-modify-write on a
Write-0-to-Clear (W0C) register create a Time-Of-Check to Time-Of-Use
(TOCTOU) race?

If the hardware asserts an unrelated interrupt (like ABX8XX_STATUS_AF)
between the read and the write, it seems this write will place a 0 in those
bits and unintentionally clear the new interrupts, causing permanent loss
of alarm or watchdog events.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907203216.5319=
2-1-apokusinski01@gmail.com?part=3D5
