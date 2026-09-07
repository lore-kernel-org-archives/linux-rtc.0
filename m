Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8883A254B;
	Mon,  7 Sep 2026 20:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788813674; cv=none; b=PE4N9CvC9kYihNZ2RxuA1Xh2z04TxIMEuHe92ywIMSKjRQCRUX7/CxPIwygZ0h8TzUL3d2Yw4jHbIehR+04+sWqQk+pJ5zf4zm9YjxI/jxa6kDlr4RYd9zcWCyGM5ZEZSOomQBQAuZOiY4TwY/re06BJzJQz5iKEG8VR4Yxc++s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788813674; c=relaxed/simple;
	bh=HLWDSn82Q1fnmiiRbuJWuS0+FJfP+aI4TtL0oTnxiOY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nb778n9kpVy+Rg22B9QsgyGIFV9dz1pVrgXexaRlyYWK5LO6ZialKSIMDU46Vdgneqmu0YBvg7K2ugXVck+wBBh0bREd2wUlagrzOooTrjwfuO6iFHl2caibDQxtedfq+QvvTaHc1u5YxgtHKv0YgYSnqUWJm2zFhvJvgOgHIpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iy7goP4a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iy7goP4a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E271F00A3A;
	Mon,  7 Sep 2026 20:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788813673;
	bh=HLWDSn82Q1fnmiiRbuJWuS0+FJfP+aI4TtL0oTnxiOY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Iy7goP4aE3MDDv84nlA2N7wlALinE9iDbzfEyKo0u8mEhq+1STKOhTgzCuAMwNu05
	 q7ihxZfBJLM55aHm7xK95HULs0Eo2x3g7Kl14i/8apFfK5iGcW4NmazLLuK4oxhv90
	 esNXaZyJe1pOqz/AtkOLrvbj1iZCMcjF0K48UINldAyOSzA6Icfh8Zu2kIis+F5U3I
	 Wo43eay81CZ9Gb6sCh8yktNti1Ds/e34Z0T5VAfHd4w47bBR4YG1mKgAo960t687dJ
	 12DS6qH1p5o+o6u1hMEW0WGN3AdVTPsemiicvCTeXZ3X9NcEJwGa30/cBWRWt6gF0s
	 0vXSyaqJm/98Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 8/9] rtc: abx80x: create abx80x_i2c_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260907203216.53192-9-apokusinski01@gmail.com>
References: <20260907203216.53192-1-apokusinski01@gmail.com>
 <20260907203216.53192-9-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 20:41:12 +0000
Message-Id: <20260907204113.14E271F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Move the I2C-specific code from abx80x_probe() to the newly created
> function. This is a preparation for introducing the support for
> ABX81X RTCs which use SPI interface.
>=20
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907203216.5319=
2-1-apokusinski01@gmail.com?part=3D8

