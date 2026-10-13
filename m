Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F4C3E0C7A
	for <linux-rtc@vger.kernel.org>; Tue, 13 Oct 2026 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791894294; cv=none; b=jKPwDR4/kes3QdW7gdWWnh6TpyG1a1qG3NTOZFP7Ch1MTRKm0v49kPCINEyWPcmN5kYXuP0GzAAI7LF5NAN5/ba3jZk06MOZhG9AIPnKiu/Fg+qJ0j90tRQhRhrucHvg0YfVmqj1bebc2V1kmimhfMXVZJpHV34GIjfhDAL8Gco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791894294; c=relaxed/simple;
	bh=IAyJ7yUURK7gNDZBEiC8/reEfmV6PAcoGVx8gBfWerw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=gX/1ukp1/Ih0FXX6LJjHPIS5e4oEBRVaHNS6f1H0182XdlIUtUOAiFy0UqX4dKWc10oUi3aXOJtstP/myw2Qum3gBscJ+3F/nhJ4SgfkWHrCZixIk48mSm0ocXSjM8ZNj2AN2tNJIDOu248oLKX5WAVX0qikfn8osOzyPPV7+B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+HHgn6h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+HHgn6h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176881F00898;
	Tue, 13 Oct 2026 12:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791894293;
	bh=IAyJ7yUURK7gNDZBEiC8/reEfmV6PAcoGVx8gBfWerw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q+HHgn6h7qMqTQZ8nLxgi8ZiHfeBMTqh+O8WAW/Zuy7W7UbvMcp9qW6iVqzYN4YFV
	 /mkXoMq5YWhdAZIvri60F9I1NnEvHIvKPiIQX84QL9NDtTeI2p9Yg3n2f6O4nYZGmj
	 6YWAEu8rf5zWt3bZi3zckLXG5Olb8BWrz0AvzEIF9eOa8CxyHithZl4m4K5pzMAkpm
	 laNCl3VhqbTdhW02T6p9qsfqNDN0pOoAWUk0++HT6slFgYUMptShR76SDFbt6xuwrH
	 gkuZ6++RbG8BtZ/C2Dgmm39Yl0oI/UZ5bhECEyfKp36naOIL7m8eOcICP0Ax8u1tOR
	 GSK3JqtdxNigQ==
Message-ID: <sashiko-outbox-169704@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] rtc: ds1685: do not sleep in the power-off
 handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Imre Kaloz" <kaloz@kernel.org>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261013120208.11268-3-kaloz@kernel.org>
References: <20261013120208.11268-1-kaloz@kernel.org>
 <20261013120208.11268-3-kaloz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 12:24:52 +0000
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Power-off handlers run from an atomic notifier chain and must not
> sleep. Use mdelay() for the delay before setting PAB.
>=20
> Fixes: aaaf5fbf56f1 ("rtc: add driver for DS1685 family of real time cloc=
ks")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-169477@kernel.org/
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013120208.1126=
8-1-kaloz@kernel.org?part=3D2

