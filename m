Received: from 0001.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99794CDA09
	for <linux-rtc@vger.kernel.org>; Wed, 30 Sep 2026 12:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790770008; cv=none; b=aJ0ESKSfD7RPJwlz+lGPWWKcUJW/pObLw6JL+tKbWALKOXhJ+WSyWdwQgU86PY4lbtnEZA1hrdGXfwVbB+zTK87O+qUB3BIKqEHs9fE9jeEVYoLbGsHIIyc9/oc45EZQ3VKLdc8tABf0I7z+H+HknMfi1ERXcY0ram3zlJyzDlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790770008; c=relaxed/simple;
	bh=0q0PEnm+1aD5Cg8E3Ba8WvLzqyCcgqhW/5fIt+yxjpc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=TRz5vhH+URcFdiUB5Bsytu32cigg8XfoC/p0W7qvW+jJmpep7XVuiMefFBXZKfaXh4qU5BFXTLtlu5q0OUH/oVZbndLU1BlsyEmt2TIFPY4dkG+K70HmhJX+MYsCNgk6oqhxAcfDKwF6a46R35QeeGo/l/P9oevdSZRWQ6zZA6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4320:1000:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id ABE3E111;
	Wed, 30 Sep 2026 14:06:44 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Sep 2026 14:06:44 +0200
Message-Id: <DLSMZIXCSAAK.ZBI487G8BST7@kernel.org>
Subject: Re: [PATCH] rtc: pcf8563: add SMBus support
Cc: <linux-rtc@vger.kernel.org>, "Alexandre Belloni"
 <alexandre.belloni@bootlin.com>
From: "Michael Walle" <mwalle@kernel.org>
To: <sashiko-reviews@lists.linux.dev>
X-Mailer: aerc 0.20.0
References: <20260930113126.720555-1-mwalle@kernel.org>
 <20260930114005.2C6661F000FF@smtp.kernel.org>
In-Reply-To: <20260930114005.2C6661F000FF@smtp.kernel.org>

On Wed Sep 30, 2026 at 1:40 PM CEST, sashiko-bot wrote:
> [Severity: High]
> Could removing this check lead to time tearing on restricted SMBus adapte=
rs?
>
> While the commit message mentions SMBus controllers supporting block
> accesses, removing the check entirely delegates bus validation to regmap.=
 If
> the adapter only supports I2C_FUNC_SMBUS_BYTE_DATA and lacks block transf=
er
> capabilities, regmap silently falls back to regmap_smbus_byte:

That is actually correct. But I'm not sure how this is handled in
the RTC subsystem (?). I've looked at other drivers (e.g. ds1307,
rv3028), which are using regmap and there seems to be no check
either.

-michael


> drivers/base/regmap/regmap-i2c.c:regmap_get_i2c_bus() {
>     ...
>     else if (config->val_bits =3D=3D 8 && config->reg_bits =3D=3D 8 &&
>              i2c_check_functionality(i2c->adapter,
>                                      I2C_FUNC_SMBUS_BYTE_DATA))
>         bus =3D &regmap_smbus_byte;
>     ...
> }
>
> Because of this fallback, when pcf8563_rtc_read_time() reads the time:
>
> drivers/rtc/rtc-pcf8563.c:pcf8563_rtc_read_time() {
>     ...
>     err =3D regmap_bulk_read(pcf8563->regmap, PCF8563_REG_ST1, buf,
>                            sizeof(buf));
>     ...
> }
>
> The bulk read executes as a loop of separate single-byte SMBus reads inst=
ead
> of an atomic transaction. Since each SMBus byte transaction issues its ow=
n
> STOP condition, the RTC's internal register latch is released between rea=
ds.
>
> Does this allow the hardware time to roll over mid-read and result in
> corrupt time data?
>
>>  	pcf8563 =3D devm_kzalloc(&client->dev, sizeof(struct pcf8563),
>>  				GFP_KERNEL);
>>  	if (!pcf8563)

