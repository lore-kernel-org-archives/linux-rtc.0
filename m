Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A58E3CB8E3;
	Fri, 24 Jul 2026 21:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927164; cv=none; b=SSK1v7KQG7KufJbFsI7g1Cm6tRt4FpEYb6/MFZ8+OzSOgAKMt53BxARIGXajT8pz2WbYeAp+ff6YxPLAeX7qPW7Uj6MxpnTtUJ/u/czKcFKtcXO9U6Ac/mwTcYuL1xtX3UvP41WNquY7LzZJVaDh4VKbBRCHTelkDP3zVPd/MIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927164; c=relaxed/simple;
	bh=+6mHMDW9d1JS015j2kr84nZel3osP5Yb1gQfS1U5lTc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nHEcYFsUrq8OqjusPJ11T+HWQgyaesiGn8a+8kLNX3i2tu7UQtlreNOV0h6RXRqSRU5B0Ak5hw51XcV73ZSYkMns1aHqnAafkVh93Qi25UNNXrN9RTu3PvNSKrfgXFpdQ2LD1Dr2m8yhWTgX3x+BoO/JGvBQPq7KWyn+YKvEZBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXEajuTX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXEajuTX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6263C1F000E9;
	Fri, 24 Jul 2026 21:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784927155;
	bh=+6mHMDW9d1JS015j2kr84nZel3osP5Yb1gQfS1U5lTc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RXEajuTXHJcgSk+fsHe58X0ACunRkLhmUvW8Mc8/AsRsnfSz/R2fanx1mUUs717B5
	 Atg3AkWy5e/WHjdRqeUlZh0bdqONbU4K1bXN1mc0hFwpaqMuAlto2NjV2lQNLZx09k
	 knVhS62h7BTFFbMhphLD6NFTZCdpKI9l+tlSHNONkN+5hW4qWcyOQ6vWNkIw4q16w2
	 iASn9jObw55rQQvwMwog9ed/XL13NYAIz4zaQelT4kbNh9kfmiDBVDxps7dOmZHu9M
	 h3d2jwZovMf8fsuS0ndY6DjW24VKqn37HtHdy2Z5F2zPXWVbZivrNUS5Jh2kApUEvA
	 8K54S2WmkYcmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] ARM: dts: ti: am335x-shc: Remove unused
 ti,no-init property
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bhargav Joshi" <j.bhargav.u@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260725-ti-omap-rtc-v2-2-13f765ca96b3@gmail.com>
References: <20260725-ti-omap-rtc-v2-0-13f765ca96b3@gmail.com>
 <20260725-ti-omap-rtc-v2-2-13f765ca96b3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 21:05:54 +0000
Message-Id: <20260724210555.6263C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> The 'ti,no-init' property is a legacy, undocumented boolean property
> that is entirely unhandled by the rtc-omap driver.
> Remove this unnecessary property from dts.
>=20
> Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725-ti-omap-rt=
c-v2-0-13f765ca96b3@gmail.com?part=3D2

