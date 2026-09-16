Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C374E432B;
	Wed, 16 Sep 2026 21:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789592822; cv=none; b=uCNsde/h8JBbRyNHZKWfZLgDSQTvDeGQiR0as1czcnT0yd9BlDFEp1A5aWhcoTZjl7ayt4/a+FdY5rbYE9pjH8Q3c6He6AjUP0SNWPEAmBO26N0Kl04xas7INoatg0V2D1vqnElYIaTFfzkIsFITkj3kZMXmr7mXrjg8SeyzgFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789592822; c=relaxed/simple;
	bh=x+ItzqtNz76NlIrF6QFqCply3U31Ky5vaLXn0ZTzbzY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E9ScZokSo1JnQU5jjj3nY+Z3xIzXdkzsJ3o6S87XuKoQtP4Zid50E5IgPoH2c11EC6HOSHXfVScUNLgjYMRofUiOHM0K5e/lE7ILaZN9StYtKWlV98ePzJ1TVMVBrqwdx0b/DHfLDRvqMbjMDhh1JZD4iwurKNizfAADbNCDB1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imQY33Lp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imQY33Lp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA7A1F000FF;
	Wed, 16 Sep 2026 21:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789592804;
	bh=x+ItzqtNz76NlIrF6QFqCply3U31Ky5vaLXn0ZTzbzY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=imQY33LpikNfK+Q6BEGfljr4XBxP8vuQZbTrWwhw6UPaifWXn+2EvyXdtbp0EoaKQ
	 MLmQ7iZ9O2hYWb38wjgY35FfU9oPQeQWZu1ZgGg4AroMp44I8oeHkcTwxjmcPaTWNe
	 +by2Gc58tkdp1s75ad8hevVZZ+NxYL0Zs8MbTbz7aUwpv1mBXorkaej53lQkTMwHR5
	 vOgRSHyfYOYIbekjvCfWqJ1lcW3vbGAdL69wp0p6TLc+bIbCftBZ3LBjxgp6md2zj5
	 gBlEVhPGuSS5JPbePpF0+1Jq32XJdf9XBktQ5Z5ixG6hk6yAzzo0/dKciEQfFkew9Z
	 FBtjEmPGA5D4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 9/9] rtc: abx80x: add support for ABX81X
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: devicetree@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, conor+dt@kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260916205138.16771-10-apokusinski01@gmail.com>
References: <20260916205138.16771-1-apokusinski01@gmail.com>
 <20260916205138.16771-10-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 21:06:43 +0000
Message-Id: <20260916210644.0FA7A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Abracon ABX81X is a family of RTCs with SPI interface featuring
> the same functionalities as the ABX80X I2C clocks.
>=20
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916205138.1677=
1-1-apokusinski01@gmail.com?part=3D9

