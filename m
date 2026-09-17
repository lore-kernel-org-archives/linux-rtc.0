Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814BA4DBD9B;
	Thu, 17 Sep 2026 11:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643816; cv=none; b=Am6qeZwatWAJTOMwYEKtrbApRiD78PmiVXaMW8n07wU+ckgt7ZWs9eiF/V2NlmfikCPZvEa+ULZVwmt5SZ1v0wftUHOSMmqZ5+QjoUApYXMuT9kdslsv3adXnpLsRZumBeotVEljoAJDbMxQWLCIWwFzJKIEE2Mdy2uNlLQ74sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643816; c=relaxed/simple;
	bh=doayIE0I3Rv1SIy3XJNBScnS6iat7pa51NKc8RYJTKQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mDFwWiXy+kVLlcmNSq7EAQiWiEGZDkfnKiMWodtBDWcVoLyi2gXvlkwxPfs+qID1d0TABjaP8xsq7g+OWCgsyRLZ+FqIxECwXcMCQUBTtx1UAOnDSYLEJsXH0x3x9zkFKTd8QsL89fWtpBQWjva8UPl4p6ge5Py0in+r2usniRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2m7uh2K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2m7uh2K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FAA1F000FF;
	Thu, 17 Sep 2026 11:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789643807;
	bh=doayIE0I3Rv1SIy3XJNBScnS6iat7pa51NKc8RYJTKQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n2m7uh2KBaK+/uiF0mAlqoF5oXMHb5+eyLuLTaE3fg9pYNcMqc6FufLSx2rV7c6KG
	 D1r588AykDy0Yk1ybvnUDhlASrXqyG0ZXOkQ1TYfoQkh94BS5uVQXEODdZmDb+hp3t
	 l2tUQCO+bq6MhBvFTE++DGNDBC8k5yjWhIf3pgzyS94ong+EcGdQjZjieqkL1va6kx
	 6zu22z3ktGrBJd056ZQQxHC3SgQ/gYqdQ3r5MWJL9IU5zwJWgCvRy6K2ly7FrMMrBb
	 buBvK4zRQLvsjJD+vB5x26luiy56rzqekRx2BLmhsuOHofl66kNR2Erk0R9FOeFb83
	 pfLZBPSedte0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: rtc: rzn1: add SoC names next to
 their IDs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wolfram Sang" <wsa+renesas@sang-engineering.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, robh@kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260917111349.52250-3-wsa+renesas@sang-engineering.com>
References: <20260917111349.52250-1-wsa+renesas@sang-engineering.com>
 <20260917111349.52250-3-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 11:16:46 +0000
Message-Id: <20260917111646.F0FAA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> This helps maintaining because the numbers are easy to confuse.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917111349.5225=
0-1-wsa+renesas@sang-engineering.com?part=3D2

