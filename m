Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793281316;
	b=LGUh8TvpJ62/kb2gILWc2qpW/o1lHIjJeIv9mfcop2lBBaqw/zD7mVs9LlL5isOlbKu1
	 0bsNmejZn3MYDMzfWr2SbkLd3mxHm5ks8B3SsQQN9YQZ/Mb+HvwjDvJB1cOvpQFhwRDiD
	 Ou7Iavnh9hqLSLIBdZmLbl3wz/mH9t+4xbBbGEr4LYee5opVIfa5ZS+DEz05wXl8Y/EWJ
	 E+b5QE1EFMYPltSJGkd5d4H/9o0Jg6XM6i62AnG88LtUwI77gdV5pK6if6+/JyQ4r4hCt
	 Fu3KPOwlnmuAMij1/ODdGzo2KKxW3g6wwJMaypb7VlxRaPHjGIos/oFLT4gmxT7RuEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281316;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iFdkL6vfFykh7OYSS2suN9CmLWI/23yw0AbuEeN+XIE=;
	b=44D3LWcWJM8XEPdTpLPiZwaTgyJN3zaNVX1pqzJqTdws6z4Gs2YcEO6NJRMMUm9ZDV6i
	 5nFYyM3UNKiiFlxgR6CAlPI45xhDPwlCz4mjIag6RbHV2Fv6HFJivbj2Hv99ULAGX4AJn
	 g301PI1Zc6yypkGTdEX2zLsKypN/7RTb8JttbV0oE24LDs68OTRBp02z/B1D+rRT4PnyF
	 jcPSJkfRfamiug+yxm9IfEVbUOGl4iHqnL41kZJ3B3KUoRVg+E8ghmsEC7YZGXXLcgPUn
	 BbcPpSRj2XP7J1pXZve1BVdox1kW0DK7w60PjoHbN3VEA/JPhcMZaoDQha21dkm+trg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mf+Qcj0L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B358606A333
	for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 13:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mf+Qcj0L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37001F01825;
	Thu, 29 Oct 2026 13:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793281316;
	bh=iFdkL6vfFykh7OYSS2suN9CmLWI/23yw0AbuEeN+XIE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mf+Qcj0LICj5ebbcsmFs6+xEhRXmGrEBrB+VIIQVQdsg6cMLwDjtA+BvPf8TxIX8F
	 Lpf3gBmD1AhNbPlj+BeA3EluC4iU2ZpOW4Kw4rxdiAGvH7zExrBsO5wi1rptpYHtRZ
	 CryBrJEQEDGBVcEHsteckYVD8nKvwkPXCz8ySmCZBMuXHYBRF0sCi9Uj+1HZJumFe5
	 F7c+pdypmQsMqFIa4G86o8gieAKJ9Q5ouNxWecM7PWJTFhgS2kbb0mfguM+ivDFFaC
	 PDR5EsRO6n9k+u2mbkHUtMYp1B3apEuCQXeRuAXr0VoqYeJW+j4qUhJQFOBN3i4pJG
	 QRPtzcl1ds+pA==
Message-ID: <sashiko-outbox-189413@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/12] rtc: rs5c372: use sysfs_emit() instead of
 sprintf()
Reply-To: sashiko-reviews@lists.linux.dev
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org
In-Reply-To: <20261029132339.925021-12-alexandre.belloni@bootlin.com>
References: <20261029132339.925021-1-alexandre.belloni@bootlin.com>
 <20261029132339.925021-12-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 13:41:55 +0000
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
> Use sysfs_emit() instead of sprintf() in sysfs show callbacks
> (rs5c372_sysfs_show_trim and rs5c372_sysfs_show_osc) to conform to the
> recommended sysfs attribute formatting guidelines in
> Documentation/filesystems/sysfs.rst.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029132339.9250=
21-1-alexandre.belloni@bootlin.com?part=3D12

