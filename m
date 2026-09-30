Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CCC3BB110;
	Wed, 30 Sep 2026 10:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790762926; cv=none; b=IDgQ4L7yZHnkC8XysMKyV46JbQ9i3VyRy9QnC6unI/y2SNVX1XppiXZbA4pqHeJLgpDdVhzr+AkAwoaIAVRWScGLiT4sORJJEIq/By/Lu6KLpQNJIUNCmuDLshtIq+1/m1SG+LdIsYDH0eK1ntZCtURHOOBYkZSFskVQy+6AwRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790762926; c=relaxed/simple;
	bh=v+PMIi9ipBhw1aLRKEoj5asCiwwYfc5l8gFiwlAqg0o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aPQYHuI0NJmyGP2gffEbor/PJkcJKMAvhYkGd3Fg1yQX6q/xZj0kH2MRv9z1lwyuttOwsCyfgZws/0avtI7zJR3KJwPdvyhZUcYWjKmwSxIiu3E5fqkLR6Jhy8vFpK5HrgJ9mA3hyhQmYSU/P9ZslZxtOuxWB6AsTd1LJmfD+9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjuwQsSP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjuwQsSP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0961C1F00893;
	Wed, 30 Sep 2026 10:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790762925;
	bh=v+PMIi9ipBhw1aLRKEoj5asCiwwYfc5l8gFiwlAqg0o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fjuwQsSP0gnGux0PlcJ3aJAIFbo2SETTvOOhkCbOQjhDY7nsnHNRExLC4PKxo92uZ
	 X7snmhVT8bON/X65OqYozbqKZHUcuY5TNhmPJkA2+hwqD+LPkKe258kq+zWKJRjLMG
	 fPvFitjNj5SU8JMsGJvSgPWNm1PTYKh3Pwdoy4W65889OucJuQEbqCYoK+Q9O0/WGY
	 yT8lZ7qVhGVGVJU1mNFVnbZ7rYHIH8XIkk1vKDyfA89HjepJPH4P0lOyRFrFuFx74X
	 ZEVSVqJX4d6Lwhymx9kUucB9aSG8lnRu4daVaPVa6HErJmYo/zQ1TthOzYIGR4lRvY
	 GndU2iN9KdJsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/2] rtc: Add Raspberry Pi 5 RTC driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sander Speetjens" <sander.speetjens@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260930095203.492949-3-sander.speetjens@gmail.com>
References: <20260930095203.492949-1-sander.speetjens@gmail.com>
 <20260930095203.492949-3-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 10:08:44 +0000
Message-Id: <20260930100845.0961C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Upstreaming the downstream Raspberry Pi 5 RTC driver.
> This driver supports the custom DA9091,
> which is accessed through the firmware mailbox.
>=20
> Signed-off-by: Jonathan Bell <jonathan@raspberrypi.com>
> Signed-off-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930095203.4929=
49-1-sander.speetjens@gmail.com?part=3D2

