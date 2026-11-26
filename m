Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795672446;
	b=HQpOSpXRFor6G17vp4iME2V0XdgB0dsg0F9wRS3vGBLKlnbb15+RfA17qri6wLLW+Vxk
	 70ibM2Jx09TxKC7DENrXHtEC38dvh5ZjcH16UQWjZNxxRDcyCmU92+KOYUz4JuCUwZYqH
	 /WHlAvTCamfJR8oVeZ3rJShmAKNd9yPzNTcw4fNgNq04zkCwRstoxKzqBeiAfYMADuKex
	 NMelfyDSDhUgAHy8NbJGXXob+/GW6EmWAB7Pp6X7dLvOEJR3ylKNZtt6xnbMe0Lcxo8o2
	 8mKAiJMWfpxn05W3Yk0Eb7EYH3B84cBHKDaRRUmPUcMp1Htaye8ef9nmuUOXk/JJQaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795672446;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sHaCAB/QD/y6m/izTtrlgFiJAYzgA8AuFZENk68btws=;
	b=JpLUGxa78U15IrLyOm0WrcsnX3Pu3K7gQ2ViSG9wjwruyq8jv9tdg5HsV3CryoPTPH3j
	 kPUEfjSq6HzigvkMKeXdIDTRsRZ2o0JdvWvYMaMeIkeKyc2wp3Ox9smaCB5+OdrkZ4U4G
	 8u8kWoBS920IDwOk/Bqc7pQlaWOX1Muvf9duA/mv3L1PuGVv+r6NF5WXOFyW9fU5MK8hB
	 7Osq5WzHVlS+adGe1XiqAu1uRYXa4VLvi4M9Iiig8PUX2iQfYYrsrLbG3szaWj376UPAx
	 S7UynzW8oXeNHKTnZnRtWGKNc2kmDten4jC8iauL30xyjGMc7fYXex9bA/Lcp8Zcb5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i2ARFhLS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508DA606A323
	for <linux-rtc@vger.kernel.org>; Thu, 26 Nov 2026 05:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i2ARFhLS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1ED1F000C4;
	Thu, 26 Nov 2026 05:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795672445;
	bh=sHaCAB/QD/y6m/izTtrlgFiJAYzgA8AuFZENk68btws=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i2ARFhLSQLW3XuZn6mQ6Glq6FA2f4ZuJaljelXLsIZOLqNztmT1mjsv86xC+YVXyx
	 AZBCX7EaXSObtdv+y6yOaYT9Xu8+ETQJ+lpQe2shaU/Y0fu+uI32hQeEzMJdM0TpSf
	 rdBBQrfnYo/qzGjBP7mJP2I3mSdRI0TVAJz5C97x7LIxpJ+NQa2QMdfStSBlcspJ8g
	 qmTz7kzUFVP9zH1QYsqtaI3jXpeXkCtQnwz3qjng/tgKCgPOvkb+AUdko5362Ydr4e
	 TevwwZKOXlTu2PvbhcVf4rWg0ni1tNPrGyA0o3leTw/HzRp8qdfPEbqLhYwVyNa9ix
	 5tdlVwaTtzJ4A==
Message-ID: <sashiko-outbox-234808@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: pm8xxx: Don't fail probe if the UEFI offset
 variable is missing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gopikrishna Garmidi" <gopikrishna.garmidi@oss.qualcomm.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261126055009.758156-1-gopikrishna.garmidi@oss.qualcomm.com>
References: <20261126055009.758156-1-gopikrishna.garmidi@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 05:54:05 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> On boards that set qcom,uefi-rtc-info, the RTC offset is read from the
> RTCInfo UEFI variable at probe time. Not every firmware creates this
> variable. On the Microsoft Surface Laptop 8th Edition the variable store
> is accessible but RTCInfo does not exist, so the read returns
> EFI_NOT_FOUND and the probe fails:
>=20
>   rtc-pm8xxx c426000.spmi:pmic@0:rtc@6100: probe with driver
>   rtc-pm8xxx failed with error -2
>=20
> As no RTC device is registered, the time can never be set and the
> variable is never created.
>=20
> Treat a missing variable as a zero offset. It gets written the first
> time the time is set, as for any other offset update.
>=20
> Fixes: bba38b874886 ("rtc: pm8xxx: add support for uefi offset")
> Signed-off-by: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126055009.7581=
56-1-gopikrishna.garmidi@oss.qualcomm.com?part=3D1
