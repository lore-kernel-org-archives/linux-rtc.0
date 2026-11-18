Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794990495;
	b=dYoEnba6kqR0InO23z1n6vYF1Osaq4xaS4BDKHRHDLRqYEMB3Ncd9b8qdVTNYaGPCCDl
	 9gDzePP2J9LLwue0uxFjo0FZumRmozpGijKRGzAeMDFVdp0J0oG3qZrzdkwe9wMRLrEcI
	 ZzlzF3HbFx3zRjTZvaCa5ArRlL1o3a59662vIpe/Or24u9fRrMXl6D9jY2Sxq7i3jPCjw
	 oEakWH4T7b0qhWMq+TfFiFLqoWEDtrdlw2E0vZmdAGI2hbXbNmtkbYNXkbTrp4hb3RNOR
	 PK3MwIpsUQ6YoGp0hmBfpSKcq9yDPy9zNXeoSyL/9ovkfSd6G/++2ErrzSudQHlaNSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794990495;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RqLTkOQUhLnj6xMvNYlhnycmvUGsTpqRbiCbGZRv8Lc=;
	b=lHEfHH9pTNkv9auU1Rz3Bet6QWIW/T4l07nyQXQTZ7yIWkgJ2qwUnZPszh8UXu9p0UzP
	 ZUPLRT9naDm/rX9SvFAC6SEENDcSuNam/mjD0oXpgf/gOyMY4QkMxvsEHW+bewFAl8SjA
	 ZdZAvHhyhOKaMXihhrUIFVbCzvnzLE5uJYPK48QCaW4UCHVwgT7r3he6PH/mU075apbF4
	 s4VQf9A+occkAgV3IDmYXWGqD2wpaYaLXPINu5UFNK4Zxd/H2wrOpIYmwYSJQm2i05KuU
	 4UNggO6WAbqL0mX2gBxAZHYP9F/mtrdxFxHm8txjuw7KAloMVJtMkwD6nFnsm1LgHrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ntvDUOMS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AE6606A31C;
	Wed, 18 Nov 2026 08:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ntvDUOMS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BDC1F000C5;
	Wed, 18 Nov 2026 08:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794990495;
	bh=RqLTkOQUhLnj6xMvNYlhnycmvUGsTpqRbiCbGZRv8Lc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ntvDUOMSq7xBE06JNA6gWxjVj8R6IWlw4PURcKsBNF0aY87v7PIaULNEZzci1PZYA
	 umUVUcRKwUB6p7qAerTpMAuDnXFK1AVi8BGsUPMDrhKQfyevmtFaEA/VV5cjXwCMdv
	 KkpT9IXVJv+sLAfl6UPiYbBurz0kerUcipBQHPj5KmQd1oRRgbH6rmgxrQnbRe3OXZ
	 F6Cfhs9u4ovY93g9A2WBocRCuHxQtyWe+lmRn1UyYYUvzBanmE89XIgfzw8R4FcudY
	 ZP3qGyDBfpielAZq1WMOa/LpSf3V+2KEp0N/7+INjItM68libhGphwHw8DZHKCa0z6
	 J/IGEzGoWOGJA==
Message-ID: <sashiko-outbox-220446@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 06/13] mfd: nct6694: Move module type macros to
 shared header
Reply-To: sashiko-reviews@lists.linux.dev
To: a0282524688@gmail.com
Cc: linux-hwmon@vger.kernel.org, linux-rtc@vger.kernel.org, mfd@lists.linux.dev, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, lee@kernel.org
In-Reply-To: <20261118081625.2399247-7-a0282524688@gmail.com>
References: <20261118081625.2399247-1-a0282524688@gmail.com>
 <20261118081625.2399247-7-a0282524688@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 08:28:14 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Ming Yu <a0282524688@gmail.com>
>=20
> Each sub-device driver defines the module type used by its own
> commands. The upcoming HIF transport also needs to recognise
> NCT6694_RPT_MOD, as report accesses are served from a separate
> register space rather than through the command mailbox.
>=20
> Move all module types into the shared header so that the transports
> and the sub-device drivers use a single set of definitions.
>=20
> No functional change.
>=20
> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
> Signed-off-by: Ming Yu <a0282524688@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118081625.2399=
247-1-a0282524688@gmail.com?part=3D6

