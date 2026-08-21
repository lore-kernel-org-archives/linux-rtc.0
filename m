Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653B94C042F;
	Fri, 21 Aug 2026 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321293; cv=none; b=gexXBhJec73DXDiMiyZ8XKeMmNvYMDOzWP+8czp6EXoTujTlO25UdA0yCif2wh4NrxdMukhx1OagrPfd7ckp0m/P+ZzJezS8PR5HQe2QoO40mSTzQODIhK8npVJQLmobcHn7qAaxd4G8DpDG+/1tw2gvSk/Pd53JUgGBMaiIdzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321293; c=relaxed/simple;
	bh=HzKgcQuZToIoN1j5ACjc4c3JGxaUg6xmINtZJdOhqyo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SPGR+HShABvP4Gk3SzCiXHQagyfMStAktOricDSgKLZo3kfdNRNW3WD/xYzJYderDmNAUAVV6loCtzRT1sxLrOZSX6nUe3sqBBkq/E0TI6ywvdpT9YQey6U9ouZGuojoIPiMPWV391qI5B74cZD16ej8xneGahr/eRidOuB1EWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrA9/nt9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrA9/nt9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62E61F00A3A;
	Fri, 21 Aug 2026 14:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787321292;
	bh=HzKgcQuZToIoN1j5ACjc4c3JGxaUg6xmINtZJdOhqyo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jrA9/nt9WEi+t75eODv1gRIbSbbLMyA0ox29KMTxP3QR3MW5+PvyRqtyJfIWXL8zY
	 3E6z4+KPQeGXcLDD0N4lD3TMsPPSNIG6t48vdXPM4DRWnbFlcMuw1sM9YONrYDLqqa
	 8cGfA9R69xv3rMGkPVg0x1GKd3zQjrWe/NC1uuz865rlT7aK2UKm/bb1+wmpHfbZEv
	 661eh4Hf+n7fAGx/PUFuH42ZLHBfezEZl9WZ/+m1RDv6GN9fskrM6vIoOBClKbSC0C
	 y/HGQDuj+tu6Q4gPYVmukvCVyFWAw1WpkwpvXEq55s3RHsqGnaYT0N+3nd7WZJV8KA
	 xewbYNCkiOp9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/17] rtc: rzn1: Fix weekday underflow when alarm
 crosses month boundary
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, wsa+renesas@sang-engineering.com, linux-rtc@vger.kernel.org
In-Reply-To: <20260821135608.275233-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821135608.275233-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 14:08:11 +0000
Message-Id: <20260821140811.D62E61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> rzn1_rtc_set_alarm() calculates the alarm weekday from the difference
> between the alarm day and the current day of the month. When the alarm
> crosses a month boundary, this difference can become negative. Since
> days_ahead is unsigned, it underflows and results in an incorrect
> weekday being programmed into RZN1_RTC_ALW.
>=20
> The RTC core already provides a fully populated struct rtc_time for
> the alarm, including the correct tm_wday. Use tm->tm_wday directly
> instead of recalculating the weekday from the day-of-month.
>=20
> This avoids the underflow and ensures alarms scheduled across a month
> boundary use the correct weekday.
>=20
> Fixes: b5ad1bf00d2c4 ("rtc: rzn1: Add alarm support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821135608.2752=
33-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D3

