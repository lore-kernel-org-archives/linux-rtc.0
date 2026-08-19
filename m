Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AD4376BEF;
	Wed, 19 Aug 2026 10:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136266; cv=none; b=oOJI7kT3L2XQdhI25Lt5C41gQIe/pG20WC/DEM/koq6Z1AjDhA7rHOdtNeZ7KGmzpZSVGtlO8ACrfPaH4iZ142diYrG+rXL/aWfwk44GBIyoRIIvfXQuqEe/tV+tj3gccLITp3GvK4qtdINnwXr5HknKe6TZ/zzRQnJvu4sbyY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136266; c=relaxed/simple;
	bh=6EyV6zZZTsz9j75xfW5lvrJa+bfgBhKPxgGXJAMny1o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y/fKDiYPgWQJYZlGhjLcn8BwVjOJJIzPDn5o+sJuarlEEhKdQn7yzjSDIm3FxW2YWZi/uvMG/QL090sE1eaj9NgTC3XCRzisfQYSJZkP2STF6BvlCvQ2dUOivUdzT8/Dopjg2gLdmVNyRF24EfmLx5BpFXgNlwi9L8u2d3lMYpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coFnj+Qw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coFnj+Qw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC44A1F00A3A;
	Wed, 19 Aug 2026 10:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787136264;
	bh=6EyV6zZZTsz9j75xfW5lvrJa+bfgBhKPxgGXJAMny1o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=coFnj+QwfxbVJkNI82MwawJjP035v1Fz2GmfIJIdaCEZcyRns9EUvyazQKimviefj
	 6cYHOIHeERkVTRcjHrKS08DMUOb2AYz3ADqNbXpSk+zDd3ypVX39LNOK/NIitim6N5
	 uK9BTY6gNuKbxmBwJmwGjeOZTegsjekqg8xhIaaWVJ25zMcpoH/ySK73mtVU7Moaqs
	 cIXOhC4fl5TCQeF7W1Qe/7LUN7LgTGRsXWCfS009LIfG8jYjt1HmvvEIEw3QaF+3Zh
	 4HqZnDlGKnxDMCg1ZYEi1Dyh0Ec/yPUbHLLQ4mgcMW5QyX/O9rcOaqOWcJMY4VazEc
	 4yrbxMiWB945A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/15] rtc: Kconfig: Broaden RTC_DRV_RZN1 dependency
 to ARCH_RENESAS
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: conor+dt@kernel.org, robh@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, linux-rtc@vger.kernel.org
In-Reply-To: <20260819103926.2136712-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 10:44:23 +0000
Message-Id: <20260819104423.EC44A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Replace the ARCH_RZN1 dependency with ARCH_RENESAS for the RTC_DRV_RZN1
> config option to make the driver available across both ARM32 and ARM64
> Renesas architectures.
>=20
> The newer RZ/T2H and RZ/N2H ARM64 SoCs integrate a closely related variant
> of the RTC IP block found on the RZ/N1 SoCs. Update the build dependency
> and expand the Kconfig help text to allow this driver to be selected for
> these additional platforms.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819103926.2136=
712-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D5

