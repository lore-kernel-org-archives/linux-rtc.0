Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2641E47A89A
	for <linux-rtc@vger.kernel.org>; Wed,  2 Sep 2026 13:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788354603; cv=none; b=uAlleBVSAWAy+tGJ4aywIhyk1BZxq/LKiFZEy8m5L1VzcmkoORkzUiWYyk9aL/oNKmzOr9F1A6tdwrD+HEqjwluZpBYc4YS0DaT9JpEsXHP9/D+blC+33MhyqAXJHb0J0WtBdToWbrCP12vxaIbE2fE5aQjmyyAjwnZPQ8x2wt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788354603; c=relaxed/simple;
	bh=N4jnIaK2DKgyLgunQB4ERPzKQe2mZEvsyXtGlOSJ/zs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j87b9H7jFcK6mzhMQdD3hYIL8gov3R+MpVWLcaiPtACFzjRgGbApLzq/fZLSFHBilKQAN2gkCAg0rTU18PbMW0E2x+GkLjE3bFcu0+Xc02mkdTeQs60fUU2TsIRDsF1tO61Wf/msTigsGgDyXLjb612u531WPAJ57x7p18lKDwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iB/ibD5Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iB/ibD5Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66C21F000E9;
	Wed,  2 Sep 2026 13:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788354601;
	bh=Iqf4IEiWUOws+SJYQJ+ilYlhuUoszEQp+mfZ1t3gd8k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iB/ibD5Q1zv7lNfOEhZlqUXP54jKlrnPCzSXS4Qq1VUKlq5ED3O/oB6sx3S9cAZ9Z
	 WGHBf/TEADyKBvhthtcuh3kTwTss7cnFmNsymOZ6hSP5z6gIr5TUtc5Z5oIHZjOIoV
	 mbK0gUcHbfuApqNfnC6aH18nsMBKXV/N5ygsZJ/f5ud8Wir3u8GePBsdLV50C2CqTN
	 imwXDxs9V/8Ge/O15ai1f1X4ruCOmGfmxQrecB7Cjr7ro+IeiU9wg8C5bzEb1zM2I9
	 Oi4EmCSUFNlMYwry+gtFekBA9ruIif8c2ZZTzCwvDPaIewwJxyDXxwtGV4VG8gvFma
	 jkhEELPvUysSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v4] rtc: abx80x: Don't warn about oscillator
 failure after POR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fabio Estevam" <festevam@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260902125257.9882-1-festevam@gmail.com>
References: <20260902125257.9882-1-festevam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 13:10:01 +0000
Message-Id: <20260902131001.A66C21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Sean Anderson <sean.anderson@seco.com>
>=20
> According to the datasheet, the "oscillator failure" bit is set
>=20
>   ...on a power on reset, when both the system and battery voltages have
>   dropped below acceptable levels. It is also set if an Oscillator Failure
>   occurs....
>=20
> From testing, this bit is also set if a software reset is initiated.
>=20
> This bit has a confusing name; it really tells us whether the time data
> is valid. We clear it when writing the time. If it is still set, that
> means there is a persistent issue, such as an oscillator failure,
> instead of a transient one, such as power loss.
>=20
> Because there are several other reasons which might cause this bit to be
> set, including booting for the first time or a battery failure, do not
> warn about oscillator failures unconditionally. This may cause system
> integrators to waste time investigating the wrong issue.
>=20
> Continue printing a message about invalid time data before the time has
> been set. Only report an oscillator failure after the driver has
> successfully written the time and cleared the flag.
>=20
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> Signed-off-by: Fabio Estevam <festevam@nabladev.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902125257.9882=
-1-festevam@gmail.com?part=3D1

