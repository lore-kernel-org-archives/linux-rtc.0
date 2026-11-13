Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794609412;
	b=AQp3ab2hzlSb5+NOHjTNRBtGvmk/wUK1XiJr3itUdnQED9eZAtdwqN/JolhAcnpKpW0A
	 YE01CScfIv4Wf2vzUMwiTqN9udjGGRJfYyXxJbCL3Lm8AqZA8fYh5PyEFyyLxK+BemHDX
	 HiEkKivzmfwGB8wONBptEfgVZ1VKq2KqmGXYTKOpwc/6esJVFRFscYEnLVIoE893ZA4Hd
	 LU3K/IHX90noMoUOiS4YpZ7lLeqBI8QiX3uOPpr2EMzQKggfma9hRVrRStQkzYnKRNbCA
	 uDyXFShJ5m4PX7zOYlinbuSUkVcH01CwjEpuQBJi/ep3/TmsYpJGfb22gdpTH89rLkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609412;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=olDu0So0KdY+2fEyBq9Wi1zdZ1vbWfXNaNd6LGkMwJ0=;
	b=qHJ2PBZmPLednhn8rnHLaMX0+YpivzGIHrPj1KWLpzcZYd64rFVcHPkECKa7gleODKl3
	 PHdEwlw6B6W2lfU/ipXx7gggg7wAiXj06LJcxg7bltP3w6noZw+EXLmcVFCmNXHe1WKX+
	 2aldIEwpVBWp3IXqyxxfe2U6AT1WZ/STvj6WwwT/arx85mGAm0s6leQ3wRNL3aZDVBo5m
	 iNtjmIaV/jHNuio5VgeSL9+DPlCBlUURfM6fXnH2CpKnjB2ziax2D2AvLydXJTgq9R+LL
	 pAPDrDCai6x4qjxl6AHZCnWWvxhpCxBQSFzditjQGxolKkc/KpTbMK9dZ7Y4whXFjow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HOMro/4H";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CB0606A558
	for <linux-rtc@vger.kernel.org>; Fri, 13 Nov 2026 22:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HOMro/4H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1801F000C4;
	Fri, 13 Nov 2026 22:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794609411;
	bh=olDu0So0KdY+2fEyBq9Wi1zdZ1vbWfXNaNd6LGkMwJ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HOMro/4HCtBMnkz3gZTQ12pv+39p5EmMwQ+LJfpsXiuhlsnvHCsOhgzXszzmCcBUg
	 N8vVV3tBk4u5AbcbwcPScicZqiPv/qqHQTuIZ9d76X38TmVr46uHLpwFQHuDz9CO8R
	 xv9j6m3kJjM2vHxbluAcTBHgw0YI6NiBcV6TIGCCs5oGkzx5wRblplST3wy02OMf4K
	 qrFqEruiyN2N5wzBmP/ITS7P84p/Kktn+67Yl1ecnYMDf055ZzuY8kgRAvl04PnM9F
	 uc/OhBnNiYQD1kEV7x0k9aT9IK0vOiGMC5Sl8j3v88CXMxLIXWtgckzyN+e6wcao21
	 Tj8zVSMHXQWUQ==
Message-ID: <sashiko-outbox-213821@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/19] clk: sunxi-ng: add support for the Allwinner V861
 PRCM CCU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261114-v861-v1-7-eb71ec3ee523@iscas.ac.cn>
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
 <20261114-v861-v1-7-eb71ec3ee523@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 22:36:50 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Han Gao <gaohan@iscas.ac.cn>
>=20
> Add the PRCM CCU driver for the V861. It provides the R-AHB and R-APB0
> bus clocks and the PPU and RTC gates and resets.
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-v861-v1-0-=
eb71ec3ee523@iscas.ac.cn?part=3D7

