Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00A5455188;
	Fri, 31 Jul 2026 19:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785524714; cv=none; b=Lw1s3aeAMINV4JFwZSDxyNsoOveqAoIp9r/2YFzfx/evpva4yQ30W/v1VMa11UaSpuyfw34QvU1+iV5AVRK4pLRwI+K4jiyR4xi8SfDUjwTdjswAjWmNKkAKr6WvxGMmvfwFlDIGZhE21jX/UIVnYGAA6IyBJHahTdBkTcWYkIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785524714; c=relaxed/simple;
	bh=jOeT9ieKXULNWNkcb2Nv5WZ+3sH70JVo50RSHQtM+b0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qatvWT1rdKqUPmFtevD7Ys64b+mYv9nXKZa6MQjDFAEVVQB77I+LAW8TvAhbI7Gl5ANGKm9gpeB+YNd/IsWgQcUCgnBiYSEbY/t1J87ZraAZ4OtZfG7y9rALLNyL+yI/P/Ul/qMthmn9OhQ2ycGcA+YK5d7NOyIYTc9bMqDX4+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnVsxoBP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnVsxoBP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7655F1F00AC4;
	Fri, 31 Jul 2026 19:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785524711;
	bh=jOeT9ieKXULNWNkcb2Nv5WZ+3sH70JVo50RSHQtM+b0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SnVsxoBPc4tpsQfUoxQxoeflivxKHlryrPFNfBBn+GlGDgRzq65LAuUCd2H2kbZ0D
	 sLaMlZw+BrMqiE2eGiIxM4kFRoQbc29uhB94/66cIyVbIPhcwQiySiBW1JZXb+gg6h
	 YPUILnXGCFm3v6ChJO5VljF7S5rEvSoiqg4pKml3gG42uOZtObrIvfOmUeomW7lXpy
	 XnMg2F/gt1uVVYOuvcrz+0oETO9BE8WCLZtn5wciBK5PzNmXuXEk0ewGM12pz9PLDs
	 FCwf00e+siblappIkv8FVxMOWHji2ufJ9HWNnfZ0KPuoxrCFT0Fv265zQxDX1oEHwW
	 cE5/8cXc/VL5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 8/8] rtc: abx80x: add support for ABX81X
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: robh@kernel.org, linux-rtc@vger.kernel.org, conor+dt@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org
In-Reply-To: <20260731184831.44037-9-apokusinski01@gmail.com>
References: <20260731184831.44037-1-apokusinski01@gmail.com>
 <20260731184831.44037-9-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 19:05:11 +0000
Message-Id: <20260731190511.7655F1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Abracon ABX81X is a family of RTCs with SPI interface featuring
> the same functionalities as the ABX80X I2C clocks.
>=20
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731184831.4403=
7-1-apokusinski01@gmail.com?part=3D8

