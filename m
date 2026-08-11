Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079283B6C1D;
	Tue, 11 Aug 2026 19:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786478122; cv=none; b=sh3esqAjxKX8g3b8Xi8IkxymOkQe866oT21gZlu7fJxAnbYWd1pj0vNU3SI0Ds8BNCKeVjPvQ5WM5qPeX5jmv7wTPnaUEVw0LMTG5tkyow2TIOHuHBq/Ylmwp5ycuFJQlj7PRbC7GKbICIn4pKAvecdNQ5zsIriUOmpojlSsmGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786478122; c=relaxed/simple;
	bh=RsfoWPkgIaXKWzYbTtwvd3u09SOO/GTuU3M4y6E1zeg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UpFSYaB/sg2RppbezH6GScrel2rpsz8AmLCcPPtawRIfB8Q48C0mfOovCbayDK4QwaRIIGUI8Rfl/y9ZV7m3cyrie0WwfhKincM0NnVbxdUKFYCHXXwzVgz9LnmV5C2MmAMB1bt8GjedKqmSTyN7osg4a0XG9JcLwSPl54j4QqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYd4/sIN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYd4/sIN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFDD1F000E9;
	Tue, 11 Aug 2026 19:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786478120;
	bh=g1PJ129h65rgo7ecdYW8iei4t8ULOuRQfEMtkeypitA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AYd4/sIN6rB93H6LVuNMAgglde5+sjuDT5fo/K4Mdj5FjYu/TXcwhoR58WVzzG0eb
	 gnH7qbQ9hYHV2n2YNj1CB7PkHas4gUYlQ0DyAMiuTQCOcrVFcfGdca2RXhH0RGPGsg
	 u00bfRjtU7UE8gj3njm2G5b5ii+8v0ablkFyyQOsRFWQ+hpSK2PA4oQtaK11eDYD+9
	 L3yJS6Cys/Kf7qN9PpFufPetkjkrFj8xLyu+jvRmEpryAlTnfCTfXsJQ2hGQ5DHU37
	 s+CF9CRhZxFs1g1s+ZKG66M04yiA/I/Yi8fccQ9/ytdekks4PBoFL3XFGWJTyR0GBt
	 VUMxe0liGqLyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/9] rtc: abx80x: fix error check after
 i2c_smbus_read in read_alarm()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, linux-rtc@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260811194034.28937-3-apokusinski01@gmail.com>
References: <20260811194034.28937-1-apokusinski01@gmail.com>
 <20260811194034.28937-3-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 19:55:19 +0000
Message-Id: <20260811195520.3EFDD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Uninitialized Stack Memory Use on short I2C reads

Pre-existing issues:
- [Medium] Incomplete Bug Fix / Unintended Return Value breaking hardware a=
larm initialization
--

--- Patch [2]: [PATCH v5 2/9] rtc: abx80x: fix error check after i2c_smbus_=
read in read_alarm() ---
commit 111542521cef97450110e2dc7483bce8d88f644f
Author: Antoni Pokusinski <apokusinski01@gmail.com>

    rtc: abx80x: fix error check after i2c_smbus_read in read_alarm()
   =20
    The patch relaxes the error check for i2c_smbus_read_i2c_block_data()
    in abx80x_read_alarm(). It now only returns on negative errors, allowing
    the function to proceed if the read is successful and returns the number
    of bytes read.

> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index 5486d9d0b1e5d..fdf9664ebb6f0 100644
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c
> @@ -294,7 +294,7 @@ static int abx80x_read_alarm(struct device *dev, stru=
ct rtc_wkalrm *t)
> =20
>  	err =3D i2c_smbus_read_i2c_block_data(client, ABX8XX_REG_ASC,
>  					    sizeof(buf), buf);
> -	if (err)
> +	if (err < 0)

[Severity: Medium]
Since the error check now only stops on negative values, could a short
read cause issues here?

If the adapter returns fewer bytes than sizeof(buf) (e.g. 1 to 6 bytes), err
will be positive but less than 7. The function will proceed to parse the
buffer, but since the stack allocated buf is uninitialized, wouldn't it end
up reading uninitialized stack memory later when checking buf[6]?

drivers/rtc/rtc-abx80x.c:abx80x_read_alarm() {
    ...
    t->pending =3D (buf[6] & ABX8XX_STATUS_AF) && t->enabled;
    ...
}

>  		return err;
> =20
>  	irq_mask =3D i2c_smbus_read_byte_data(client, ABX8XX_REG_IRQ);

[Severity: Medium]
This is a pre-existing issue, but does returning err at the end of this
function cause problems with alarm initialization?

Since err holds the positive byte count on success, abx80x_read_alarm()
returns 7 instead of 0:

drivers/rtc/rtc-abx80x.c:abx80x_read_alarm() {
    ...
    err =3D i2c_smbus_read_i2c_block_data(...);
    ...
    return err;
}

Looking at how the rtc core handles this, __rtc_read_alarm() treats any
non-zero return as an error. Would this cause __devm_rtc_register_device()
to skip calling rtc_initialize_alarm() at boot?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811194034.2893=
7-1-apokusinski01@gmail.com?part=3D2
