Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444940;
	b=A5t/NLvAQ2bWmEPHPec02S10aLwz52YhIzf68nN9rEbFDpVjQLNEzsfQyQBAE12bQ3aY
	 Xpu+s3Mi3FtOrIfGjMYcKwD+LIo+8BykQEvMAAfhkQfi5fnjjFyWsbdcKUuP+0IAol6iQ
	 HbChz/lzLpJODAiLDvnRgtcvoDfAu21zXS8PeOLXrotB8TQLKgr7xwCNXbx6P+JDrJ7jP
	 D85pD/NPOAN0ox3mfOYMx7xv7pIt4et8LJzc5n6+DnaN1l5H9tlSNCm5TUrOfOfjBkJqQ
	 fKUWzka/LSNk1On1xnThMuz5Q6/Nrr4BUVkzJ2VAl/i4/iPGGDH3tavVhiPoVJEC04g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444940;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Sk6bWmV43RPYettasPor6PljMROjV0KUpUKFWKIDLpg=;
	b=ofUIJQGAksc/4SZOWefCRPnrOdAulwGQTLpdK72KDqNTIBfQR8fj8ZCSoQtPz2W5z9MY
	 0zzmQPxQREA5gbS0M4k4kf/17oRKso6gRl499QWvXh4r0BCBoxuWjMNjbQoNrNS0qsAPG
	 drhNF8vznUPa17ESNYO6lUpmwH5PJXf6Yn+h8o5i2Ac/w5Ko5L3NvSTjsh6d7L3MF21GG
	 5O1GHGJa9Bw2y60DvVmOG57GZGy790cJXDswWF28Fjb24mFOYW6qG34gGuHv1Q2ShA4k3
	 f7g3bod55ol/4nHwy0ZIqBHbqMoD3mClKev3n2Afx9LO9M95XFLE5xNtOqBTE9PCIrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TLNJDkfU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C53606A31F
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TLNJDkfU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085DB1F000C4;
	Mon, 19 Oct 2026 21:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792444940;
	bh=Sk6bWmV43RPYettasPor6PljMROjV0KUpUKFWKIDLpg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TLNJDkfUnPwGqZMbhd3+Wgfc4pU+0WuQpcqlocXd1cjpwHTbtXUd1abKbC50DTVTR
	 XlqU9MFfzH57u5UH05ljm0uCCbqU0+Cn4R7fGRAuDBXoduiGlIiVQioYffG8kIw1y9
	 P3m6hbgB8XvWTHNdG3vAeHLwIoZvMgGoxnbdSxXSlG5nr59KQfxLhrfyTEmgugl+r0
	 vVQGFfSaJSc+acyzQc0brvKFoXb050XFMQol73IswXOMhOaU3GOd1zjWhQIkl472TR
	 QPVciPiaIEPoGA40DAsVSO13jGM4uQhQFNzDnxpCkov2uyJ7B59CiLJ6DjdTy3iTYv
	 SpkLFFX0A5r8g==
Message-ID: <sashiko-outbox-178239@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/19] rtc: introduce rtc_device.ops_lock guard()
Reply-To: sashiko-reviews@lists.linux.dev
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org
In-Reply-To: <20261019211827.126262-1-alexandre.belloni@bootlin.com>
References: <20261019211827.126262-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 21:22:19 +0000
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
> Add guard class for rtc_device.ops_lock locks. This allows to simplify
> error handling in interrupt handlers.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019211827.1262=
62-1-alexandre.belloni@bootlin.com?part=3D1

