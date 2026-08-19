Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F43346E55;
	Wed, 19 Aug 2026 10:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136402; cv=none; b=cAvrq9sSpgMAErZ041pTE8xqR4B8X2cO/fTw+qo7AGRq9XpHer++BKnw04F8/25O0c3M8c+N9eTCPDQMath2UTd+O5XCs+wJiFvfTfjx28jV9b4dBpbugAXusJC77AVHvEoBKjuewQ3LWQz76RUNCBzj9KmM34ZF40KJorWUHDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136402; c=relaxed/simple;
	bh=uVevxZcyHuRSrm/0B5vry7eq90Zl85J5vAJMyvRSwns=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XQAcwoOzsGEXhtpnHJf2fugE7VPSJynUFf3VBnYIuSs2UgeoiOvQHAtT4/tCZakwrbeCQGQfuW3BIiqGkPO82tJp3RAGS3qR9Wh1+FyyO81YzLc79MnhpJOQ6FGvpxJXsi/PSA1QsRwhizoUeHZ6KCjkqfQa6HU9zEHzvAG59Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEuVkUjA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEuVkUjA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B3D1F00A3A;
	Wed, 19 Aug 2026 10:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787136401;
	bh=uVevxZcyHuRSrm/0B5vry7eq90Zl85J5vAJMyvRSwns=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bEuVkUjAWGxRWxVCxoQyYGIoTz4W3hTyptSl/xa+KEBdakg/eQgk76VjHCi5Yl9m5
	 fJjqp8c7QGdYSL7EyisJDs8gWDcAMyiHvpSAO2awmlp6oAZ4dHcqkpswDLXVsj8k98
	 OD4l1UntbUVx0fU1osqHzXgyiVfBnXkVEV/EDjhShsvjkqobMm5yc1kS7yfWSbNY2O
	 3uyB2i+40OdDXUu/VWwz4cWrKH3elGEg79WPB/ExIqHBvn69nZqS2zMhqAbE1nFvUN
	 8Ii2vgnLrChhS00q7nIBlFazcDtoLNVCdWD+pCE6ZZi3VaTJxWDEX4YwMAudcr1u4S
	 5j37hld2eWRCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/15] rtc: rzn1: Use temporary variable for struct
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-rtc@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, wsa+renesas@sang-engineering.com
In-Reply-To: <20260819103926.2136712-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 10:46:40 +0000
Message-Id: <20260819104640.D5B3D1F00A3A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819103926.2136=
712-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D10

