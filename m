Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A10A37DAC0;
	Mon, 31 Aug 2026 19:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788206235; cv=none; b=DpHxzktaAIAuygRM/lp1wNLg4mSMN0etEm/Hy9wV/pVfYsTZ4ek8EiEIBo64GhyGsRGA5s8ZDGVSRPqIYcQkA9XUZo+3eRJHEpXI8inV5kG16cwOZvtYKaqgWYw02RsebEDQW/82tTYeUSuP0RT2R6Dc+Ip94NNzZa86DEqa8VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788206235; c=relaxed/simple;
	bh=z6mHMY0I5MccJov0xw6OaVgoNx+bNcHk72SNR/QNa00=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B5wz8/mF4itc4uooqK90dyxSFKvq+uaKHQn/otXMym/wSMa9hg4JsDpXounjV/IFnHV8gGyCNUlJjici6gguqtHTo9J6mQ7RrQ7shEl2DJpthKdiVr5ffzb36vb5lZqOV2+zAwEikakXxPt2CtZDw2o4SyhCqJS9MGYDqBcGkmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOWpOa5g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOWpOa5g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678741F000E9;
	Mon, 31 Aug 2026 19:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788206233;
	bh=z6mHMY0I5MccJov0xw6OaVgoNx+bNcHk72SNR/QNa00=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lOWpOa5g6D+ENtc7oojfF1REDwu5KdL1q8sdDBrVstLJDY90GLQQ7qSctlEgcdvEk
	 LuIz2iELQWGQexQTtaXiPCbU2SmaD6epZkhOEv7vXmr4RIsDcHLTQp9Zk3pjtWXwie
	 lmUiViYJnx/Bt5Ztm4ghe3nPGqKVktqVC4BH84fPaw9EL97UMB1DefAfGohKnTazVw
	 VSIkCLaAA0JuQiGDbEsAMBf8BvuqF2AP18ngKeq3uzQ3IyrjJvUIZP3j9Nbhra8I1Y
	 qWRTyq5v7BNItafFAJn9EowlpkqnNDbyF6G+9AMKGbUXONkqH6G/3g8W6O5Mt70Sn9
	 EjyqnRzAww+9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/6] rtc: s35390a: Add missing newline to dev_err
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260831-rtc_s35390a_int1-v8-2-dac1dc86ce1f@posteo.de>
References: <20260831-rtc_s35390a_int1-v8-0-dac1dc86ce1f@posteo.de>
 <20260831-rtc_s35390a_int1-v8-2-dac1dc86ce1f@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 19:57:13 +0000
Message-Id: <20260831195713.678741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Fixes: 3bd32722c827d ("rtc: s35390a: improve irq handling")
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-rtc_s35390=
a_int1-v8-0-dac1dc86ce1f@posteo.de?part=3D2

