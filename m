Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85B82DE6E3
	for <linux-rtc@vger.kernel.org>; Thu, 27 Aug 2026 02:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787796201; cv=none; b=D0vCTJLVFjYLYKP2nunOfbrav5cot8hS6mKkdRne5bqF4jZkQjjHJr+KXyVUQTSpaxZmjs1SwlWuR2/Np7uL9W7xTeLdYtFRWCXjp06w7tJ/YO0X+2tiruoHgGFGUlG61U5ii18T3CqHWkcS5Mxux6WL7Dxchbumw8BrUiKYy7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787796201; c=relaxed/simple;
	bh=zBoNggVcZWiFg1A+2QAbkTu2082EwoxAjOiYqpJSq10=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gnfuZYt60B80ui5QR2iI+tY8CsLqlEdM2+HYVMpxgNG091gkykKQILA2wcDlU94vuh+PQ5xLpSfhYvW3gVvHIsEnzbVQS+nqNpJ9oOyhVtVzbIQFY5mjabz1k1i9wbDZUEs/euw/aLR9JJ/e/M9IdM8KS5x5I7UqaYJUf+0tShY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EstRQV03; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EstRQV03"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA361F000E9;
	Thu, 27 Aug 2026 02:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787796200;
	bh=j6P1Kzj5pVgzpda/iTxeyeSW5XS+MFuHKsHyhNPxvU8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EstRQV03TDRVZSDwsM/zFM3s3P7wCmn2YLdAbON39+WUpK2Uvy/icG4+6s8hNG2Fm
	 KkfDc3JLFxdH6PhYGghtN+Nwoj83s8slfeWW713MHQPPfNpDK1qBmpSQCR+YeMWMEM
	 9C8BzcANuyyZUBLUFZlH2zUhVlSjAMnSc20r2ZNHuE3PBvSa5RY9pDtWCVLmLuN9ed
	 C+chGeqBp/ODCIFInWrCz5dHJqCOopUFbychNq3tVdUwu104xOKRlycAoYdcDTvhon
	 BhnfXIOxu+luUmZg3tERw4HEhiW+6kvVEQV6tfxTJoz9Jha+lHIvhc7SIna+ek4SWG
	 zYrBKomUUYUmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: rs5c372: add missing error code for unknown RTC
 type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liu Dalin" <liudalin@kylinsec.com.cn>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <C18300C5767FC690+20260827015846.3314353-1-liudalin@kylinsec.com.cn>
References: <C18300C5767FC690+20260827015846.3314353-1-liudalin@kylinsec.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 02:03:19 +0000
Message-Id: <20260827020320.1AA361F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> In rs5c372_probe(), when an unknown RTC type is encountered in the
> switch default case, the local variable 'err' is still 0 from its
> initialization. The subsequent goto to the exit label then returns
> success, even though probe has failed.
>=20
> Set err =3D -ENODEV before jumping to exit to properly report the
> failure to the caller.
>=20
> Fixes smatch warnings:
> - drivers/rtc/rtc-rs5c372.c:860 rs5c372_probe() warn: missing error
>   code 'err'
>=20
> Fixes: cb26b572dc394 ("[PATCH] Update the rtc-rs5c372 driver")
> Assisted-by: smatch:2.0 [static analysis]
> Signed-off-by: Liu Dalin <liudalin@kylinsec.com.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/C18300C5767FC690+20=
260827015846.3314353-1-liudalin@kylinsec.com.cn?part=3D1

