Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33A23C4555
	for <linux-rtc@vger.kernel.org>; Sun, 11 Oct 2026 12:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791721409; cv=none; b=KlRQ9Rl09cQAur9XAIs14xl8mcPwglDgmXe9CjONvlNmF8PTFCj9S7ZXViNN2ur9UjPDC/FakUf/a2Et4To47rvhwypRYHiR4g71mKcpsV1y53e6d2J+jdglUVpzh2p2Wpjg1GacgOscm+3xNZwCTtCKvbxkSWOI0W0m7a/+NZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791721409; c=relaxed/simple;
	bh=Z0F0sI5SB4/MmkaeqbWZav20CBig3En7s25iNDvUhE8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Y7G8t9R+iti2JggRUUhWzMNPzsyCDfRNYVsR5cyXtn4yOQBpQsAV7bsXrQuObDIZYmwqCVLvQ49mM9jbNFj4K3VRzBlAdgWiQlvwc/T6loW1opTDC0Yc/z6hbYbhLAYPmlpbtqpaRWy33U9vtOeSGFf+xLVBlz9IVsAc3JbJg60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3ZfBU4K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3ZfBU4K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307CB1F0089B;
	Sun, 11 Oct 2026 12:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791721407;
	bh=Z0F0sI5SB4/MmkaeqbWZav20CBig3En7s25iNDvUhE8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H3ZfBU4KAuQPgW7UTdATJHAuORKXSO20WX5VJYCqIV1o1RmdWyXx9Std299TJymju
	 XGyyZpT7jvABUKdxScZ5Oa8lU14I9hhZLZJj0ZgvTE69dg1VFwfXO2YAPNYGMk2YtP
	 HzWMZjjThAPpUTLUbtHM9Q1I7YdxBBFZUDcDUMIBI8ukwnoQ1fDodMdpttIuGtwsIS
	 +ZysurwWgeEesEyyUFkSpJhUd+FhfheY7Hm/7KT0IHrrMg5LLcTuZp555ua8Drh4ZU
	 iExWSPq4v7C8onT2u9S0w1AEiiX67jnL8bhBg51hOAruB3otUeY6QIePyMI1zq3ybF
	 FQd4jZQ3rh24A==
Message-ID: <sashiko-outbox-167220@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] platform/x86/amd/pmc: Fix RTC reference leak in
 amd_pmc_verify_czn_rtc()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ma Ke" <make_ruc2021@163.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20261011121759.3267678-1-make_ruc2021@163.com>
References: <20261011121759.3267678-1-make_ruc2021@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 12:23:26 +0000
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> amd_pmc_verify_czn_rtc() opens the RTC with rtc_class_open(), which
> takes both a device reference and a module reference on the RTC
> driver. The matching release is rtc_class_close(), and it is never
> called. Every return path after the device has been opened, the ones
> that return 0 as well as the ones that report an error, leaves both
> references behind, so each S0i3 suspend leaks them.
>=20
> Release the reference with a __free() cleanup on the declaration,
> which covers every return path without adding labels.
>=20
> rtc_class_close() does not accept a NULL argument, so the cleanup
> helper has to guard against one: rtc_class_open() may fail and the
> declaration still has to be cleaned up.
>=20
> Found by code review.
>=20
> Fixes: 59348401ebed ("platform/x86: amd-pmc: Add special handling for tim=
er based S0i3 wakeup")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ma Ke <make_ruc2021@163.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011121759.3267=
678-1-make_ruc2021@163.com?part=3D1

