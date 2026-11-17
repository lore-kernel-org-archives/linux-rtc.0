Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794902065;
	b=iWs4TVDiAzab6N7E3bpM0XmLfNLaKA6vwU6dTd92ceywor0tmll/VO6yWuYVVfRmAqDb
	 Mf1uyKdmS9qjjkpE0k2FPTmHV97ioGqI4v7i2bVPSShqxeIpU82xlcNiylcFLir+VPk3c
	 +5oNoi8fMZjjDyz8dJEomVBlER2ERdIas7jpwnH+kwerIN7kr24dQEgjap3hZF3jUauus
	 k5hxj/xfTIFHeuigODJNPcmZ5zj5b8xUxYcpP6XvtCBR2KDwUDOuJWvJU+XDCiPGbu3Hl
	 Z+uvXf2abmdlCSJGKpSlF+M5lfi4uhhU6duowFQIy8MnRPlDRkbbmIktHsPjKDg6sEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794902065;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GmfHz4lPRspXOsgyjrzo98uoOEk2J99E0OwPhD7JFcE=;
	b=eAq73kpEOnsFUKy1UR4U7yzLQolNiTuku41m2GaDy+VO10OwAMTPF5EARvZkWwxAm3f/
	 hCqmiZtyDi2MejLTB59l7BWG/ttJgXKyGiG6unMnfH7D4q8jVIhDbt3yTXloh7rp+JBNh
	 Gy5MlV2iwYCOt1oCYzahqQ77wUkwpr+wdx5d7nQYSn00dY6dbkqYmbVSR3kFt5FEsj+Lg
	 s3lcrzpkrYw/lOmB9+UkoSE5GpyMxBIyVjiWC8UPXr8yPA6YFCIlE/9lGJL38nyiJ5a5O
	 xx4c2M050NTXuNOh93lHU9fdjBORr9GMY7anXFNpZtPerlOKDcElzCXi9u7wx1LbCng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YEbYs5DR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D90606A31C
	for <linux-rtc@vger.kernel.org>; Tue, 17 Nov 2026 07:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YEbYs5DR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4061F000C4;
	Tue, 17 Nov 2026 07:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794902065;
	bh=GmfHz4lPRspXOsgyjrzo98uoOEk2J99E0OwPhD7JFcE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YEbYs5DRjRk5K/CmhwKTIJKhsrbRA3e3VjH8udglxkbxkRU/dIibx1lLXw71gdvwh
	 1DPc7MFTTm1qoqPvyrBOkhhmp7WP/QQco2wX3EABOAQekNseRRIwWhhxkEqfme2tzR
	 JmvElZ43cEegXzt4lbIfcEROs9KO4GAK3ldcSMNdC9lxEZ53kjtHBHl5SlQpAV6+Jc
	 V4HsL1Oy8kNJazWZTewsU7zBr3XA02m5fU1jbLfd8Fq+qx08LcpJX5JL2TKcynqQSq
	 cDqljxUlLLEhjkFTU+jw2VG4q9CU6pDv1VILYKB86xhiHojj43WAklp3CgyrbyF5n7
	 Xc0v4bU/MHuTg==
Message-ID: <sashiko-outbox-218387@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] soc: qcom: Add pmic-gio GIO framework driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fenglin Wu" <fenglin.wu@oss.qualcomm.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261116-gio-framework-rtc-driver-2026-10-12-v2-1-b60e6fe33831@oss.qualcomm.com>
References: <20261116-gio-framework-rtc-driver-2026-10-12-v2-0-b60e6fe33831@oss.qualcomm.com>
 <20261116-gio-framework-rtc-driver-2026-10-12-v2-1-b60e6fe33831@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 07:54:24 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> Qualcomm SoCCP battery-management firmware on Glymur platform
> introduces a new interface which is called General I/O (GIO).
> It exposes functions through fixed-size register blocks grouped
> into virtual peripherals such as core, battery, USB-C, service,
> settings, debug, and OEM, etc. The data blocks must be accessed
> using block-aligned transactions. It also generates alert
> notifications which could be identified by a pair of peripheral
> and alert ID.
>=20
> Add a transport-agnostic PMIC GIO framework that validates register
> accesses against the common GIO register definitions, and exposes the
> firmware register space through regmap using transport-provided read
> and write operations. The framework tracks transport availability
> and notify consumers when its state changes, and route alerts through
> a virtual IRQ domain while retaining their payload data. It also
> provides a group of managed helpers for registering GIO transports,
> state notifiers, IRQ mappings, and auxiliary consumer devices required
> by the transport and the consumer drivers.
>=20
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-gio-framew=
ork-rtc-driver-2026-10-12-v2-0-b60e6fe33831@oss.qualcomm.com?part=3D1

