Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB2450E5BC;
	Wed, 30 Sep 2026 15:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790782777; cv=none; b=qnt33KWUdP/X/wP+4xmPXgisX4bNs/w4GYOObhf/h1vu2WO6LWFgyI7PTEEFWbcvoJ/MFmRvJXuDGOqHdQdFh4vZgyOTrQFl65QAy33LLoxtL5mLjdJS2LDj0tYW4TMJ/Fwe/WIhmCSw/Cn9+W57QKyKPuAs0jSYtAQppt7ngek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790782777; c=relaxed/simple;
	bh=BwXU1eIrD/l8NFOy0j6vv3rK+CVHJEULhcITxNTMaEw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sxKFYgGoRNU+khrl0aour/AAuaDACk7FV2QWUzHx/a8hJONpFt//W6EKYEJQNGLG47SyA7psGlaWX07dRITkI411ENr9J5NVLvu8VrOev181OTzOXXq5VLdmSn7aDcye+ObY6hhXgOJCdjhlZjcB1Mab5/Jf1L/TRdX7uLxDEAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5FRjU2F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5FRjU2F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270B21F00898;
	Wed, 30 Sep 2026 15:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790782768;
	bh=BwXU1eIrD/l8NFOy0j6vv3rK+CVHJEULhcITxNTMaEw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y5FRjU2FMvj91rgv6AlliragNabUgSDhmHRYjfcrRTrS39df8W9VO8YhIv45yjlVW
	 KxlUjwzj+GoUDRuNihEhFVuzAPFg6R0DkCO/03DfQwDVhSbzZyefnQUViwRpwwQ+Xn
	 Mib7V3trgs8WrrZpdMlFXjpFu6T5xM/jz1Tss6S4SP0li9kbI3TWbsw2vXM1NYf/vz
	 +KI0AA9pmDZoQcTxCPUttehR3Tj51Z1oV6+VE7yOCI/o2rujP/MF1DjkBKoFBWs2BZ
	 NoYT9Psch8IiGM77LjjmBZ6bSx5rENbbcONaouJSt5kqhie4dhv3aENAo9cUKnbSlB
	 3GQROtHLj3UTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 4/6] rtc: s35390a: Read 24-hour mode on access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: robh@kernel.org, devicetree@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260930-rtc_s35390a_int1-v10-4-e7b1cbc50a7b@posteo.de>
References: <20260930-rtc_s35390a_int1-v10-0-e7b1cbc50a7b@posteo.de>
 <20260930-rtc_s35390a_int1-v10-4-e7b1cbc50a7b@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 15:39:27 +0000
Message-Id: <20260930153928.270B21F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Instead of reading if the 24-hour mode is used on probe once, read it on
> access. This makes it impossible for the mode to be out of sync and fixes
> time corruption if resetting the chip while in 12-hour mode, as
> `s35390a_init` did not update the cached value.
>=20
> Fixes: 16486d0c1c65 ("rtc: s35390a: handle invalid RTC time")
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-rtc_s35390=
a_int1-v10-0-e7b1cbc50a7b@posteo.de?part=3D4

