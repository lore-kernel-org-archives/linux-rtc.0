Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0C750EC04
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 10:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789554709; cv=none; b=tEbnEoixvVWhhsN//RsR3n0CFpSVV5AxYUyMHbSoDsX1CZXnxL4EyhdUeVlHMAXvMkx77x1zV9ol+qwAOkD09tMrrZyQlbH4TWDhWUzet+6/mhPlUH5AAM71DglQpu4UGH8l7nHhGgWe+WoqUf9NzEKmCC7QhL7HhXXoqXRu11s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789554709; c=relaxed/simple;
	bh=y6lRcSbwjZE56PiQWSaavloPX9JiSUHdsGHJeTPvx7o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L89uJu79i/D7bGLY9EGxntDQVUXZt1jCl57Y7Q4HHXMyIX4Y4UwxpdaCW6BZDE71Zypck7teEmIakFMfurUWHybWOCjrcnsXlimUFjV7fm7wF5ApxdnJt2lfumNUT9cCKR64vOIv8nP/LOxyEiJLLegXm237j94tEMLuFb6nyUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYgcXaS6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYgcXaS6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6831F000FF;
	Wed, 16 Sep 2026 10:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789554688;
	bh=y6lRcSbwjZE56PiQWSaavloPX9JiSUHdsGHJeTPvx7o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RYgcXaS6ip7diAMXoG9xgDdrxFcINfnjbdAHdRwa8OA5op9j90nASyuLdsS4GVRtd
	 Srjvinogy4guNNch6g1sZ0VqbJv1sn3kHZcqdNFnszkJdy4Zz2J+Ni35SYBrxKd3t8
	 g5ixi45BVS6KRqT08PCq6CFH5WRo09BM4IxRiIZTRoS5B/tAI9IR41CYA+aPWT0nEX
	 yZZwwZK/6H+4F2A97smuU2haGDOueJYngUm1/MgyrefiQy7HDDGiuAyJyAS7+cG3Sa
	 lh6gvZh20x7jSCCO+0onOsv8IFCv0WlCc7Xem+lQaEpIEtDgLd1o4dB4rJW7rhSOgF
	 G5SKfqgCjuu3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] rtc: rzn1: add R-Car Gen5 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wolfram Sang" <wsa+renesas@sang-engineering.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260916102520.24288-5-wsa+renesas@sang-engineering.com>
References: <20260916102520.24288-1-wsa+renesas@sang-engineering.com>
 <20260916102520.24288-5-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 10:31:28 +0000
Message-Id: <20260916103128.6E6831F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> In general, the RTC on R-Car Gen5 is identical to RZ/T2H. X5H is an
> exception, though, because interrupts are not wired. X5H2 will have them
> wired again. So, skip alarm setup for the X5H case.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916102520.2428=
8-1-wsa+renesas@sang-engineering.com?part=3D4

