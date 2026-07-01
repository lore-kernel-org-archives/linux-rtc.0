Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212CA3546FD;
	Wed,  1 Jul 2026 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916780; cv=none; b=irPYXLJAwzGtlIM7hW2CZ8nx7EGrsO7z1IKhb6qnzB7IF4IfLrXhwXd9hBDapLjqDbKOlNxQYXcy//mrrBqDyWU1QXS7HWJLdVCZA43YjTCbpolgdckt/0Dj7b2jQi2MtbLNQc9eBVtsCdZ8Et+W45pVGQ9lxzQ08GKkgUxLeuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916780; c=relaxed/simple;
	bh=kGZ4DeEPUn25lmvhjveDY8YV8kYFkNGO5JF1h9JIKQo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ETDX/DqK3t3D3qwr4tTbtNXM2PpwvzjKNd2SnkSM+HPhgU7e3XkZ42/9kgsEpK3Xy/8QlTq7Rh8ds1IxTu+gB31JhHuopNbjwtOhR3zLP5/feDtylGx+n+biHG7fYYPdDAfFPIpTHA3mNSBrdNZ+kby2Xpipu1CBHVf3DoP0S8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AF/tSh0a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AF/tSh0a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27CC21F00A3A;
	Wed,  1 Jul 2026 14:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782916778;
	bh=kGZ4DeEPUn25lmvhjveDY8YV8kYFkNGO5JF1h9JIKQo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AF/tSh0aKs5BJZJftTcyXA5rv0HJyWBbNjHRLDB1x9S1bXnapkamStoYT2eR1J37z
	 9hLm+YpWaBB3aeLynL7b/nwWABoLgWito7egSMxukxtFITlxycuDTiuhArsZxptoE6
	 gow9AjxDtN71DoAWhp6r8ZQIgZRrlbKNmaYP9RFtLb6E6H/p8WmRjqoy0lMdg73VLN
	 7Ao4YaT9uzcRhqLlC4k/l4FDp5gTKUTADKDn0Vpm6BMpDSDDtObVIoF7OLyVmeyYA6
	 guhV3MRk4OAVfwILGjrBNkFmHzRZEsCyuJs4+RfdsK6elM1HV3ayFsXzOC5fasSG0F
	 IkXl9I1hnZ8iQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/10] rtc: rzn1: Handle EPROBE_DEFER for optional
 pps interrupt
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, conor+dt@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260701142953.2014895-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260701142953.2014895-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260701142953.2014895-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 14:39:37 +0000
Message-Id: <20260701143938.27CC21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Check for -EPROBE_DEFER from platform_get_irq_byname_optional() and handle
> the deferred probe request properly.
>=20
> Although the "pps" interrupt is optional, an error code of -EPROBE_DEFER
> indicates that the interrupt subsystem is not yet ready. Intercept this
> specific error condition, assign it to the return value, and jump to the
> dis_runtime_pm label to avoid ignoring a valid probe deferral.
>=20
> Fixes: eea7791e00f33 ("rtc: rzn1: implement one-second accuracy for alarm=
s")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701142953.2014=
895-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D2

