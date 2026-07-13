Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DFC33A033
	for <linux-rtc@vger.kernel.org>; Mon, 13 Jul 2026 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950178; cv=none; b=cCbyEfFenWKbrWKNm4sK3X9tjFcjPFMO4UTyvjILfZ/0IP2IoxlG8Qwy2NfVzH0H17Hz/jGrl+xHnIEKG6wb0k3F4M4uZecyHxYRlAks2CXGXTXoLyFr2tGkebKnLdW5xk9pEKsM5LGq9pKj98ICeZ3dzwXsOWqHoGP2s9yYN7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950178; c=relaxed/simple;
	bh=+gBtcuN46PIx3ua/BFmlX6uY4S5iwuZioy+C6XPDr9A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P5d3i7L/4rcg3EEAQwz8HYl1XcTmjiZ4oXg4FPVXxpTlBAq/c+UCwGaN3iMJdyjjGagODWLbCM3fYXIpn2CxExIgYdbpfrW0dTeJcxdMvStJOdwB0zMoI53x/aw8sm4h975x/PJ+pKN1f2msss8J8xyVY+t/71k6JkA0sWYdFuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPU9gPQ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPU9gPQ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0871C1F000E9;
	Mon, 13 Jul 2026 13:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783950177;
	bh=+gBtcuN46PIx3ua/BFmlX6uY4S5iwuZioy+C6XPDr9A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DPU9gPQ/fUAKxbQsbJl4yV2wpAOuomxyjfp/Qk1Ru7q0xEsXQ1X7UrkM3RoiDZ6Wn
	 CU7CY1i31k/wSkmw6To1WNDN3mo9y0oDbv5p8hKtnVtxAtYMg7uwj1okkMi4+ItwI3
	 SCAa+xsSc5Sz4KcAJo76m5yA/FgOtCKvZXs0NyvjFlRbwuCktYLLuLSuQSttiZ12D9
	 7JLgDkY/ItZ6TbNqX0ER9r8T1FRP2XifcPdNjTcUI9U9aB9cSzay8hfZEsiDE6UpvH
	 mL2/FRUk8ASnCTyFK+GaE5/hxRctuKsShi/tXpU+wlsZ2apIJ/lJmV9Jxc1+IyPwZW
	 Q1LMYLYXFqX0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: msc313: Select by default on MSTARV7
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Palmer" <daniel@thingy.jp>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260713133919.1356748-1-daniel@thingy.jp>
References: <20260713133919.1356748-1-daniel@thingy.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 13:42:55 +0000
Message-Id: <20260713134256.0871C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Daniel Palmer <daniel@0x0f.com>
>=20
> All of the ARCH_MSTARV7 chips have this RTC so it's more likely
> ARCH_MSTARV7 wants it than doesn't.
>=20
> At the same time fix up the indent on the depends on line that looks
> like it got converted from a tab to spaces at some point.
>=20
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713133919.1356=
748-1-daniel@thingy.jp?part=3D1

