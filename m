Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCFB46D562
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 21:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594368; cv=none; b=LWhQJCllgiKcV3E4NpdF6aQEPfD0WTt3wi+EAPOr0yNtnvaypyJ+7YWblubRfH9pW8J2Hi9pmXj6dibj+8H1WN91AiW/AZLODjO/RSGPNujCcQ8YCIz2UuIfh/A4lRQqEA3ATrYyjoWnTZWGpGohbo9sI4OMJobLnKeJ7v3Z/vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594368; c=relaxed/simple;
	bh=0fFsQEDtDGd0qa8Ivu+nOwWT5Hxm7gWAEwuHMLpp5ko=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FwukX2oub/7hfgNANPqoPu+nNwbORztG7A5fj5zDP9sG6/0Qj2+ZAhmh0sZdiv4jF1N6r7nuFG5hMtg+Mf+WTpiLbfwz4MQ1zla7f/VKzZf0KbwHMyXW84THejmYC06H4hvzBk6eBZ2i4SZYjYe1Rk8EnjhCOWyo9cRnx7d0olk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9Uze6QH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9Uze6QH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7B91F000FF;
	Wed, 16 Sep 2026 21:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789594358;
	bh=0fFsQEDtDGd0qa8Ivu+nOwWT5Hxm7gWAEwuHMLpp5ko=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L9Uze6QH/OGK5SPBP9ESOz2FQdMmT7V7KusCm8bga0VOv4uALa+sjfnMlwkkj6CNB
	 ogkRLuz3KCwmMdPEK1U6cB4WXMCIrirs/rbj+t2lvquAbiD7ILHifQgU9OkBnfwGyr
	 OcP1631yySRosaVZ3tkwGhKvHaeTwAY51VVbjWvM7EhQn8eqou/VuT/BA3TmLZQqMp
	 rKxszbV3pl1OhGeezN/eO/4U8mQ+ivbhgnoD6mZT+uNyY/UpTFNw6IJ9TNijPRob9G
	 BD7Xaot0DIScOjnC5xJHVcikLVxQH2GE8PHVYHgXuxddNSK2sar62fGvhZ5tVQ2uaw
	 fKKZPUyOo+NsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] rtc: bd70528: properly enable wakeup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Kemnade" <andreas@kemnade.info>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260916-rtc-bd-v2-1-ee5c15937d25@kemnade.info>
References: <20260916-rtc-bd-v2-1-ee5c15937d25@kemnade.info>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 21:32:37 +0000
Message-Id: <20260916213238.1C7B91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Wakeup on RTC alarm now only accidentially works when wakeup for the power
> button connected to the same PMIC is also enabled. Fix that by properly
> specifying the wakeup irq.
>=20
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-rtc-bd-v2-=
1-ee5c15937d25@kemnade.info?part=3D1

