Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DFF279917;
	Sat, 25 Jul 2026 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784992339; cv=none; b=iLS4M/G89OKdtTfBdRDcJOYyqxrnk8c9PQwg3bAn71SzJ22OKCSVCPzTbM3nIeqkDfmbJQC/kcPIYNldNUU5mY/Y5lTjiTVnL7S9VRWMuYXJx5G640aOwNAhzUuBZ3/5tzw+NR0EBNzmcobAjdMuXSQp5VVGIkXGg7Jjoy20L4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784992339; c=relaxed/simple;
	bh=G6yJ/ps9IHMgqj3yHPAVjClp0E66+DDZ5oQkfEfIOMc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=swIO4E7e0IUQ8YC62+IboWasxfwXDq1gMcdKRrFixkkRJ4iGh0ztfw9QvFkvv8Bn+hEj0FUMyDHcwC4cqSLZvBB2xE1Y8nYIL+Fb9b+6o/i5+8PKPu5YdWMgF75Zzc+FzZVza79ppR3Pw+mmAye/+gAeQdJoU+yFgb0OZVxPNEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3nXdF5t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3nXdF5t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD0C1F000E9;
	Sat, 25 Jul 2026 15:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784992337;
	bh=Ys1v314IgA6M15Z/LImYYvM8FxFviflLKwnB7z14+qc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j3nXdF5tTPW+ZE4c5BnWEptJK4yuONamgDbCMZ/ADjA3KywJoRBidegK/dpZifpx1
	 hvoOnsf7GrIE33mjU+cOBNeVNJz/GgEjTIkjP4clgwJssXNusWTvjwExZx/t9oPbZX
	 KBeAnQi9/75z2HtSOHqFegQ/LXEwkF8vsE7iAnD/nxbsFda5DFzpsa1WIhKLVY4kCB
	 orQ6VYsXmm6ELd5hXUP6HxQEHiiwbDIZaIFH7RCsoCyy8mjI0c6odg7IdD08f8QK7j
	 TMlNb426P2QH4harsgijjPsfbyu7JTQNhAIzQwUntdpbOgaB3P1RmbqWAExY+WnMlf
	 7PYBTd95uPKEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/8] rtc: abx80x: replace read-modify-write pattern
 with regmap helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260725145718.14733-7-apokusinski01@gmail.com>
References: <20260725145718.14733-1-apokusinski01@gmail.com>
 <20260725145718.14733-7-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 15:12:16 +0000
Message-Id: <20260725151217.5DD0C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Hardware state machine race in Read-Modify-Write on Write-0-To-Cle=
ar status registers causes lost interrupts.
- [Medium] Unprotected non-atomic configuration key write allows concurrent=
 operations to silently lock the hardware.
--

--- Patch [6]: [PATCH v2 6/8] rtc: abx80x: replace read-modify-write patter=
n with regmap helpers ---
commit f4c200ec9260a52df31083ec22d071486d5b6fcb
Author: Antoni Pokusinski <apokusinski01@gmail.com>

rtc: abx80x: replace read-modify-write pattern with regmap helpers
   =20
Before introducing the regmap usage in the driver, updating specific
bits of a register was performed using the read-modify-write pattern.
Now, the functions regmap_update_bits() and regmap_write_bits() can
be used to simplify the code.

> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index 3c5ab0ffbea84..a7686206eb926 100644
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c
> @@ -246,18 +246,11 @@ static int abx80x_rtc_set_time(struct device *dev, =
struct rtc_time *tm)
>  	}
> =20
>  	/* Clear the OF bit of Oscillator Status Register */
> -	err =3D regmap_read(priv->regmap, ABX8XX_REG_OSS, &flags);
> +	err =3D regmap_update_bits(priv->regmap, ABX8XX_REG_OSS, ABX8XX_OSS_OF,=
 0);

