Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132483A9870
	for <linux-rtc@vger.kernel.org>; Sat,  4 Jul 2026 12:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783167727; cv=none; b=JFf5nW2alZ6YDGOsJJT47kwJ3oCaRJYf4CMjj8hJQhpnpCm4zcSU1HQQ9aVoRJTvMnIjSeY2liQQa9uZFc0g4tUCQcoYoZI6awt7wIpdKrV3K5gQdaInhzR72yfs2Xuf9CoPU89w14xhEz/7iCbBCP9gfPEt09k3E0A9ZYcGDkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783167727; c=relaxed/simple;
	bh=NCTxmMwuntF/RAhK3+MqCzaBkUkIEr+jqRs2IejIpU4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qf5X1+IpnaQiXT/nlXNxO95RDGJDkdrpt/ctofrOy86oekGBD9mN5PdSZkF8KZWQaTm6SRiSxFE9V6KnR9uxCd/S6fLRzHKt7LpVG1oT25R4DCKbsSVhHvolSr1drxaNPYfZbRmRYl3pNDmuKdy7gUZbLblkzYFHSd34737GbPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H82RClCt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H82RClCt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214BD1F000E9;
	Sat,  4 Jul 2026 12:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783167725;
	bh=VjmDhzavK8qwgz9JRjUvLejViy7B4VlwEF6NLtt/AE4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H82RClCtIeDqRG8zzMh0HHLyernhCWURr7Nci7/YbhDNPln9If7k2EZnELvJ7/Wzl
	 GcOEIe7QcVnj0uTS33qF5RfQXU1mEswR9LUTGQycC7ZvDbDAkW1ePQEpIr8Fi0WKht
	 skq0XjHJ9dLMDqfVE4o/5mu7jHEs0HQ2dczuL1alJy1LxveNd/F0J9ATaENZjrqRsL
	 7iqIgjDzvzEe8+jetPnM1YvH4LqNzrQ8xRwvm4MR1FpIJBUhpXgaSvQZvi90TqqE7l
	 Q56bQkGtHQx9gvj38ucYFOBl1NVBDwJZVqYwYrTO0x1+1eLpESsPUy839juJ7kATHP
	 9BWUCXUbPBHsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: s32g: add missing MODULE_DEVICE_TABLE()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260704122003.70108-1-pengpeng@iscas.ac.cn>
References: <20260704122003.70108-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 12:22:04 +0000
Message-Id: <20260704122205.214BD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> The driver has an OF match table wired to .of_match_table, but does
> not export the table with MODULE_DEVICE_TABLE().
>=20
> Add the missing MODULE_DEVICE_TABLE(of, ...) entry so module alias
> information is generated for OF based module autoloading.
>=20
> This is a source-level fix.  It does not claim dynamic hardware
> reproduction; the evidence is the driver-owned match table, its use by
> the platform driver, and the missing module alias publication.
>=20
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260704122003.7010=
8-1-pengpeng@iscas.ac.cn?part=3D1

