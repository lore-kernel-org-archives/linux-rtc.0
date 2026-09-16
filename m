Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A024D37AC;
	Wed, 16 Sep 2026 20:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789592396; cv=none; b=mMkwxCKdSV2m2RS/H/gRsGvobM/rgBMZVEvRLAneqIFzDy6Btm600kVDsgGfV/KqcP7grcuN+q/962cCrkoNgsLDu/2EzcndSK4LvhDGf4OnrdvOnttMcjdBiivEwX87xA7WOB7uTlpxyiVwlH0ouLLdUjsO9jYECl3s7Y9MCYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789592396; c=relaxed/simple;
	bh=trC4G7DruGcB6x3z25KcEalPHewRjIlwdHlhyxbPzd0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DL/WPm3/AgF+vRI1oTBXDz1UQTkn0LZtk8AOSlmGBoaALr/xfN70HZAzInG3NlFkAOX1dfVG/0ZD8Pz+pg4BAKq5vDRVxrQACCAwCI3TzBDX68ceCQD2Xxnval8tuejLY/yhcm+9+YllEvQjrfOdqeRvQN8D3Z2BmAZcBOQBq+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIGAKDgE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIGAKDgE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35EB01F000FF;
	Wed, 16 Sep 2026 20:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789592379;
	bh=trC4G7DruGcB6x3z25KcEalPHewRjIlwdHlhyxbPzd0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mIGAKDgEpMVZnrt7aS86ryn+xM2jUpyotHGy4+Kt33l14/4P7eJK1jxeRLIZNSsCn
	 ZZnqfCoxm15uxIeumG3QmbeFHQDjRX5dDmTEQCk6fbW2ACevnkWFWlSVg0IpK5WDRy
	 dg9YZrycNI2j3xmtvJApqAIbANF72riEruabKhTl31jopPKNQWcST0v7pazbkXvDFb
	 A4n4C0OHkhTp7aTfjBvMFS6pQv9SVtH+BJEXffOze2WhAmbGPXMN+DtphzHMR53Umx
	 A78PoL0h0YXSTIYtnMAyiTfPHStVOJH+ZzFqdS6FJ/aKOeiyRY9LCYti0QEc16H7Zi
	 T5Y/mDgEFgzHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/9] rtc: abx80x: add irq to struct abx80x_priv
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, conor+dt@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260916205138.16771-6-apokusinski01@gmail.com>
References: <20260916205138.16771-1-apokusinski01@gmail.com>
 <20260916205138.16771-6-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 20:59:38 +0000
Message-Id: <20260916205939.35EB01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> This way the irq number is not tied to the i2c_client and can be
> easily accessed also in the case of ABX81X SPI clocks.
>=20
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916205138.1677=
1-1-apokusinski01@gmail.com?part=3D5

