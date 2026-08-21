Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7C3204C31;
	Fri, 21 Aug 2026 14:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320865; cv=none; b=crakZMgzMOwaxaTzGk7BrGC5joVpmmIxLf3jjw+frWPgkYrjT+tlhCFop6WbNXal5Z9PVWT3/fPL/2HGrWg0dC6d5fkB0g3a0IXVdvCpIgj6XWbAd73bbRLibF8Hfu6knpWet5Vj7UAhMKS3jS4Os1Rtpv4Q92T66RD2lnJtOJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320865; c=relaxed/simple;
	bh=AGUPvLQR/+NPDM0ZFWMq0OnEm4uqSpYEyXcjwSuwWDs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NjJvN3xW3PwQ6BG/FLUC2fLtFcqBRZoTWCdNaRpBVNSfBvFRpH7oF5gaYIlE2rCUmLlbSSftDuMrjvXFpB7Dv+14CpL9Wi+VJ2aClZPWTZ7tIV7ZFCFZWuy0p2v8Ks9m9FK9X7Dj+mA+KG4rQmth3zFfPZfeIYPBNASxzqvg3og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTgBidTV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTgBidTV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8481F000E9;
	Fri, 21 Aug 2026 14:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787320864;
	bh=AGUPvLQR/+NPDM0ZFWMq0OnEm4uqSpYEyXcjwSuwWDs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PTgBidTVfr/fsxnfQd30ctGptGwkRP6p6DUmsxrJMDfTN12/7wLMDX1dMQG1ZndC/
	 BWilJpOQAW7QEXG8TbnrQKvxU+Yxt1YW6Fwh/k+dBpGukOBatHiByGaCnx7IwyHo8/
	 Y86Z11r2CspjBiPdAME14M1iDKrIWLq4akTlzKwBf2trHOrwS6yAfoJgov9sqGhSCt
	 94NhXU9IxyumzkD8f4VlMhOQ2Z1vaQTWyosRAq2+ShvzobHmxKDDCXnntRcvVwElHw
	 KUw9mCMXwckJ/9TBfoxHwfLxx+puRArQk8y1ypSpsZxm0qwzyJEW0vPPNJDqhWEuD7
	 mwkId6kSDOaRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/17] rtc: rzn1: Fix malformed MODULE_AUTHOR string
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: wsa+renesas@sang-engineering.com, conor+dt@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260821135608.275233-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821135608.275233-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 14:01:03 +0000
Message-Id: <20260821140103.8F8481F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Fix a malformed MODULE_AUTHOR macro in the rtc-rzn1 driver where a missing
> closing angle bracket on the second author entry creates an invalid forma=
t.
> Correct it to the standard "Name <email>" format.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821135608.2752=
33-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D7

