Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A8B2C21E8;
	Thu,  2 Jul 2026 08:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980365; cv=none; b=VCNk99ET58jCS2KREnM2KSpbq54WAuCDi8kUtyeWO7e/HLU75vX/pnHWZOJNBIxkgnGyx/kNkYKOuPZf7VIZIsybEWixr7BZTMF5ccFCWsfmH/RwWXlTxLwfSpOOtlCMSnQ1zN4rhTujQcmyr+tsUyKG8LO3wknWtAmUDa3Va7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980365; c=relaxed/simple;
	bh=F/g2A+3gY3n10XXKCo5QO61/eH9gAq5coGzK/C4aAOk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BmquXSMrVFPVsann5maFAoncEQCaJl9scflGm+7l8UCnRd6jV3N+rJ8Z6nemFaCAqpcsjywnuynCbWNw2+clk7Lp+8EdiqLHJTJO+bvQPTCZy6/TwM+OrwBAyWXcFr4HPDQ9u1uv87E4CcZCTjc371lUMYsi3UKjM9nbwM4W0JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7+uu7hp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7+uu7hp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABFE1F000E9;
	Thu,  2 Jul 2026 08:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782980364;
	bh=F/g2A+3gY3n10XXKCo5QO61/eH9gAq5coGzK/C4aAOk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K7+uu7hpYqgN/JH5k+GbDUZd50OvEQ9qks0LtLu+JKieautnHdYs7xZs4GTJl7+VD
	 UEfCJ0rQWHSMRZVHpeyXaCee6jfTJV9qTjL9fdPK3IxUMlb4AwySCK0eqNJbHL9jsl
	 JK/ppEI5CeD1aQf8mQqSGSMmTg2mn6glEN7OS9CyXiNgOQwDjeltWl/+FveGq8gijz
	 T1Y5haFG82TVdmZ+xpnp4oFZtL/Lxfxqystlxf5433v1GjCxkhNr8aX/kDZV4yJCZW
	 v0aJYP0cRdtG9jr3+NGj9wMyPhziob/JO5cZWsERGq7CajqV+7TyUYe/SomyEsLm39
	 YV3Fz7borB2KA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/8] clk: sunxi-ng: sun6i-rtc: Add feature bit for
 IOSC calibration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jerome Brunet" <jbrunet@baylibre.com>
Cc: linux-sunxi@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260702-a733-rtc-v3-5-eb2580374de6@baylibre.com>
References: <20260702-a733-rtc-v3-0-eb2580374de6@baylibre.com>
 <20260702-a733-rtc-v3-5-eb2580374de6@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 08:19:23 +0000
Message-Id: <20260702081923.BABFE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Junhui Liu <junhui.liu@pigmoral.tech>
>=20
> The sun6i-rtc CCU driver currently uses a global static variable to
> denote whether calibration is supported, which makes IOSC operations
> tightly coupled to this file.
>=20
> Convert this into a feature bit to decouple the logic. This allows the
> IOSC clock code to be moved into a shared module for reuse by other SoCs.
>=20
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-a733-rtc-v=
3-0-eb2580374de6@baylibre.com?part=3D5

