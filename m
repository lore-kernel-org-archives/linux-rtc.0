Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962E63515DB;
	Fri, 21 Aug 2026 21:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787347108; cv=none; b=npLBcgeKenYj1lswtnhaexObK5kCcYi8jQf3kE4u6hTe36K0+KoAJmf5Dj2miWvEkJMSYKlrdey64aTJTd75UoCA8B6FkXR/hQttnHSjeQ/hcTJsUtkjRoUH1oiFA7ueUvkQst5y5t8BM81RJu91XG3ddwjZFv2BliDGS3TCPpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787347108; c=relaxed/simple;
	bh=xlYB0vZHr/4knM4qf/CmrXpMzMKE5AHrBifpe7c49Ks=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RJ2dWlgSOkXWT3bJke7xrcdc8xUWwei55IAsHNfWWGq/E50DdEd9mdXVuKPgYwAIChUJqcvEpYAcCIqQkgPnOltYhr09aCFImNfUOVqNmleES4ZuNNpU9deHGsRMm7evTHonGZccOgPZTrIbk2+yLBQ5W0saRbYapEBFPmN4bx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faEAjiBI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faEAjiBI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A60E1F000E9;
	Fri, 21 Aug 2026 21:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787347107;
	bh=xlYB0vZHr/4knM4qf/CmrXpMzMKE5AHrBifpe7c49Ks=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=faEAjiBILPG3kS6/0flkGdZJL2at3UoiG0Az2bZRcKtt7ORe3PEXij0cNsILeI9XZ
	 FFTeCVP/XoG5QhmhDQ3Lw3KN6wZI8FrWxkqT7SuWkm95prbuAWL8RWlxutre8uLuQ4
	 RDqDKGPIIK6Ip7WV+3nfab2e+KOkT7tJ/iqBnvukDJD/MxOtIGdbRW/ChNxjaf4YRy
	 ira57+j92CUqNU/PonGIZcCY6DuWuFC3+Bw9FewOOyedz9CMgWutYRA8aYpVa6ZGG8
	 RujsAOCCUdSQPjnwCqkWUo7zL+RAkSuBe8HUbRHBmN2wMqfxMEyfbGvm6mecULs2fn
	 3UhOZ7TA00aRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/17] rtc: rzn1: Use temporary variable for struct
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: wsa+renesas@sang-engineering.com, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260821211032.13554-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821211032.13554-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821211032.13554-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 21:18:26 +0000
Message-Id: <20260821211827.1A60E1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821211032.1355=
4-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D12

