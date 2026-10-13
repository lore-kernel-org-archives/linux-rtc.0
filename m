Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D685F4AA402
	for <linux-rtc@vger.kernel.org>; Tue, 13 Oct 2026 10:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791885906; cv=none; b=TghhK+K83g2rZH+u53udA4NvZSqwwwuAlDmkWEGr0D/JMXCc/bcpm9caAqGN4KfCZrpt3838CyKkWy11tqdPcsXZkSeo7YDKq8485U/8ZMl28hdlNsIQiM002g+Y1OIw5GxhH+YgFaxeN0wycnX1fY4hi36g7a8AgqhhShlIYxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791885906; c=relaxed/simple;
	bh=TLZ3BFEtFeSQC+TzIP049vPZhDorLfAsncOLxvlouaI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Ryz8vyUWdHnJanC4v2OOZQ5XTvPyhFsqHy9AiS7aPaNMqNT6nr21RAMNwCvVx81muDETkBVQZEpXNWjXvx1MUTKazmvvBBZddyowbEpj4BW1cDYuLZewSQV/bZZhDImOoN/EbI+Wa0QpAL/zE7bUV1K9dqEVOwLzJZP1a1k0XUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFH6pwZc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFH6pwZc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C29D1F000FF;
	Tue, 13 Oct 2026 10:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791885904;
	bh=TLZ3BFEtFeSQC+TzIP049vPZhDorLfAsncOLxvlouaI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WFH6pwZckNjIn3oYyg5UAKeYV3GyWl/+Wyyxhpt8bMYh18T0Nu+EiEkra5lvSrd5g
	 5YrOWfmQYr4+AHzI7sBvF+MmkG5IGAVqaRf67V3SrScAByb3N5yzjE8i8Dcy5Gya4w
	 HPADsXOJz5DNIrhXwcXQ5kpRaMOjrHp+8qfAsi4Ox1V/UbFp4n6vk79c2vaJbS/iom
	 nU3k0UTXaWhFb0fukJXXgZ+wN+kZRonFi6y7YYLPHqPu6d+UpkesqPlASK5feuAyYP
	 mvnCatIS0awH/7pIIdODV8SU/h4+QIhqzyAlI4RdwPHSk1aXRxNFgOtN7+EIFlBk2n
	 Zk/Gkp/SbJy6A==
Message-ID: <sashiko-outbox-169449@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] rtc: ds1685: arm the wake-up alarm at power-off
 only if an alarm is set
Reply-To: sashiko-reviews@lists.linux.dev
To: "Imre Kaloz" <kaloz@kernel.org>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261013094930.574-2-kaloz@kernel.org>
References: <20261013094930.574-1-kaloz@kernel.org>
 <20261013094930.574-2-kaloz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 10:05:03 +0000
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> ds1685_rtc_poweroff() always sets WIE. The wake-up alarm then compares
> the time-of-day and date alarm registers, which hold whatever was last
> written to them, and a match powers the machine straight back on.
>=20
> Set WIE only when AIE is set in Control B, and clear it otherwise.
>=20
> Fixes: aaaf5fbf56f1 ("rtc: add driver for DS1685 family of real time cloc=
ks")
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013094930.574-=
1-kaloz@kernel.org?part=3D1

