Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B7D27A47F;
	Wed, 19 Aug 2026 22:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787177577; cv=none; b=ah4sFLWjj+ocazOImMLIxwD7XLEXc3tmEuaZeh49kRVWS45jk3fVYj3lOqQQDv6y8CY7u6PvEL/Q/OkUz4Y6fdonrv22jo4gFXSrwHpG0hZmyOxIraHyoGz4uJI9u5N7BLyI2OUpbvEetTaR30xJx8gWquFE0c5VJT6sooo/isI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787177577; c=relaxed/simple;
	bh=yDUqBP47VRuRIijG33x9VR7Yc9vpGeohIj3NRQNLEDU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ID18mxFTzGqUvaMCnGDoTBPISpRK/sar4MOa7gUgWL4CHm0DoVdimYGjtcS+twV7eYGr/pRJ5v/Q5jESigdAr2XPmQlw+oRj3aVV5NIxUzQ0lSCA6o/ysFMA6B6nQ1SR0bjcJwfT4wrZF7nsFzig/Nb8N3gQXZpuVkqYjOPjgW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGpNTXsp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGpNTXsp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052F81F000E9;
	Wed, 19 Aug 2026 22:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787177576;
	bh=yDUqBP47VRuRIijG33x9VR7Yc9vpGeohIj3NRQNLEDU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UGpNTXspBqZMf/v0JZz/kVmdjpC+cH0YyD8ZR26ff6qdswC4VTfV44jzBWAULHk7n
	 ks2o7HHPQQfYcFQPyrAwXOPWb1B/9RLaR8nDxoVimXdaEsB/pgF4RkfDsISIrh/bnn
	 2spWbj+ogmUx7cfb24Xq+glH5VHSiRohr5olhJzX2MDYhf1HZUwa1LSPTwdThf0D0z
	 Wuc/TsqjTDH5UcyYN9n5ah0z1p07P2SKUYGWxNQGh1kdL4S4kzhLqV6stvOwFbH52t
	 J9bAusDgfuz9Go8HOlAd68fhzcJ79QVMF9MjDGHxbTBq5tTGPa7Ho2GzfpzdlMQere
	 i+SByL01uQEAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/6] rtc: s35390a: Fix alarm not disabling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: robh@kernel.org, linux-rtc@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260820-rtc_s35390a_int1-v5-3-5eb4ef85c6a9@posteo.de>
References: <20260820-rtc_s35390a_int1-v5-0-5eb4ef85c6a9@posteo.de>
 <20260820-rtc_s35390a_int1-v5-3-5eb4ef85c6a9@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 22:12:55 +0000
Message-Id: <20260819221256.052F81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Implement alarm_irq_enable callback.
>=20
> Fixes: 542dd33a4925 ("drivers/rtc/rtc-s35390a.c: add wakealarm support fo=
r rtc-s35390A rtc chip")
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820-rtc_s35390=
a_int1-v5-0-5eb4ef85c6a9@posteo.de?part=3D3

