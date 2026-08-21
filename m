Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2802D3A7C;
	Fri, 21 Aug 2026 21:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787347102; cv=none; b=BWUbs5gr+wKr75e5jqVKM0SfVglTpm/L5eDmPc8e+yN+ayTTmROhme5I/FqJQWGdannkSqwSB+THELSLhshe7hHAd4x/aF9DTNiGBPkunrqiwMsbEfhlHXVslk3R2NXThq/a/YjUcXjv+G5+GpjcwfPkUBq4ULprnd5uZ8EkKqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787347102; c=relaxed/simple;
	bh=AyDUaZymNoZdK2C/l4RKoD5dbQq6mQzloj4HRLpqhSU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ejIPjbcNgOEi4QuQObdGF+RHZeqYvneuxgGxmNC5+B9ci+k7JjFczPUbzz8VhzxX1n3+NqSSE96XKdJiiirw8UvkdoNLgHnhC750uprg9wuB48/mYjAcjwqph6iCYf7KDaolTYNDfeMRI5pAiLbv9rTAevZCKG6v0MHaC2HPq1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWQv7dhI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWQv7dhI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC441F000E9;
	Fri, 21 Aug 2026 21:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787347101;
	bh=AyDUaZymNoZdK2C/l4RKoD5dbQq6mQzloj4HRLpqhSU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jWQv7dhI7bPtj1H0qWWix1M+YTeFCAXHII+Rc7rbuJaYhpFlscLywWY7SThc+4FNj
	 PxKmQKVXc0BVl4zqxPUynfE8oPhwczj7/0FK1iA7CnKqcnG0MQTQErfE6aPMpANNJT
	 snjkO9pBI2fW6yL6GLmsK2utl3Q5hkFxss51mP5RSL5xCaB1G84yYIB3IpJmormgzh
	 TyiLD56FL/bp8z/sAuhoWDCxvSORMLNOP7luhzhhzlphJqrddWKO8kzIRerV7GJRF+
	 TtunMNBUvQpRWxhf5eKrC912uPINwkgM9jCPsdojBLRJJkDHH2R2irlEdhkuFoKEfn
	 7yvwAFEUosoYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 16/17] rtc: rzn1: Drop trailing comma from OF match
 table sentinel
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: wsa+renesas@sang-engineering.com, conor+dt@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260821211032.13554-17-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821211032.13554-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821211032.13554-17-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 21:18:20 +0000
Message-Id: <20260821211821.1EC441F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Drop the trailing comma from the final empty entry in the RZN1 RTC OF
> match table and mark it explicitly as the sentinel.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821211032.1355=
4-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D16

