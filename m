Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988155;
	b=ruEvuNWWhjxk5O603/oidAcpW+zUQ90hk0/zfNQ+0xWboizZTjBeXGqU2IMgnH2gsjp7
	 jaUY0JFxc93Sf3KyboFvHc4VxzAcOCJxuIJNLUl3CdzvssvnQ4rlWwlfwrLY9+00c0rFd
	 DO/fS9QJAq7wKlLjtwKksu2I8Qph3Q9peyVF9ofnvVpQuq6nbU92dXQI5ynmdgabYlWmM
	 vxk81F+hM/zAgKRXE8H6m0MPSWw3TjSIewsWqREPv9uPZNiL+QvW89MimrGOB3ZFayikn
	 DDKk9kWMHoNT1Fk+RIcAe08tdCf7CQChhgIi9374hftxfOzKH58ovB+SNMp3Ne0IluA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988155;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XrFPNC9OZvwU0VoZnHyzFREOsYFqsDrERCyj+nkmHYo=;
	b=umQwOkJy2/2dO8k3Xy8mNo8EdpsBPnch4jAiHI/hsFDcJi8tLgHns56e8xxQLM+hC6hp
	 7qhCw34htUElf7nhk5biPj6qaGwqMwNjuDB58E1Nly8FMfgQ5ugHe9sdDWz0Zi8UPSpR5
	 A/DwUX0xel+z0q7dk2CSsiMW1Ptbvc0hBuoPMSdQNJBITZqzeQYVjUFkgxhpS76O8kmzf
	 BXdbvqzbz6gFVBEm/SPKV9e4bX17t08EsxqANzJAyjiv26Q/pZP+61LiBtIzqpn6prpCz
	 RwF4mWHsKTz8vl1A/BZHxLE9g2kM97S+sbzABEhRxPcgnrZYwTXuaHj8t4XupKCTRUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PTqJOMiQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B6A606A326
	for <linux-rtc@vger.kernel.org>; Fri,  6 Nov 2026 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PTqJOMiQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899691F0089F;
	Fri,  6 Nov 2026 18:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793988154;
	bh=XrFPNC9OZvwU0VoZnHyzFREOsYFqsDrERCyj+nkmHYo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PTqJOMiQ1A4jN7kqF314c7qjcacAxvuY/u81jZW2+gAvPzY9Dwro4BrZRRAcAtkrr
	 kWjAyMXdJOiFJDO/Qm+c/xSAbM8h65FoDF0uY3UiKV4PUlb5jGow1gQCp/0pHZkAfZ
	 g+duzsCZ3N7kAs540BGumT/VJbdNpvxCNhfwzil3JELBwCqCNajVS5ftF8XcLezRbK
	 hUQhtfgzi9o89R38gmRNuVPrlBe9qbXr1mFLB9pPB+QB0LhHqCe51GJEPTEnMK0lwB
	 2apxFG59n3gZBAoagC+3V5hVzI9VMJXyBATvh/wDxbFiOOq+wBexB5q8rMylqTbaBg
	 iJ9FMzJerB2Rw==
Message-ID: <sashiko-outbox-201986@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] rtc: Add StarFive JH7110 RTC driver
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?T3dlbiBPJ0hlaGly?= <oo.hehir@gmail.com>, linux-rtc@vger.kernel.org
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261106175600.3877614-3-oo.hehir@gmail.com>
References: <20261106175600.3877614-1-oo.hehir@gmail.com>
 <20261106175600.3877614-3-oo.hehir@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 18:02:34 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: "ziv.xu" <ziv.xu@starfivetech.com>
>=20
> Add a driver for the RTC in the always-on domain of the StarFive JH7110
> SoC. It supports time, alarm with wakeup, and the frequency offset.
>=20
> Signed-off-by: ziv.xu <ziv.xu@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> [Owen: rework of the StarFive vendor driver for mainline: drop hardware
>  calibration & the default time set in probe, use the generic wake IRQ
>  helpers, wait for the update bit in set_time, re-read a time that rolls
>  over during the read, round the offset to the nearest step & follow the
>  sysfs offset sign, enable the 32k counter clock]
> Co-developed-by: Owen O'Hehir <oo.hehir@gmail.com>
> Signed-off-by: Owen O'Hehir <oo.hehir@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106175600.3877=
614-1-oo.hehir@gmail.com?part=3D2

