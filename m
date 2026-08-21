Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE1B4ADD91;
	Fri, 21 Aug 2026 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321199; cv=none; b=R4CumlTu8EY/evS36RP47QiVQCqNYtF0Zwjx1YshJFJlTpRTgTutZ+fNLs3n3FFhoMg7F+Nc7b0QbMRrZ7wlL9Ie5hrWI/r6wCdttpZPAorJwmwYiObvAmh2znS/Rzn+N7sFzMoq0halRkfwCcrJRTY46CYNIWpkeC5JrSZK7hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321199; c=relaxed/simple;
	bh=GMm+t7A8DNslifQCySL0RlNmlbqv1NPIjJyXzIEZPE4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Rt8aaOLA/wP59ZDfnvq2JjqMUBfJuxmsmhm+2QjTuoL8jMuhbwVcv3F+uZquN9VX+s7pRT0njOOfXHmtkZhJ6Z4ex1cZBxodQm4Dx49CxMXh0c5J4hz3js6awRQsxaMiD5ep6fLsxMUsa2mCYNBE7XGObrHqdrOYmZWURY5efSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTm6As/H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTm6As/H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBF41F00A3A;
	Fri, 21 Aug 2026 14:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787321198;
	bh=GMm+t7A8DNslifQCySL0RlNmlbqv1NPIjJyXzIEZPE4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oTm6As/HmgmYHVoxHmVBcQks1Twiw0QOZj25/Y+L9YBX2TLC99njqPxO/quey73pZ
	 1Cup5ll43SQpPNjo4VmSOh2Go2zhWsSLhh4zC+oYOYKCEq4CGYCszOAr5bMW0EM/tR
	 eBmTNcrLWEJcO9Oli7LXvCEbHgpjBOp6XzfG6mfKmnI1tGvs7tIJRoQyKQUSc5jh46
	 8WLfEofD8d5scpD968eTc9BvAXA5HAXlV8EWHD79Wf3vkBnMNySR9YlH0U3vjvXYBV
	 sX07pFVCzyLVMJJov3S4oMGtZ6iLfSkMQRhnrtzxyJyyVvSFkiWg1GmVDtfFDIQwOg
	 znr1f5aUNf15A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 14/17] rtc: rzn1: use FIELD_PREP/FIELD_GET and
 GENMASK for register access
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: conor+dt@kernel.org, wsa+renesas@sang-engineering.com, linux-rtc@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260821135608.275233-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821135608.275233-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 14:06:37 +0000
Message-Id: <20260821140638.0DBF41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Replace open-coded shift and mask operations with the bitfield API.
>=20
> Note that the weekday field is changed from an explicit 0x0f mask to
> an 8-bit field definition, matching the hardware manual. This does not
> change behaviour, as valid weekday values cannot exceed 7.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821135608.2752=
33-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D14

