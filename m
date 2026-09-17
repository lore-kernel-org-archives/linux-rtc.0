Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891E94BD347;
	Thu, 17 Sep 2026 11:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789644004; cv=none; b=YI2BJa6v3qhE7tGoPnktHJvNW+k+lzKkfBMqJlOsw59+mKK/vWf7C96v0S1JrAYcWNkz/PlF7Q7HPDedgXngTj/j5iM6SGo+fmMzEAqoe+7Je6jq0O4tcI2HiGPJYPv0NFPZnE0RWBU3wQfpl15qEyeqP7/S0WRvy+h4XfqMBVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789644004; c=relaxed/simple;
	bh=KeFHNchMr6G/JPZ8VrJidMutvKTyddkRLOv6I9eroGY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M5qBe2g+MqeTCKr2d/npRmKEr1nlEax1QDxOdfkFSxEr92okLp1j5T3nSeUbJ1Gb2A9mjA7z/m0mB2fcCYNqAjxUHzPPuN3QMv6Fgh2w27IIqtzi8+t8EOuERS7utvD5aQoA6HB4cYE4/2v78VRCpGR3Dv6C0AxgJm/Z061ixSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYcUlKsf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYcUlKsf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22AB1F000FF;
	Thu, 17 Sep 2026 11:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789643999;
	bh=KeFHNchMr6G/JPZ8VrJidMutvKTyddkRLOv6I9eroGY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KYcUlKsfnRxsjaImrVyi+G+gT0/vrtFZL4JZZpGhqPIJRJXQPtxQuyoGCpLSIrViz
	 Esn6N/6Sz8fi53p8D6TCW73BLCIM2zbtte+YnFnSJwZQcm61j05aUpFgKo396wG9Ba
	 nOKXfjDXisNNLvbmh0npL5An6vJJ3rOZsN0/LAm7WUE78ejv4yuuPY/6i9HJofxTuB
	 WVrg2XRLhFHH09Mc0Gy7IyL7FN0B/M+XyU8OqU8Fz1cyA01ZJmcU3dO1/lwiZIlZAF
	 KlQ9u8kvTbFRhkLfzp+CON6HisSmDBSNDuLZs+jtpG2NgFfQk+4YCQxFXuLANb8kN7
	 9h5ejVbP/A1Iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] dt-bindings: rtc: rzn1: add R-Car X5H support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wolfram Sang" <wsa+renesas@sang-engineering.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260917111349.52250-4-wsa+renesas@sang-engineering.com>
References: <20260917111349.52250-1-wsa+renesas@sang-engineering.com>
 <20260917111349.52250-4-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 11:19:58 +0000
Message-Id: <20260917111958.E22AB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> The RTC on R-Car X5H is a bit special because interrupts are not wired.
> Future R-Car Gen5 SoCs will have them wired again. So, create a
> dedicated entry for X5H without interrupts.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917111349.5225=
0-1-wsa+renesas@sang-engineering.com?part=3D3

