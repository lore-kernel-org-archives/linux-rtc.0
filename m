Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3EB3BCD21;
	Wed, 30 Sep 2026 10:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762495; cv=none; b=mKppHhon5QW5LMYU8fw7UV34G6qiVVK+Zw2czt4JCq4K1pNdvtxh3FYWVzK3hyx6GrqY2CsIZr03KjU4CURNrX96VNo1eRaDOH9HdpT9+8+4NA3thelPeJVWneH4I4rma3fbHQ//jtU4bug/2+/A/2/16nZ49DTuNSty91D1RQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762495; c=relaxed/simple;
	bh=4EbFYGafMx672v/csn0IJAK2U3+tv+dLVyVp5fMAU2o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JJudGCwt87U/3+gHe11lGh+Umq+O22ihUvSbEOKaPNiZ6ni/VPUyOIp3d5b+k8oQNEsAj+myPjcywg7on9M1RNVS/eb9nlK+p3MBOCgBIbT34liKti8tb8bBO+ndDiElJsX0Sl4gWRU5wGR/HQwSbcICfUrgdg9l5Q1+PB5KZZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLe7DMhi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLe7DMhi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9498C1F000FF;
	Wed, 30 Sep 2026 10:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790762492;
	bh=4EbFYGafMx672v/csn0IJAK2U3+tv+dLVyVp5fMAU2o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CLe7DMhiqLQ8H1CUTTrZ1caEdeIMcfoxIRIRGAAEUyX2b1HSXX+Lcrzsk8ILuhMik
	 3USKF2r5OsBwGY2CvehO7DYmGchqIzWDz75WtTbYzsT+alN+W1DB+H7Iy94yHAS3Ie
	 obP1wc4STcD+rscEVJkLuK4QJ5A02PWQJPE8SrfYV7eagp9/rh71mxEVmpl/0903X8
	 2X6xvB0Th5mI7urmzCMh5+BalcRTm9kZieqNRyyzTNAUiBhNmh7ygr2B5U3IEckqqa
	 9d6SK2MGGpmxyONzS4W4hnlrU3gen+n1u9ky6dYm32TbfpCJCJw9KGvOmCQUlB1sov
	 EI4fd3+ezZ2dQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/2] dt-bindings: rtc: Add property for Raspberry Pi
 5 RTC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sander Speetjens" <sander.speetjens@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260930095203.492949-2-sander.speetjens@gmail.com>
References: <20260930095203.492949-1-sander.speetjens@gmail.com>
 <20260930095203.492949-2-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 10:01:32 +0000
Message-Id: <20260930100132.9498C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> The Raspberry Pi 5 has a built-in RTC that can be battery-backed
> via the VBAT pin. When a rechargeable coin cell is used, the
> hardware requires a trickle-charge voltage to keep the battery
> topped up.
>=20
> Expose the trickle-voltage-millivolt DT property so the driver can
> program the correct charge voltage for board specific configurations with
> the attached battery.
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930095203.4929=
49-1-sander.speetjens@gmail.com?part=3D1

