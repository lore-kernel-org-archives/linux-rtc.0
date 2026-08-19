Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C110337BE71;
	Wed, 19 Aug 2026 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136401; cv=none; b=LJLwcDR/N1ooCPnuSgr57O+TATU8c0y+RNmeidhp+8wCb8va2RpvoJE35KrJKSRtU7tgmIAL9u4z53RhI7zdTxj4nZ/BoZWTpjK2LArkG6XYyFMPO8f91hFHz47qZzg73bildDGcOUauldAAie7fYmgrOF+5c1sPG1EUDxGBan4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136401; c=relaxed/simple;
	bh=NRtq/1LeBQ0vELao0/RFGi6U3vNWb7tks63dguybxLI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KKeqBXZf20Rou0zcYHa8wDdTSMX8FkZZ1t8j9Wa6kusST0UzvCwbe3BQWXE0A/cWiZokEddCBR2JTlYf2Jf82MYlwdiPJLMyiwLqXBrCp7qTCCu73DPNyWGUxcgYn7zE0zlksp6981hAZCnilh4ULYCNJgF7WKtz4AIGKkp/BxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRenMdsL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRenMdsL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05AE91F000E9;
	Wed, 19 Aug 2026 10:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787136400;
	bh=NRtq/1LeBQ0vELao0/RFGi6U3vNWb7tks63dguybxLI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NRenMdsLba6daANI1cTVypdKW5PU1p7sD0nk+foASrZjsqwOKZ8Dj75zznYnSnTRH
	 vwBAWRP0+azPnxmHpnVpW9SXNj+S3Fk9nEDtyG8A1JcRf+4LXKXDfaSg12yfSy8l4Z
	 C+pWfhcGjUF9prUAAfymJKh9m8a6Yd7/mvp569f/jifdlT917tyCMIk0p1PRBxe6jL
	 c+BDsvsRIgisAjiz6sYpHLvZigHJ4P0C/lZJvQ7QnktDsGB8uJzoPHj6y71BG9mjCw
	 jFmss/SFvMtvflC4Z/cnIA/oD9B4IgVNWckfsnRxi2rYIKA5ES9mPzFCDNfZqKluwh
	 2x8xmfoXFxNIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/15] rtc: rzn1: Handle EPROBE_DEFER for optional
 pps interrupt
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, linux-rtc@vger.kernel.org, wsa+renesas@sang-engineering.com, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260819103926.2136712-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 10:46:39 +0000
Message-Id: <20260819104640.05AE91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Check for -EPROBE_DEFER from platform_get_irq_byname_optional() and handle
> the deferred probe request properly.
>=20
> Although the "pps" interrupt is optional, an error code of -EPROBE_DEFER
> indicates that the interrupt subsystem is not yet ready. Intercept this
> specific error condition, assign it to the return value, and jump to the
> dis_runtime_pm label to avoid ignoring a valid probe deferral.
>=20
> Fixes: eea7791e00f33 ("rtc: rzn1: implement one-second accuracy for alarm=
s")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819103926.2136=
712-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D2

