Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA61375F82;
	Mon,  7 Sep 2026 20:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788813722; cv=none; b=Q8KTMAXmhc+VEOnDBCYNyKEUJgdt/q5D17a+qp61sdxvwyiDb4t1lRDQucutmG5grPr9CNGmF0i7x29EpctN7Ge7H8J2oXJL4U9I8Iz0OCQxRNJt/Sz5F9j4T5oaXmQoR0yKQ+7KP9GkzO5XMwwm7d3uuJ6LhkBgQ3ikIrC7W9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788813722; c=relaxed/simple;
	bh=D6aZBmEa/q6ucgp9j9dade9pYGcaG1aPdUy9y0LeFAg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W5vZleV40890VIBVGlUaTHXH0y/nfcFHShdA3F1RrL5Y8cSSns+5qVl4zUUyzFtZsLl/Q+5b8ROxkKgiHtXxGFccNT4/7P3DPYbpv2WE506SK3R2TG7IYbgEI5v6fZEiR3fpwQ1rjeCEQoEXADdVc6tbNnA7CcjF6My6LqYArAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LovKCuld; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LovKCuld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584301F00A3A;
	Mon,  7 Sep 2026 20:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788813720;
	bh=D6aZBmEa/q6ucgp9j9dade9pYGcaG1aPdUy9y0LeFAg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LovKCuldlPpSEIB4CtAWUcVPXwg9cIUU/E6sTqiko0OEB1m5I0je52GVlixaYcm2+
	 Bu9sTmbDdX4Qt4k0+BDc6trD/CljI0RwZBcafOpmsu+3P4d2vMKA616bmFRaxkb5O6
	 6ukQiAWOLECnRfiXhPuqBCVglmyhn4YBr//SLnZChbewPSsyq6LfWl593npI+p62H7
	 FvGJRSdRM20d585prrjbrrKSnV9NmM7fISRukY7ysHWY4xC151Wmil1wAEZQvzbj6P
	 yQJa5ykjv3MkkyoY0GL1Df48HasvVoiuG0e9LdfA2+Eh4Cl7UCN0zNMccYiwp7i6Kf
	 8SE5x/VHG+JYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/9] rtc: abx80x: fix error check after
 i2c_smbus_read in read_alarm()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: robh@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org
In-Reply-To: <20260907203216.53192-3-apokusinski01@gmail.com>
References: <20260907203216.53192-1-apokusinski01@gmail.com>
 <20260907203216.53192-3-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 20:41:59 +0000
Message-Id: <20260907204200.584301F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> i2c_smbus_read_i2c_block_data() returns the number of bytes read on
> success and a negative error code on failure. The existing code treated
> any non-zero return value as an error.
>=20
> Fix the error handling by checking only for negative return values.
>=20
> Fixes: 718a820a303c ("rtc: abx80x: add alarm support")
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907203216.5319=
2-1-apokusinski01@gmail.com?part=3D2

