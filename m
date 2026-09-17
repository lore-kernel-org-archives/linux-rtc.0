Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BC63BD65D
	for <linux-rtc@vger.kernel.org>; Thu, 17 Sep 2026 19:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789671867; cv=none; b=FsOvGV+lmnlY0leP4A58a555/VRD1sgE7lN/odEtExeOXG5nkMr9Dpn2/ucSJtzgxcDSbbU9lydAnWz+p/NugJ09enICBgAWkhmJCIpALWnSPawES4DKlTybEv59U5VaI2/bnPKMWgor6hyBev/PsbIudMBD8rley9pzg0xaxYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789671867; c=relaxed/simple;
	bh=UxltFbiU7dgyck/I50r7OVG4tFsIQtl9nWfhUQ5hPeE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iFpnUrn7tYqMQWJDyS8haapcb9IccF3WjcOrGKQuLedESDlVoLvYFMNKCDFzjwoDGKbrWjk+eVHgdq6L9D2fAtNdhCdKEKcXo3Ckfotmn3EPtvOF6/UcXw3xv2/bEIKBWc5HXnE3D38gTsv9CsTjNspolfZgT9Wx2BPUlDwbXjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBJ3rXM9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBJ3rXM9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D000A1F000FF;
	Thu, 17 Sep 2026 19:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789671866;
	bh=UxltFbiU7dgyck/I50r7OVG4tFsIQtl9nWfhUQ5hPeE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aBJ3rXM91DnYxNB9/Hyz9f2TzBBh9oyl5qU70AZKT0nDiEIHxly/1rDMEFKhetFGX
	 UjLqsaWlj7WPOkNvrM0htnUfa+uFHJbIaqkR/nw1uQESMcIjSWnZlZUwBsIX9fw1b6
	 Eawk1wADGRWA721zRGfJrMUG+APVECiGg+tn1rRkg6DRxDY+oPPB82njzoKY+nxpKI
	 s+ycI7WrZewRdRo/P3CoQ/KyemN9IS/h8eFu+bMCJab/W2LjYSUxrZbaIxOdA4oMSV
	 nAfxOT+kyHxEnH67ZDU/GUlY5veD980SPtEzzRQAAOf2K0BRibPcDTTu4mTLUrlKjl
	 EnCyzKpaklkQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/4] rtc: rzn1: add R-Car X5H support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wolfram Sang" <wsa+renesas@sang-engineering.com>
Cc: wsa+renesas@sang-engineering.com, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260917185903.61253-10-wsa+renesas@sang-engineering.com>
References: <20260917185903.61253-6-wsa+renesas@sang-engineering.com>
 <20260917185903.61253-10-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 19:04:25 +0000
Message-Id: <20260917190425.D000A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> The RTC on R-Car X5H is a bit special because interrupts are not wired.
> Future R-Car Gen5 SoCs will have them wired again. So, create a
> dedicated entry for X5H without interrupts.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917185903.6125=
3-6-wsa+renesas@sang-engineering.com?part=3D4

