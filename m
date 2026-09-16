Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D2349AA55
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 21:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594815; cv=none; b=InnhvOfSyzK25Q4rgdgyJLwZZiDxN64953ij5qIocedcY7m0YDYdekAU5vukeA/xI2Z0Kww35dbEHKkvD+WzV9lgf+Rc/qRO3kdV/2O+5fk/DKL6q7AqX3bzGP3ICvEvpb+GfpCzputBjplaaTGX+ccDF8tzkSuigIqJM9r4veg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594815; c=relaxed/simple;
	bh=HuP4ITEBBPQcLMwGXAlmWUMTIXMPHbhCvViH9fU2Nig=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TEcG70BudWdzfkK1mqPYKz7saEO2QefQCqF+kUMb6oABJvLquExWsYNV91jeVrZnCg9e+oI9Te4zdLoU7QqejpnbMnCG4yQYmT+CQNCTZ8xaPIBagr7GIZs5dG23fasFzmzSMrCKi5nFos4uHKnr9YJgkuK3fGGQgVNmFL7fERY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0oHQk9k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0oHQk9k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CDB1F000FF;
	Wed, 16 Sep 2026 21:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789594797;
	bh=HuP4ITEBBPQcLMwGXAlmWUMTIXMPHbhCvViH9fU2Nig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M0oHQk9kbFMImyvFJz5DE0Cw5nbNWoKb23D2RbiXav/GEngKDrqTc7IHZzlUthFNx
	 0UovaZwI8mHh4LOcUU3oZp3DXsT8/vw+lwfiVZZW2aR++Pvr9Fuj6NSv4yrKKvlpyd
	 LbIf1NOfsMvG2MtKFx347B81KX/rxNEZ5xiD6kWqM0T5ZNob98OQSFxPZQcQa1QPdF
	 brRlzzphjD61BabyxnIeP1uv+pcP9sR2mmfSbQ8PQHFCb7yBXhHnyxCCsylsbbD/cz
	 SGio9dkutZKopjp6G6AhM23+LH1P9oabxWzEN8OXn/9Z6vpATcbKsqW1GvAlqhMaqf
	 nSi3TeklrjlkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] selftest: rtc: rtctest: make missing UIEs really
 skip
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wolfram Sang" <wsa+renesas@sang-engineering.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260916213108.9234-7-wsa+renesas@sang-engineering.com>
References: <20260916213108.9234-5-wsa+renesas@sang-engineering.com>
 <20260916213108.9234-7-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 21:39:57 +0000
Message-Id: <20260916213957.92CDB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Use the proper framework call to mark a test as skipped. Currently, the
> test is considered good, only the printout mentions the skip.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916213108.9234=
-5-wsa+renesas@sang-engineering.com?part=3D2

