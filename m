Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E29420E89;
	Wed, 22 Jul 2026 20:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784750993; cv=none; b=iY/mdQHdNJJwMAPaiLZctZl8f23o09Nq3dhPmoxfxkL8NkhbgmGhRkWrUWkSagzzNz/UqQBvYoCydpC4GtoGaRoq3tBMAjeTGNgcGjALAqmT0CZbjgF/G/jv1sYk7kSM2JHug34bSzSDFmAEz5CRovLbJ/+EAhaUPF/QGkTqE24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784750993; c=relaxed/simple;
	bh=YVN0T3uc3AcZoXggT4liwjmggWb+80zDQzigFNJpMQY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K3bNi/aaUDzfGmNppRCRRyMjRh26F2G8ethkYlIHJDAXgvwOezGI9mu0/5g/5uAP/5ChcRJkTL9TYgOOeY2kqxR2iE3eFzl4T2MqFxr7BHgCFCWc0PVnhyUs11VCEVgNeJEcIjM78s7NHDsKUqhNH1+KivujxN++Vs+aTAESeuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2wLDSzE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2wLDSzE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7D31F000E9;
	Wed, 22 Jul 2026 20:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784750991;
	bh=YVN0T3uc3AcZoXggT4liwjmggWb+80zDQzigFNJpMQY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B2wLDSzEyoMfRlRegf61P4t69pP8zkX5lzkP5QCX0jJi19uRFZt1f14a3dVlSX2lt
	 1Jk5MjhvMVftl+ou5uhgA9zVqffVORCqNQhBeas7fDkfpI/d1QMK975h1jTE+NgiJC
	 v4+MUgPOkcxDswfnTzadxmfuXoZ1ygc/+Qkd+mUTHWkIc9GHQB+GvM1ZUwO7vr+v+y
	 ckfS9ZSG4hi0TlmcWXmezmsuSrsFuHxDafd56yQ4OcQzQokT5nXqTwU8QWtwmb9CE1
	 urwvfvKARNwccT90UTIBhvrV0YHfwkxf20hagCloE3ZVEqAy42CvcbbLITmm7f8fJz
	 4dRcsno9cYLgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] rtc: abx80x: add support for ABX81X
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260722195814.298552-7-apokusinski01@gmail.com>
References: <20260722195814.298552-1-apokusinski01@gmail.com>
 <20260722195814.298552-7-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 20:09:51 +0000
Message-Id: <20260722200951.9C7D31F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722195814.2985=
52-1-apokusinski01@gmail.com?part=3D6