[Severity: High]
This is a pre-existing issue, but does using regmap_update_bits() here
create a race condition that could lose hardware interrupts? If a hardware
event triggers between the read and write operations inside
regmap_update_bits() and sets a flag to 1 in the ABX8XX_REG_OSS register,
this write will write back a 0 for that flag since it was 0 when read.
Because the hardware clears flags when a 0 is written, the new interrupt
flag would be cleared before it can be processed.

[ ... ]

> @@ -390,9 +379,9 @@ static int abx80x_rtc_set_autocalibration(struct devi=
ce *dev,
>  	if (abx80x_write_config_key(dev, ABX8XX_CFG_KEY_OSC) < 0)
>  		return -EIO;
> =20
> -	retval =3D regmap_write(priv->regmap, ABX8XX_REG_OSC, flags);
> -
> -	return retval;
> +	return regmap_write_bits(priv->regmap, ABX8XX_REG_OSC,
> +				 ABX8XX_OSC_ACAL_1024 | ABX8XX_OSC_ACAL_512,
> +				 flags);
>  }

[Severity: Medium]
This isn't a bug introduced by this patch, but does the configuration key
sequence here need to be atomic? The driver unlocks the ABX8XX_REG_OSC
register by writing to ABX8XX_CFG_KEY_OSC. If another thread performs a
concurrent RTC operation that writes to a different register before the
regmap_write_bits() call completes, the hardware resets the configuration k=
ey
to 0x00 and the write to ABX8XX_REG_OSC will silently fail.

[ ... ]

> @@ -466,24 +455,14 @@ static ssize_t oscillator_store(struct device *dev,
>  		return -EINVAL;
>  	}
> =20
> -	retval =3D regmap_read(priv->regmap, ABX8XX_REG_OSC, &flags);
> -	if (retval < 0)
> -		return retval;
> -
> -	if (rc_mode =3D=3D 0)
> -		flags &=3D ~(ABX8XX_OSC_OSEL);
> -	else
> -		flags |=3D (ABX8XX_OSC_OSEL);
> -
>  	/* Unlock write access on Oscillator Control register */
>  	if (abx80x_write_config_key(dev->parent, ABX8XX_CFG_KEY_OSC) < 0)
>  		return -EIO;
> =20
> -	retval =3D regmap_write(priv->regmap, ABX8XX_REG_OSC, flags);
> -	if (retval < 0) {
> +	retval =3D regmap_write_bits(priv->regmap, ABX8XX_REG_OSC, ABX8XX_OSC_O=
SEL,
> +				   rc_mode =3D=3D 0 ? 0 : (ABX8XX_OSC_OSEL));

[Severity: Medium]
This is also a pre-existing issue, but can concurrent operations interrupt
the unlock-and-write sequence in oscillator_store()? If another RTC update
occurs between abx80x_write_config_key() and regmap_write_bits(), the
configuration key will be reset and the oscillator update will be ignored.

[ ... ]

> @@ -550,17 +529,8 @@ static int abx80x_ioctl(struct device *dev, unsigned=
 int cmd, unsigned long arg)
>  		return put_user(tmp, (unsigned int __user *)arg);
> =20
>  	case RTC_VL_CLR:
> -		err =3D regmap_read(priv->regmap, ABX8XX_REG_STATUS, &status);
> -		if (err < 0)
> -			return err;
> -
> -		status &=3D ~ABX8XX_STATUS_BLF;
> -
> -		err =3D regmap_write(priv->regmap, ABX8XX_REG_STATUS, status);
> -		if (err < 0)
> -			return err;
> -
> -		return 0;
> +		return regmap_update_bits(priv->regmap, ABX8XX_REG_STATUS,
> +					  ABX8XX_STATUS_BLF, 0);

[Severity: High]
This is a pre-existing issue, but does performing a read-modify-write on
the ABX8XX_REG_STATUS register risk losing concurrent hardware updates? If =
an
alarm triggers between the read and write phases and sets the ABX8XX_STATUS=
_AF
flag to 1, the read-modify-write will write back 0 for that flag. Because t=
his
is a write-0-to-clear register, this clears the alarm interrupt before the
handler can process it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725145718.1473=
3-1-apokusinski01@gmail.com?part=3D6
