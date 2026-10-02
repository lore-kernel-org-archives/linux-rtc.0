Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E453B83F9;
	Fri,  2 Oct 2026 10:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936812; cv=none; b=eozmkhj+fhxMJklu4YOv10P+L8aCKgRt+Gku81fgbWz/pBngmFu6YMQlXMwMjDNK/rqDP0AUW6aujc2skWN0ywAa55JLkMtST3Fgs+9mjurjEbELI5/bfbOZdLNsBO1qvmagdMM21BKPRpagAbX/VSrlYtqHjWVeoNfCR4S0js8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936812; c=relaxed/simple;
	bh=WDvQ/u6DiqSc0AAyT6MaBMyRVZ/aAMTaf+4n/WcnbNk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EOT+unqPHINBNHJD3dNd4gM6oDBxH7Wpq2ATNxuFrGIgQmFFT8uEmvT7jOczPZXSUlqgwfRB6zADOeZmEu9B6GP0fLLtdrJZ+rLRWuxuZM+HYHH/btmJZNa9h2s2MmJY4CTrorotC4r4btpBf+d1QVWdRFuDJoPCjTedgnIW3QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJxtQ7hs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJxtQ7hs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E861F000FF;
	Fri,  2 Oct 2026 10:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790936811;
	bh=WDvQ/u6DiqSc0AAyT6MaBMyRVZ/aAMTaf+4n/WcnbNk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WJxtQ7hsal/bi/wee6wb6htgcMg3fJ8lN8v0W6Sbt05QxQ9XyEN0K/pto3hBE5a1P
	 92+pCWwwafsskDtHWmDj6gDtnnEgGvmkbCf12OCrqvFqUh0im7FZlWi1yEM1Ghze3y
	 0WD7drAoR8wKQfg2/6NHJUT0iHZtk1i4hTvsC1WzOO9XixHFoJOoZATVMV9bXP434w
	 hOd0ExZjHJlL1koZl0NXjR+iDS/P6A9fl6cqjUW+jmiK4PO3cEmsx6ZgMqcH7uLBe2
	 xoIUynSFfvcRnuTeZddpaRt0bmxuhJX66Wgik1OQ5AVaW/RLFp1I0I22bsRJ5R9cvH
	 xUYI7m0ZYoP8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/3] dt-bindings: rtc: Add missing type to
 trickle-voltage-millivolt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sander Speetjens" <sander.speetjens@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20261002102419.830595-2-sander.speetjens@gmail.com>
References: <20261002102419.830595-1-sander.speetjens@gmail.com>
 <20261002102419.830595-2-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 10:26:50 +0000
Message-Id: <20261002102650.C8E861F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002102419.8305=
95-1-sander.speetjens@gmail.com?part=3D1

