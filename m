Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB3B4CB8D9;
	Wed, 16 Sep 2026 10:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789554471; cv=none; b=ryHrr48hH9zGavACjGvajuJ3pprSAwF568Qnoxp6xZIje4iILeZgHgCYmFQboPOY9MCtVtGj9SIP85GSoJxoXt5RrnZ3L/C9aQyi6MaWDfn+9AWunNPsXkc2ph1qrKAGzbtZJ4VkrdQCMSMGmdMAsXvYv/dFGk0Jm3JBpsIT/Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789554471; c=relaxed/simple;
	bh=EBfrWc+2iQKpkd/UqryP3f8wuTX9BgHTjxsP5n6/uBI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AmuekSTFsUltsHyL9bKl/we5Yb+xE5+FZGJ3k+I3tYtjdmwqg3M4J83fqA7JriLNKW1GcDY2PMPfWGgXiBiGwudY08htpa4jIk0zImLWSBLIz6jXsRc0kMBEj+jpoLDFvXEQ1HnhX8sjxP5W/CR4bhXeYdSh1weziBh0I9sWxN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VH4kHptV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VH4kHptV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A285A1F00898;
	Wed, 16 Sep 2026 10:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789554456;
	bh=EBfrWc+2iQKpkd/UqryP3f8wuTX9BgHTjxsP5n6/uBI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VH4kHptVTGqbNkz1imcQjB/QwYPTdErDaqCFeoKXTpynGGiGEx+lb/aufUQ2iK64f
	 7rN99bzCKGtbvJCjBGK8L4ZALwW9sJIArfSLhptvmaJ0BmdYvi0mRqWi+73w+oQff2
	 jSvftidCpmzhI0CATiG3E+/J2uW47dB1jBGlv0HUQ08DEbvMfWIQxaBAcoWvQ2bWNA
	 hBodo/PNeqCka7HHWB+WKmjVsOPfSLf/JcsO7zco8VI0CE7ETmyAl7973oMY8GvbMm
	 FNvJRwvj66+ChP9mID9Nh5Yj40BfDo3Gznll2/TRXNTWTr47Pb46jtViqKMRHk9X2l
	 1v2ySnAr8EmSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: rtc: rzn1: drop unneeded
 'start-year' from example
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wolfram Sang" <wsa+renesas@sang-engineering.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, wsa+renesas@sang-engineering.com, robh@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260916102520.24288-2-wsa+renesas@sang-engineering.com>
References: <20260916102520.24288-1-wsa+renesas@sang-engineering.com>
 <20260916102520.24288-2-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 10:27:35 +0000
Message-Id: <20260916102735.A285A1F00898@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916102520.2428=
8-1-wsa+renesas@sang-engineering.com?part=3D1

