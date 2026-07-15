Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC31431A27;
	Wed, 15 Jul 2026 18:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138691; cv=none; b=a5G3h2Uk/kXaEm1TAB9hmDKm3faME8uXRafU4jWZET6p1sXMH/sMKIeHC0MYfjf1gGB+8UZVMVQuqqL3GttlJE0SfLfr6EuRHq95XqCecuZ89tzBaULvgsuPZ8IjUk/2yXDLTHIfCEa+xICQ5CbGlYw3aNY2DBXqH6o8bnpO29E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138691; c=relaxed/simple;
	bh=Hk7VnBZ0ZdY0C1zu84f7T9IkMd+Uct33zyrZ1r3c1Rg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PnomGb1sbgi+1uUC7BdfPytsvG+iiuXDJ0kp46uIFkD5ZGmHMe5OVt+cjAIqT6f1k+hHFutaB0NWBCgJgwB3Te8uMN0um+zVkFHlVb1ZJd/zhGDg+eRTB8lLPSEmyfgZ29gsrjNolN+Nr5Hft65jqxtw2Tw/cUjiK8j8px47G9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnWjnD8q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnWjnD8q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1FF1F000E9;
	Wed, 15 Jul 2026 18:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784138676;
	bh=z1bcCig/w+n8T1oUsM8SsxcefJTzaUQb15/bkmwPnMs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FnWjnD8q2wlfLJI1T6KORtV9Ktm+l3x9iOZi8E3DSQwgH0Q04A0HwiJdztZigdhbS
	 s7bDbMn3OqVzbhDG3eVZ9eVfJdHspgoVMeveM1WRK8vxS7aBUY9HMh+XZEiMK7CiJ7
	 icwsVbbvl3OC1kjODbpT0Mhfei5I/gyI3mQmqZs7p639YIKLDeUmCWnjeqybPfKF/5
	 HbOF9D0wLPvpCCD6OAh9otvPzS/TN+6eGCCfGUGW63IBsQfvKaYj/ypg6RjIS6Znoh
	 ycficcla2aRMl9gTQiLg5ew6ZYfUQJZS9xYMzLk2iTCFx10fETO9sn+UPpblOknC8r
	 xzEgYWE23cypg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/8] misc: make all reg_write callbacks take const void
 *
Reply-To: sashiko-reviews@lists.linux.dev
To: "Link Mauve" <linkmauve@linkmauve.fr>
Cc: ojeda@kernel.org, neil.armstrong@linaro.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, lee@kernel.org, linux-sunxi@lists.linux.dev, linux-rtc@vger.kernel.org, Frank.Li@kernel.org, linux-amlogic@lists.infradead.org, imx@lists.linux.dev, mfd@lists.linux.dev
In-Reply-To: <20260715175229.24672-5-linkmauve@linkmauve.fr>
References: <20260715175229.24672-1-linkmauve@linkmauve.fr>
 <20260715175229.24672-5-linkmauve@linkmauve.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 18:04:35 +0000
Message-Id: <20260715180435.EC1FF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Low] Passing `const void *` to `nvmem_device_write` discards the `const`=
 qualifier, causing a compiler warning/error.

Pre-existing issues:
- [Critical] The `m24lr_write` function uses the device offset to index the=
 source memory buffer, causing a critical out-of-bounds read of kernel memo=
ry.
- [High] Writing a dereferenced `const char *` byte to a 32-bit memory-mapp=
ed register triggers sign-extension, potentially writing corrupted values t=
o the hardware.
- [High] Silent data loss when writing an odd number of bytes in 16-bit mod=
e.
--

--- Patch [4]: [PATCH 4/8] misc: make all reg_write callbacks take const vo=
id * ---
commit 8fae9381bce13733c89619440fc083ff647125a4
Author: Link Mauve <linkmauve@linkmauve.fr>

misc: make all reg_write callbacks take const void *

The previous commit switched from a pointer to mutable data to a pointer
to immutable data, so let's fix all users of the nvmem_config API.

