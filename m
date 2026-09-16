Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B15441021
	for <linux-rtc@vger.kernel.org>; Wed, 16 Sep 2026 21:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594538; cv=none; b=RwAkXbj3GbVEwj8CLqFGIuileETTplbSghyRdVoEY09a21v9+IbUwD6kjo1qu8nPJCqYUPNAoYfm2Wgtdw7WxOpW3yz0/5zmYZtDdpKffacG30uOZf0dJwcuWaSWgyAC+Y07Be10TJ29gBiEPiyEiniO3TkV5pCTRMuogFYdD2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594538; c=relaxed/simple;
	bh=+6OeeBaWxgKYoigijBpiDk+6Za6u6ZC+dPyxTJRRL/M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jF+ZsSi1KYYnfNDCGtUsWm38wYsc2KzeZLSDeotCTVmqoGd+U31XRQgBLyylKQqjvtkCI25BE+To6bLtSE5faYWVJITv4L/1ERw13jIAfW8C1N55djqnmj4KKEUG1D8bWNH8i7VfPluvk/zDCuIIHj5aQMnFjSYH+Fbf4FJR8hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TX+orwx2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TX+orwx2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C4B1F000FF;
	Wed, 16 Sep 2026 21:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789594524;
	bh=+6OeeBaWxgKYoigijBpiDk+6Za6u6ZC+dPyxTJRRL/M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TX+orwx2MoUKbkPqc2E6F6OmFEkydHY+146S24MtuvWeYu+tXNgBBVdThkLSRlzQn
	 10sd0NS2VQtnOrpIwCaioQ+PSleV7jI8jlcDQ3wUsUg8d7sF4nB2W5aFqkWAlmtfmi
	 mMFw1j9/qpEeSJpoIZ7KbmakEfsR2kl6zCEbLf2eZXBos4+h+hFOUQqcDoHl+G37Si
	 R5pSw1N25NebYeTUiRSxvrXmUFbSUn5yD2RvLI2vEUc80TP6ZoUsG2gZL0eiQEMnVW
	 KZbl9Luaf/bas4NhAN2mC2F1ZGe/l029oZapVC7dQ3x7Avlx0ONE5DFjbUOB6w1fAi
	 6kO3hvw80UJ2A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/3] selftest: rtc: rtctest: skip properly if
 setting alarm fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wolfram Sang" <wsa+renesas@sang-engineering.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260916213108.9234-8-wsa+renesas@sang-engineering.com>
References: <20260916213108.9234-5-wsa+renesas@sang-engineering.com>
 <20260916213108.9234-8-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 21:35:23 +0000
Message-Id: <20260916213524.56C4B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Use the proper framework call to mark a test as skipped. Currently, the
> test is considered good, only the printout mentions the skip.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916213108.9234=
-5-wsa+renesas@sang-engineering.com?part=3D3

