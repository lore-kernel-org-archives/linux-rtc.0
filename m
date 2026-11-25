Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795597967;
	b=e0SPn5RaJQ1E9sT/7MX1VLs+Gm93WV3QWa7KNbeQBIvemPUSt5rCR6e59vja8tZOczue
	 S1mdV7lF9d4zV2avPGxKh5VLvsHuNiDHhDt9X2s6gVe88alfKl7+ZJFImPQNTkIjKmvdR
	 8t3B5mxGmh1CG1oRcMGOINXmiSc2Y3tYBWaBA9KDlgk01I+zxKnMvOlV6bI03TFigF7n/
	 81BRQl16txvGgw/5sKNlSUG5w3UqVedG87rwIrK6hC+C6iaLDVwp6FLF6dIevpgIkp4kc
	 11emJGJKJGlzx5hGcKIY5A895FqptX3IdlQmVkJwRafYc4Y2lrQJmoh07EwXbDbVhDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597967;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cs4bzT1dwsOP5t5P0gJHXQamrkRkSzbU8bCKJJvy/yg=;
	b=IW9DvPjE5Be4Khq7KBcH9R6ZoKBouikfyb36TGMs9Lw47MnJsf5k4hE6X4SGGsyILHM7
	 ++rz43gSahps1PuwZYCZSYb1QHqz4l3wsliGqfI7B9jRZqBsLu5U1UTY8No26TIiLc/1V
	 DJ4D6eluZBbHejBuST48NpfScPstGRBkH/DX/wSXfrDadIajxYGOT+rxp4Y466E+St8C3
	 TboJYIdIlnznvvsB+dp+HWNftMlWLdWQqx9gYq4uYJ0ttgnQjMZzplf/t/rc7QH+5G/QA
	 PIlEWGD2RwOpz3+YVGBDfivHoEHw+p3//eO6nepu4rI2V/roxzQvldCagASyCSYE1Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MChWobpr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84318606A334
	for <linux-rtc@vger.kernel.org>; Wed, 25 Nov 2026 09:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MChWobpr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB6D1F000D0;
	Wed, 25 Nov 2026 09:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795597967;
	bh=cs4bzT1dwsOP5t5P0gJHXQamrkRkSzbU8bCKJJvy/yg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MChWobpres4J9ESnT+a6i1ZnJQLU47gUJqZj05AjvaRvqhsWf8iLCtAjIaTjbnVe4
	 AwRBVRCwfb1aVm1hnH5s9lD2tHMLegq1MYkW5CIAwK7F7o1uksmPqu9zmzw6GAEXRd
	 J8tYzghVq8OFRxCqFmMuq/sU36lu3ycNb0uxLtgraGVrtZ74u+pgGtca0qi3RZygQ5
	 s3YuKRSZ6qbJP1gq1mYGMlcK6asmdgdcFQlM/4qnacBnAFWx/67qv8ZTwHAZTrJR9K
	 DeiURssXAqOBcf03NyAHtTMYpRWRnS5+73mMSatl37f/9J80KdsAlJ48zXjMvHF1uC
	 b5Zze/EIx93Zg==
Message-ID: <sashiko-outbox-232976@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: isl12026: Fix EEPROM dummy client leak on probe
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yige Jiang" <yigejiang86@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <rc-b1-20261110-vc-22-300211a8c5a0@gmail.com>
References: <rc-b1-20261110-vc-22-300211a8c5a0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 09:12:46 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> isl12026_probe() registers a dummy i2c client for the EEPROM at 0x57
> with i2c_new_dummy_device(), but only isl12026_remove() unregisters it.
> If devm_rtc_allocate_device(), devm_rtc_nvmem_register() or
> devm_rtc_register_device() fails, probe returns with the dummy client
> still registered. Every later probe attempt then fails with -EBUSY in
> i2c_new_dummy_device(), because 0x57 is still taken by the leaked
> client.
>=20
> Use devm_i2c_new_dummy_device() and drop isl12026_remove(). The dummy
> client is now unregistered on probe failure, and on unbind it is
> unregistered after the devm-managed RTC and nvmem devices that use it.
>=20
> Fixes: 4731a43169b7 ("rtc: isl12026: new driver.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yige Jiang <yigejiang86@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/rc-b1-20261110-vc-2=
2-300211a8c5a0@gmail.com?part=3D1
