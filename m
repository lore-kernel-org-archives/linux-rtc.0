Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792656861;
	b=Hm3YQbI0UwEkGh9LUHGMAdfQX3r/rvgM77m0VG21K6BXuUCRrHbgPPK7xDPd3dPXM1tg
	 qFiAmTg31SIouHNtlsS+w6s4V9WmFsCCHfzjGBwfgpAlFF/kAeW4/2l3j0/DbsAvjLjzP
	 haDk1nfvxRTcF3eXbjyljNBq5w18HRY5qkdjoyfKb8LsDYx+jnvkCz4ETNimh5EsUTspa
	 ZRzxykBPvNdzpr7LanDvPjQe6NQNNeAXFMw2OQtrXTGymlCgBPBds0Mgpzj/Xabw0Mzef
	 oDIWuvdbpmtG9T3D4A2iPq2vTV7d7UaULzsVA15422uK9scafosb1fQ7b9DESuNRCAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792656861;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vOiYYVC2P35OiIFhjTjgfACKLNvt1Acla48Q8VB5jf8=;
	b=gUZ/JYI+B36R/AoZKwDNUfhQsklrCIEyyEGj3CEbJGgTQ4IQUIbKbmSDm8hy7ijJs18R
	 zIm2/RPjxAj6FQCZ0wRSPJ0EiZXcRWPsdYAox1j7rJVGbWVrTbjun2h0+v1AfwqhBmX8/
	 a+mk9/hj0MLWTIA+y6U6OfYUP3LnS4sypVExOTjnuFvB/aDRp1Cpvrdvg7nAxgGCYaHPh
	 5nMmfL8mS4USRy97vraJvpq1tnVIMps/7EPYGdV3r3Ty8PquVmt3+AnFtleMTBgSnoNsD
	 ToxdU6bu/ElnRtmdovNnAjPnmhdBkRWhrzjW/0JnQb5dpNnB606D5sRclllUpEkXUhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M5mHtzck;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CB7606A319
	for <linux-rtc@vger.kernel.org>; Thu, 22 Oct 2026 08:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M5mHtzck
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974C51F000C1;
	Thu, 22 Oct 2026 08:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792656860;
	bh=vOiYYVC2P35OiIFhjTjgfACKLNvt1Acla48Q8VB5jf8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M5mHtzckQdcSlwtHPE7d0paeL+oHZr8jipjEjiiZDp6+LiPCj8EsuBppzkVmFFBGj
	 HBcPpFJPzzR7rbUHd8RKYQZqHlh/HuUxMyUvObZ03T+bAZxgZn6Ywdo06Mm4ao0LE4
	 z5DFX7QgzgWjUwTcFUusvlNvmE6atahEH1o8lB5vTL5EnOBDtvBexT4tr0jfbyoVo1
	 NiLFDR6iHNsJkd0SBcmys5dT6ruIYF3aOM0iNJoDbYDTEhwXDyXO8u9dwG5tyiLhxP
	 mZzk51w8B2H1wrc3XwiGbfGsoiqsgs5z9aC6hCNztxqTz4rjwfpOGwvLslEacO4iFh
	 qi4/f+MCGQLqA==
Message-ID: <sashiko-outbox-181155@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: rv3028: use sysfs_emit() instead of sprintf()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Akshat Rawat" <akshatrawat095@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261022081242.421-1-akshatrawat095@gmail.com>
References: <20261022081242.421-1-akshatrawat095@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 08:14:20 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> Use sysfs_emit() instead of sprintf() in sysfs show callbacks
> (timestamp0_show and timestamp0_count_show) to conform to the
> recommended sysfs attribute formatting guidelines in
> Documentation/filesystems/sysfs.rst.
>=20
> Signed-off-by: Akshat Rawat <akshatrawat095@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022081242.421-=
1-akshatrawat095@gmail.com?part=3D1

