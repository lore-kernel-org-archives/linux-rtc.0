Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604C14D9F80;
	Thu, 17 Sep 2026 11:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643840; cv=none; b=gnD2du8hiY2uBDLaLzsvVRIpkD5Wl92Y4YUwpU0YhEesX/XwFv1rRiXaoeSJmhzbWHXnkGJqPDxzoScQ519BEqZuV/AKp1/z+ZWl98MNMt8GKLudmuCccJxi2O6ZTTlZxMjiFLmL71R/4V9/P9uR1oHNoHSlRXinI1siT+LvCUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643840; c=relaxed/simple;
	bh=ZtuV/0R7nQvFNR0Ry4E2qtH2PPIf79l77H4ohfCgW/k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lHp0rhO994sYM3S7F3o9nVUWtqFqovKPhiHOicZhaBk8cBrk63WoMmZBH5RnftClC48+0VzE1yMG/wP7byx/4Id073aYpiy3iILsn3Z4FEm2JDg4n7z85xFT75I1a5kObiKMxb788Tb8eaGr2ckrHv6shDnj/JtIJme7wO6d+6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6/jC3aI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6/jC3aI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57581F000FF;
	Thu, 17 Sep 2026 11:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789643833;
	bh=ZtuV/0R7nQvFNR0Ry4E2qtH2PPIf79l77H4ohfCgW/k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C6/jC3aI2AjGSK9msnxQ5CsYD/Sq8p4i4OgcznbNKHrBl+TB3F1sAO/1JI6zjfnIn
	 C0SvUzxZuoj1irDXNBF1c1RS7HSlpngJgvj3TQ289XbtNM2EdWmIibq6+KYtipSxmf
	 PzsgrUNIyzqhSngJBsUcMCzoi92dMxC2h2q47m68vzq1al5HbtYWHVg6q8waD6gJeO
	 ByjTLfZ4zUQ3d2o+6vMvJ/oBaMGNWA9+FX+sG+RECaP22DgxxSSyMJtBPhsxXziKoL
	 dyuSANpcEFKVzx1MGOYGpkgiHtVtkMcoI9iGwmINFzm13h4zl1+TP/+lJp9PUyKiJW
	 HkIEU1cuvhwMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: rtc: rzn1: drop unneeded
 'start-year' from example
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wolfram Sang" <wsa+renesas@sang-engineering.com>
Cc: conor+dt@kernel.org, wsa+renesas@sang-engineering.com, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, robh@kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260917111349.52250-2-wsa+renesas@sang-engineering.com>
References: <20260917111349.52250-1-wsa+renesas@sang-engineering.com>
 <20260917111349.52250-2-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 11:17:12 +0000
Message-Id: <20260917111712.E57581F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> We don't use 'start-year' in upstream DTs because the driver does the
> right thing by default, ranging from 2000 to 2099. So, drop it from the
> example, too.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917111349.5225=
0-1-wsa+renesas@sang-engineering.com?part=3D1

