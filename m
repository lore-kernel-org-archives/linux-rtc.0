Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340A8374A1B;
	Sat, 29 Aug 2026 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788013928; cv=none; b=ODImZcXBa4QDKGhDqX6oOc2yaZSGb22X/9AI/mGYVhnTilM3Y3Zt3DQYPOO6fsVIvmiaG8aK8qw6UvRy0fsUza9ZI4SqgkwhlDKMUBBZFX2gC6FIeC4eMp/5HNDZZoydT0hnHOpkfdnuDFPH217q/6goVzbPdnfYPJB9Lera6SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788013928; c=relaxed/simple;
	bh=SSRIq0g4Ei8yeOsG0gqEKLcVpGTda0CDxRt9VGOq2P0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iSBvBG2PuvTv0P7k4eS2KS8bX2WMakcASXy7jGCL8KKg8pyKmPh1cHkLGx1sMm4RZ25H92ryaVDC9eHxdyJXZFdH7dYy8P2gH783Lz/nvxJQre7O1mA31R87HBoId+17sdH8VuMr286GmS7YxahCWSO9yHxSkVKkW1nKDf7M50o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dt8I3Uby; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dt8I3Uby"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B98F1F000E9;
	Sat, 29 Aug 2026 14:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788013926;
	bh=SSRIq0g4Ei8yeOsG0gqEKLcVpGTda0CDxRt9VGOq2P0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dt8I3Uby5Lx1fTRSoOKo5e9v9oeQBDkIIpgL6TyPdEl61GPKBhHCAV3zSFASXtESQ
	 7z0HGpS/Z0Mceqg3dOsiYIcuXvZhagU+bTSqO8pQBomkcKeP338aFzXs1o2K/GEopw
	 LUtStu68S3qoKJznPyPDs0eHDyaIRxvnwyZt+mwIl/dbvpTwVadA3DQtWpYCaS9ecd
	 Jv1IHzimAz9OvZEdMU0ooEG1TKVBQZ+LCzu31EonuKiOpQ0IyCviKQWgpFmA/Pqyp8
	 JVbjzOVgLp6L0TNZpIOWbdbkyYS/YLAv1G5KERYfWcfXX3UY7j+ELKQSz0ko2Fhxk8
	 OzfNspBWHVzgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/6] dt-bindings: rtc: Add pinctrl for S35390A
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org
In-Reply-To: <20260829-rtc_s35390a_int1-v7-1-debcd31143ae@posteo.de>
References: <20260829-rtc_s35390a_int1-v7-0-debcd31143ae@posteo.de>
 <20260829-rtc_s35390a_int1-v7-1-debcd31143ae@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 14:32:05 +0000
Message-Id: <20260829143206.5B98F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Synology NAS devices use the output pin for interrupt signal 1 to wake up
> the system.
>=20
> Move devicetree bindings for sii,s35390a into its own file.
> Add necessary properties to configure the individual pins via pinctrl,
> which allows the interrupt signal 1 to be used for wakeup alarm.
>=20
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260829-rtc_s35390=
a_int1-v7-0-debcd31143ae@posteo.de?part=3D1

