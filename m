Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795175087;
	b=BhUzRNiqxOsibq+pEeQ2+M3utOx6AYRox7xrpAhd0P3uL8XwknVzQf1p5S4QieaiuIsk
	 7JDvP38G5JzRNzQCsojf1DRy/EAFCjy9diQDrJvXbrX+D3FbiQ+JpJWDEjVhMUObXj/uK
	 ptDeEJjBry57tTWbE4L9vMBef6pLKnK3fqX5WH1QE4CZW4tvvGo2SWGgayg6Jc8KyWVTZ
	 20iBhZ69BiNUp9n7hVemflTrbiNJEYHepY5lwaBxJSrWU91B7bdaB0yfnYnswj/SElykp
	 o6Mc24DzvCAcoQL8Xbv0sSAXKEfzYgMiOZ9XzeP5ppesqdTGsolp51RtoB9yKicEbDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795175087;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sw4N8TRIauzXuV1YNLfI3YArGVjyM0yc8HIQpVzjkzQ=;
	b=IjzCxRtqkbG1KRjD/a+m7N2LIavsVMua1rfHo10dqAbv108eIDwcqteWBUuwCNWgUUsd
	 iSsuS8TTPWK0x4mCjseNgmj7n5Ejg/NAP/dJBqq28ynDVV/Ohq9A0m+beoIDx2Kx/tSm8
	 r5DN7lxiuY4LrKp8YHxK7bMKRfHxNT24SrsbyS9n8t/gxacvyi6S6hOA1zmAZWpD6LMwY
	 iNMARXMVCy2xj5Uazd4wnE4I7b0oSyEGmD0glps3LkGJH7rSYEN0/9m2GbALOzAiwb32K
	 Ybxk/q+2VtyfN8+SmKSFcz2ohVREfqJJXBnO9ju8sZquWdatWePK1LNEH5zZm5BNJpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3GMpSrd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B49360A2609
	for <linux-rtc@vger.kernel.org>; Fri, 20 Nov 2026 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3GMpSrd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C70A1F000D3;
	Fri, 20 Nov 2026 11:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795175086;
	bh=sw4N8TRIauzXuV1YNLfI3YArGVjyM0yc8HIQpVzjkzQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V3GMpSrdoRYO0Tx4D9HAAJJ3F55LsjZSHgaMXP9GHLrul0YxTn5nkUOtKLMG23t2n
	 g/+vGgngpQA4A8AqOoZ+KcHkWJPSulMnjjT7FD7PfKEmH4cl0+nTUog+rTJPH9yYdG
	 3DOJRrrZ4DFWQIo78j9vdYvskEU7cABwxEvFKAJNlqQMjMtGacBjkzX+ehWOfxz/Uo
	 eORCMewHc59ibcuSxBQQNhCu+BpDj94rKv2FjABfr58lN+JH4UYXtdh/e+6iKX7fA1
	 NOJw3WgRCCH47mrOplsMnTXEeL2xP8BXTvFhT1jDIexpeWR0pl5Ns9Etrxa7c82ThC
	 W1zLaGHWImWRQ==
Message-ID: <sashiko-outbox-225091@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] dt-bindings: rtc: haoyu,hym8563: document vdd-supply
Reply-To: sashiko-reviews@lists.linux.dev
To: pjh456 <pengjunhao409@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261120113502.563894-1-pengjunhao409@gmail.com>
References: <20261120113502.563894-1-pengjunhao409@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 11:44:46 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> The HYM8563 is supplied through its VDD pin.  Add an optional
> vdd-supply property so a board can describe the regulator connected
> to it.
>=20
> The property is optional because some boards connect VDD to an
> always-on rail.  Describing the supply also lets fw_devlink order the
> RTC probe after its regulator.
>=20
> Signed-off-by: pjh456 <pengjunhao409@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120113502.5638=
94-1-pengjunhao409@gmail.com?part=3D1

