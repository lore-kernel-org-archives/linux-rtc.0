Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A5A4D2EC4;
	Fri, 21 Aug 2026 14:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321315; cv=none; b=lMF2EJFsRq68iU8ot3E2Uc4A/LxviRcX0lDAj8TemfQ99bMYMK6kwIrmSlwujd/KdXrdhJ7gSJS+zs5iQioSebRYJ+JF1Fvp9yvyb8C/6BRQBEz46XyERzPKYwOuNT/ikeN+0FOzRqaE2ILraOeo+xHO0zQQVqCSysQ5v/Wct68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321315; c=relaxed/simple;
	bh=iyYUoZhYiWTvmqewdiCKTwa6MofSM0qmSIpXn7K4+L0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I7pnacYaeQKxS6fEDRnNw0WLAYU1WQA3HgaTZAvc9A/70X4t52KzJpkd/G9WiqWO/XEvxCskgUBccxEf+qiOMpBqklml+Ld0o96TF/lmhEny6qdGPp3Nn01iLmMmX5VLcC2sz9dOMtEj/ueSBVRsBG66ZpndznosC45HWnUnORA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYX2OFNp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYX2OFNp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7031F000E9;
	Fri, 21 Aug 2026 14:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787321314;
	bh=iyYUoZhYiWTvmqewdiCKTwa6MofSM0qmSIpXn7K4+L0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YYX2OFNpNHuiOfZpURKoVQmBqfvhR7Odqeq9ZheLv5RZv3zr/Drga9K0CNh9+dFL+
	 UbXGtBDhGI1OMQ00P0Inc2vEFVa4Z2kSsjaBFcw3kujfLfiSi/W2wDU9wJgSofpah8
	 4HVmy+CZCRhOY8//ifwn8cZv2lR1EJxZhq5fG28jULSZ7uCQuoc/Y641q4/Gx6pVa2
	 449WQA69lawtclia53oMsR/zvT4Q1nm4RJvDZb+kmVpjkfq+ffjhU4NWdc50NqwCot
	 fJr+HYKAY29yOm6YWavOUE/GWxEs6yKXM7l8Uip/2pSXs8d+qLrnKUKarYFFSkm2HB
	 sUoqID5WyRftQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/17] rtc: rzn1: Use pm_runtime_put_sync()
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-rtc@vger.kernel.org, conor+dt@kernel.org, wsa+renesas@sang-engineering.com, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260821135608.275233-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821135608.275233-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 14:08:33 +0000
Message-Id: <20260821140833.9A7031F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> pm_runtime_put() may trigger the idle check after pm_runtime_disable()
> is run as part of devm_pm_runtime_enable()'s cleanup action, leaving
> runtime PM active.
>=20
> Use pm_runtime_put_sync() to ensure the idle check runs synchronously.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821135608.2752=
33-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D9

