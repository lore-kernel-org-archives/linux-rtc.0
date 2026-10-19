Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444963;
	b=lKhmtDyPZstYQ4SmW7AXc41yXQ4BzPRD025icP/+2kjNlBOlKtec5KYsDBYxjl+O/HQl
	 KrovF3qCMD+3uEC1iHduGdhhQV15ORPoUgEvcVqkulqnj0VYt3jAqYizgh8LEOEwgBDKj
	 WxNHtJKz4TGRow02PBTk+39OxM5hkjaohrhIwIRoOwHmxruloK1kqctBsa/tGmCEOrA3D
	 Qb47D5oIcNvWYyCx6YX1jgK481ENlQB8W0twC6e249p3S21kUeAA6M4s7RC3k0z4VNeNR
	 +DTyiKi8QcSXcWLzHmKOyBQTUQ8B1QTz6Eek4ZLRSpRg88WD99iHqQGAe2LTCuzQydA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444963;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Cr9aJcH/yg/55zb6+frdcL9vvTXFb3dWfgc28AVB3z0=;
	b=k37RY4C1Om2lkWRoeh4MWV78ScNbdnmvtwz5LQDc+5IEogbpPx9DpTo0wfThe7Dga7WL
	 EaWaZfEzwwruoSb8a1I1ytHsUd5ckoHj4BkfxNAqrAR/QQAOi9Eh3JRV1aI6E4FNMurl6
	 3crMNksb/fqi4aF/lFfiCYyJHO7qD0IVP4QScj8TCAhW0Y+hGxbzyAcEP2Jm+YBxOEEm+
	 8/IzUv1orytxsN5klMx5A3oJg9WFZmIdZ6UZk7HIpdUTDQVsG+fcFvIFhwDeNToI+abDj
	 1ZSjWy2Gm6RhwkMtpn0oC/Smzc4zRNOpvDjpBkc7Hg0tyeqaYpAL+gXn8ZaXrlX6FAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nRfq1f/8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043EF606A323
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nRfq1f/8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7254A1F000C9;
	Mon, 19 Oct 2026 21:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792444962;
	bh=Cr9aJcH/yg/55zb6+frdcL9vvTXFb3dWfgc28AVB3z0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nRfq1f/8KAM2gpsGA7lEY7bCVS/q8AL3dYPu6pSSmjWL25AzplSeb0DUCoFAf9sVa
	 0O5fldmMSwGSq3KSmbQCYSx7mpmq+hRPSbNGPWnhxw5cKCbtdG6WoloKpR8NMA0bML
	 3A3v3Vh1mit4JsAnTVGdPsDIMPULyvwugNo0A/3HBlmJ/Erv0hsbkkk/ClUovoUBk1
	 fPrifAsYBAs7SqVD/Vytn+3jbaXtqRKwfz+mgvvTQAwsPL2se4kOrsqdS8dQbrPmHU
	 IxE6Y35FM8xXazuHd2PK5yCh5CVBeMoHYcLsmrzP0sEj1XO2SDoEFFUBhIF8+NfTj6
	 O8MNFlUG5j9eA==
Message-ID: <sashiko-outbox-178243@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/19] rtc: rv3029c2: use guard
Reply-To: sashiko-reviews@lists.linux.dev
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org
In-Reply-To: <20261019211827.126262-15-alexandre.belloni@bootlin.com>
References: <20261019211827.126262-1-alexandre.belloni@bootlin.com>
 <20261019211827.126262-15-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 21:22:42 +0000
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
62-1-alexandre.belloni@bootlin.com?part=3D15

