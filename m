Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9B14B9220
	for <linux-rtc@vger.kernel.org>; Sun, 18 Oct 2026 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792336343; cv=none; b=PwYQvpM3m90pdhnzYBjm54jeEAzj7Gr6Arxy6ahSS7EnZz0NV6LV00XI7Kv3yBGlWmFv/XjhmWrNeR3wduIF20NK6ds7kIdaR8RoQx9tkPRZXrmH4aGdU7YM/mCNXwQFulWErJKJjrevc3cWqCpWHWa/o880kynerJnD2OJoaZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792336343; c=relaxed/simple;
	bh=yhdbxKHjxhasekqHbnICFuKA50befc78U7BTVD0x37k=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=LQwMCf2UWrfcVuR8acixsyrc00F//zFUh6WFfh5mwdsjpWzVGw0bePUvVJt1XLXhV4y3MqiNcFEb26W10wHBetahq4i8v2BBuaul744hHf/XslpCvVMUbM7w7Bc72bCwPrKkuuv5jc9IWEWqwYS54UpbOS+LXCQHUXcpp1yEIE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfSUhxN6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfSUhxN6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC001F000C6;
	Sun, 18 Oct 2026 15:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792336342;
	bh=yhdbxKHjxhasekqHbnICFuKA50befc78U7BTVD0x37k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JfSUhxN670/p4+RLPoVGLNAuwR0XLXsYz/IxRb0/Ib26aVrXHO+TBrJMVKhakGV/D
	 8+nNdmWky8sMk2cMlaMKnXvcUYOCUBBWe1PAA+MK4Yilpn83ORBi1BQyxmU1Yw5GrA
	 Wo1hRsB0PsU79c8YH9tnjuTBRRtbW+baziZtqplaYSkZ9gMxDFGjUAgf8QQ3pkDSO8
	 smABWS9j8LwBWvUDX9uOG/Y3QensG8VhqafjTwaQsOOIYuytpaZdx4Sx68qouC67ui
	 azX0Kpg20cTKR25wIiWefTmMf3tcUQhUJdHEzNMYCwqRNQ6LyCJ1Ykepr1RaMy+SOq
	 rzYZIlWUj/BWw==
Message-ID: <sashiko-outbox-176231@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 1/3] dt-bindings: rtc: Add missing type to
 trickle-voltage-millivolt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sander Speetjens" <sander.speetjens@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261018151056.1051330-2-sander.speetjens@gmail.com>
References: <20261018151056.1051330-1-sander.speetjens@gmail.com>
 <20261018151056.1051330-2-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 15:12:21 +0000
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

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018151056.1051=
330-1-sander.speetjens@gmail.com?part=3D1

