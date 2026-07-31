Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1A619E968
	for <linux-rtc@vger.kernel.org>; Fri, 31 Jul 2026 08:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785485333; cv=none; b=tlLFkIg6ac7hK9RYwFxVEaV8qWfroLSB2/EF+a+J162kqIsNm8t+uLjQz1jDGx3CT8csDaWw3co+Zo4cdUnXJi624HH61E2yfVt/OG1W0tM+ZwMsttFQyMcs3QGDiFwGctjCbbNOWK8WEdAYnpItRT7JaPh0/qAj6pkfTm7ZueI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785485333; c=relaxed/simple;
	bh=7v3dRfHu66647Wlb6MaJAHRzu/FgcJ9xdlWu+NBgSvk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TExmTh3Z0VKJxqqNj93QbpkSUGSN0K77H+TIYKqIhqQPn68Spi3Fd8gFOg7nGYGwGh8V5u8nMSJxfLnN2fBzcyKS92byLkYsFHkkvMB8s50OjVCCVyQYtgKQfxfrb8ZcdL83Xd9XNjRyNal3YQd3NUmdf/K/wY6Cf3WH2L5l5PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mo2Wz68d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mo2Wz68d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D128B1F000E9;
	Fri, 31 Jul 2026 08:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785485332;
	bh=7v3dRfHu66647Wlb6MaJAHRzu/FgcJ9xdlWu+NBgSvk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mo2Wz68dphjIuYwt8GXExv3Q7+tyr0u+MqWL63YjbmChJj+dwS1KjGxKyYRMe/Fsv
	 QOVqnyEuasq2JdRaeW4OS5bGbkdDE0ssGrnc/MbFsXJbEwHEdekAIdz4Ykxsv+2TPD
	 fkY/KWprUmioze/dEZcZ6HSDrvKzCTqQiThQ/sIjqXyYBQeuN8+rKrcBFFNlabwzDe
	 lUInp0QcdZmYYtdS18JrcR1nwpKZ+iyP2E+b5czo1RjCjTiJ7NWTnOw6JacjOujxyX
	 DV905mYVl+ESSEHLniN7JEETf4Wf9OAlNmavE3QDfmIK3qF4S7qFwuNNLi3lCzJxX6
	 dz0D7KoMn1LXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: gamecube: check return value of
 devm_rtc_register_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linkai Gong" <gonglinkai@kylinos.cn>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260731080458.417532-1-gonglinkai@kylinos.cn>
References: <20260731080458.417532-1-gonglinkai@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 08:08:51 +0000
Message-Id: <20260731080851.D128B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> gamecube_rtc_probe() ignored the return value of
> devm_rtc_register_device() and always returned success. Propagate the
> error so probe fails when RTC registration fails.
>=20
> Fixes: 86559400b3ef ("rtc: gamecube: Add a RTC driver for the GameCube, W=
ii and Wii U")
> Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731080458.4175=
32-1-gonglinkai@kylinos.cn?part=3D1

