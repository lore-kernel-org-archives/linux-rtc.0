Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABF0485511
	for <linux-rtc@vger.kernel.org>; Wed, 14 Oct 2026 08:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966904; cv=none; b=PoIJ5D1yYAICrVJyHbYt+lYoLUhWmSDYEGwpFh+Rc/m7ZaDhLZO67WycPP29CbcjKKEkr2oG0pme92KVqMyBkroNLdNWJ8z4O96AicecHaxTDvqUun7w9Q+Dj0ypdcG+wQsswghUTA3mPXoJwAB963CitOEfzda5h83d4/MWajM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966904; c=relaxed/simple;
	bh=G4u7L6FMeU26eVhf0qqnEUhhAXIS2zUc5XzqtQSOhaQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=rvqHd1p2tcmBFOtAkDWreYQfHfPcvAnwzY+EYsnRj57KouAOsbMniUrZ4YFtFU6jyIeIrEGaSTaOhPbXgSb3Wj2IMMmfW/Bc09Ejyk3qT9qdgbe60zl3hgCsPw9erVs+0AiVusvcSb4H4eHIFr4fP9PAagoFYppgdrJEjytMBt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSoWa8aX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSoWa8aX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C871F000FF;
	Wed, 14 Oct 2026 08:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791966902;
	bh=G4u7L6FMeU26eVhf0qqnEUhhAXIS2zUc5XzqtQSOhaQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BSoWa8aXyLIaZasnG5wuEVJ/ywKmhm9Esv+OBM9SgET7SgD62nkn77/+CWwnzLAT2
	 ++UKhv5j/kvatJ80rFTczb2I9kv0LMDD7YYVojr6NjlvwlZAfj7WyEggDm4l8/0o7l
	 xMr5LGrQOxiVOET931Cpgr7xr63cbwF46TNcpCQ0GAzSmC8SSb9hU7Gt7roJ24J6Jd
	 N3v03NhyKc39L2f8jG3zxbM1jSg5j77dRm/E0TQ+iES4oMgGi2W10ZvfzNBjNabsQe
	 5jrn/hQwfdesHGilwl25sZvoBZiXsITpcrAp9s/ezwkCFEz4yz1E30zyv8hkYlHUom
	 OH3cIPiQ+/EUQ==
Message-ID: <sashiko-outbox-171020@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 2/3] dt-bindings: rtc: Add property for Raspberry Pi
 5 RTC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sander Speetjens" <sander.speetjens@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261014083016.332338-3-sander.speetjens@gmail.com>
References: <20261014083016.332338-1-sander.speetjens@gmail.com>
 <20261014083016.332338-3-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 08:35:02 +0000
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> The Raspberry Pi 5 has a built-in RTC that can be battery-backed
> via the VBAT pin. When a rechargeable coin cell is used, the
> hardware requires a trickle-charge voltage to keep the battery
> topped up.
>=20
> Expose the trickle-voltage-millivolt DT property so the driver can
> program the correct charge voltage for board specific configurations with
> the attached battery.
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014083016.3323=
38-1-sander.speetjens@gmail.com?part=3D2

