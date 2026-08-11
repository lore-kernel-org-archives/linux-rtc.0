Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2EE36E48C;
	Tue, 11 Aug 2026 19:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786478218; cv=none; b=seIHgonsErf89y23LaZ7JAfzH54c4EQwMFROlEy+QI0RpRWV1cSeqLdxJTaWbuQGqsrZslcjiaIEmz1gfiiXfPyrhAm6+9oBYJSFGO2p921PFoPQkZrMpx3rUPl2k2jQlQ7+5fWIvq8rT4RCfNsB6VrUxV8mYyKec+JWz9dwXqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786478218; c=relaxed/simple;
	bh=e+xTOKiXO7BY/FzxqjZl6uDSoxHss+YE85nP48ogiKE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=deUeAJ1BeBX7vePRUsGHg4OOF5hgrBLfqOjvIb+ZZGDqMU5MI3BBulVIvZvIJkZMFAkrP8VWPlqwzCBfwB+LjScm/Ype20D2ossZZjgLhEYIiKslU9QzVwxJPre0d67dDwno3mVy6WOCsQvnxIy3tivBmPbpiWnbvWH8ml7T2wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zv0mz3Ok; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zv0mz3Ok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691DC1F00A3A;
	Tue, 11 Aug 2026 19:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786478216;
	bh=uGFKrBcQg34eurWwJlDmZWaNsbjtcbnOgl8xRsaFaw8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zv0mz3OkiZeZgiR6tyTIQ9OUoc3qpBKnLrXyH3+Ig0vAiSfVffGVtQcnD3BLqBkfe
	 rgr7uQR3gikoikuHqqrPKAdRZTYMPR1WfD2BkDhnfUDBeGuRexX4tY5oOMFrS7yUGT
	 GKo7YR5fSZncszZWwGORJRvu4kcmLknFpiKLFbs47mizuoR7+Hwyde26okZZ66b3gO
	 Y/noE+WOHxHBrJWSHlJ5xvkRPRlNB+d04sY4iIiAVhTJEMx/C1K9KFOWDRMXDCQstd
	 UzAwHIDlAN6TShCzUWSRjdjnqrbauUSlI0mXS71s+6i3J3/EQnubGNq/899An354wx
	 WwsTMs4FgFcNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/9] rtc: abx80x: add mutex protection for register
 writes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260811194034.28937-4-apokusinski01@gmail.com>
References: <20260811194034.28937-1-apokusinski01@gmail.com>
 <20260811194034.28937-4-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 19:56:55 +0000
Message-Id: <20260811195656.691DC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] The patch adds a mutex (`priv->lock`) to protect multi-step writ=
e sequences (like configuration key writes followed by register writes) but=
 fails to acquire it during I2C read operations. Because interleaved I2C ac=
cess resets the hardware configuration key on this RTC chip, concurrent unp=
rotected reads can silently abort active write sequences in other threads.
--

--- Patch [3]: [PATCH v5 3/9] rtc: abx80x: add mutex protection for registe=
r writes ---
commit 22bce01eb8bed117145738b82a585f1daa2c3fdc
Author: Antoni Pokusinski <apokusinski01@gmail.com>

rtc: abx80x: add mutex protection for register writes

This patch introduces a mutex to serialize multi-step register writes=20
on the ABX80X RTC, such as NVMEM transfers and configuration key writes.
It uses scoped guards to protect these sequences from race conditions.

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
>  	err =3D i2c_smbus_write_i2c_block_data(client, ABX8XX_REG_HTH,
>  					     sizeof(buf), buf);

[Severity: Medium]
This is a pre-existing issue, but do read operations like
abx80x_rtc_read_time() and abx80x_read_alarm() also need to take
priv->lock?

If a process reads the time or alarm concurrently with a configuration key
write sequence (like a sysfs store to the oscillator or autocalibration
attributes), could the read operation interleave and silently reset the
hardware unlock state?

This would cause the subsequent configuration write to fail, since interlea=
ved
I2C access resets the hardware configuration key on this chip.

[ ... ]
> @@ -539,16 +559,18 @@ static int abx80x_ioctl(struct device *dev, unsigne=
d int cmd, unsigned long arg)
>  		return put_user(tmp, (unsigned int __user *)arg);
> =20
>  	case RTC_VL_CLR:
> -		status =3D i2c_smbus_read_byte_data(client, ABX8XX_REG_STATUS);
> -		if (status < 0)
> -			return status;
> +		scoped_guard(mutex, &priv->lock) {
> +			status =3D i2c_smbus_read_byte_data(client, ABX8XX_REG_STATUS);
> +			if (status < 0)
> +				return status;

[Severity: Medium]
This is a pre-existing issue, but does the RTC_VL_READ case just above
this block in abx80x_ioctl() also need to acquire the mutex?

Since the read case performs an unprotected I2C read, it could bypass
the lock and abort active locked write sequences in other threads.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811194034.2893=
7-1-apokusinski01@gmail.com?part=3D3
