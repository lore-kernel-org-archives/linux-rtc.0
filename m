Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E14C434E59;
	Mon,  6 Jul 2026 09:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783331781; cv=none; b=h+yFkLZoOWe58uhnB2AuCgHPZJDWeqrbZtx3Jry4EwVGgX2jdToyRm53YQjBvzykDlBs2gRogzFMTIE7L0+THCl/YBc4QtFffWaJnhpmKc9vcvVf1pqKVhTrfiThlrZMUmTrsbSwHpZkT4m8RRApcqCXqu9wxCnpSqUmBfSMoGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783331781; c=relaxed/simple;
	bh=lxbYUXc2GuYjJVgEeQ3Otgs6BHLF9/cttk3cowAA7h4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=II4/so3xmh6s7GYXQaJI7a78YfPSPRawJ2naBaeUt+WyV2L4fcjBt+snzoKBSDXupvwtqzpt5NNUhEiLvz+WiKjKoGnUqUWpUcYjluF/jguYAEjfTgM/Wxp30J2tpX+uF1h+wqXbZqxcz07SH7KJsooOMUmXKm3qsh1+/mB2XV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDFven0v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDFven0v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA151F000E9;
	Mon,  6 Jul 2026 09:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783331778;
	bh=lxbYUXc2GuYjJVgEeQ3Otgs6BHLF9/cttk3cowAA7h4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZDFven0vCU5HBacKtsK4Wsh2d7vqxrPBT5w5IxkjmCTFCs9j5bed7J05mSjGgimm6
	 LSoOZyWPFt+PieXsf0K2u3aMQYMOMx+QNSKd3OHHG86kYNY3wQjtJkWMbki/P4qOEQ
	 3Ttk/TXO5kQjCpNCrDfoTEHxqz1Ut3PRl/xh3iEqsMN7NsEAQe7f7GMuI/CLnzLZpL
	 uQgVeOIBqjs/RXBIcUjx2Y8tAnDhOcJFIlQaHyXtLjBHPjs8VTU5LyepEPWEKyNGVj
	 pzof65YV6PIvtFbsirymrMFASs5g17pBRyKaTtg+x9hcbqDyQn+jPBuMO4VMXneGYT
	 mj2pgV8Ufy8Hw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/9] clk: sunxi-ng: sun6i-rtc: Add feature bit for
 IOSC calibration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jerome Brunet" <jbrunet@baylibre.com>
Cc: robh@kernel.org, linux-sunxi@lists.linux.dev, linux-rtc@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260706-a733-rtc-v4-5-f330728db3d3@baylibre.com>
References: <20260706-a733-rtc-v4-0-f330728db3d3@baylibre.com>
 <20260706-a733-rtc-v4-5-f330728db3d3@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 09:56:16 +0000
Message-Id: <20260706095617.BBA151F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Junhui Liu <junhui.liu@pigmoral.tech>
>=20
> The sun6i-rtc CCU driver currently uses a global static variable to
> denote whether calibration is supported, which makes IOSC operations
> tightly coupled to this file.
>=20
> Convert this into a feature bit to decouple the logic. This allows the
> IOSC clock code to be moved into a shared module for reuse by other SoCs.
>=20
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-a733-rtc-v=
4-0-f330728db3d3@baylibre.com?part=3D5

