Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795527839;
	b=m/6zlCkz1EOJ0YR7nuxqMvpAPRD9yJ0GqdIATpuxvc2tEfHUxMmjm2xNo7FxYNq/Mp+T
	 fs1a5AJymexFbMCHjP697mJgBY1R3C1j/TD+IPjOI+SQMFFMFarfOXfIG1Z2rDSNs9AMb
	 AHxEgSGQvlgeAkPqsuiTPFm8a9qScyaqtsxmgm1PcWQw8T4DhJohzBZLMJX613bh0uxwh
	 fPE885w9R3NFqiBkjW4ZzMvzO2g/mBUdrmM1YG1Sf6VLmiM3ehYmrhZC+ojmbuSwG1SVu
	 nwelXLm2sVJ1IXa+Ui2jeWSrPhpD5F0TtjKIZAagBmXAa1ywruMbhJSbX+DMz3lweSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527839;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RqYFy5f0eLa+rfDcu0HWBDnDriE7qHYbEIjxatxV1TY=;
	b=tvLlvJeTDzxwodgzQx15uxzBZYNXDMxlNhyXLbKFg2eM2U0NbhFV7hQVbwf1PKkz2xtu
	 LHbQxneM12KVDAd4gw30THhs49I6FtxH52xV3xXrovHLQLnqRg3WmOy0qLYxzHKbDfFbM
	 RTgg4e41rKtizVL37gnQQLOTPYn5jx30RCdCwUtcAARw5fawYj49U0GSb4aKx1mD9R2RY
	 BmtpHMZRKVRpVzEVa2VJuF1vjnAIPwoqpMhk3A20IN2CgHLwirvLHxV5IxqhkV/jO6xXD
	 fDo1KclQoqfApOdDkgZcaRvnzief1+b9Lu0XEviy5y8z9xV43o+e5Dpi+Q92UlS0nwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=omY6v6yB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64633606A321
	for <linux-rtc@vger.kernel.org>; Tue, 24 Nov 2026 13:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=omY6v6yB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E381F000C6;
	Tue, 24 Nov 2026 13:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795527839;
	bh=RqYFy5f0eLa+rfDcu0HWBDnDriE7qHYbEIjxatxV1TY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=omY6v6yB6b75vmJPifX5DcPdDnr9bWybLUhBHzQ5upAhHm5lEi006NSJhAvdDeGzF
	 7sDm5dEXsoMv3H7zRJBO/JD8NJb/INsTheWKSDpqNLwl0VUILgcgeB9nDrjrDEX5Z/
	 MuvtJt/jp14VDtydqYkl+cAK6HIj9H8fQ2wSaocGGj2eISpvi46NSu5PaTLgsJ7s4U
	 tju2KMpuDjb/m/K1GuYZ3NKttDKgaelL5d21OKTGATPajQKVH+QDAZlFNBRESzvnmD
	 vJIQHQ0O9GXIWjIyyaswmk9icX414QFJhrDyNxPCsWAFD4nlmoQrwkr9oqNnfx5+zk
	 1JvFiRD/TgrOw==
Message-ID: <sashiko-outbox-231241@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: sd2405al: Fix BCD encoding of the month
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thorsten Blum" <blum@kernel.org>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261124134110.237481-2-blum@kernel.org>
References: <20261124134110.237481-2-blum@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 13:43:58 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> The SD2405AL expects a one-based month encoded as BCD, while tm_mon is
> zero-based. Adding 1 after converting tm_mon to BCD incorrectly encodes
> October as 0x0a instead of 0x10.
>=20
> Add 1 to tm_mon before converting it to BCD.
>=20
> Fixes: 5af858acea22 ("rtc: Add driver for SD2405AL")
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124134110.2374=
81-2-blum@kernel.org?part=3D1
