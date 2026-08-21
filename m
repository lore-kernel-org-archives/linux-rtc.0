Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D30B4ADDA7;
	Fri, 21 Aug 2026 14:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321105; cv=none; b=EIfir+D4bNd332tqZYI04FiAwagh8CUBBcBT9mCh7w5ssMVtQy5B5aGK/tmKP1xzzoOa2b6mOF/U3KNf5iptNGXvoDl1Wl7Mq41zPfo2JzSnQisLpLhjthl+EJQxu+oSHUXyjwcrhC3cxbgEKgvXQL2pGSJNIAKZswTfsrg4Qd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321105; c=relaxed/simple;
	bh=/0pdMUPLbkWBjCzi9MV1YCBobBefzN3WQSSLMHjqqoU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xvd1Tlm349rK8nNiumSATy0St2goCNnkAhFdgr5FjpPDMTeMeQ2HIFDaqBgp3XDCCWL3KwurAMRP0J2QU4N/TSG/SbFGBGv8XN3AeLm0ulGdMOMxBVLTe3jkhPeJ/sqtGsUnZYQ9N1q7sg/l7sEq75oo+YXQhDUFh/YRxXlDzgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahuwS+Xk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahuwS+Xk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBC11F00A3A;
	Fri, 21 Aug 2026 14:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787321104;
	bh=/0pdMUPLbkWBjCzi9MV1YCBobBefzN3WQSSLMHjqqoU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ahuwS+Xk2ZwVf3FeXkBSbn+ZchJNsTLrogN3mC5H64x4GlTMHVx5petDGqvEqkx1c
	 5Tx3Gcm27WNuQXgl1LlQaqt/BjxKffdfZNH7sZd0tkvPgStnztAtbFVN8kZnO1iIy9
	 QHCth1eOTsivTMnd0Trt/5LCLBZjB08ZAf75OyLaGYCTtPGlmrfw/DwEElDLDtEUtF
	 G9iJebQH9/xWdklGJMt+67AU+bXC2fsACY62G/MS3vJccgcan1va5FYIJ/1sm5xqzk
	 MPS8hvN9l0UzF8G2FsvCq7HEThe+I7OaHyR7UyL5Q8uOfdhQ5Ikag/qRocyxqoZeIc
	 AOnHCOlxBr2kA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/17] rtc: rzn1: Use temporary variable for struct
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, wsa+renesas@sang-engineering.com, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260821135608.275233-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821135608.275233-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 14:05:03 +0000
Message-Id: <20260821140503.BEBC11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Use a temporary variable for the struct device pointers to avoid
> dereferencing.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821135608.2752=
33-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D12

