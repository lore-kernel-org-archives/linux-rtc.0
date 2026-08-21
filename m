Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAAF31E841;
	Fri, 21 Aug 2026 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321115; cv=none; b=lvWHxMvtX005cooMyUccNEjcKHhvfyhFvb6Hz2lEVvYwz1QyiWiOtO4PDE9+h2XDZQJWVdFwNhDWsiBrq9H9ClfD14LKjKq8FOqzINpa811cmaNE8wSH5xhm+E01TYI777e0+dvBWpuE0nXtipTjmI9HNIQxP4G/x1oZMQfe0Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321115; c=relaxed/simple;
	bh=MdfhGAnCHgFqv6Z6cMJ3ghkLYskaNxXm3ucLvqr/8Eo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l7k3ebqJwpCY/rc1Kh/oS29ojOv//DGz5++minSwLe0pOS+HRSFG5lBZfsnVvAZLorFUrqn77R37zJjPfNZvrZSz0mfRY5VAARdeykw32wdIkdMyeEp+OgrOaBLafnIQ1XaGHD32Dlw2MLnpcSMlFhkyqgw8LV1ovM7q40B1Qtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUMCRrEl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUMCRrEl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0D51F00A3A;
	Fri, 21 Aug 2026 14:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787321109;
	bh=MdfhGAnCHgFqv6Z6cMJ3ghkLYskaNxXm3ucLvqr/8Eo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NUMCRrEl22fu+OjQ8lvVAJK2yX5hH19znrCGvci0qR4Od9F6oYlLQw2IBxCOyzd6I
	 Liivk8RpAvHfU7EZHiOWUf7AchQ6DjvFpa1MMTygz9z03gM7qbL4vT9i3UTVk16DS3
	 6WYuQmoQ1kNLcC1F/boERnOUgXNJHuSxmY/4C4911UD5proXH2LWzbsUwOVqGN3biX
	 PUDPYXbfcFg/l/Q5T2JnjZNpUHQ64u0vzfALCDE3QfpjMWlBxUlyaNULyZ7yHFb1mi
	 OlXa4iN2f91QOSLiOPJbzTLP1Y9KjuNjvgsKu4jnuxtmzBWiyDzMdVYfEv5Q6LQ08Q
	 hC6QEQl/FMGMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/17] rtc: rzn1: Dynamically calculate
 synchronization delay based on clock rate
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, wsa+renesas@sang-engineering.com, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260821135608.275233-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821135608.275233-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 14:05:09 +0000
Message-Id: <20260821140509.8F0D51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Replace the hardcoded hardware synchronization delays with a calculated
> time window derived from the operating sub-clock frequency.
>=20
> The driver currently hardcodes microsecond ranges assuming a fixed
> sub-clock frequency of 32.768 kHz. Newer SoC variants, such as the
> RZ/T2H, drive this hardware block using a much faster clock rate
> (~195.3 kHz). Hardcoding these wait windows forces faster blocks to
> over-sleep, introducing unnecessary delays during clock initialization
> and register configuration.
>=20
> Calculate the duration of the required clock cycles in microseconds based
> on the runtime clock rate, and store this value in the driver private
> structure to adjust the usleep_range() and readl_poll_timeout() boundaries
> dynamically.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821135608.2752=
33-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D11

