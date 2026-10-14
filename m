Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C615444F565
	for <linux-rtc@vger.kernel.org>; Wed, 14 Oct 2026 08:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966785; cv=none; b=Y/asDsNbPOXC0+Ns1fvwW8CBFxjFmTbylcmGJpjEno2Gt3bwFLp6ysr5tPKuTFSjfQALiGviEDstE4gS6c35VJy5v2iwNLQel1Q4yRfYEan8JIWBQeOyqeQDFSWxK3/D/ZnBfPvtTGj0rbgXgizP8R5p2AINBLker30SrIlCA8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966785; c=relaxed/simple;
	bh=LtsuMm177Qby6039wJzHCKxvqg6Kmx2HM68DwjluwaY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=W9d6db4QzweXICYYN2oUJGqQ5FX8ZxPfVgCWHzFoedEnM1DXM6m93T7o1oQMrQqFpzANZYkWnW6O4778JsSWHu2jY3r2t4U9mz1UTa/WLqkw4CnCRB4oYr3SceSI7f/wcRqZysVjSj/3lbVjCX3hSQwRIZNkW0eXFRjkpze32J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtDf4EaX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtDf4EaX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2ED1F000FF;
	Wed, 14 Oct 2026 08:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791966784;
	bh=LtsuMm177Qby6039wJzHCKxvqg6Kmx2HM68DwjluwaY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CtDf4EaXrUb9CVtfEOV1dD6dr8Nm92BzsP9cYGNmeek7MxxQs7RkX3DmUyTaV2t4A
	 scH3GPAhUBYlrWW40B588wKw/BWQnQAIqKTe8yp/uYHiF2c50rpbn8BNHKnjRGVbP6
	 tgzLPPpb8h8Wf9FwWfQR9+Avp6oo2+ZvD1au4EluXbma6dZH/bvLFapXDQMrDl+lut
	 D4lkbwUZ+AXGR+MNCO2/2vU//yG+ioGy3UrSNqv7eDgBDXy3712h4ZAVmLuphpWx6e
	 R8t4xqnsHBbj3Z/Jz02V594vHFtFpjXh0mom6dK+SsNVzCDvcMubGTVcpeYuEXPNHA
	 atc/3zr9Bs8Zg==
Message-ID: <sashiko-outbox-171017@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 1/3] dt-bindings: rtc: Add missing type to
 trickle-voltage-millivolt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sander Speetjens" <sander.speetjens@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261014083016.332338-2-sander.speetjens@gmail.com>
References: <20261014083016.332338-1-sander.speetjens@gmail.com>
 <20261014083016.332338-2-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 08:33:03 +0000
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

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014083016.3323=
38-1-sander.speetjens@gmail.com?part=3D1

