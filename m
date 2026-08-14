Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C523D7D64;
	Fri, 14 Aug 2026 02:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786673732; cv=none; b=Yw7R6VXyGqjXDG4IMaR0w/HiCK3TDuEgsOQqc+WtV7yZJHM7siArEjqcST5GEwB01Z+u6o+u2q08gOQOJs9g2niOL0ZMcED1fOmrw3nXdxj/MEd5hU9TILv6d6+m6cF7sq6CYe4gfkV399u0gZUP3ESOvReLRx4Y4W/K5qZUerY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786673732; c=relaxed/simple;
	bh=5e7QQP3MR8H65RyhROnw2DX1wdu9Rut1yx9uSaHBksU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t3BEtwEDDoVENDQmG8V7Xta8Mx6ChtLJICv5EoKUrKaqnRE2qRmJa1HEQVfFpDfhHorXO7c1t0XrJSbK+LBrpKyKiMvsTCrCTdXVA+4Bjt6mr8IhDwj2ZIVqiiCWKYED1V/8hIXjiOdgy4jLvy4yrkTueiKo9OadM9AFMaTJbdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8Q7JucU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8Q7JucU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4737A1F000E9;
	Fri, 14 Aug 2026 02:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786673730;
	bh=1dIGmQ2PLnyBbdI4SuMMAvOt2T1+ooWS0a6Xd7J+Tak=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j8Q7JucUZQSRAaOXJdkk6+t138ZLIJmNTEM/NLGKO0KKJA7/YiIvShGrVhZNgTeWE
	 g/iIvigCoiBdrNZRWHMYFoXajbneglYYjZKSyRxIjBv1ggLxoBrXjfeckpfMqeA0TP
	 c6hRBXHchboOOy6/lzdInXOB0jhtQIwdm94c/2xRMh1I0cTGcp6pajwpBkXEDt0nuE
	 IR1ec3xU40iIqbv6A0WcRfuIFshAFN0EhVnOpLzmiOcFy0zEHk+qKRkFxmArLXCcUc
	 e9pInn+B0bDHmeeBnLkLHO11WdnWZP9q3QU0MVLvGAr56wgGr99STr+fHtKVjAuS21
	 5buodEFidNupw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 8/9] rtc: abx80x: create abx80x_i2c_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260810193826.210683-9-apokusinski01@gmail.com>
References: <20260810193826.210683-1-apokusinski01@gmail.com>
 <20260810193826.210683-9-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 02:15:29 +0000
Message-Id: <20260814021530.4737A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] RV1805-specific initialization workarounds are skipped if the devi=
ce is probed using the generic 'ABX80X' compatible string.
--

--- Patch [8]: [PATCH v4 8/9] rtc: abx80x: create abx80x_i2c_probe() ---
commit 5c7e0bb55f377bff46772b45dbc25f48fd477301
Author: Antoni Pokusinski <apokusinski01@gmail.com>

rtc: abx80x: create abx80x_i2c_probe()

Move the I2C-specific code from abx80x_probe() to the newly created
function. This is a preparation for introducing the support for
ABX81X RTCs which use SPI interface.

> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index ab88af43b4fa0..08b22c0676995 100644
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c

[ ... ]

> @@ -911,26 +876,24 @@ static int abx80x_probe(struct i2c_client *client)
>  			if (partnumber =3D=3D abx80x_caps[i].pn)
>  				break;
>  		if (abx80x_caps[i].pn =3D=3D 0) {
> -			dev_err(&client->dev, "Unknown part: %04x\n",
> -				partnumber);
> +			dev_err(dev, "Unknown part: %04x\n", partnumber);
>  			return -EINVAL;
>  		}
>  		part =3D i;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but does this ordering bypass the
RV1805 specific workarounds when part autodetection is used?

If an RV1805 device is probed using the generic "abracon,abx80x" compatible
string, the part variable is initially ABX80X. In abx80x_probe(), the code
checks if (part =3D=3D RV1805) to apply quirks before executing the
if (part =3D=3D ABX80X) autodetection block that actually identifies the pa=
rt
as an RV1805.

Should the RV1805 quirks block be moved after part autodetection so they
are properly applied when an RV1805 is autodetected?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810193826.2106=
83-1-apokusinski01@gmail.com?part=3D8
