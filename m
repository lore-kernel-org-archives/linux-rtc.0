Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EE619F137;
	Sat, 25 Jul 2026 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784992074; cv=none; b=KPETVAeLVcqD1tAjU4ztLWNmdKJqApOPhrhC5XWEiwZUE/dYlCoBfWN/V6xvMp8wTjtZMePaL24lSvWOoEXv+eAT3KeEVNeI2+DTqo7Nvgta3mw8ozly6tsUOCJwFI7AqkCwpDPc8G+kWQaoQJ5RWeiEHpy+7cps0L0UNl0ihNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784992074; c=relaxed/simple;
	bh=lQiD+Q6uOnfB7oXdvWKPSx9bEeRyGiuovTPB5acUjE0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ubcIKRRRCShtdHhCqb5CXDzs/SyoyQ7x45JZMlL7pXK94GTG/MYWEvH8+xge7v50HvyPB42Kzkuakyi4Ss6ZdRmmdOpF4UADyUQvbKkgDAe5DKa7MgiAwBqxAuu3mACvxJHryy8DqFTMZ1/8ajBAH5ggZILpq3Ae//8BaTXyhKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBSkjU13; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBSkjU13"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325271F000E9;
	Sat, 25 Jul 2026 15:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784992073;
	bh=SuSgPf4xetPuUCqdjJyMPJoirGO12FTQdBEeJBLZiNs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XBSkjU13bjjkrZDew5oGgEoNFhtvmt4iB94V6EsjVS1OWkIoygU9QDOsYQ9iqvjly
	 gmSPBOaqhjUwDL0l6vY6chfMiJGqgdjKIexUFxtNfzi/UwzAxC0P3uoYK02C43VGfj
	 3c+KO09lfbCobY6wPe0YYYa6bw4sNM59iShmL8diB/H5Go264837JckxjtHN1ed5o4
	 MyXjyeI4esCW9j5J1hyA0X6aOjpLKAmylOFcYPFtLiyGQ7/W57mvUnYPtmhv03i4b3
	 nl8Av/KXRBhWJnvky56ooVJGSbGJXY/6f5gC7scSadPiL6GontqGR0ox+sK6jpjywL
	 2EGIp95VnPr7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/8] rtc: abx80x: move part autodetection before
 RV1805 configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: conor+dt@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org
In-Reply-To: <20260725145718.14733-3-apokusinski01@gmail.com>
References: <20260725145718.14733-1-apokusinski01@gmail.com>
 <20260725145718.14733-3-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 15:07:52 +0000
Message-Id: <20260725150753.325271F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch fails to resolve the issue it describes because part a=
utodetection for the RV1805 incorrectly resolves to AB1805.
--

--- Patch [2]: [PATCH v2 2/8] rtc: abx80x: move part autodetection before R=
V1805 configuration ---
commit e37ea6c1257442ff3423e6bacb742916beb85bbb
Author: Antoni Pokusinski <apokusinski01@gmail.com>

rtc: abx80x: move part autodetection before RV1805 configuration

This commit moves the part autodetection logic before the RV1805
configuration block. The intention is to ensure the RV1805 specifics are
applied even when the driver is bound using a generic compatible string.

> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index 5486d9d0b1e5d..ca3af91c29977 100644
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c
> @@ -814,6 +814,25 @@ static int abx80x_probe(struct i2c_client *client)
>  		return -EIO;
>  	}
> =20
> +	/* part autodetection */
> +	if (part =3D=3D ABX80X) {
> +		for (i =3D 0; abx80x_caps[i].pn; i++)
> +			if (partnumber =3D=3D abx80x_caps[i].pn)
> +				break;

[Severity: Medium]
Does this code introduce a regression by preventing the RV1805 configuration
from running during autodetection?

Since AB1805 and RV1805 share the same part number (0x1805), and AB1805
appears earlier in the abx80x_caps array, it appears this loop will always
match AB1805 first.

If the driver is bound using the generic abracon,abx80x compatible string,
part will be set to AB1805 instead of RV1805.

> +		if (abx80x_caps[i].pn =3D=3D 0) {
> +			dev_err(&client->dev, "Unknown part: %04x\n",
> +				partnumber);
> +			return -EINVAL;
> +		}
> +		part =3D i;
> +	}
> +
> +	if (partnumber !=3D abx80x_caps[part].pn) {
> +		dev_err(&client->dev, "partnumber mismatch %04x !=3D %04x\n",
> +			partnumber, abx80x_caps[part].pn);
> +		return -EINVAL;
> +	}
> +
>  	/* Configure RV1805 specifics */
>  	if (part =3D=3D RV1805) {

[Severity: Medium]
Will this check now evaluate to false due to the autodetection resolving to
AB1805 above?

If part is overwritten with AB1805 during autodetection, the RV1805 specifi=
cs
will continue to be silently skipped. This leaves the device vulnerable to
accidentally entering test mode and leaking extra power, meaning the patch
might not resolve the issue it describes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725145718.1473=
3-1-apokusinski01@gmail.com?part=3D2
