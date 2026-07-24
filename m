Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4AE3D9DC1;
	Fri, 24 Jul 2026 09:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784884826; cv=none; b=bzbOMSYDVm61cagFPYgvDNjQr2utcc0ZUoJJXCj3k+v1qu3jIMqi/PjOP7+6hhQlipQdLxQU2k4SvUZbAn+VUMZtOdM3h3KSAL1Qyo5UAA9m9z3chM83oPpCtfH9U307Y1NC6vfB1iVsFlPl4Xh8E6WYULErVTL2JL6BebbNNjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784884826; c=relaxed/simple;
	bh=IaIXCVuzx+LSsbC9pH2YWbdcoNrDs0L0CUCzrGpHkjI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ovJGnT8trAdaz9UiLU1+uqiNM2/K1s9rlcyQDQhBinVol28uIpFkUB8kl/DPqAwBpWcbtEOV3Gbb1hxdCMe/GLM8/vBgAjzNgtfMaKj55I82nu1Jj9y7l7ThVbmps9byQ3g+Zu7j5bH2FtHW4q4t1wchWZY8skUv5wZIi/lJplE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUK87rVU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUK87rVU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5EA1F000E9;
	Fri, 24 Jul 2026 09:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784884810;
	bh=IaIXCVuzx+LSsbC9pH2YWbdcoNrDs0L0CUCzrGpHkjI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FUK87rVUe6g/fDXQRM18aUqmHp9yq4LYjHO92+EwC+HG1V9FQkpta2jx27DSmeDWT
	 3hSIiCrKMMc6+LZFlqw71d8TZT1BlhKxO6hnE9C4leuPq87vHJKjmfqeRm2l703t2Q
	 3TsQuaR4lTxqIsysbpEVOQArWJ9Gj6XhQL0chUCiX5LWkKlF/qQ05FTcd5PksCiRzi
	 MLYcrfePm+DoorTAQcjwQNNUKRxhso/cpKUF+AybBzy0dcvferxOczYNnTFaN/xeoy
	 3owuuKstQ3sAmiOfDliOFcTZ+ICLzQmeQTUfR656HrGYDiPgh+nBKX4FxZytcp3N+U
	 vtRm8EWAQbGag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] ARM: dts: ti: am57xx-idk-common: Remove unused
 ext-clk-src property
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bhargav Joshi" <j.bhargav.u@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org
In-Reply-To: <20260724-ti-omap-rtc-v1-1-ffef78853cd6@gmail.com>
References: <20260724-ti-omap-rtc-v1-0-ffef78853cd6@gmail.com>
 <20260724-ti-omap-rtc-v1-1-ffef78853cd6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 09:20:09 +0000
Message-Id: <20260724092010.6B5EA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> The 'ext-clk-src' property is a legacy, undocumented boolean property
> that is entirely unhandled by the rtc-omap driver. The driver instead
> determines the clock source natively by checking the presence of the
> "ext-clk" clock via devm_clk_get().
>=20
> Remove this unnecessary property.
>=20
> Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-ti-omap-rt=
c-v1-0-ffef78853cd6@gmail.com?part=3D1

