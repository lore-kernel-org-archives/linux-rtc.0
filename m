Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A5E472095;
	Wed, 16 Sep 2026 21:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789592502; cv=none; b=IFc0EUpkMSzeG5anqjo2NyTZa9BlxARB7Nk+TbopuLBwshGWVfI45sRjd6rE50kDW90+4tfnlVkPHdj+A/q4M7X6k3ZtteYDzboeCSUdr3wQNnVQnOAdcn0jbsRzcsGtB/KFLsTAIJ97y+KyBYettxUmDNLtBUDfa3R5psNggIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789592502; c=relaxed/simple;
	bh=UqKlP+ilJ/dLNlex54gCQZi7taxlJKDywSWCkAwNsvQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SzY5fUUj38/VlEVdOtf+Rg41RCb/auOrPf+5Tp6v/rAnGr2W0cqWzSJyJMG3eHAYm4mwtItHcIRIReBstI6ifkQsYxk1GUrrax2OBqqbexi859lcSudwn7wh0xoIojJP3IPZoSvuqeWSo900G2yZwaOjUiNtGESNo5PlGGc1E9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLiCUIXs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLiCUIXs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480E11F00893;
	Wed, 16 Sep 2026 21:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789592486;
	bh=UqKlP+ilJ/dLNlex54gCQZi7taxlJKDywSWCkAwNsvQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eLiCUIXsuj9bGn4rhmssWJ/Xe7CgKB+uxgN6fTY4o5+ZuDEQ1KkVXaMZFH09Vxd70
	 VtfwSItJHxaqr9Va1+MWkYFQFvWYGifGMGl0bTO9jWVVdhF7M8i0+6CZoOfSZ/yrHX
	 ScrM0m+9HnenVAjiANzla+2lQJ3bUdKG3gIzV/uKOGN8qP7f1VMZkk/tf3iQ+poXhp
	 veHQsxXhQlKQLUSYieO5JTRJW/Yn9oCn218U4Pp47Vct2MliIKJmdbbTupK7yUfgS/
	 nOqUW/MXC2cBnjJG83whDxuq76NKuUwsheMkplLj2DgSRYNftBd4V/U8/BoRWbTtjG
	 78X5I4QoS2SCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/9] rtc: abx80x: fix error check after
 i2c_smbus_read in read_alarm()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, linux-rtc@vger.kernel.org, conor+dt@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260916205138.16771-3-apokusinski01@gmail.com>
References: <20260916205138.16771-1-apokusinski01@gmail.com>
 <20260916205138.16771-3-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 21:01:25 +0000
Message-Id: <20260916210126.480E11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> i2c_smbus_read_i2c_block_data() returns the number of bytes read on
> success and a negative error code on failure. The existing code treated
> any non-zero return value as an error.
>=20
> Fix the error handling by checking only for negative return values.
>=20
> Fixes: 718a820a303c ("rtc: abx80x: add alarm support")
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916205138.1677=
1-1-apokusinski01@gmail.com?part=3D2

