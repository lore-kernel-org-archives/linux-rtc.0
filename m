Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C04B3CFF4F;
	Fri, 24 Jul 2026 21:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927507; cv=none; b=gaf9xIyKv474dOkKJANoMZ5preQXHTpJuGarur+JCBaTmyzs3ghziO/nG3PyUA2eDcttq2/JlEKGWFhywtzASoI9UqWAeE7Qr/jy1OZO3S1WrzL44oyBGNnuglHWSOkYiOH6nV4Qbwj4QkccGY8A6/fN2tzRY6WwbeCWxo/uHAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927507; c=relaxed/simple;
	bh=0qfl00PGE4mAJ/4fYCxpR2hWyycMjGVUJRW2pNZY3tw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bos+1k5A+UWzObvYxRESRjcQFIsGJ4hXAAVETQJ2L+E2sygNhAx6J4RFiwUxOr0nH5cWKu7h97IY7cy3RcAeinp0G/pUn1+IdHsaXspCpjeFBFFKoiSCDeSgmaRYHWMPon+/7n4WPkPYT45vgilgBRWMjvxDskZgJfYPfqMXdUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fROllaWH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fROllaWH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3171F000E9;
	Fri, 24 Jul 2026 21:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784927506;
	bh=0qfl00PGE4mAJ/4fYCxpR2hWyycMjGVUJRW2pNZY3tw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fROllaWHtmURynlhJEImfLV7AgaWWOFf39i34w4fqGyTYWaHtzA9DG3QcTVR9s51K
	 GWwzzsAOcRUZz5lqSOHpKffrmxIwKXrJCMek/d+vuzqxIGcpjyC0QPr8nJcNYZSeP4
	 CqF5TYAtWPlKzWQVVoMv5JOqJScgPaFoPAyaSufQGqIWDBcIPr7/5hH2NfqlkB0J0L
	 K0+8Nw0DUwjsg/hK4QeRXpAtYPqZNRnxqUhm1c3RBwBmel91M/oLkP1mqLqkni2EHp
	 GoB+VZ4ZUZkocYgtjOPq/b314vK6LKWeyKnLaXe6+adMSaFsvv87jk7SbEbtN+uGwO
	 VbbxLlkFNRoNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] ARM: dts: ti: am57xx-idk-common: Remove unused
 ext-clk-src property
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bhargav Joshi" <j.bhargav.u@gmail.com>
Cc: conor+dt@kernel.org, linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260725-ti-omap-rtc-v2-1-13f765ca96b3@gmail.com>
References: <20260725-ti-omap-rtc-v2-0-13f765ca96b3@gmail.com>
 <20260725-ti-omap-rtc-v2-1-13f765ca96b3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 21:11:45 +0000
Message-Id: <20260724211145.CE3171F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725-ti-omap-rt=
c-v2-0-13f765ca96b3@gmail.com?part=3D1

