Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3FE18D636;
	Fri, 14 Aug 2026 01:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786670426; cv=none; b=Op58nseTjQUnmtLALUQbd5sM2n/lQWqk18qW+vp7RG3D0ravnSvjh/4SnE0KcBPwIG0IgbyA8oIbQyjc2JMrhTPg1RsBwy/Rru2E0P66S8vFIxhm/sM8YXgDbYV5DE0da3RhpM9MN8UlMrajKe61Yw7c6IOl201es1SGWKkUEro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786670426; c=relaxed/simple;
	bh=aXpm0TM8UUnOq61TscpKmsdd6l4qgxfgFbUU6Qk1KsI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fSVLOPYDainTSZCpJDqy5WikjPLyl8NprsUHc/o9tw00WxcdtYjaJKVgBjkSNVhzzIZlnG++Rf2fSDRbmDrdcKUWoK8sMZBo0BBe8BcYzgG7wyFCGNbfJeogG2R9VWGrUd6hkXg48Eo6FbppnA5M35/N/CNlhsrvTcSGwvjvAPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLQOG0ax; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLQOG0ax"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6678E1F000E9;
	Fri, 14 Aug 2026 01:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786670424;
	bh=zwqpWtiIaVUUyzNdIPrLzuieKKUG8F91D4dLIKJXkpk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iLQOG0axaoEKj1LmsUasxyvC6ZNW+6l5cUbtGlhs8NvqKCs/kJKhfA0FWho2woV7p
	 Xk9lciby78ZZaUeRqzAtiz8gBl7724W2mZ35XneIt5FNy+T8ISkkKQYIF1StHxBhx4
	 Xl37vQPymkhjxzj50OfojE4V5ow1uqGhZMAc9INnu9BiYW5lpZOpYg4x5k/iREdY+M
	 sOxM/UCDmYUzzEKY+5rbvObawraYb/tGI0xd1OCPb5Spyq/31Euxs8FhHxJzVzm4fd
	 Gp3H1hjuONcj34y2SRm9yG9/OVHcwiBEmSwCOkmeH+OI260lFgrb7wJKszxdryH3Wu
	 OvhYTxJkcwa/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/9] rtc: abx80x: add mutex protection for register
 writes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org
In-Reply-To: <20260810193826.210683-4-apokusinski01@gmail.com>
References: <20260810193826.210683-1-apokusinski01@gmail.com>
 <20260810193826.210683-4-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 01:20:24 +0000
Message-Id: <20260814012024.6678E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete locking leaves configuration key sequences vulnerable t=
o disruption by concurrent read operations.
--

--- Patch [3]: [PATCH v4 3/9] rtc: abx80x: add mutex protection for registe=
r writes ---
commit 45525a43d1a439e6b8a50fcba7c541c85b598f5c
Author: Antoni Pokusinski <apokusinski01@gmail.com>

rtc: abx80x: add mutex protection for register writes

The ABX80X RTC driver performs multi-step register operations such as
NVMEM transfers or register writes preceded by a configuration key write.
This patch adds a mutex to serialize register writes and protect these
sequences against race conditions.

> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index fdf9664ebb6f0..0c8d3416fd5a9 100644
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c
[ ... ]
> @@ -234,6 +237,8 @@ static int abx80x_rtc_set_time(struct device *dev, st=
ruct rtc_time *tm)
>  	buf[ABX8XX_REG_YR] =3D bin2bcd(tm->tm_year - 100);
>  	buf[ABX8XX_REG_WD] =3D tm->tm_wday;
> =20
> +	guard(mutex)(&priv->lock);
> +

[Severity: High]
This is a pre-existing issue, but since this patch introduces the mutex to
protect multi-step sequences, should the read paths also acquire the lock?

According to the ABX80X hardware specification, the configuration key is
automatically cleared by any subsequent register read or write.

If a sysfs attribute write like oscillator_store() acquires the lock and
writes the configuration key, but another process concurrently calls an
unprotected read path like abx80x_rtc_read_time() or abx80x_read_alarm():

abx80x_rtc_read_time()
    err =3D i2c_smbus_read_i2c_block_data(client, ABX8XX_REG_HTH, ...);

Could this interleaved I2C read silently clear the configuration key before
the protected write completes, causing the hardware configuration update to
fail?

>  	err =3D i2c_smbus_write_i2c_block_data(client, ABX8XX_REG_HTH,
>  					     sizeof(buf), buf);
>  	if (err < 0) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810193826.2106=
83-1-apokusinski01@gmail.com?part=3D3