[ ... ]
> diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/ee=
prom_93xx46.c
> index 5230e910a1d11..8de85433d593c 100644
> --- a/drivers/misc/eeprom/eeprom_93xx46.c
> +++ b/drivers/misc/eeprom/eeprom_93xx46.c
> @@ -269,10 +269,10 @@ eeprom_93xx46_write_word(struct eeprom_93xx46_dev *=
edev,
>  }
> =20
>  static int eeprom_93xx46_write(void *priv, unsigned int off,
> -				   void *val, size_t count)
> +			       const void *val, size_t count)
>  {
>  	struct eeprom_93xx46_dev *edev =3D priv;
> -	char *buf =3D val;
> +	const char *buf =3D val;

[Severity: High]
This is a pre-existing issue, but does this function silently drop data when
writing an odd number of bytes in 16-bit mode?

In 16-bit word mode (EE_ADDR16), the driver intercepts the call and truncat=
es
the count:

    count &=3D ~1;

If count is 1, it becomes 0, skipping the write loop entirely and returning=
 0.
Because the nvmem core interprets a 0 return value as success, the caller
believes the data was written even though the hardware was unmodified.

[ ... ]
> diff --git a/drivers/misc/eeprom/m24lr.c b/drivers/misc/eeprom/m24lr.c
> index 7a9fd45a8e460..22f3221e232b5 100644
> --- a/drivers/misc/eeprom/m24lr.c
> +++ b/drivers/misc/eeprom/m24lr.c
> @@ -374,7 +374,7 @@ static int m24lr_nvmem_read(void *priv, unsigned int =
offset, void *val,
>  	return 0;
>  }
> =20
> -static int m24lr_nvmem_write(void *priv, unsigned int offset, void *val,
> +static int m24lr_nvmem_write(void *priv, unsigned int offset, const void=
 *val,
>  			     size_t bytes)

[Severity: Critical]
This is a pre-existing issue, but does m24lr_write() use the device offset =
to
index the source memory buffer?

When m24lr_nvmem_write() calls m24lr_write(..., val, bytes, offset, true),
m24lr_write() passes buf + offset to the regmap write instead of advancing
by the number of bytes written:

    err =3D m24lr_regmap_write(regmap, buf + offset, n, offset);

Since buf is only sized for the data chunk being written, adding the device
offset pushes the pointer far past the end of buf, leading to an out-of-bou=
nds
read of kernel memory that gets written to the external EEPROM.

>  {
>  	ssize_t err;

[ ... ]
> diff --git a/drivers/misc/keba/cp500.c b/drivers/misc/keba/cp500.c
> index 6c65fbf22e756..ee7889cb63a8b 100644
> --- a/drivers/misc/keba/cp500.c
> +++ b/drivers/misc/keba/cp500.c
> @@ -590,7 +590,7 @@ static int cp500_nvmem_read(void *priv, unsigned int =
offset, void *val,
>  	return 0;
>  }
> =20
> -static int cp500_nvmem_write(void *priv, unsigned int offset, void *val,
> +static int cp500_nvmem_write(void *priv, unsigned int offset, const void=
 *val,
>  			     size_t bytes)
>  {
>  	struct cp500_nvmem *nvmem =3D priv;

[Severity: Low]
Does passing the now-const val directly to nvmem_device_write() discard the
const qualifier?

nvmem_device_write() expects a mutable void pointer, which will cause a bui=
ld
warning (and potentially break the build if -Werror is enabled):

    ret =3D nvmem_device_write(nvmem->base_nvmem, nvmem->offset + offset,
                             bytes, val);

[ ... ]
> diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c b/drivers/=
misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c
> index a2ed477e0370b..f2759e9b41386 100644
> --- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c
> +++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c
> @@ -159,11 +159,11 @@ static int pci1xxxx_eeprom_read(void *priv_t, unsig=
ned int off,
>  }
> =20
>  static int pci1xxxx_eeprom_write(void *priv_t, unsigned int off,
> -				 void *value_t, size_t count)
> +				 const void *value_t, size_t count)
>  {
>  	struct pci1xxxx_otp_eeprom_device *priv =3D priv_t;
>  	void __iomem *rb =3D priv->reg_base;
> -	char *value =3D value_t;
> +	const char *value =3D value_t;

[Severity: High]
This is a pre-existing issue, but does dereferencing this const char pointer
trigger sign-extension when passed to writel()?

Later in this function, the byte is written like this:

    writel(*(value + byte), rb + MMAP_EEPROM_OFFSET(EEPROM_DATA_REG));

If the byte has its most significant bit set (e.g. is negative), the C comp=
iler
will sign-extend it to a 32-bit negative integer before passing it to write=
l(),
which writes 1s into the upper 24 bits of the register. Should value be cas=
t to
const u8 * to ensure safe zero-extension?

>  	u32 regval;
>  	u32 byte;
>  	int ret;
> @@ -262,11 +262,11 @@ static int pci1xxxx_otp_read(void *priv_t, unsigned=
 int off,
>  }
> =20
>  static int pci1xxxx_otp_write(void *priv_t, unsigned int off,
> -			      void *value_t, size_t count)
> +			      const void *value_t, size_t count)
>  {
>  	struct pci1xxxx_otp_eeprom_device *priv =3D priv_t;
>  	void __iomem *rb =3D priv->reg_base;
> -	char *value =3D value_t;
> +	const char *value =3D value_t;

[Severity: High]
This is a pre-existing issue, but this has the same sign-extension behavior
when writing to OTP_PRGM_DATA_OFFSET:

    writel(*(value + byte), rb + MMAP_OTP_OFFSET(OTP_PRGM_DATA_OFFSET));

Should this pointer also be changed to const u8 *?

>  	u32 regval;
>  	u32 byte;
>  	int ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715175229.2467=
2-1-linkmauve@linkmauve.fr?part=3D4
