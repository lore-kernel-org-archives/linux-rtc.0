Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792840560;
	b=xAipjK4vWoq1n7QqK1W7FK93tjXVP5uMW4FzF3I5SwpBMsCjs47kZtzvthnO75/OCug+
	 XUF0wqlVWz1YNlIkdFzH2qK0ySvC4NzEBrgnsg17Zii2hLM6UQDetH+xUk2ZY6bbJvZrd
	 pixS93X2I8O+EzqACyk1DIiBH4peUwnJc8lUgmZtE7oZGc49/5IeI7R+uklNPLPXCK91y
	 SFhRKrT75puuHtNYuNjbE/TrP135bpFRMfwhPZytmzZyZJe64g5kE0UuaDI6jhu0aAS2n
	 eFc5HMMZj+ePXiiZUMTZjfplicZFUVNU63wCsr3rKSkUixourvmtrx5JZk20TeX7YTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792840560;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Uv9OuFZcoijfSi6ItFy3FKY8YbjFJsKZty0nZOHkh10=;
	b=t+DFLCwqug97QOAdcMQX5cG8kynnL/7cghWmj86tgDh9seSY/rIfww1odSVfz6ogpAXc
	 5Bd9sarhpv9f442FId22JsVsdKtw1lC6WJh1kB6E1O09Oo1Mnk8cAVfcDX2WZSAgcaRYp
	 aF70dAnYz6NlXnbH+/XH+LncdgLLta8guKZYpFnVy75mBYAoW2mOW8ZHUuBCE4rS7V0AV
	 P/aa5KQGPfwCl58f4A0rsIgqHw6uUqM5B5AdfdWavq1yapBmurv+FNxvUsrogHEybjvCs
	 t01TW/CCMyJYc8u1IIxkSfNtsE8OmRAYKr7QCpPtyP6M6MteC9CorIsN2ubQLEiNCiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LN8yS375;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79908606A31A
	for <linux-rtc@vger.kernel.org>; Sat, 24 Oct 2026 11:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LN8yS375
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51051F01825;
	Sat, 24 Oct 2026 11:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792840560;
	bh=Uv9OuFZcoijfSi6ItFy3FKY8YbjFJsKZty0nZOHkh10=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LN8yS375KC3v28Sy7yOkIRZGNC+qB+2fYoQZHGBWVtfCj91K5Xlmyvi7qvGWDCr6t
	 VF28lNeX54BUNPC/XNy4qqH4bxjwz9DVDxYcIiuCM45kkptR764jDgEUKJ+NfwAzUE
	 mW2xfT9qhgMqot1IGJ6kuemZ/j8SdQQ8YiZ8FJNCqr4WJq9FFKyEuuR3ZaEVvSmtBb
	 QGP6W2Klmh71QgJ9KI1zoqosZYDVh5B9kG+LnO/EwoDbc1QyDP0hdWiPzkb8/PCpyv
	 nHf9zLaBtQBh+TVKd8Zw9yUbXIklZl0Ml9OzOH9CBIKl2MTLDRUGOe54qIorXEDVjR
	 fxBUkUhmBAV7A==
Message-ID: <sashiko-outbox-183676@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 2/2] rtc: Add NXP PCF85053 driver support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lakshay Piplani" <lakshay.piplani@nxp.com>, linux-rtc@vger.kernel.org
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261024110437.2851275-2-lakshay.piplani@nxp.com>
References: <20261024110437.2851275-1-lakshay.piplani@nxp.com>
 <20261024110437.2851275-2-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 11:15:59 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> PCF85053 is i2c based RTC which supports timer and calendar
> functionality.
>=20
> Features supported:
> 1. Read/Write time
> 2. Get/Set Alarm
> 3. Wakeup Source
> 4. Generate up to 32768Hz clock output
> 5. Primary/Secondary i2c bus
>=20
> Signed-off-by: Daniel Aguirre <daniel.aguirre@nxp.com>
> Signed-off-by: Pankit Garg <pankit.garg@nxp.com>
> Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024110437.2851=
275-1-lakshay.piplani@nxp.com?part=3D2

