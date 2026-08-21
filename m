Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1BA472F87
	for <linux-rtc@vger.kernel.org>; Fri, 21 Aug 2026 13:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787318554; cv=none; b=teJqcbyQIgZhqGcTTkFA/FcahPP+d4ZKKSd0fOY3Ve7y4PipVXbT8BVyLxJxroWeaQeZPOjQN+SJIGPp9jsWnOmS11CRDLLCnMy1KN0CGz2Ec3Gh7tyM5n/a+3qWhT+HYQxZJIS/vOf7NMXR322gZiOq27H9ddfn0rxZNh6xPD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787318554; c=relaxed/simple;
	bh=d5N4KqTlwgsET6exOswtKRChQmcSY9t1DrCW92Ul+y8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DpAaYU+k5qSe7PpZyewJ3NWdmWKwwcWMH+9wviaSpf2zzGrgacqgnJLEJkXyfUQhcN9iXxXyLoWQJmhfjyaUXkvLJHkKdNioPfH0HDV1lsYAG7Hg9Vr2ON+pVxhcaFMuTxeFMF3518JB0Qtt6xCovtyzheAL27LxV3zTNxyotlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOm7V1M/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOm7V1M/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8F01F000E9;
	Fri, 21 Aug 2026 13:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787318542;
	bh=d5N4KqTlwgsET6exOswtKRChQmcSY9t1DrCW92Ul+y8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fOm7V1M/ws+n1UVMuP8dKQnWetlEjr8SA9GUVdrZ0XaLUt70KAdeS+iMnxoaYKE5/
	 5ohZ7JO/q5Cb9/hB/qaoeKWCdUkZC7rkvMGF7FGTzbFp8v0X7iaXKJo3WO3Y767BWG
	 RS60F/T+WU7pxqRzoexVrPsJXOWB2QQcV5XAPQBuzzjkNRwY5IW6+9PF7QPVW9K72e
	 zkye4Rz2YgQ/yhM6UT3nsANbmtyyMX1F2ogXieCfEOB7CAcN7JjDPEQfJ0v+JrW8Si
	 91zHEXl5EotKTgxHvTth5Od1/boKXc4txvyGrWn3PP84VawFkqk3fBO7r5ETZdBjut
	 /0aooVT50+BTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: ds1307: drop redundant dev_set_drvdata() in probe
Reply-To: sashiko-reviews@lists.linux.dev
To: chenguoming88s@gmail.com
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260821131644.71794-1-chenguoming88s@gmail.com>
References: <20260821131644.71794-1-chenguoming88s@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 13:22:22 +0000
Message-Id: <20260821132222.8E8F01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Guoming Chen <chenguoming88s@gmail.com>
>=20
> i2c_set_clientdata() is a thin wrapper around
> dev_set_drvdata(&client->dev, ...), so calling both in ds1307_probe()
> stores the same driver-data pointer twice. The two calls were introduced
> together in the regmap conversion in commit 11e5890b5342c ("rtc: ds1307:
> convert driver to regmap").
>=20
> Keep i2c_set_clientdata(), which matches the convention used by every
> other I2C RTC driver in the subsystem, and drop the redundant
> dev_set_drvdata().
>=20
> Signed-off-by: Guoming Chen <chenguoming88s@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821131644.7179=
4-1-chenguoming88s@gmail.com?part=3D1

