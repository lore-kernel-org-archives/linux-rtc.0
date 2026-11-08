Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794173507;
	b=17F26UaJiW2k0VKJKizWx3OSPL+FSoG1fzyttYfDBTGv+XLRps6BTdYWm11vArCvOjmX
	 rKPTtHn5HoyUhrY4qxk9N0xZOmurDDWXzVyuKY5A4zbrSn48FVbHJuJZhbI3ZIiWNQbRj
	 FgExBjEorV2o1OgYacsMqXSbgEOyk8w0RFgdhKn7JE2kVA6cebNjnQ4Qs7in1VfhevjD5
	 SouzU+pmMkIO02aSgp+G97a0E/E+YHrOyrwAYpmz7RAzD13d24lBkc7EAEZMrGYaJnJDB
	 Io1rgRuUZ196CmTtVRlp+Rehpkpaxi/Og8KrXcCb1zipT7w2OftZFm5mIfmX4CVUWtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794173507;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sX6VaQAg1PX03EG7WPJavXKAFYGWPkzwYBIxnFmXqDo=;
	b=S0m2ejyq7VEEutXjkqldp2nxnYVe5adM8nU+wSkiErhvP0oIWUN/wuhfZyNVMK/A0f2W
	 QUOnZRi+srND3/OFAeqLtwjWLH4/jDNyzGb4lBDD0mA4jYnkjE8rmwX3R5UB6RG5LwDPS
	 lqThFGdN0ra2SugsqdnFYVkgl0m+iqWrtPLGiUCWnDsH6unolenCjylu8JyZBoQ+WqwMw
	 AIbxkaDbf01vGXrAq+WS51MkxpRDr68+lABQz+cDsa05uHeMjPPIs9Z1sWULw9YjVl77h
	 eYoZEL4SEpB2lbif4NKaElyCeEhWl9cVl/ACFojDplFd9kKjPnYPJ+YmZgAbDxoW77g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m+6PICaB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25E9606A31C
	for <linux-rtc@vger.kernel.org>; Sun,  8 Nov 2026 21:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m+6PICaB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457341F0089F;
	Sun,  8 Nov 2026 21:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794173506;
	bh=sX6VaQAg1PX03EG7WPJavXKAFYGWPkzwYBIxnFmXqDo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m+6PICaBxlkYemGkVAHCNi0EDC9GM6Yi2NuYmcSfj3rrOQo4qDBUrT4FmJoMLDrvk
	 y6MHDfaA6klXRDNQk77qZtciHAYpeAjSE9D7UjMS2hE2YivzMnWEr6styVfFKBsP5F
	 u3d0pxl0p/Po4ATzWNaiaAubtQ8IuCjjOfuVTqm6iwauinh4E/FgvmiwolDhmQgsSy
	 cbVP3m/gZfqgpVSv9zt4gxUqSJlXO0rKpbb6iMoPyAVgScAo17SHcRvuGrqm6H+dlW
	 Sw5pXUlj27AWp8haP/JJXKBaZMyfzmE7O8jvbw6MrMgQlYmIvdhMZEaYgcaRjvZJ0B
	 c+ItFO9T+SAWw==
Message-ID: <sashiko-outbox-204079@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: rtc: Add StarFive JH7110 RTC
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?T3dlbiBPJ0hlaGly?= <oo.hehir@gmail.com>, linux-rtc@vger.kernel.org
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261108212826.15890-2-oo.hehir@gmail.com>
References: <20261108212826.15890-1-oo.hehir@gmail.com>
 <20261108212826.15890-2-oo.hehir@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 21:31:45 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> Describe the RTC in the always-on domain of the StarFive JH7110 SoC.
>=20
> Signed-off-by: Owen O'Hehir <oo.hehir@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108212826.1589=
0-1-oo.hehir@gmail.com?part=3D1

