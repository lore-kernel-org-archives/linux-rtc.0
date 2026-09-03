Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436AF42E42D
	for <linux-rtc@vger.kernel.org>; Thu,  3 Sep 2026 07:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422104; cv=none; b=HIMdaPTKmj2m2hU0r/jLNi+2/FfSTIZlDg9+V6oR+INgXpkWmu9SZLoeV45yaOoylEWxbB1utrNKtQ6M182smYlLhQiHgzb2Ud09LZx5iapFWcbfjtNlqas9Ye//j6UiO88MrMSqJ0N08jvRHvFSF5Dgem4EpW6c9pOlK2H/wew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422104; c=relaxed/simple;
	bh=+Mb6iZQrjF+ZdWQ8lTjFBvamDuhCehH4y0dLEeatRY0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Lea1Aedbq4Wfws1EKSgtrP8pECgjM+2bWBktdi0GhbW2u9McF0avl9vIzp/TPNaaeIrFteCiqi20NjHQZbBsz+KfbmxtyLbeX5A3Z6W2SLvYK2T4kAeblReSrPXjymgIlc0IAOpQFoz/H3GqWrspjAwDW291wL3cGdcmoWf09Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3yfuWNa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3yfuWNa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CBC1F000E9;
	Thu,  3 Sep 2026 07:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788422103;
	bh=+Mb6iZQrjF+ZdWQ8lTjFBvamDuhCehH4y0dLEeatRY0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C3yfuWNamI0gZsuPIialRI7nstTik5h0U1oItL8HevN8XOm6spdoRH0PrC5GWl5m8
	 D7oFdjvaQNO3jQjtYSaEyQeO5LUYThKSU2ycrCK5pv+4DFXGZ/blV6inINMOqEPLH5
	 Ml2oYdZzmkvETXkEt3aTnoYbSmHCee1UJP6yg4ObYWFQ18lvWcS/b2GaDiT4okZDPy
	 XE8/NNkHQ9r3gQKVsCFyt9YvKF/+j57wbm7jPDz2Ranv2P4qYDto1/GG9iT5f4+uwH
	 kyiDd/5tCgq/9koK5b+zL06FHdsh2FqCOOHX3/qUL2DftpHt6HenyKxRZZSN4HMz66
	 hura2MEIl/QoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] rtc: lib: Implement time64_to_tm() in terms of
 time64_to_tm()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWggKFNjaG5laWRlciBFbGVjdHJpYyk=?= <thomas.weissschuh@linutronix.de>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260903-time-time64-to-tm-v1-3-660be972adfc@linutronix.de>
References: <20260903-time-time64-to-tm-v1-0-660be972adfc@linutronix.de>
 <20260903-time-time64-to-tm-v1-3-660be972adfc@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 07:55:02 +0000
Message-Id: <20260903075502.E9CBC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> The core timekeeping code already provides a function to convert seconds
> since the epoch to a 'struct tm'. This can be reused for a the
> 'struct rtc_time' conversion.
>=20
> time64_to_tm() can handle a larger range of dates. It is also
> 20% slower, but this function is not a hot-path anyways.
> On the other hand this saves ~600 bytes of .text.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh (Schneider Electric) <thomas.weisssc=
huh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-time-time6=
4-to-tm-v1-0-660be972adfc@linutronix.de?part=3D3

