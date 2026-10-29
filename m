Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793281234;
	b=cWLXZ8Op5RB3WWrpyYW20MWKWaiFWmv41+jxpzbrAqwxIb3r4iHw175yLRBmIvZfQTL0
	 RWT3Zo4mj141rbPBW62wnK8k3NlLTLMI2jo2s7oh3YisajTlyDi2NRl6BiLaBnbNwV2fR
	 CzcK1OeWqTYSOJGgNy6THDsJ3kY8U3fBRwxYRWXykuuZ0ZnfVm/AGHNDuDlXmjal4NQo7
	 cz0kFZPUFjfQ0qfClnCmw/ZWBZ/6j64cjKr39QrNgnaUurhI/1fzvY1JIyXQxoUwvF4b6
	 5Yidwlx8cIGUpI3c2Bt+sMj3ELEBQ+PBhmkBBrXLwBMx4BXHKwBNBvoxnVGWLOZ8SWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281234;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=487meQuMlclaTiGXzUVaEeBrDGGG6aJxGqz2KvENtlY=;
	b=wwtB1HsKXZt8Bd0wEmHQhazE2H8cDHXfgNk4W0oj0FHkI7uM9BuDBtbXJVzhUrfHmj0o
	 0+lIhHe4YvdcTtSpgTVjJ+VHCMi+AIaC66EAssXKH1ChC0B/tfs5rY9hLZNv5PAiEXhNt
	 1qLIx2RcsXQ8W1n3p5rbE9CelVjJ4zulOqauMDQwYmgbbqeUyph48kqwjCBy3O7gEyRdf
	 9YjmDHKxiumWCzGqJlf0Lt9QXh47PvE+fGP9ayNB+mHK2+vQxOTim7HsXxMNNhjnAUmWo
	 /p8deqnjdipnvJTGnja/aARYWbew9aTBf/W1X3sGJDBPWHaGDcWwp6GFSAcu7ohfXxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AIER2+1c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067D5606AACE
	for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AIER2+1c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9991F01241;
	Thu, 29 Oct 2026 13:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793281233;
	bh=487meQuMlclaTiGXzUVaEeBrDGGG6aJxGqz2KvENtlY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AIER2+1ch8eJVho3QdXL46j1j9B0Of6qk8gNEAzrltybS0G8gbZ9z80Ab/WxKg0vY
	 3NzICqUHNx49fXahabdySRUwaDLQMxbYMcTZiQkVqmSbzO4rWr3A0evaMJC9FVwmNt
	 QT9B4zWY/CS4QRN8EHbsUveaVYujR3g6Lcb8kEZQJ39Kvnl9M9WJld5YZzahgeU/kk
	 5c0teXsrpym3XB06puoc4kh69a+D3nbWabJLZOMjrNZz6s+f6QG31K+RNN2Rh2ragj
	 OV9FoLzVnsgUDQnwxVllWmdRKOn859aK6Q0Yrve6gV+iUZIdWgkf8btlF6tlfuaBCO
	 LtwahBmo2xJ7g==
Message-ID: <sashiko-outbox-189410@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/12] rtc: bq32k: use sysfs_emit() instead of sprintf()
Reply-To: sashiko-reviews@lists.linux.dev
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org
In-Reply-To: <20261029132339.925021-4-alexandre.belloni@bootlin.com>
References: <20261029132339.925021-1-alexandre.belloni@bootlin.com>
 <20261029132339.925021-4-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 13:40:33 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
>=20
> Use sysfs_emit() instead of sprintf() in the sysfs show callback
> (bq32k_sysfs_show_tricklecharge_bypass) to conform to the recommended
> sysfs attribute formatting guidelines in
> Documentation/filesystems/sysfs.rst.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029132339.9250=
21-1-alexandre.belloni@bootlin.com?part=3D4

