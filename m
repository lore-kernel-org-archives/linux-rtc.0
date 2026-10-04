Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFE43FA5FA
	for <linux-rtc@vger.kernel.org>; Sun,  4 Oct 2026 22:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791151659; cv=none; b=BEmXBIdQFuLs5t0Krq9jaHBOJCzSjocjAis/nbdJSYVB9h1sizB9caDVV7qXMP2+WFmhpZ2iRKvzKCi4YstHhiKg/3SU/dMxtzhX6C1mSA4Vq8dL2okDR2gUuqqAYLGMxHN5UCrbalOrlVlxRv3GjvvDm2zr0PxCkuResymebbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791151659; c=relaxed/simple;
	bh=oqURhFqkiXiOp0l3uIHy+fdHLoliuW7QPraP8iyhb9w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f5d46ImzuICUNyutO0lEMGfAkj9faubfGEOLcBGv96jyzWy6ZRClnfINA0GYyWu9Y0zGvp17a6gVIchmjYt/oEfMvDvd+Jhx0z7vs6jXY0fIBrZP5LciuCyskKdgdV0qns4PFMkJtEqmMmHCoRk5wvJd6xG7vsXO2tVquYMD1cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvPC9vD+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvPC9vD+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE7D1F000FF;
	Sun,  4 Oct 2026 22:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791151653;
	bh=oqURhFqkiXiOp0l3uIHy+fdHLoliuW7QPraP8iyhb9w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AvPC9vD+AK/sY98EdiaoxrJRmb9Jc+ZMsZwzwzKfh0mPsPPIdzOVueu1Lz7h/QYmO
	 343oNkmd+VI9ZHOxlPhujlpdNHXjYwUOK9BIQqbErlH39C9xLtOaxI7bLnYekXcJ5E
	 MAhL05eAw668OhhJxbopwMInLrS/9GBh/bQC9okcH5FQa/gu4m3P3VjwJtd63zB6wc
	 N68vZebP68xpo2p6sbpSXEB2eCtNcSOnuM4+UZPjenowo/mKUfZTLZvGO93PqhTxzf
	 Edd/I4jUh39+i8MsmtZb6NDoI6Ic+GPKUmqUq2o5vtqv3nayocV7nNjlO1uNTTr0mQ
	 /pNZsrzWHFd1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: omap: wait for !BUSY before reading time for the
 power-off alarm
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261004215914.397512-1-rosenp@gmail.com>
References: <20261004215914.397512-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 22:07:32 +0000
Message-Id: <20261004220732.BDE7D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> omap_rtc_power_off_program() reads the time registers to arm ALARM2
> one second ahead, but does not wait for STATUS.BUSY to clear first,
> unlike omap_rtc_read_time(). The time registers must not be accessed
> while BUSY is set, as the counters may be partway through an update.
>=20
> A read during an update can return, for example, seconds already
> wrapped to 0 with minutes still at the old value. The rollover check
> after arming only compares the seconds register, which no longer
> changes, so it passes and ALARM2 is armed for a time that has already
> passed. Power-off or rtc-only suspend then waits for an alarm that
> does not fire as intended.
>=20
> Call rtc_wait_not_busy() before the read, as omap_rtc_read_time()
> does. Both callers run with local interrupts disabled, as the access
> window requires.
>=20
> Fixes: 222a12fca604 ("rtc: omap: add support for pmic_power_en")
> Assisted-by: LLM
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004215914.3975=
12-1-rosenp@gmail.com?part=3D1

