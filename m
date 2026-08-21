Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7FA4BC00B;
	Fri, 21 Aug 2026 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321164; cv=none; b=bVMIJsY7dCdF7doRQCllyMte33ubObgwCIr7doJoz6fPcjibklsxnuPmIQ71BhxEYqLgKCNzsJOjXtLCcCf5M24R3v2OJ4mbjGL5P+VD/IZzDQw1Oz+yNsyckYwxf8sUeGU86j/uhNc1vz7MTXGW8scNveAfuSq3WGEbMhWFTyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321164; c=relaxed/simple;
	bh=QgdrOM6wDy5DcaGJ5EreehGoCWKyfYYWT0WpebpnYdw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cS56zUkH0XebXQYBFIkMuksydiOMuwBsaM9lE6eXdX6tgronJJ9US7g7HJ3FdqcjF3Vg7SltWiit8j4a2NEEKm6CgudqXRqX5tMfAPiSTGVzwntx63b+bsfYilsXrH1dGomIKZjU6RhFP/RaW2icj1kmfNMS5RKUmE0rPRD9pdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZS2q8D6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZS2q8D6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABE51F00A3D;
	Fri, 21 Aug 2026 14:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787321162;
	bh=QgdrOM6wDy5DcaGJ5EreehGoCWKyfYYWT0WpebpnYdw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eZS2q8D6oTPlharVX8CYoAuWuVuMzqtJRwdtiPjNZ/p5qv70eTSco7mm3e/KcJ4K9
	 88aOkq9aKwWAuHb2GixEZdF+dAP3isHdTJtA1Ec5FmckLU0T57WrZSoXceV71osfUE
	 bUmH65z9v35H2HlUL1rlTd7txNTqaNnz+oXiZsL2+/Pt09/Oqbqp+X4vuzp7xek+c2
	 zObBVSuU9b3Lmr4//siO23VkBczTxCDLNkULooudpYpHnJD34OSMjez64DJ6GsCugt
	 9U1QGP8SFNdTiZSZaoEU0+N3jnNq/sdpCTWnwgju4Irf0Fv1OixM2ZAgWON+DGgVhx
	 MQQVYzAORSJhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/17] rtc: rzn1: Fix alarm range check truncation on
 32-bit systems
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, wsa+renesas@sang-engineering.com, robh@kernel.org
In-Reply-To: <20260821135608.275233-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821135608.275233-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 14:06:01 +0000
Message-Id: <20260821140602.1ABE51F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> alarm and farest were declared as unsigned long, but
> rtc_tm_to_time64() returns time64_t (s64). On 32-bit systems where
> unsigned long is 32 bits, the assignment silently truncates the upper
> 32 bits of the timestamp.
>=20
> Fix by declaring alarm and farest as time64_t and replacing
> time_after() with a direct signed comparison, which is correct for
> time64_t values that will never realistically overflow.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821135608.2752=
33-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D5

