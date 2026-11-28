Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795860353;
	b=ZQo9Oif6LZTwu8vI5KPbJ2NxvSxXLXoP5pdzpzKfmizXLTikz26GwwW6jR/haRKEiKGc
	 jpCQqZr4+emnDuExifuB4ZfSDZe5PihfpwXJz3QvXScLVsDynZtVdmVzTkCIsms2xMnyM
	 1S4iZ1tj72HvoTP0i9j2IBQmuEA9o7j4dV7Imsv6r3mLEBnHTBKf7CN9f784ILmKQxE6j
	 WwP3jfn8oj+G0kGhhE57jPS3wOoUYwQp9H4/WqkD8YcOvg/bdEhg0f1Kscc5+DCkVIAM8
	 lqBHKFLjkP6bPuhsaJpItn8KzpFVAu00a2y0XDHyF+D+yqpKBDfR8cxvvBboJ2bvokw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795860353;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7aXgKq69Ly1HMb9y8ATUYVo45UgfWirnsSBvJpqoaxE=;
	b=GmHTIJTqszCxTytCLPiOGOq+FwjBHnW+R0JTken4LeuU+5ZpPwquadKcFs+9f1P4JTpy
	 PxsQHYLmyV1tePRGkY/G3EzVigN/M0wFie76FnPVOerZaZ9I1Zv1rcMw/3aCm8UQ9R0TA
	 KEgvmI2OD+2Fss2gi6okhpdE509ionhK8gnHaXw6YvDYRwZH5elti361uM+dYhTyCZONq
	 JI18Z8+NOx+GXEUqGJU6eVXBtSDAmQUPz4crZJqsanURrP0MncChhn/2H+xAgwxqXfFPN
	 PGipMZpTGDWHMMdqTeLdTOWr8/laAHBjS07FiVvwBgpVs1fTTao/vWop2Mj9gSUwTZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kVRzBM8a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33808606A323
	for <linux-rtc@vger.kernel.org>; Sat, 28 Nov 2026 10:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kVRzBM8a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B4B1F000C1;
	Sat, 28 Nov 2026 10:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795860353;
	bh=7aXgKq69Ly1HMb9y8ATUYVo45UgfWirnsSBvJpqoaxE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kVRzBM8aHmVbcneJP4O5SkN7thc6AJ6xHZS4DUwE7YPSRZRm3F5yeqX4CoDYlzrRj
	 TEdMB6E/5BVDHHdax4xu2Om8CDUUHZCJHj75Dx/EZtmWINBuex7gLMzvs6/LwzPSqG
	 7C59T6r/AZ87A4vFl6Hw8QNlJEgwtUTHTyyNvIcbOy1TZorO8jYHrwE9Y96/eRDXvg
	 DSXGDv7XTv6nVdZSk7abMJsS7nIIjH3bm9vSuQZfds+Kctl4cCREqS5Qa2GCV7lR3o
	 aZE2frFU8QCrPzaXjIntTrBCTsWSIpWLrM355I0c2VnSSEt8+DyJsQ31eyZNPYz4N7
	 XcKK7O83lM7mw==
Message-ID: <sashiko-outbox-238620@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] rtc: jz4740: Register the power-off handler with
 devres
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tian Xuechen" <202300460064@mail.sdu.edu.cn>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261128095638.840312-1-202300460064@mail.sdu.edu.cn>
References: <20261128095638.840312-1-202300460064@mail.sdu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Nov 2026 10:05:52 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Tian Xuechen <202300460064@mail.sdu.edu.cn>
>=20
> A clock registration failure or driver removal leaves the power-off
> callback pointing at the old RTC. Register a managed handler with
> the device as its callback argument.
>=20
> This issue was found by our static analysis tool under development.
>=20
> Fixes: f9eb69d1ae2f ("rtc: jz4740: Add support for acting as the system p=
ower controller")
> Signed-off-by: Tian Xuechen <202300460064@mail.sdu.edu.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261128095638.8403=
12-1-202300460064@mail.sdu.edu.cn?part=3D1
