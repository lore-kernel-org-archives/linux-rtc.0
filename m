Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF8A542816
	for <linux-rtc@vger.kernel.org>; Mon, 31 Aug 2026 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788190249; cv=none; b=PuOrglo2aIDUwYzMKNwL4pfwd/f4tMV0BqAXVuadmyCmck2hosWjzXzWjA9Meu8sRr1taRKxNIGq8KM5LFtifBFlpbb4rjTNlCgo4yAbD+nSw2VB5rLnMIKtx6FzOBqPP7uICf7mEKLOpJYubikAJtiXqz+sBxMcf/TWIyiX72w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788190249; c=relaxed/simple;
	bh=oYKKKQaGnxjGhQS/E9qnr8VgTMFoXvSbxtQ2cODYGPQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q+Q6HWGtSSBRl1bnwlL0mXCGB7E3E3mOipuJs9PZo8yOOw0rSeOi+pfVGUQeVNGKBmAGXXJIJ+U+BVxgIR1kfPA9MRgGOE5gnJU2SyZUC/XzU8kdpThLUnmV1lSzLKgcPzhe9dastPbV/aXddhsGTUYVeK/7YtsPiishIN4LNfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSe0n24K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSe0n24K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19F21F00A3D;
	Mon, 31 Aug 2026 15:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788190248;
	bh=oYKKKQaGnxjGhQS/E9qnr8VgTMFoXvSbxtQ2cODYGPQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bSe0n24KpSo1wcXyeR00UVgNVq01IPcvkRk7TUyGKgqKNqUD/xE6S/8ltod+jZ6dP
	 BWHKR/CSJjVwmz4aSBto7kw4eIo4ldltqUe0RiF7jm9iYn3w8FKQKJxQMJNnGbba3T
	 SC1dfqeZjWo+TCA7cQhJ/RjcXYuVamyGw7f8tE6EMS2VqtV6GmYnXby8gQX8N8Lpnn
	 +6WARpqAbz+uKBVERnZ/xJIArrM0w66Wly3hfGJqBSSiOLyo+dl/9z7f2AMzE0Trm1
	 XSRmoGIq5xSguTQNA/d0yhTQEWumtz1GH4kSe7QeODDYw2eho3qN7nU4BlTMEleSZa
	 Kb4bdz8unXLWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] rtc: renesas-rtca3: Check RADJ poll result
 during initial setup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, wsa+renesas@sang-engineering.com
In-Reply-To: <20260831133314.4125787-314-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-314-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 15:30:47 +0000
Message-Id: <20260831153047.C19F21F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> [ Upstream commit fafb016d081200c7652e84202f8ba5951e659a53 ]
>=20
> In rtca3_initial_setup(), the driver clears the RTCA3_RADJ register and
> waits for it to reach zero using readb_poll_timeout(). Check the return
> value of readb_poll_timeout() and propagate the error if the poll fails.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S
> Link: https://patch.msgid.link/20260602192559.1791344-3-prabhakar.mahadev=
-lad.rj@bp.renesas.com
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-314-sashal@kernel.org?part=3D1

