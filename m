Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A40415F0B;
	Mon, 14 Sep 2026 21:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789420864; cv=none; b=eB22ssxmATjwPQ0LvtBmlX/5aZDWsu5F/qljdHMJlbLU8hEGTTYIRGzR00cSz6iVLI3EEjAozTQel8KNezPj4wrqqVcsOrEBiM9YsHeWzr7ZaUiHNs8zRL1cgnRoSnjrQi5FLmnzbGPq14dzWq7JfDWZvmMtZqjIyHnLpMGLQA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789420864; c=relaxed/simple;
	bh=fpFCPQLuDCHy8Nc8U7+H+b8lNgQIWwmR3HuGoOc8PRo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GDpVYp3S4w1J9xjFn61GqG/sdIvvYl6n+NpW93iIrMKtmgG2LidipPc8FA1sjFBWSZGz4Q6RKXtBA2si1OXusHC6kxF5h0T93KGMjYR/zxkjkwivBumJ0iijDPBCK+dUf9d27gu+wfk4mafh+nekbQN7Yda98xXVTR1aFT559yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6CgvFMP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6CgvFMP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA1C1F000FF;
	Mon, 14 Sep 2026 21:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789420863;
	bh=fpFCPQLuDCHy8Nc8U7+H+b8lNgQIWwmR3HuGoOc8PRo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I6CgvFMPkBRRvscbWF8JEXpikNgKtZLyRjhTDxveEJ+0FWfnNjTeUQl4IP9JKTeuf
	 M5F3pJD4lrbDCAJdVFBl9+lPSIVpk3YvUCsWDPJxc/h8iLIln1D0c3LDimD+0ly5LJ
	 deL3NAdwK1HXkqIK53/d04lmy9e9jut+LwdSnhgUjLxzxLazUGRzAAeA93uj6lRare
	 VGG+6zR8dMMi0YsQ/ogNns2O75DGbdVB9mrtgGZk8NLB5ybuNXkuSd9Oky0Jnqs8Aj
	 tIU5n2AkOy/Psbz0A8iIRFC8eTJKQMPMLLEimP/xOgCGTMLvXixqhsfiG9oh+oOp4g
	 YQbPqbErE5wJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: rtc: rzn1: drop unneeded 'start-year'
 from example
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wolfram Sang" <wsa+renesas@sang-engineering.com>
Cc: wsa+renesas@sang-engineering.com, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260914211826.73727-9-wsa+renesas@sang-engineering.com>
References: <20260914211826.73727-8-wsa+renesas@sang-engineering.com>
 <20260914211826.73727-9-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 21:21:02 +0000
Message-Id: <20260914212102.EAA1C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> We don't use 'start-year' in upstream DTs because the driver does the
> right thing by default, ranging from 2000 to 2099. So, drop it from the
> example, too.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914211826.7372=
7-8-wsa+renesas@sang-engineering.com?part=3D1

