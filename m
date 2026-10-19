Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444964;
	b=a998gWPOe3AIgK+KLMk//bhTyP9K6NTvNV6aU6VepoiSNubLFtmlxked5sP/lN6id+Ba
	 V3DzzEFuzn1BPWs+Ucf0s+IydU6aOE8Sy2T2UwsBo+53umSKLhYv2BSi1XJ4slY0MvL0b
	 8qyYk7aLQlioQghAQQtctW1bpdAKqvZRKe+Pg/PBK6+eVTQMSyyb+sQe5YPuIP6hjv9po
	 JnR/OAkJjRludXbjbAy8GZCmJmqX0vkH3rgvvoiANoIZK39etB5Tzj8fUe9IaLOH+zStW
	 c6HhC8JdI8JcCHmjA2AM+8KgVHYyiX865s1POoMrHx8NM82ovTV0waKye4J/7inaqlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444964;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hwbAoCL1/SOmVFETGSNQlEjEk/Uo3lsdtcyBiR6Tkd4=;
	b=PZDKHX+Jz8jBdwtxOrxWkuyng6EaILEv7WdLS6Y8I3G8Mrj7XyMXg1HSsi24dqhx3/AF
	 bzDwxF9Hic04WmXFmsjMw99pTVBWVj74FE32SoA+rUT3Ih75nlwHZPBp2bcrzJGAfxYh8
	 kOt5ERzySJMlFmfRvPu9BST14K9+H9NGV/9nzH7C2qgE0lg9/4pcHwTxVbJ9cdQgdEdZ2
	 Gd8nhoc75JChRkfZ+qCOAKGtgX0WNSpPqkefJOBOLfqLcFRtdFOIqPYwavaTXCjUoZpft
	 wH4zG7WTMpj09UUzVMpngSe7BzXS8lPJA7jSAEGQwtBh0W7i2hyWiBRtLBAj6PDOGMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MkVIDM6g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E9D606A31F
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MkVIDM6g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140631F000CF;
	Mon, 19 Oct 2026 21:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792444964;
	bh=hwbAoCL1/SOmVFETGSNQlEjEk/Uo3lsdtcyBiR6Tkd4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MkVIDM6ggy80Ux1wEDHIInlYcOMY0t1Hx6qfGXGYDQGyEHHv+TaeJqocs/LYUS75w
	 vrjOJA0FRd73q4KpyPJVS0rOTaejXJY77GMXD2raNdlpNC7+SjAPDfbJIxhSosR+s9
	 J97/YzPy5QTBJ2a4FV6ZFfSYmlUPFyQs55SAT/PrdB/fh3zvCTC79UuL8Am9vTj6RN
	 47Q97YWoUezVcDQwQqbMTsARYEOtDxBKUhSA3uKZsktDYM1R1XOMXTkCksXYIh2e3X
	 6OlD/xzlBuHDA3D9pKlj4YwKgChbs3OYp9gRKLkxMTKqg0yZPpvao07V6KKBYI0YpU
	 IvqD35hcRZHAA==
Message-ID: <sashiko-outbox-178246@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/19] rtc: ac100: use guard
Reply-To: sashiko-reviews@lists.linux.dev
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org
In-Reply-To: <20261019211827.126262-2-alexandre.belloni@bootlin.com>
References: <20261019211827.126262-1-alexandre.belloni@bootlin.com>
 <20261019211827.126262-2-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 21:22:43 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
>=20
> Use guard() to simplify error handling
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019211827.1262=
62-1-alexandre.belloni@bootlin.com?part=3D2

