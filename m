Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B284908CB
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 21:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594716; cv=none; b=sWMc5OODWm6zikvh3SIpN96qgn/8g2JXTGSGAtrj24dN2fMCDebLPXYTD8U79TB+1HrYR4fkuuA9Z/cKhn1Os+TI2vNrvEheapUg3QB5nI/EKNat4+XoZgzeGQJIXKPZVX8vPxDVOCeHohujDA4KZSjLJITErG563Ck8ztQ/3FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594716; c=relaxed/simple;
	bh=rispqrUp7urjl4wuDIuitG971U4sxHW5PiUu+hyFxac=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pXjUTkcG8Q6sFH1KS5fpwzjHg2zvdZGdr8/xoeoKsP+l65EIMzWTEvRrSMYYdM9lkG8DloW3drpcz165rNByEuJcJs1+XlSZNxTIcCv/Lbt9ax63rvEkbYdjHfkPBzw3lUEgddyNAKuxPWXVoNoYwEZW4lEfZTaRbfCEygfTHPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJTWdEiA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJTWdEiA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528DC1F00893;
	Wed, 16 Sep 2026 21:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789594699;
	bh=rispqrUp7urjl4wuDIuitG971U4sxHW5PiUu+hyFxac=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UJTWdEiAPZBC6ifoUtyDzk7lSr1BQKos78aALZqA+WlpLSk81R5VdYjgKOx4G2el/
	 LHBWs3QxOEoz+re/+fZM9PIvYEldWndSSltapySkH4Vq+USYF9pFq303ICNnA59Jf5
	 oG6xptrpNa71XM8Aiha+tWofLAeLKUiHsj+a2/itgz+e1Fp/QKfr5BwhUQcvZx+lum
	 7jU71OnHrpA9+ip7TBSt2PJ6ottSU/dkSVetjDcAy080Pm8twY7hDKmXZzAC2jA4Ly
	 hfZvuFJEYlgwkuZuK7a6AhHbdwV8MzwDkeKndvRqjwq6sjIKyPifw63l8ps4b8Ng7x
	 3gJcXp5R2ancg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] selftest: rtc: rtctest: don't mention skipping
 twice
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wolfram Sang" <wsa+renesas@sang-engineering.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260916213108.9234-6-wsa+renesas@sang-engineering.com>
References: <20260916213108.9234-5-wsa+renesas@sang-engineering.com>
 <20260916213108.9234-6-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 21:38:18 +0000
Message-Id: <20260916213819.528DC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> The framework already annotates that we are skipping something. No need
> to do in the tests themselves again.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916213108.9234=
-5-wsa+renesas@sang-engineering.com?part=3D1

