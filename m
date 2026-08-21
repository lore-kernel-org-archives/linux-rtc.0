Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90933515DB;
	Fri, 21 Aug 2026 21:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787347124; cv=none; b=Zfv+6E171XgCjC3ckb7tNAIqz+63/TXX5tHjJIRpP09vnrfwDHiY82ZRJwa03DNwnkrRenc/aAwScG6kUabQOPk/DKJ9xHnj/UZMe3Q6ByaAJ7lnnnW8HY7gaXjtnW477doNATC5QHzZG6LKu6L2ep694a+wlNwC3odtBM+EFlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787347124; c=relaxed/simple;
	bh=LIy5Wj1/zrfmeQ+7yLzWssGVzQRsvM5b7GYB7p043Lg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ChR1DzZzz8Pkf6mAlJuxl73CSAbDQQGFsIDJepJUoCLWiNhrhd96gGThi/VcFyxSip25d0dUfPkqLr1ttw8gxBExUeGrOLnbzFw9axM85NIcfTrl2mrqTM6gN1xbx6xiyO9P1waFgW2pU+LDlnOMZTlWzJU1kzEa/cT6xDlGDqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LgssSTTb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgssSTTb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EB11F000E9;
	Fri, 21 Aug 2026 21:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787347123;
	bh=LIy5Wj1/zrfmeQ+7yLzWssGVzQRsvM5b7GYB7p043Lg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LgssSTTbyLN6zlXz081UyOprgrnOyMh6GuFPbnTERQccLzbIWYNjgNqDWuCTrqqkG
	 BILtEfJAaaX4PP/vFR8Wohxy+VO3LZB2heLBlpJedG0tl4do6s23GdSbrsbkAKppWr
	 5eNajDRT9BHT6SuGf2ZvgzQcWZCAWB/EjbeXWNoOVhXrAIoskhl/PpFN9sHbjlF1j4
	 uIWGkIZouaa4/Cl68bnf750wmkt+tatBTlelznjRoZr+EdfpXpq7VXKxqixstx1HWl
	 o2x2wEguwAfoJlBo9Tx8cSTRfJBhMvFYmVOE349REAf6TS1RlRN1ja+GH63LclGsP6
	 hXdQK97uVgLug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/17] rtc: rzn1: Handle unset alarm weekday in
 rzn1_rtc_read_alarm
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260821211032.13554-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821211032.13554-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821211032.13554-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 21:18:42 +0000
Message-Id: <20260821211843.08EB11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> RZN1_RTC_ALW is a weekday bitmask where bit N represents weekday N.
> When no alarm has been configured, the register has its power-on-reset
> value of zero.
>=20
> rzn1_rtc_read_alarm() uses fls() to convert the weekday bitmask into a
> weekday number. When RZN1_RTC_ALW is zero, fls(0) returns zero and
> fls(wday) - 1 evaluates to -1. This invalid weekday is then used to
> calculate the alarm date and can either leave tm_wday set to -1 or
> produce a fabricated alarm date.
>=20
> Treat a zero RZN1_RTC_ALW value as an unset alarm weekday and return
> without calculating the alarm date. Move reading RZN1_RTC_CTL1 before
> this check so that alrm->enabled is updated for both configured and
> unconfigured alarms.
>=20
> Fixes: b5ad1bf00d2c4 ("rtc: rzn1: Add alarm support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821211032.1355=
4-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D4

