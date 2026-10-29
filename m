Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793281218;
	b=KqadwnDkwH7t8SIIKWjjcmcavT1ldr/2MCxDK0S5ybZvCwWs7Dt+fb+zQCMoYudxqqq1
	 nqxF7qCUhsKFfOPZgcyjLQrvLcXWPjDMPYuswgf9alVS9XU9giWPinUSytIx8Hfq+5omT
	 arbl9icgqZjGoOE1DzLu99IPRLLFz8EOww+gcAf1SkVaYf/P2llyfyVB+4w+E2pARCGpP
	 Xp5JQ+Qq8FhjNB8VhAbNiAHjcyJlNPFNOlerjqvYov8vQ4m11ZdgeQDkjiPuNdqtEcYtV
	 A+UPYUBqy0fZZLNuwGqTyvp3te81SwM5xKstnY9478Si2YLZTZU6xOhOVknJKFbEBCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281218;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gI1wLwQJWmduGgVDqdaBpLCIaPCkSrvFdWORT61pkLo=;
	b=P1ed0BuZPEW+Jyf/adMecw8q2QYi3bwsg2ZbKoB/z8QJAsnsFi+IwZ6kKcuda6b2JisB
	 V6Cq/MkecIgM3SaKnPjDgJL5FoSKJWSPa0M7caF70grwjdjFsKNihNgcWOSNyPqcIGebv
	 kLIbUQWOBrgYpW71GyPV3O8k7GYlu9pDSNjfGpbRHc0CAa0f2Y8A982+rjQpn2nMnsp+O
	 eS7j+URy6Gb+1xeRBXZzTJYdzXeEWz/5aO3/bYp/+hB3x1UwH8HUnJQOpciGACJhI+b5C
	 DQrhD8DvWrZi2auvfxMJTpYXJjo3QKefjdJE3qJQDqtFwFp5fO6nsdDX92sjKkYmHtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VK7Uq67m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580A9606A31A
	for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 13:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VK7Uq67m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4C61F01241;
	Thu, 29 Oct 2026 13:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793281218;
	bh=gI1wLwQJWmduGgVDqdaBpLCIaPCkSrvFdWORT61pkLo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VK7Uq67m16zHXMXOVwPLgQMEgv8J7FEeQvgwIaLM8gW0ZUZ3v5XBq272ySlRBdbay
	 4vTNfO4DJE5UximCm4OZNSiH9zFmre4VUl3Ef2Ri6tisZGg1TFlOgYQqAkz6sRhHLM
	 YXi/ZEp+qJpGyi4SQC7cjhvpcDV2N2eNtD6A5XNnNqCT5s1jM/SzganP3Li7CHwY9c
	 dPJE7sSwW6pyxFvAdB7rMC/5h63o6LxY0fJP9IL+9mWvwjAweOAOB55V1QIPzZtZRe
	 T9lmffr1SYCVhDbFlYMoq1KhqVKlpkBf9FRuuwkLsHTGJ1lZ5U8BEqRQ+jpCnZlW7q
	 oo+uVn7vjNaDA==
Message-ID: <sashiko-outbox-189409@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/12] rtc: ds1685: use sysfs_emit() instead of
 sprintf()
Reply-To: sashiko-reviews@lists.linux.dev
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org
In-Reply-To: <20261029132339.925021-9-alexandre.belloni@bootlin.com>
References: <20261029132339.925021-1-alexandre.belloni@bootlin.com>
 <20261029132339.925021-9-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 13:40:17 +0000
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
> Use sysfs_emit() instead of sprintf() in sysfs show callbacks
> (ds1685_rtc_sysfs_battery_show, ds1685_rtc_sysfs_auxbatt_show and
> ds1685_rtc_sysfs_serial_show) to conform to the recommended sysfs
> attribute formatting guidelines in
> Documentation/filesystems/sysfs.rst.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029132339.9250=
21-1-alexandre.belloni@bootlin.com?part=3D9

