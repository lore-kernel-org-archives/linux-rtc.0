Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE32B35C696;
	Wed, 22 Jul 2026 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784751059; cv=none; b=ihlQFfkNffW8cL52PVfB4xRX6jnrdBj0TOb1zKQMXyGlRVEvGkCTxDo0a27klCc5uL0WfsQhKjmzyytz7XZo3k9eI6VTxp/HjWXeyb7/9vT9T8tlIIKx4/tRdmxZeQLi1K41nHtAqHB//8SuOaqJfimhSciVnnQHOjlZ4X5ptUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784751059; c=relaxed/simple;
	bh=gDoU0YrFXna12kF9DUMMbC+9/JBGBTtHI7WXcgGIxTI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GrbjCdkUnso/x6AH43t+1E8KIHRYNbsaZCZw9vZaxe7uGZ7YoDZBPzt3Tp1ponQe5ouYutU7U1oTDubLZaIxSi++LTG2XhRZyjK4WFgtguKV8nOI2o2nhjqmYxn7bnJtT4V2Qjx7KPXEpd10HzTbkj5suxFsqlrFoepjRF/lgCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKQ3BCm4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKQ3BCm4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE841F000E9;
	Wed, 22 Jul 2026 20:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784751057;
	bh=XlKeMSo+M901rjUmevkhUWEcKrDoxlxHdAqZCVuIsN0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SKQ3BCm4ifypbkCB07mPjfBumzOShLAnUp0ebtdyEel3scP3JyWS91GiXAiM4ljKJ
	 1Tnh3oPE8wHjfUbSlwlOfpotp67AGz7GwsJQZMlAJnSwycfz/zC4vxAbfx30qyDnIY
	 bTeQrjUA6m9GJO4FBaLBjZev3EfCbxkr80UIU/PEBu+YHAx88127wNI+XgOPFvtDAd
	 lzSxsAo6qzqV3aSZ+VFkHcJNEK2nRhD5cemCipSAbtsY1QpwI0644UGbP7SHsuY1C9
	 2r1Jx/iOASPAct6I29ESpRq+Lvkf8LCLipcAibw7jTeIVj75oW1bB+0jM2POdiqg5u
	 LdsJ1c3F1DECA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] rtc: abx80x: create abx80x_i2c_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260722195814.298552-6-apokusinski01@gmail.com>
References: <20260722195814.298552-1-apokusinski01@gmail.com>
 <20260722195814.298552-6-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 20:10:57 +0000
Message-Id: <20260722201057.5CE841F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] RV1805 hardware workarounds are skipped during auto-detection.
--

--- Patch [5]: [PATCH 5/6] rtc: abx80x: create abx80x_i2c_probe() ---
commit 0661079a8b8384fb14bc67f5100b45ebe0a01c3e
Author: Antoni Pokusinski <apokusinski01@gmail.com>

rtc: abx80x: create abx80x_i2c_probe()

Move the I2C-specific code from abx80x_probe() to the newly created
function. This is a preparation for introducing the support for
ABX81X RTCs which use SPI interface.

> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index 7761cb353994e..6e0c14695bdf1 100644
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c
[ ... ]
> @@ -855,7 +820,7 @@ static int abx80x_probe(struct i2c_client *client)
>  					ABX8XX_OUT_CTRL_EXDS,
>  					ABX8XX_OUT_CTRL_EXDS);
>  		if (err < 0) {
> -			dev_err(&client->dev,
> +			dev_err(dev,
>  				"Unable to write output control register\n");
>  			return -EIO;
>  		}
> @@ -867,26 +832,24 @@ static int abx80x_probe(struct i2c_client *client)
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
This is a pre-existing issue, but are the RV1805 hardware workarounds being
skipped during auto-detection?

Looking at abx80x_probe() in drivers/rtc/rtc-abx80x.c, the RV1805 specifics
are configured before the part auto-detection logic resolves the hardware t=
ype:

    /* Configure RV1805 specifics */
    if (part =3D=3D RV1805) {
        ...
    }

    /* part autodetection */
    if (part =3D=3D ABX80X) {
        for (i =3D 0; abx80x_caps[i].pn; i++)
            if (partnumber =3D=3D abx80x_caps[i].pn)
                break;
        ...
        part =3D i;
    }

When the driver is bound using the generic "abracon,abx80x" compatible stri=
ng
or I2C ID, the part argument is initialized to ABX80X. Because the workarou=
nds
check if (part =3D=3D RV1805) before part is updated to RV1805, they appear=
 to be
silently bypassed.

Could this cause the RV1805 RTC to accidentally enter test mode and suffer
from extra power leakage?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722195814.2985=
52-1-apokusinski01@gmail.com?part=3D5
