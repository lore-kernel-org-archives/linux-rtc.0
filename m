Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A8F3914EB
	for <linux-rtc@vger.kernel.org>; Thu,  3 Sep 2026 07:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422048; cv=none; b=XooG6j/AQ9ATB7caqeKtM59BG0wiazIKIUaStdC5rYFGlaYkwaMx0Uq9q6j1TTQ3sjaps/eTEX6S+95LPd+IPFSkhJLQ13KKk4S+UmGX4ofu7+36YMMLo6NGxSCdeS6QZh8LdQ7uNvw2K6iZA+oVSRfP5/Deopwq8ut5OhPCSFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422048; c=relaxed/simple;
	bh=PWWspcTTLVUBDN6KjOgaWtlHsgJRjZhB8e3FQq8g33U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mgRZOiUNBGgKrAs2umJNCCqiscy4cg8Da6+Daj01RUV4V8ZTHJ5fvVkDOo3X6zhaJAXvkK+EiSp0XP9p1W5bgcXI+WQ+cYm5/MsVVJYRUU7EtG5sRdL6jpLG35PpJ+eKA9e2mMcTkyWZQBt0YbM1ooWl9MCsKbLZ/b9mRmtrgic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKEwGmKl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKEwGmKl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9481F000E9;
	Thu,  3 Sep 2026 07:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788422046;
	bh=PWWspcTTLVUBDN6KjOgaWtlHsgJRjZhB8e3FQq8g33U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZKEwGmKlzIU4kCmpT9TwBkchOpJUQ29Vvuw+dj4XfJj+KpP6IHan0wFXHMNf/6FK4
	 dSjhC+yGHCiKsWKekG4GG762X8GnMqAlbSrWBMqUq3eNR/zozABzrlKeInRgfGI+eZ
	 5Qqtm0f/xExDMej8FYzagaXd7AGpOwybfzBQblBOisI7aJISC6DNHAXjTiH/N+jMCM
	 42t7owBKXisXIpLCJSOj+N/0icJSm6R5fAMvKu2ZqNc/nFphvfpJrFBQMZKo2mF/4k
	 zbm1f4q9fM+BJtlYJpZygySWZYyoRhUg8KiYojxvI61rEF5tqlt6zNVlIk8ch8okC1
	 1s2sVLmzfU0lQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] rtc: test: Remove test_rtc_lib.c
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWggKFNjaG5laWRlciBFbGVjdHJpYyk=?= <thomas.weissschuh@linutronix.de>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260903-time-time64-to-tm-v1-4-660be972adfc@linutronix.de>
References: <20260903-time-time64-to-tm-v1-0-660be972adfc@linutronix.de>
 <20260903-time-time64-to-tm-v1-4-660be972adfc@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 07:54:05 +0000
Message-Id: <20260903075406.1D9481F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Now that rtc_time64_to_tm() is only a thin wrapper around time64_to_tm()
> the dedicated test is not necessary anymore. time64_to_tm() is already
> tested with a similar test in kernel/time/time_test.c
>=20
> Remove it.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh (Schneider Electric) <thomas.weisssc=
huh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-time-time6=
4-to-tm-v1-0-660be972adfc@linutronix.de?part=3D4

