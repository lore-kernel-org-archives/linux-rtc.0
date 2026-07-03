Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E517A39E17E;
	Fri,  3 Jul 2026 11:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783077279; cv=none; b=mcAYZyMyy/ec7QXwHLCaQV1ujMRwGIva492IMpbFuHx9uzzAC+k0/ydasRxwMW6oOQss4XyoNX6uEssZ6Cleco+J74HW+zMNobsPbpZYLaS2u5qtFPVwN+DZ3NWEeDvld/mTDht+YyYLroVL9fE68+peOSS0z1Lne6qZCyYMVtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783077279; c=relaxed/simple;
	bh=B2Cv9HdI4Z9YbV/iZl05x/8vKlZkC2XZ55yv2DZvb6o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E6JaalvpH6wWmJGMjnD0qfYxamGIPqKJu6lkd2I4aoeSl+I2JIPKd8RGXYTXxF1/hV0+kvFzebOGO0fPYZd9aDTFWfor2VmYOXsaPfU6MTNnITiBvj7lBRkfzbaNE2GVrunXJQaEw235BZilMszDDdyqVHE2nqXUxyG/lHJTAVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQF/+12W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQF/+12W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E781F000E9;
	Fri,  3 Jul 2026 11:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783077278;
	bh=B2Cv9HdI4Z9YbV/iZl05x/8vKlZkC2XZ55yv2DZvb6o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fQF/+12WnVHg8vFoiTvfyAYguhU7IOGXbpBUWI7Z1M44vdzNYfQppYdomsn1JI5zV
	 O+6I1I4TF10Ecx6xTC8SUeT9Ucl5LaGWxIYRFRbhMoQjOH8CAcALWH+p+yhFWZZH39
	 J40icATFJxmpTo3MDAQNV8asxWJlc/yvtM3BLihHaeIDnvP23GW2uLiOZ0hipZzMtT
	 FA9cWzx/2GDcvohQWSkcrLroCRCjH+6w5oZaSQ21JUq5/BZWkiTyXmk4F4T4SUHJ2H
	 LGF1E6Rlv/rei1pDlQsfjn1sr62WzI9dW5mh8g+uXC057F4kZjbmtEvypl/nsJmv3h
	 VwgJ3ZiTLfTrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: rtc: microchip,pic32mzda-rtc: Convert to
 DT schema
Reply-To: sashiko-reviews@lists.linux.dev
To: "Udaya Kiran Challa" <challauday369@gmail.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org
In-Reply-To: <20260703110442.205026-1-challauday369@gmail.com>
References: <20260703110442.205026-1-challauday369@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 11:14:36 +0000
Message-Id: <20260703111438.22E781F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Convert Microchip PIC32 Real Time Clock and Calendar devicetree binding
> from legacy text format to DT schema.
>=20
> Signed-off-by: Udaya Kiran Challa <challauday369@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703110442.2050=
26-1-challauday369@gmail.com?part=3D1

