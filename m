Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5BD344DB9
	for <linux-rtc@vger.kernel.org>; Sun, 18 Oct 2026 15:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792336602; cv=none; b=CfQ80Rkv1ccprRaLeFoDOQHE7HGhxjAbembLe9pUiZji3vcbjv540mPj7DPpHBBvUStgUt68wguI6haNCvKbC/NkzZcOJ4uz10Hn84Bw0p9cudGdSDf1Xeq0LfsMrVZD/fyBQ7z5si8jsMW7KeJuwFJ34yPEmrXzoQiCuYPviLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792336602; c=relaxed/simple;
	bh=lJ5ym8YB2ZL62+38CB2jQUPn0v3tgetbCSviHKGaJFQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=TjpxAhq06pjmQhqG2sjh4BspJrF0pkcHfPZTgfuGU586tHvlCRlZK3MpK+GHgaBiNInR3cqMZUdOjHcrNs+zCb0QraWq4+iKcN5who6ySOmAwmrd1DI9yQTDTrQY6MaOhFoiHZaQmEfY5dh0r9xBkjnuQSWlUPoq1Uk/BD+Vnho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npiZfd4Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npiZfd4Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 228C41F000C4;
	Sun, 18 Oct 2026 15:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792336600;
	bh=lJ5ym8YB2ZL62+38CB2jQUPn0v3tgetbCSviHKGaJFQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=npiZfd4ZxlEmGP1ElnsN0EXrjKYyfhfHOEc6P9DmZqT8Yndhn/ddiAmkxpztvg5Ep
	 ho6v6tItHWhamj80f4zf386Xurg6yrUF4Ep7Cm4UjebNXgIMkGwxjOwt/P+fCq6Hw+
	 e76gjzThkvTCqARIbTGE1+ZzIH2EIwSaKfPl+SBeMpPyAE8S6mO3Cr8C0KVIEBywak
	 2q0YmCpYG7j62X+zQQg8nueptk6fFW/iHoFn6JBZnr3T1BKg83AnyNPdFKxArCtDhe
	 SXNEGY2zfWNuPxpALDGx5XtBksbI4KX92sjqgKMd/FNViFIrvWjkUlMFcg8fyfg8zL
	 lmY4/FmgoEHmQ==
Message-ID: <sashiko-outbox-176232@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 3/3] rtc: Add Raspberry Pi 5 RTC driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sander Speetjens" <sander.speetjens@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261018151056.1051330-4-sander.speetjens@gmail.com>
References: <20261018151056.1051330-1-sander.speetjens@gmail.com>
 <20261018151056.1051330-4-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 15:16:39 +0000
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Upstreaming the downstream Raspberry Pi 5 RTC driver.
> This driver supports the custom DA9091,
> which is accessed through the firmware mailbox.
>=20
> Based on code originally written by Jonathan Bell
> <jonathan@raspberrypi.com>
> and Dom Cobley <popcornmix@gmail.com>
>=20
> Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
> Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018151056.1051=
330-1-sander.speetjens@gmail.com?part=3D3

