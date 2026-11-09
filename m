Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794264120;
	b=ZDsa+MlxO/nHpvgRo8FPjKq/uNxJsD8CiAtBEsotqiYXa5HX9jOHJhJjv0G/Myqkm7ay
	 3h4138ttSpVhOdxVilnYSudgNWY5isC/a8Pxiq3BRssq8rke0hF9hpdkaMRD/vip0fMuX
	 E4lK0oEYqPTtjED8KWKH6bXZtXeQy6rRjY+8sVf/taGIzC6tytPw8XvgD57B+0GdWCkAe
	 alrOGqM8a1VdY1lL7scl74kBRi12GElefZJjdPnCYq2MecymUabvA1m2u3fkycMkxc2kb
	 2mXlJcfU2tAKFG5ZI9d2AFPbNZ6Twb8Tq2ksexuvfs1ystrbL9a9D8H1YxQMZo3lmNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794264120;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=l6x2ztObzINydHq9EplVZtQUrVS1W+j0p2mEkfVZP6Q=;
	b=i/C7mb2YSBeZbZQ1pLD5649Ib75qL0aBQO8K6E895VJtDBoCzTITdCK6rIUdSdTEfpYd
	 acWRprMvf+SFwjLuAr21l9eagICU/eATtyZZx+3j8EJO0bvWVLqa1ZQxccwNMc36dgI+Y
	 D8dYYiSlaHXF25zL+WyJ1263plSh/aglA+opMFhUrUScfHnOmo7ss6Hz9jNO/QN2ODgWV
	 FegGJaYM0jkri+utgvLaxNK/Nh2dRIpaZcJ+/zvSa2HRDBcyRFG53dYEKkfaGVIiGihF0
	 N4m7wxMzgh0kZOiokZctYYZ9cQgTlc1E4c493W+ZryioR2AVsQhyWtBW/3pEbdlSmdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W0SSSM38;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55162606A31C
	for <linux-rtc@vger.kernel.org>; Mon,  9 Nov 2026 22:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W0SSSM38
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCA41F0089F;
	Mon,  9 Nov 2026 22:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794264120;
	bh=l6x2ztObzINydHq9EplVZtQUrVS1W+j0p2mEkfVZP6Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W0SSSM38acB4Rw3royjx0VR9ik+QYctzZu9mCIzcz/a9QWYfEz0skTT14hprSw5p2
	 oiq9+o0AWr3tgQjuY0xsFk4mIBsVbn1ZTlGRhjTakWjpT6MXn42DSbM/ySU2FUppK1
	 CT45ZKy5a7n0xRz88RHOKzOlZ2eZCmIw7KelK/8ZKNkfzmbrkOBiwzEFn4tzrNm68X
	 MlQCE0Cdpw4pkTGjHpH4gHSO6pCLwCpvi6ftjZNsIT568VgUbveaF4by91Ods1xYKz
	 u9mqyTrRtWWY+GCQG/Pb4zGyqRZ1go5TVYFLt1gyU1eGt6YbVo+kVH08uEXqNhbCuV
	 L0E8IEcVSssAQ==
Message-ID: <sashiko-outbox-205765@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] rtc: gamecube: Propagate address translation error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thorsten Blum" <blum@kernel.org>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261109223902.84918-6-blum@kernel.org>
References: <20261109223902.84918-6-blum@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 22:41:59 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> If of_address_to_resource() fails, propagate its error code instead of
> returning -1 from gamecube_rtc_read_offset_from_sram().
>=20
> Fixes: 86559400b3ef ("rtc: gamecube: Add a RTC driver for the GameCube, W=
ii and Wii U")
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109223902.8491=
8-6-blum@kernel.org?part=3D1

