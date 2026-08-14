Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D362882CD;
	Fri, 14 Aug 2026 02:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786674697; cv=none; b=ni4JFihyzDmpj0ZH5eVneOAPyZCYt1VxibTxIa8SA4kcWcFt+qaum4wglsivr151AuSd7CWOagQPEBEcbjHcBR2p0+Pe9WRl4UZjqySbgK3towI3i6A4hkGasPkNEX4uIsAS30D+v3lh8wEpLdY7L0mVIQeU/VKTLGmIDAEDqio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786674697; c=relaxed/simple;
	bh=IZwG7sanJ0A5MaD7bIOLF9BW1zFs+oqu2D/9l0lNBCY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GfnTkce9A+CcybfON1tQinRdZt76xtrzuxk604fAvzwhpW1m06pW/O5MHZhq0Fm8mLfURwXk3zjkuqYYmOkPVrkcP2sx8gLUkwlQ65ivDangYflnVODm1h0AJ7V6F2cZpEm1CXwCQ25/0fYs7zFq1b8wVjDsx72tMdqEan3gQqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVq4l+yf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVq4l+yf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32B41F000E9;
	Fri, 14 Aug 2026 02:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786674696;
	bh=IZwG7sanJ0A5MaD7bIOLF9BW1zFs+oqu2D/9l0lNBCY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hVq4l+yfnuFPVCYRWw+uiR0NzA+0pHcSkBxhCiWz0e1cqTBY4aZQHtYiIgTrt+JGZ
	 gKabc8K2EaIyiIpN47h3jFrI4+RJ/PM6w3RnhRvcANlfyUMd1w3VhklfZGK6En2m+S
	 1tyLXDM7A17JH3MjN4hYp46IR3dj8glogI/JIt13qJ4lbYT9nHR+3eLx/vHiXXQA/0
	 2A4pjlVMIPMj/tAna9xooa7Tra96qn0VAFpCwTEPjGqSKh1qR2oGMwY3Z3dvvyc/yv
	 avKAgMcE9JzmUP8cfCHf1QWhSmP5t90PCVayW54jROtioQ8SsCKhNTyYnCNhyJTnxF
	 jba8U3uFro9ag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 9/9] rtc: abx80x: add support for ABX81X
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260810193826.210683-10-apokusinski01@gmail.com>
References: <20260810193826.210683-1-apokusinski01@gmail.com>
 <20260810193826.210683-10-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 02:31:35 +0000
Message-Id: <20260814023135.F32B41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Abracon ABX81X is a family of RTCs with SPI interface featuring
> the same functionalities as the ABX80X I2C clocks.
>=20
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810193826.2106=
83-1-apokusinski01@gmail.com?part=3D9

