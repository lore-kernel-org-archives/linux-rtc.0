Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3CD2DE6E3
	for <linux-rtc@vger.kernel.org>; Thu, 27 Aug 2026 02:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787796247; cv=none; b=ufRUXj+YWzvf51ymhyEaa2rCJy53EY3PwBN2SAwtmMhmsxwPioPzblOMN631RWAehqyto21iM8tnJmlSZC8D/MgSd7xc+NSawt/4Uc/qBDYZBri+ZZcwYbMr6WZMpStCZ5l3UA0k0rEVCfmdSvDyjGNaSVOwgfNUkPRilyL+mQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787796247; c=relaxed/simple;
	bh=if8BNexsKmNUYHDyphaDJYq10SwKpoWiwzD3uvXtBYE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CNZmB8ROQfxNktDrdzq8bmVPLnjWxtORGSw+VhkHsUS3YYX6axf5gPHNuY6AjXp9Ejaqd/LFG1/Fu+TUE7bzLS4xHlNR+701FkmRxSokkCk5I0bKplsGNtuVvlnqZQelLNYWEOg4e/bWNdpAbWVggVuHEUbmjdpYE4DmJjQmIDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPoK+3md; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPoK+3md"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64D91F000E9;
	Thu, 27 Aug 2026 02:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787796246;
	bh=pIb7pkSUP7vfQMeQNMAr5kAQSyV01UWX3yO70L5LBKw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mPoK+3md8oMXGQUd3MVDbFIP6nTCRFks/RRJK/nbztn6XEYsgt/vOf5AJqVGHGIGo
	 2DGfR5vCgMMnzeNZPKHsfgJC9OH3aWBFckwsw4tjBEciVNdF4OSFkWNkJh+dl8X5WH
	 cT2cr9ECvujoCx/qzecToAsee52FBphdZhZVLA+U+qRkkYy8a7bShFu3hj5pHoSf2+
	 mh1xGGz8EYgvd/ulTKRAJW6VEzOiJWd5JX6QtKsvh+QnX1EY9KIVbAWOXLiADYjmv0
	 1zsBGCEke1YP7WI+iRB4A7cZ3FYkMOqjeJxloxJ3ZUU1VuyVn6cW6dCdQkRfmhWp7T
	 RwCw7GhxbhHJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: dev: zero-initialize struct rtc_wkalrm to prevent
 information leak
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liu Dalin" <liudalin@kylinsec.com.cn>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <B28B7DE18F3A9447+20260827015444.3314227-1-liudalin@kylinsec.com.cn>
References: <B28B7DE18F3A9447+20260827015444.3314227-1-liudalin@kylinsec.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 02:04:05 +0000
Message-Id: <20260827020405.D64D91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> The struct rtc_wkalrm has padding holes after the 'pending' member.
> When returned to userspace via the RTC_WKALRM_RD ioctl, uninitialized
> kernel stack data residing in these holes may be leaked.
>=20
> Zero-initialize the struct at declaration to eliminate this information
> leak risk.
>=20
> Fixes smatch warnings:
> - drivers/rtc/dev.c:392 rtc_dev_ioctl() warn: check that 'alarm' doesn't
>   leak information (struct has a hole after 'pending')
>=20
> Fixes: 36e14f5fdfdf ("rtc: rename core files")
> Assisted-by: smatch:2.0 [static analysis]
> Signed-off-by: Liu Dalin <liudalin@kylinsec.com.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/B28B7DE18F3A9447+20=
260827015444.3314227-1-liudalin@kylinsec.com.cn?part=3D1

