Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444915;
	b=4F1fgKiIT9FEQ9nVb06pYZEBCtIUayvV1r25vRABB2n0zPV3tyyngsOs3wCzyoC4urJt
	 zCqxZKv4X1Dhj8zv/yZGReBkJvzUH/oj0OGaPQbGrJMFoW6Ro4vW9aseV0KOtC4GLa2vb
	 b1XspaFCfHA0HmiZs7vKDKFVHzVzrB3uFqBruWHtFJseCvNvqT4UhBtgh23sOsxLOB+lI
	 T89m5UDodXnPdNdcQBugg3556vofolAKcQ4gOo+BZzYP1FHaFTo42UtA09Cxs0AeOnMfn
	 nkFnxHkl9NUz2NmktRVjZAijGCK1bDi/r7oyqU3Ea5K8/zZIKZIXKWb2TcZbX7Qcz2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444915;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=snfrbJeCXQ//4r8dhEjYy5mf+5utXgdkNDKmeu7ykLw=;
	b=0AQ0ZlAwIyJsun26bCtybDd0Y/WznrfdEf99If5BP1ymmEyXq4H681+AoldRwvxak1Yy
	 3H4YwKxTv+bK4UWcCfH3OhiJusv8eTPcGHJGH8uxG18lDc4Gjx3aRC4+eSX4em1HbJEm5
	 uCNhau6MZ4WGBq1w7U8dZwVVCYxv2xe/mXoWzZI5EN9xJc/NzTs6nTKI89SyXRcholcd3
	 qFm5ecSLMsEsm73UKc0KYeVwFpZEx4moacp7lD2E0BIjKjqnotvcIOHwxUZcCKh8uQZ5n
	 AJ/bViIoC5DHeCNY7icULeM/F1teO2NAHgDr5Imsb1PAlMIN2mS2FObw4v9VR2gMDTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Snkp6ZLK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30641606A31B
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Snkp6ZLK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9E61F000C4;
	Mon, 19 Oct 2026 21:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792444915;
	bh=snfrbJeCXQ//4r8dhEjYy5mf+5utXgdkNDKmeu7ykLw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Snkp6ZLKZH4xTlzKed1qJCmpAn20nUfhkVWFgLQcEtWnUBCv+cYxgPyEzkQQlEnIf
	 7FEXvsTYq24omNRkw3I1/GQwNK2BrVpEivQ2hCOYzZwh5u7uOOBZGDkWCzyhGqu2yU
	 LTxRtNY356OM67DSdnzDpVtAYTo+H4se7DurwUGRe2Gxi8aD+TmsvUQvQ4u2PfSAdg
	 vdyNGEy5Eh2vgcoOxTpFesajRaS7Ov2YLT9xrWaLoYrTpQ38lGWIGH2E9z3wjA+zX4
	 rHMTU4QFS2GP1UO0gDrJqKLGKeZOKh3n85E8BPJQWHHU7lkEhwOkq9rEr25XeEaj6/
	 TvRG9xrTO4keA==
Message-ID: <sashiko-outbox-178232@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/19] rtc: nct6694: use guard
Reply-To: sashiko-reviews@lists.linux.dev
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org
In-Reply-To: <20261019211827.126262-13-alexandre.belloni@bootlin.com>
References: <20261019211827.126262-1-alexandre.belloni@bootlin.com>
 <20261019211827.126262-13-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 21:21:54 +0000
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
62-1-alexandre.belloni@bootlin.com?part=3D13

