Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875EF40099E;
	Wed, 16 Sep 2026 21:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789592428; cv=none; b=Hyus5bjdO9eD4t84m+ayXMxkfX3c/0VStlxd3eyi5HZLRAPwIZwmWD5ggVzGzbEuwj8EQARRmRagrw6wnG3tdGcq8FoFY0mUbJzOnf6D1hU3zkBNHJpK4t9x9t+Z5wHMB4ZOXx4ZWFKMerEw0bkt4BvO23GVzAd58S4bZvYTAww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789592428; c=relaxed/simple;
	bh=7V4aEiZHyKgLBinI8n/D/5Fq/+LYDItfzmla1xt6acw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EAsoP54QOFey0P66bUYnXrvuuD89Uw321rqeTXDH0E6/ZPz5CHbVioLjUV1VyRyfIwfaRrmIMjfwlMf8CfCEKPllVOYw+QiK6hNq9So5HHwODPJlCwUg13KUj48DEoRZObgeHSQFu5BPN+h9kE0/u2nT+3nzq1nmZTSkVsJEH5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdQx6r9D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdQx6r9D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E6B1F00893;
	Wed, 16 Sep 2026 20:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789592400;
	bh=7V4aEiZHyKgLBinI8n/D/5Fq/+LYDItfzmla1xt6acw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kdQx6r9De8cGXr5Q1fHN7lwrtDGMKybAFtS9N0F37LBzM93JHetEGRC7l1rVMdJTi
	 bQA9CttmVgZC/CuFap7Mcno/Yy0IkGGUUcNL3U4Bu8gpaDDr2HMT16+t/MBOxPl2HL
	 NoQWq0YTXLldvPgDHGBFsPnlQqAbjESAv3hEJvflTIYNgVjkYrvweQ7oMRFu1qnAVn
	 YiHi3TmrRydG7UTkoDh3sI9DJASRD/u88yn/vPnKfR25ijjNgSaPTHeXKcXLX/RA8y
	 g2r9w0FTpSKSTCxUoW9gWdSOsuZuxHdNBqSBFwDzRXIiLyerVb6C3lDVD1p/AZoWWq
	 woRxRLsWxpZLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/9] dt-bindings: rtc: abx80x: document ABX81X RTCs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: devicetree@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260916205138.16771-2-apokusinski01@gmail.com>
References: <20260916205138.16771-1-apokusinski01@gmail.com>
 <20260916205138.16771-2-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 20:59:59 +0000
Message-Id: <20260916210000.00E6B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Abracon AB0815 and AB1815 are RTC modules with SPI interface.
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916205138.1677=
1-1-apokusinski01@gmail.com?part=3D1

