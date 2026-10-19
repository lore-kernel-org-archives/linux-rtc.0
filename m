Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792422273;
	b=xU7NUTBerXWBgWiZxJLENUgJpOzUuZI/LxvND8wgyvc0R7aNZEn16yHGUKGr/KbFrjE5
	 M1YVACauXtAVOgwR6gKOUEGRCjDYu9avJshtCo1OuQ4pXR8bYMGLb33cJNdzyV9kkO4Sy
	 YLGLUaOuvonWT6+vvSLKpWSnoCzeazBjC3GJzbQLbKZl1JudZX7Dv/nJzu7DMx1oRGb28
	 hq+pzNOTuqdX+jLrA7zvd2h1kEYm1OPMb4WzpNuB+34w7o7Ny2X5tGUO6urn206IqhrzR
	 Y2/GVKG6aeUTTXVtA0A5MLZmyFPcjCxTCWwp+/OiHbOViLO5+FsibSy8KAZ7qXEnt6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422273;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9tQuEbhTMktJo8T1pzFuE/cae//opbb4+Kl0KgZw+r8=;
	b=41p9YeRGY0dF5kQKRSTKkhtawJCyBQufAddaoVP9Pp/uCMAaC3bZDBBJRTZ/WcSeWgwn
	 WACJzTBuk3ErVShLe94P21z+dXCGg1qpjiW6ihbCnVCyaLLFFfpOTzqC5wsm4a2VJXbYE
	 WGPK8mxbsojkIR2Tg/nYL7DMNenfa7tWgBsSH195BE8Oe29S6siUqP4Jfg9QT5jQyL+5n
	 tT/sQauVOd+VNaQxfEAdl74t+TfRJTmLdikUO89XYtfS2Tn2jGHD6QK7tzgp5NjhNZBxo
	 ONR7BNCXY8VpbaSq5/b7OFNNX+BNch874DAb/QqzjMmsOw8+YZy8NXlX9XR1kmYIFRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qe3YTu0W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26235607F496
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 15:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qe3YTu0W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3D11F000C4;
	Mon, 19 Oct 2026 15:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422272;
	bh=9tQuEbhTMktJo8T1pzFuE/cae//opbb4+Kl0KgZw+r8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qe3YTu0WEi4XfOtTZCIvmeEq6cqBq+MJHe+Xh7fyGX/BPaApaMU0IGXYDYVw2DJ2c
	 5kaKxjFdtdE7Xmv9ebBh4FhFae6N6nO656JaDkOLySZLOjYeUCihkifPCKkgnyv67I
	 auuniOKPUqhvYlL7ez9KWc7vrXixwH6A3oMEDOYhGO8hsZTJJBtk928R2PXu3cTelU
	 P8lkIBHhldyCbX/n0RSw72U4O0rLDEZWuvaiN3gN5SJbjlCqWtJBhnJq0aYuz/U3Os
	 63KxvxJBIuFGfIer/ABWpw4EGpuHX0eTHekmNFkK7Xte/b2Xg/Xof8dwmN3qwMO/hX
	 c8TQPUbreCeIw==
Message-ID: <sashiko-outbox-177600@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] rtc: ab-eoz9: add missing
 MODULE_DEVICE_TABLE()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261019135441.1420968-384-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-384-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 15:04:32 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Pengpeng Hou <pengpeng@iscas.ac.cn>
>=20
> [ Upstream commit 7490b8356e52e09c196645912f2c054f79aa5f3a ]
>=20
> The driver has a match table for the i2c bus wired into its driver
> structure, but the table is not exported with MODULE_DEVICE_TABLE().
>=20
> Add the missing MODULE_DEVICE_TABLE() entry so module alias information
> is generated for automatic module loading.
>=20
> This is a source-level fix.  It does not claim dynamic hardware
> reproduction; the evidence is the driver-owned match table, its use by
> the driver registration structure, and the missing module alias
> publication.
>=20
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> Link: https://patch.msgid.link/20260704152528.53258-1-pengpeng@iscas.ac.cn
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-384-sashal@kernel.org?part=3D1

