Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8819733E345
	for <linux-rtc@vger.kernel.org>; Sun, 18 Oct 2026 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792334348; cv=none; b=q8X3KMp6JjU2DYYWWU7ScU7pAlcI0Ya7bAuHSK6Op6wKlBUGMU6Tt8pwfRvD2dTnFuPy5/b0xYHaDPoScQ0biKcsWRS3HFsxuF/rjJaQ5v/zpYFxwdoqcP18egN8cXo6ATQwuCk/fQZG1t9Y+pz/v07ug4RDcgAQbQQbPMU+kaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792334348; c=relaxed/simple;
	bh=EZH1wUue6oZYVGFrLALhGwyDu7gsMQTum+i06f5XqtA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=h0AhGtwRJJknLUJdQwHxmysx94nsOlSWFZ0dKSVC95MERpHmXdUBK7lwGUX9MI4fgknMZqHDMHBbqebCAbGg20FvJCdlay3lUK1dCtzn9zy2D0yi1D6vwEkx+/REHSTakfnbPth3UX2keXWBG4JeWlp6X8vYXz8r0Xn8dDkIgn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0VX30D8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0VX30D8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38DC1F000C4;
	Sun, 18 Oct 2026 14:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792334347;
	bh=EZH1wUue6oZYVGFrLALhGwyDu7gsMQTum+i06f5XqtA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K0VX30D8PKN+g8506Y8fik4UZP7wNIAjDIAb/kVLodX8P/lx8YJv2cEKBtSZrUZcx
	 JEgEHrf29FZ4D1VhLvT2hMz+QvSnoFIccCEez2YFgiSXXLvi7P3r//fPnETp+mOz8O
	 IsyndUtUHAoBAPJxVFu3fI8RUH4sowne6sFi2t0zJXFQ2TSgHz1UJwfw57F2MF+GGT
	 93kzp0tCiFzX7PoPD5V5GxjozM1X9vPbd1OwHDXmKdkLxH2uzmfS17qJGfXjbfNb51
	 XkY1ATZ38YSPqV0YM4MlDLvju/wisx2oS5jq0eV7Q3RUHJJvMe1JkEit4IHFwPGKzQ
	 7obpXKjVirFFA==
Message-ID: <sashiko-outbox-176206@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 1/3] dt-bindings: rtc: Add missing type to
 trickle-voltage-millivolt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sander Speetjens" <sander.speetjens@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261018143712.1040152-2-sander.speetjens@gmail.com>
References: <20261018143712.1040152-1-sander.speetjens@gmail.com>
 <20261018143712.1040152-2-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 14:39:06 +0000
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> The trickle-voltage-millivolt property had no associated type.
> -millivolt is not a default property unit suffix, so the schema does
> not automatically infer uint32. Explicitly reference the uint32
> definition so the type is correctly declared.
>=20
> Suggested-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018143712.1040=
152-1-sander.speetjens@gmail.com?part=3D1

