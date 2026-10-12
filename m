Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA753BED42;
	Mon, 12 Oct 2026 10:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791800157; cv=none; b=rayyir4KfaHjfPk1XzMPd8Vl+tRPsKw24Cor4r/5mKdku7gOm3Fy9dnMbn7RDXIng/eZh0lAdGAwzJMbk8xIrrS7ee/Tecr1UQXJLA4T1kga2io/ZJnoNnJT6TgP0yQL2p3Ii4CkPCaDyJTucZGbvnxXYM7c9ydU0Bg0w0RG9eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791800157; c=relaxed/simple;
	bh=QeJVyAuhn50KdJTgYxdFGVmsKfdNIyZIiO5eUIZNudU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=UyLxk+8sTSeAEAj5RIIsw+g69/Fy6/EvE0WI+yXPGFssRlUxXr5mwugVwV0LSoGY8OeChBMgCdUQXFUJeba5OcE+2WtPwyYrOuMtB53sykECEbNdWDfGiTqNuK3RSmpi5OHVnkl9tAck4WaDW9hKET+UWrv/9vsVYBkjm0bu+Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mb/TuAnl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mb/TuAnl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450911F0089D;
	Mon, 12 Oct 2026 10:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791800147;
	bh=QeJVyAuhn50KdJTgYxdFGVmsKfdNIyZIiO5eUIZNudU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mb/TuAnl2kgJZ9gtm6UIqRcj3oQ4jlbe4cBTkTwXkuK0oTZ8CeKtXcz7n9mkI7VMN
	 hOzUANf/wWyv1K4uiGxxsJ6vj2z1CdJ68RqRHkLRlGRgkc/rXiWsTTldcsSaXpX5NN
	 APc9u9UkfGlO1iDPaS5bbPa4ku0AdfAaHY9266C1OJUVKFXjamdh0Y++KfiavEYCzT
	 S6PUUrsRznOdjG6WPQchmkdE++TTqtorZ32lKxsZ4di5Ho5wa04/qvrlsuyiNSZMog
	 u+KDb2rC+87XOqwaPeKR4MLdg1ZDYfQGby0VbpQ3jjBVwXJ+4Jb34emCRdweOHrMzr
	 a8BgNVeijlSyg==
Message-ID: <sashiko-outbox-167941@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/11] dt-bindings: rtc: sun6i-a31: add Allwinner
 B288
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pablo Mazzini" <pmazzini@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev, conor+dt@kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20261012100816.331033-6-pmazzini@gmail.com>
References: <20261012100816.331033-1-pmazzini@gmail.com>
 <20261012100816.331033-6-pmazzini@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 10:15:46 +0000
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> The B288 RTC wires one alarm interrupt, not two.
>=20
> Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012100816.3310=
33-1-pmazzini@gmail.com?part=3D5

