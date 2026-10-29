Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793281129;
	b=eapE0S1f9TEUVMMxhOWAVBjhBuyWRl4jaxMrdn8NBxPc9COzExYjaix2RRuwTPaVbGc7
	 43ZhPhhui1bClmFI4my0UL6lnuyAdgV3WsQhvT7WFZeEQpuGqgRRDs623UqajuaBWD8yE
	 Aul1FfDwh3SjaQrBD8L8/bXOA1dnoiah8XWCdrjcTHjvZPlGl/IOEoIg5HHPfZBHQqMN6
	 x3BfcaU7kv208cV8crwPQ5cjNzSeHcNOqPsIFz9JEP4O5E5BumNCsats44dudcPHDf6gD
	 J4nrmwdIqq1LJmxTHofl2D4Mip4/pkZjNbeWUzxUm/vLFY42Jz4LgXJ4Lvh/7jjR9nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281129;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=g+KsBBTyPqELPHpsfUvBvTCWL/ioaSywJikObsyxfQs=;
	b=XUUzIcvHOfBW2c2UZPKQZGsu7JSqHOT+6FXA31prHSeQWin5CfvylgcTI7KXVjWip7LB
	 qBLJVPPI4jpmJ99toBsQFnR5c2Z4WKaRTknmwaaD0W49G0GFeoeoHWWPn1axSe4cb46Z1
	 kT09QfJLTApNcOzwE8j0FytFaYEijTB3V6M9jI9UI7QbgJAyiILKfshyDIUEl+09dBrl7
	 coSLg7TRs1KD90Ngy0Bo9ni9AEfArdI+BmkYPwI0AbUA8wIAaT16nCJmXJ5B+x1ckMGKS
	 vpZ0nIRwEGOHpXp35Q//QEfcDyFtB22ppOsC7UZjflGI3HFsahVwy9+IiZ6hSfe6mLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k4cHcXDC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386BC606B545
	for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k4cHcXDC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0AF61F01247;
	Thu, 29 Oct 2026 13:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793281129;
	bh=g+KsBBTyPqELPHpsfUvBvTCWL/ioaSywJikObsyxfQs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k4cHcXDC86dCxs4yzZC5TtRPxh3Tk8Cq954b70k7P5Ku2P6o2R0yCQv5hxMqRPCcC
	 2+blazAeQKH/OYxAM0zkBe9J9ruAVU5ouXkBt1+FtLuy7zWq5oY5zJ6pkKp293RgNF
	 eXu0BYjfPUrtznSqIRr5DD4tMqx3ETS7R/onIHKEqpaJEcI4AcRDb+w5/uZlgHkqdq
	 OfpjhbXVM34Lf3F66LpSqqdsxNQ9pkeLbcMCpUW0XikMuHgjc264tvhQHtz/rDMc9j
	 Yt38OhLgAmzkMUiT+Sl5Hom+9IEEw3CZBRHH9gOxCwO+lVLSGzfW08v1qRGo1Q/I+z
	 X4HGSdqzm7zgg==
Message-ID: <sashiko-outbox-189401@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/12] rtc: abx80x: use sysfs_emit() instead of
 sprintf()
Reply-To: sashiko-reviews@lists.linux.dev
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org
In-Reply-To: <20261029132339.925021-6-alexandre.belloni@bootlin.com>
References: <20261029132339.925021-1-alexandre.belloni@bootlin.com>
 <20261029132339.925021-6-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 13:38:48 +0000
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
> (autocalibration_show and oscillator_show) to conform to the
> recommended sysfs attribute formatting guidelines in
> Documentation/filesystems/sysfs.rst.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029132339.9250=
21-1-alexandre.belloni@bootlin.com?part=3D6

