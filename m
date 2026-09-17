Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3195598BF6
	for <linux-rtc@vger.kernel.org>; Thu, 17 Sep 2026 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655446; cv=none; b=isbXwd5LOvNVAOUH39QoffNkq5ZfCXXSLe+6UsUEzHRBSrjV6TnvnV+efntp8U6uQcW5VcHsrsWiqy5nXgAsRnD8zrdqQPj8G5hWnrE6qt2qGXnrGaYkf+bNN47zTI2hJchlhSIjs60dYBIrh3X/XIdfr4b1giqV3q6pBHky49Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655446; c=relaxed/simple;
	bh=ne5s7WiCUhL78UY2XvXzNNmu6rlqc0AzQzHZGTfqMKs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pLwPiXJ+6zk+H78Vwv80RFdL57obI7WLE3h4GiqPgn5X+JA9Y8SGArThSBQ0mS4O8iANRrsZC6O5Qi4TeGloJCSeWQKTgblfHFgNIwHkhCq+7OjNHw6yqHvbKAqqLSJlSaNUFhE3d25WWeffM5LdUjg+ooQXpQ4d5xEPv4IXPKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjAgiGab; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjAgiGab"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053E41F000FF;
	Thu, 17 Sep 2026 14:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789655444;
	bh=ne5s7WiCUhL78UY2XvXzNNmu6rlqc0AzQzHZGTfqMKs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EjAgiGabvfHqRrZcbVZWRWI9+A770bUX3/exImdJS+0LUBmCojEh9QnuulEs6eLy7
	 G4NXy0SGuLZCdOgA26rvYg8x+7QXytZs4FDhxPNtjVCfFCVD+lkq3f7pJdn6JUryqk
	 PMKXqu6vnY0/o5ENbYtgOiilkMqQTuAiR2hWw3Eb3A5LIcZdM+XqXUGW/T+VQZPoOP
	 imdexf+lsqSTW21iBwyeup0j5d1e4eG9UPfJmmBIGn/MIm6n0eb440b/gAEF4NM6+g
	 av91ku9hL+4HiL62ARg3FmstPpTjoThbzqcH5T/9Daj5v1K+4I/ZMhh2CuhZ6xvYC1
	 hUdKccTBOIfSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: omap: remove unused argument
Reply-To: sashiko-reviews@lists.linux.dev
To: alexandre.belloni@bootlin.com
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260917142654.2576889-1-alexandre.belloni@bootlin.com>
References: <20260917142654.2576889-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 14:30:43 +0000
Message-Id: <20260917143044.053E41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
>=20
> omap_rtc_power_off_program takes one argument that is never used. One call
> passes the struct device of the rtc but the other one passes its parent.
> To avoid confusion, stop taking any argument
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917142654.2576=
889-1-alexandre.belloni@bootlin.com?part=3D1

