Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EA938239F;
	Fri, 14 Aug 2026 23:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786748568; cv=none; b=Rlw4IATFtvnxUcvAzyxxZ5qZxUNNotQaaaMRINEEPcz6/77nZvDQZGmBhKmHXqgbR0bMEIzxPvzIiqSPi6CtlaTpcZVf9IObNhsJ5A54qDboudzR/pM+fst+Tl2Q4AU2gJOotkyVwSi6XMvg2Gw/+rzfrgC6TnDBq1ipdHPCtH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786748568; c=relaxed/simple;
	bh=SXkXDkxQc4lYylCu6/qZ3UA1hIDF3W+hgaOcUt95XHU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uqgNodFR1GZbVOfmZFTVo1k4cuqYwWgMEuzFpkIHligt+lUk1XV5g5oCvtdcnLU054b6R+7pRFRmsAfwqiiEfTLr2ErubcJ767Zq9RnE3Xh4mGxceRIL3n7RlC+coVXk70+6ZJ7c+wxdI4H67um9jfYprnwOhDEgGtHWlYkhfxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQ8xbOwA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQ8xbOwA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDFD1F000E9;
	Fri, 14 Aug 2026 23:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786748567;
	bh=SXkXDkxQc4lYylCu6/qZ3UA1hIDF3W+hgaOcUt95XHU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fQ8xbOwAbko0+8DFC7dUZ/C7c/he68mTP5Bh3ZmrPhenuw6Ql1Fi4+I2KGhUH3DJ7
	 OC7WK1crOkOOAP3tlrttjyy5yQL8nrtNpSbJr9k3Od1K9b2xurPgfaWTU9KlRJ51q9
	 zL/bbF77l2YpxP5dL3C+fCYf3w7JA+xwdf1zUV/VPCPEd3urS1ojNXHN1YIanWe1Hk
	 esSmBNAEy0CTfwLvaGJxss2TFa9leQng3EMcNPGZpEUZIcb3xibgbkOhbvmUvOeh62
	 8MUqdFNhJ8aZzx5bJCHsypkaRFtje0i0kg48qAHTuxRlkqtSHReITHmMh6tTRtxdy3
	 SEcpqIPh82x9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/6] rtc: s35390a: Fix alarm not disabling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: conor+dt@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260815-rtc_s35390a_int1-v4-3-3133309c365f@posteo.de>
References: <20260815-rtc_s35390a_int1-v4-0-3133309c365f@posteo.de>
 <20260815-rtc_s35390a_int1-v4-3-3133309c365f@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 23:02:46 +0000
Message-Id: <20260814230246.CBDFD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Implement alarm_irq_enable callback.
>=20
> Fixes: 542dd33a4925 ("drivers/rtc/rtc-s35390a.c: add wakealarm support fo=
r rtc-s35390A rtc chip")
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815-rtc_s35390=
a_int1-v4-0-3133309c365f@posteo.de?part=3D3

