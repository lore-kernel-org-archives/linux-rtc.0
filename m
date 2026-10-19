Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444921;
	b=1quP35dskbx1KZgKfO2D1uzkMjvOfOyy4fUebjtHbjYJktgEnAXULIBleDqzMWwRuXRL
	 KBlZYctOSVlfXMmywH5O/tbTV4gbHFYRUgiFVZu34MnKXs/JkWgiKV+2Jk1SgQjcUhgYu
	 gNeWNdw5aHI3g3kRd7WmHxOJmWUsv95JyhoC751pwCDoXoxufdj4t5oNulvaHfMqoHE9j
	 CTIn1/6WTFNGQssO3Xp1H3O7H8Qe+M/i2/iF8S3K1crytc87fPMLyAexTwM7QAobcDPU6
	 qFz1KFZO1adIePoKmlga9FuivukxUe0URwO3xFwJMyh1GTvsfWODwztyrhtH1sGTNQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444921;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cwWby4LG4c3NuUcVdk31mt7jh1g9bQGq9PYAUHEdh54=;
	b=Bb+LHU64Ttt0tABpp8BlnxhIRFYM8MiCfSqdgjOjDthySEfoZqr1VCkaMqJaDeQJfY/L
	 O7J/0U0pTl2M4SrphiJ8k1jdDWhkx3SOPPu27D5U/1hwf/JraPr/02+Dsmwf/lRHfX2I8
	 t+poAe9xqrld70tNA93D6syFwWTSpewJSqsZHFNw3kFjx/8s0KnBz+WHcTswfeLzmG7e7
	 81MF72eWS5vIlbw+6umNpeRy+Ev7zk12qk0j5apnlMYcZ7Cu1okciOu+ZcT5b2wFHVuAP
	 CWZv2x+endVOE+IaPCvYEnTNEHfJyzNsNPR+z69S771dKXncuxnPyRaEGyalLvEXj3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PeZnzKHR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D22606A319
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PeZnzKHR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA4C1F000C4;
	Mon, 19 Oct 2026 21:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792444920;
	bh=cwWby4LG4c3NuUcVdk31mt7jh1g9bQGq9PYAUHEdh54=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PeZnzKHR13qBTgUmf7pvY1tFBKyBsp8ylDQU7tCPuDrH3xxRRaHQCmLS152Tf9Aa7
	 OdXnKOi8HTWUgu2LWxTDw6WXB9zdeS5EOByeR9vDEK2I2+RsjORTBbJVMPlABNlMNv
	 IZMSMIqmsy2K1Bm8Uo9Ax47EEyI4fxmU+WyS1PXEaw7wZXFbAEhJavW971m8+6BQbf
	 9Kke/7+SZ+mlZ4YpjvHe0j0G5aUHnfsUqhgevnSokrCYgazzDrYijwe3ZW6dyyu4YC
	 PxM8OvE47LklKnGvEyXyTNoIe5/shaEI66YMQznU+kmoaIHpBsahrOFmFDBUQMdc3o
	 VYnwtKUA/FDRw==
Message-ID: <sashiko-outbox-178233@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/19] rtc: pcf2123: use guard
Reply-To: sashiko-reviews@lists.linux.dev
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org
In-Reply-To: <20261019211827.126262-14-alexandre.belloni@bootlin.com>
References: <20261019211827.126262-1-alexandre.belloni@bootlin.com>
 <20261019211827.126262-14-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 21:22:00 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
>=20
> Use guard() to simplify locking
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019211827.1262=
62-1-alexandre.belloni@bootlin.com?part=3D14

