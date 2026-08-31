Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDDF41DDE1
	for <linux-rtc@vger.kernel.org>; Mon, 31 Aug 2026 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788187290; cv=none; b=ukpGRS3d9U3wy4GsK5gN9kldVtDexfO1eHDItDEH0A3AvYwJGRKZWDiwer6fzTOOkvyk0fncYXVt056QAEtw+yWIFcjoN7exnJYqHuqic6k2N51UI4nzQ8YDkskffUN5fYR8idAa8YUJndLdZSF8tm/2FCmrXVX9fNsswXuW6GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788187290; c=relaxed/simple;
	bh=kJnGbw2BENlDa35CuBBOM5PCcFef9vfK7SS6I9se1s0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qLcVY05RnTEoft0fQo9rAsuabJj76DaErBX+2zgIS0qZ6eIGOiaa0JFV68rNTBksRG0gl7V7FvDfBKpMGo2kNtonyfzIYj9ClOB5LQE9lcJ1nArpsDpIQcN0gemIvOlQuhOImkmE/7xkFGhfKd508TgobDxYYJmr68so9+mp4go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeXBJYbb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeXBJYbb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D79E1F000E9;
	Mon, 31 Aug 2026 14:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788187288;
	bh=kJnGbw2BENlDa35CuBBOM5PCcFef9vfK7SS6I9se1s0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VeXBJYbbJcYZi/DsdBn3+INkmUKmmRWAGD3L25U5nWI54Bp6Gbr+Hj+k8+RYjKrwE
	 QAR84avpGfWWGVSKHbZhnp1FNAyKOajbUURU5UmXwR+k36wdYQ8WtKXjhcKpsw096s
	 Ect1bEngyRlF1BIQcGZJjS7Dle3uwKkWrcbzHQQOXRrc376Hu0mlGEdU0497vT/Gd5
	 6rMqmfNRr9SZ2NvO1zEAIMJUdWKD7mnWxkBZORrLbeAnAFuNMzMRzj6YIiWVazajdI
	 +WkFhmL8NfbzoU0KnnJwc1JvFvX7/5VwrFWJDHXDLaK4/BYgUmQoU4ow14QOhb/YW3
	 FeJbVZhl+qCqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] rtc: aspeed: add AST2700 compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260831133314.4125787-179-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-179-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 14:41:27 +0000
Message-Id: <20260831144128.3D79E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Tommy Huang <tommy_huang@aspeedtech.com>
>=20
> [ Upstream commit 3319cfeeb8c4047026f84df045c438f7bbd338a6 ]
>=20
> Add support for matching the RTC controller on ASPEED AST2700 SoCs.
>=20
> The AST2700 RTC controller is compatible with the existing ASPEED
> RTC driver implementation.
>=20
> Signed-off-by: Tommy Huang <tommy_huang@aspeedtech.com>
> Link: https://patch.msgid.link/20260601-ast2700-rtc-v1-2-15d4ca46500a@asp=
eedtech.com
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-179-sashal@kernel.org?part=3D1

