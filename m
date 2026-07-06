Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B644E41DEDB;
	Mon,  6 Jul 2026 09:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330771; cv=none; b=OZKgaZG0ASUozfQlL8faADvsAy+UColGEuC+sqwHKEt2290T3Zq/FBLmfYiujDblN369nTc9UgKaFt3YbnU2inHMo7Y1D3gT8qpC+vhXrSXdNUOToGAYDBNWD7errw0ptVafLnmClnhWE2I6BxtM8efSs+dE4P452td4/WFY5rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330771; c=relaxed/simple;
	bh=iYsx7glwWmFVPpmr2N2S1sIS9kTAuQDthpPNvZdAjV8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g2/Fcv0g16ARTLaLgoFLZyAZeNTz5wp1/qugxZRGF/7yaA0qRzIgXZX6TncsfD1ivPSD+89J5ZdU4sBPPI+OlZvqkG/DQGFoWz5pHZWxoeJrLPU5qrC/4kwBr+ZSEPXxyh3hW5G2ieJ3pID138SNRhWFH6KxkQUPEXcIw87Vn5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5I9GFcn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5I9GFcn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3021F00A3D;
	Mon,  6 Jul 2026 09:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783330766;
	bh=iYsx7glwWmFVPpmr2N2S1sIS9kTAuQDthpPNvZdAjV8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C5I9GFcncNt2LURnMrw3WXN/v4n4aQ8SxavMlF/aluQZUo8C8F6Dvegot5sgMjSeC
	 ehZFntNdXd56ZQYR0ehisQM6/iQehyr0EdS+XZrZrn4XA8mieA65Wz6+SHKno5D3AD
	 vfDm0oz7YmIzESIqBBzymNAXo210BoWKd4L74DgH9qbZNxJ531SLtTvbf4YxZDg95u
	 IH9tXwecxv2Cpzc3Q03XYjxj5PDcK+A7OWGo6Gr2zk4UG6XlT9cRLjSigNMSZ6jPBL
	 UcrehiifMWIusPyKiFjCG9H5G3+w0yWHFtjQqylStgEq+0wxoHu6Zhf6WJTEUANh/q
	 2IHRoRBp8ulGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/9] dt-bindings: rtc: sun6i: no clock-output-names
 on h616/r329
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jerome Brunet" <jbrunet@baylibre.com>
Cc: linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260706-a733-rtc-v4-1-f330728db3d3@baylibre.com>
References: <20260706-a733-rtc-v4-0-f330728db3d3@baylibre.com>
 <20260706-a733-rtc-v4-1-f330728db3d3@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 09:39:25 +0000
Message-Id: <20260706093926.6F3021F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> On h616 and r329 chips, clock output names are never defined through DT a=
nd
> are not meant to be. Just disallow the property for those chips.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: http://lore.kernel.org/r/20260629125305.0DF981F000E9@smtp.kernel.=
org
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-a733-rtc-v=
4-0-f330728db3d3@baylibre.com?part=3D1

