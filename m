Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D572F2367D3;
	Fri, 18 Sep 2026 05:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789707868; cv=none; b=N24qeLkr2E8mi4BUner7MgC1rvmEjmgQojmkC//nLYmVEVTWRjyt6pc3il8CzbHalluTESbjsyg4geLzyeVqajK4vpsZiyZNlc0EK9pJVwOJs7FBnC+JWkCRQ9RMF00t+0mlBbA89ubVKxjmQ1OTa+KzQmIu6hlWc1221y+aADA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789707868; c=relaxed/simple;
	bh=nR6pyfZ3jF0P9rscXHGANvnts1kdsr+yHb1qI9RhDYo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s5eOm4M80mH3u4pgqti13+U50yV7t21D5EKpHeDbGcwZqb7u3x339ulPYgtJUm8znBtnR65EcTd00uN4YUFI0KDysYkU3bdyrxDLbpPObAYhLOnaiAwBUqQDl4P+dpsBZASZLXDpYhFSHYcfWZin/Jt+JtoIsaxOhRq171hs9L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6vRMB67; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6vRMB67"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0ECB1F000FF;
	Fri, 18 Sep 2026 05:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789707866;
	bh=nR6pyfZ3jF0P9rscXHGANvnts1kdsr+yHb1qI9RhDYo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a6vRMB67cJsj82UgtAPxq1kihDpHRIqbNbzpd+RNpD+5IVHvgin1kvJgemPiiT8EG
	 vSZzIE38lHMLwtTRqkGkiCy0aHFdvCW6AL5dKWdJ2t7eGZkexaiy6MXciJTLtDGZBn
	 bsqRdQV/wBq4/Z3fh6yCSh+RF74xQDwXvc8XSLN22K08lLEbyMlvY+78WB2mQFF3ee
	 WeR7RHPsCDNw1NYMIwVFk1GkDIrfnaIjV4bA4bsyaD6uy+wdIGLuCk+XoxlotrtbnE
	 FX5Yjhd9CD0+srGSBv7PPZuU/LHI6xVB7ZoBatG7MLdMQMY3Qq9uNni9IGz0hYxvFn
	 DYjIxO5Vv0CFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mfd: mediatek: mt6397: describe the
 RTC's nvmem layout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ryan Brue" <ryanbrue.dev@gmail.com>
Cc: robh@kernel.org, lee@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, mfd@lists.linux.dev
In-Reply-To: <20260917-rbrue-suez-upstreaming-mt6397-rtc-nvmem-v1-1-558b8f95cfbc@gmail.com>
References: <20260917-rbrue-suez-upstreaming-mt6397-rtc-nvmem-v1-0-558b8f95cfbc@gmail.com>
 <20260917-rbrue-suez-upstreaming-mt6397-rtc-nvmem-v1-1-558b8f95cfbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 05:04:25 +0000
Message-Id: <20260918050425.C0ECB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Four of the MT6397 RTC's alarm registers use only their low bits; the
> high byte of each is storage the clock and the alarm don't touch.
> MediaTek's documentation names them RTC_NEW_SPARE0 to RTC_NEW_SPARE3 and
> assigns the first to a fuel gauge, which is what a battery driver reads
> at boot so that the reported capacity does not jump across a reboot.
>=20
> They sit in the RTC's always-on domain, so the driver can offer them as
> a battery-backed nvmem provider. Allow a board to lay cells out over
> them.
>=20
> Assisted-by: LLM
> Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-rbrue-suez=
-upstreaming-mt6397-rtc-nvmem-v1-0-558b8f95cfbc@gmail.com?part=3D1

