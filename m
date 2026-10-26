Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793028401;
	b=FTETrW08xRDBP4sa4KTP4EwLLcsCJpPapVYDsD37UCr3N3KFEDtzSUWEDAF8WAfmyxz1
	 xgHQXFopWqlvfM7jn5G5xKV4/zK9RBo2hdb1yzmhz8If+ZtcX5v2lD6Ql9V8C+HPFeq3F
	 YW2RPT/XnyhvwjyHfK5uGAp3AhlMdIebsLd+wIaXoZwG3UTlClDr+WgSt2mTUxrR5SlKb
	 LniOr75y1gLufB1aKAlNzkpgvwIRyR+98Lv5r1hnQAZLjs561/w/V03mAuDWXXP1gRxxl
	 5aGv8g4k9UuzRVTzjmkuh4QPUERYOL9jCYhUecBMVXTV4JJTi1eHWF+QyiN05FaLwAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793028401;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ggDveh1PFeampxc7IsAwYdv+muCaVgi1SWiYxQvh47M=;
	b=dBe27JfnWQMkMdcJUDYOMxNLzfyY8Lg5a+c7MCq6ylLGZHBEWHllp+98W0HXsXwPN3SY
	 Yv8hhkPYHW1pUHANDmcE24AuHLjRrKSSGKvtDMaaAB3CX02OLKe+/AdVxMG6rUn4sCJQm
	 l/Q0XoAGdgYr2DteydDHaS0Nzb3SPSx3+qhdx+XNw7wlLCNGVJGpfQp35a6Eht6I2udPj
	 9p7aMsX76Cq51MtPFYWOK4ZBMjtmTIcTuBWuz6I/M2SIDQuEpPl8XJU/kFuG6eWnQoKwS
	 lO/hxbTXqGsrtiZT9Lyphc0meUld8RPDoKocae2rYGKEhkoitfdoJGCURWGLusySBCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BxikQVTv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9394B606A321
	for <linux-rtc@vger.kernel.org>; Mon, 26 Oct 2026 15:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BxikQVTv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172F91F01828;
	Mon, 26 Oct 2026 15:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793028401;
	bh=ggDveh1PFeampxc7IsAwYdv+muCaVgi1SWiYxQvh47M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BxikQVTvxlZVPm5HtlOvhwRox7UGAG4NLHpwvamJBMEkIPA1SuLKUNnEIqnn/9Tso
	 9XnYyq5deeVNOGtF4sjONCAAL0kjv3fWFbI5Mn4RfoXirOqB2qhxJ2wmDIAokUEC9y
	 kLYJItSw9bkFuiO56OT3Nn2QhTQtgMmmk0p2EZAc+kJBDO2eW8xT511+EiMcRy9nh9
	 G/QCVSBlJ17eA0nM6RX0h6O/k5Au9YlZOugtiFn8/hJ3Ua1YLcgH1ZJ4LHFxntFtR3
	 lPn5h/2tE00eZeWAVuIvKtZji4YfXW7Lj2Le+Zmt54JKFwYMotSnZ3SowRo9OTgZ8Z
	 j8EuBVpgJi0Ew==
Message-ID: <sashiko-outbox-185436@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] rtc: efi: defer to the ACPI TAD if it can drive
 the RTC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hamza Mahfooz" <hamzamahfooz@linux.microsoft.com>, linux-rtc@vger.kernel.org
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261026152103.3109313-2-hamzamahfooz@linux.microsoft.com>
References: <20261026152103.3109313-1-hamzamahfooz@linux.microsoft.com>
 <20261026152103.3109313-2-hamzamahfooz@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 15:26:40 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> EFI runtime services are best avoided where possible, and ACPI defines a
> standard interface to the RTC in the form of the Time and Alarm Device
> (TAD), which the acpi-tad driver has been exposing as an RTC class
> device since commit 8a1e7f4b1764 ("ACPI: TAD: Add RTC class device
> interface").
>=20
> So, make rtc-efi decline to probe, before calling GetTime(), if
> acpi_has_rtc() says that the RTC can be driven via the TAD.
>=20
> Also, to ensure that acpi_has_rtc() is always reachable from rtc-efi
> when ACPI_TAD is enabled, make RTC_DRV_EFI depend on
> ACPI_TAD || !ACPI_TAD.
>=20
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026152103.3109=
313-1-hamzamahfooz@linux.microsoft.com?part=3D2

