Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5971E3515EE;
	Fri, 14 Aug 2026 23:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786748537; cv=none; b=JYi0Zf5cmpzhaGl7LmtUXANoyLw8XdHzlpr4vO6vDkAKeUutkpnlAp0tqcI24mZev/et855gksgLLpxUneG5NOfpzhOJY/OtIqIQDeHTwikOSpYnOJEatqIW4A1v1s4a4vyYbdPXOIRFpxZGaK4Bf+FG7a66E74Wv0jt6EyZ4TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786748537; c=relaxed/simple;
	bh=kAdHeZLbaJwX5Qm97IWqJqYm5i1EEYq/G+nB1T3Ek7Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Un77YaYSX1/riJyLjbpSN4SKLRSNhjC/CpmAlD3FMg/kB6wYuqXXVcBitMmnST4knrg9y764cJwItma9482JyZZM7y6zCu7DubMBD7dghychjlSiC5pSLf2tarrVy7Ff9MYHF6WSpQlq/KGl02tnnL8xTrD+SgLCUqXNEelGWuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GA/3mLgY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GA/3mLgY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5B31F000E9;
	Fri, 14 Aug 2026 23:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786748536;
	bh=kAdHeZLbaJwX5Qm97IWqJqYm5i1EEYq/G+nB1T3Ek7Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GA/3mLgYccOrc9mYYGVRqKOldIVhix+lzCiST2iaAPKadSbGGH5SsFBatv4tVs1EV
	 350D05MEJRNukZ6x5GAu58MZiFFAciaZLnAE9L3kLOKl8QfGVuFhBoBv5MNhAHDATl
	 Y4XMGQCCLS1RMlHRtojxP6UYAZqG+ODlUvc/FUqlkcAxcTcYCeTDThaH1Rd9AEu8tZ
	 w+zmBuP8nUfyH06k0SdduQReFs1M1FFYeviDErx8A7Nx+VqEt+xYx5+eGXjEKUji1N
	 odWrgwClBnmaGZgjEDeCTY2mc75Xum46H6s27SLc8p2V4DxzwB4ya9po7cQEjJIWJK
	 haf39DIN50m4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/6] rtc: s35390a: Add synology quirk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-rtc@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260815-rtc_s35390a_int1-v4-6-3133309c365f@posteo.de>
References: <20260815-rtc_s35390a_int1-v4-0-3133309c365f@posteo.de>
 <20260815-rtc_s35390a_int1-v4-6-3133309c365f@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 23:02:15 +0000
Message-Id: <20260814230215.DB5B31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Synology NAS devices use interrupt signal 1 for wakeup alarms. On ACPI
> it is not possible to configure pinctrl.
>=20
> Use interrupt signal 1 for wakeup if no pinmux function has been
> configured in devicetree and dmi sys vendor matches "Synology Inc.".
>=20
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815-rtc_s35390=
a_int1-v4-0-3133309c365f@posteo.de?part=3D6

