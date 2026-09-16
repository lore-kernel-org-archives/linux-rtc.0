Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1695C4DE70D;
	Wed, 16 Sep 2026 21:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789592742; cv=none; b=r30P38RnO+KNzywJSbfcogz+aP6JkFQCT4VCaE4cFI0ukOqfMBurriXdJbCu0pUPvbQKxZUMcugPsdyeIrFAWnVJWJqBkRX7rsq5Gqh9SZALSwXI3wSaUIHuyMZmp0PadNOKBi40BQ/FgjwdJOfCgzsPBGEZiGUUR2o47xoeMLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789592742; c=relaxed/simple;
	bh=S1nf2tTBnagNxYm8JVOjxAjYQFjTDf2OL6N0OXLnqvE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GyhRLy/Ba8mv2Jz4gw6hS//gqInfha3nA2PZ2cg9FEGlSNtIRLE/fBHBRS52ulCLwKXRYSzaSmXzQ8qG9LWrEaD00VP6w2+m1zvYLeAKHr65dBJYJk6i2PfJTot6w64o/Elt9OnYlmEocFzoQIL28a/51wXXHyF6h9VaqZmbI78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4peolnq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4peolnq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544401F00898;
	Wed, 16 Sep 2026 21:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789592721;
	bh=S1nf2tTBnagNxYm8JVOjxAjYQFjTDf2OL6N0OXLnqvE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F4peolnqzLANK8aVtAdywcMczYL/HMyowHF/0GEeOTld/eDCGC6MDYrImQeq26KQZ
	 81su6SwNxHiBwhzxMQl7+Dpau/gCT1MjGOYvF4JKOUAqg1wJ3UozUVJD+hKX69sWXF
	 6pwxzgO81X3OAiF7sMXUaqncw22Tx+z98+B5/Rhuilpfa9AKWWnzif1jR9S6nD0kXQ
	 vclI119iswuGwMvMmxMf28aKoc48YtbvQWkGNESIe7KQ7PHARp+k/m6+po59brAAEJ
	 UCsVJgIUhvHaeY8d+Pj0FKmnxM6Cw9iXkIJmnFPLv1FiswV7K3lsnjlvziKDh/UYB2
	 p61blfL1jHclg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 6/9] rtc: abx80x: use regmap instead of I2C specific
 API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260916205138.16771-7-apokusinski01@gmail.com>
References: <20260916205138.16771-1-apokusinski01@gmail.com>
 <20260916205138.16771-7-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 21:05:20 +0000
Message-Id: <20260916210521.544401F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Rework the driver so that it uses regmap_* functions for communication
> with the device instead of the i2c_smbus_* API. This way the support for
> ABX81X RTCs which use SPI can be added later.
>=20
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916205138.1677=
1-1-apokusinski01@gmail.com?part=3D6

