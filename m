Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444975;
	b=KgAdj/QZTFddOx3V2gQ27rtbbjGIk/NV0eO7eISBqe0d9eLpWtitOVhAxu20nfxWYe5i
	 8CqyCe4kQ2jmQeQ/kgMZKemiBr68U9iO4YMWZkOaYnuzSn0YWqMN4FktQC7QfTWNqpppt
	 rI7H7qNC1sfksP1QJjYw1GyMLdbWWVqwdN5X1vXDelToatf97ZtL/EL0E1HjPV02hQe3A
	 0goiaHqn8Vg9jxXM4xzVgiig9Ft1x99AWX4JnrziqsQwUWUVuNY7YihaosFfZx6qa89kh
	 hcxrAmUmzBapI78bzV0SKP+nutuaUljcNijtGLAQj1auyQtX+TSKI2iBsqWvYbCY51A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444975;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NHTpSRUhuyeRs1G4gesj7tVGwj9f9J1aUPuG2YUG92k=;
	b=12dRVBCxlM02C8lM9SWmebUSt5ZAYBVSRWx05ra9cMBo19YrMnX+eS72x2WPxLbL87cO
	 KUUX1DN4ZvGFenpLuvi5gQ37ZXDFk8GJgQEEOaLOPbJ02iAPuzvh9k5DNsU29ahLJWNkp
	 g2/pAnUrRBbDF0r1iBB+Uz6JTyLomVeFmYs239EGLvvbJPz0W2JI61wlSLHXAqRoBKLt1
	 USA14befqCDQ0qVUTnl64sK4VVtIOdrr/5cton0ysooHqvXCDPnhgGaJKJFyqqMYeaxkh
	 8I4as4M+UsMjEjYTpWUgG3nrYeja7ZcQQQUVxOloqmqSyncS/0l7J008ohJP180DJCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bTJuGtun;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE50606A31C
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bTJuGtun
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2A31F000C4;
	Mon, 19 Oct 2026 21:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792444975;
	bh=NHTpSRUhuyeRs1G4gesj7tVGwj9f9J1aUPuG2YUG92k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bTJuGtungKcOHDF0syTpoO/y+/PgRqSq0hmnM5BoerZ+c1tKSw0byjGGzTZk11/Qp
	 vbgXRK8zodz11zj4xv/FSXoiDQpsv23Mn3yA5sxj96/BvUUzMfEggIUQyxiJjiKUjT
	 vMGGi12pAE0/JxJAW1xcNR3KrMGwqPudKXwdgbg0HU7oPvutyiy1GU1/ZI6ta6nh3O
	 rjPBKLYclVa2FuP640rjH0VJjhgG3K9lOumjJRSlyoJp47cQY8g6p/+2DZtmHvM46+
	 yAafxTWOV4bLFROvIIP6R1XjL6Ev2U+ty1jMWnw1chNo+p1Y9phk7uR7MPrHYAzWcf
	 wUqxb/QdJnUng==
Message-ID: <sashiko-outbox-178248@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 16/19] rtc: rx8010: use guard
Reply-To: sashiko-reviews@lists.linux.dev
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org
In-Reply-To: <20261019211827.126262-16-alexandre.belloni@bootlin.com>
References: <20261019211827.126262-1-alexandre.belloni@bootlin.com>
 <20261019211827.126262-16-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 21:22:54 +0000
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
> Use guard() to simplify error handling
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019211827.1262=
62-1-alexandre.belloni@bootlin.com?part=3D16

