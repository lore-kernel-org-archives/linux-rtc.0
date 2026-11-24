Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795505020;
	b=V/qMM6oWVAu+3iB84qnkSDZTyPMJk1EupHvjWS66rctrjijkZUd0UmyPLT2Vmy6LaIuh
	 ab1DQIIji/FrmANU1E1jSNP7KqjUANZzz5JS++BrmgOnSCj8H2L+OSOogB6cDUBb4WrUl
	 6mjXCNVo1PRSwHc3WqGlWpfCrKNky4S6ocJdVXcx7W114MmnMEtWHjgzWCvLlWQnHlgHX
	 1HQYhpEnAlwlyFfH0sQOYQQlmKuA7IufEpg1daUQ4G2etSF8xjzDebJFEI6flG44AMUAB
	 HC+xJPX/358VinftYWESxi5wZeFUZA5+LZjvI4kPlyvG3FXLTAHh4JoBIlcVNFG9CEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795505020;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2AaCFhjaJ2rABwvXcfrMBpku/wg6LtUTJuSoikP5FTU=;
	b=hoi4GnIpOacdDXrKiJiwS13GyGTHzUJipRgywg862+wO/RT7QxPEGYOwFsfLz5I9o5gB
	 UlUwG8kKa7l0grNKC6tFoOpeEgtKP+nocZYG9kj5vi1fvdu1oK2nYaMTe02U+ezvXvgtV
	 PiNXxWxvuTWmu76P7vpSZsOn8XKPWJigSBEp7d64muxc1YIxRbuKRgQWxOtJqX6AOD+8+
	 GChpF7AHErOoy4X86VNMPShXrQIRdCqI4cMIhTcLyB27gX6ZBzGpYspBWQoHtaj+hY2nQ
	 24b2mnzBZXa7af8OnzAISaoQ57qkTGBmldoUgEmjs9LdQEaoOYe+iC4wEox50IosaWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NWvH+Dpm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D79A606A31E
	for <linux-rtc@vger.kernel.org>; Tue, 24 Nov 2026 07:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NWvH+Dpm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EF61F000C0;
	Tue, 24 Nov 2026 07:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795505020;
	bh=2AaCFhjaJ2rABwvXcfrMBpku/wg6LtUTJuSoikP5FTU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NWvH+DpmM8KwdaLo5fY3wQlwKhA++yNWqTmQKZNWPnREbE6HDhjmsS65GJp0b2fW+
	 mf+z37Utq/wOP0Nd2wDKboj8Av/kI+F+FGan6OEDvikmdEG0FzhgEpR03iYKJg4TQV
	 SYfYp5ClEucOEVIEDW99YE6amWGD8ZYSr7tQg04weeYL3r2NvH79BG1p0VSTomw5BB
	 7HcHsp53mTQ7b/SuGHu/Vkk0ziN6X/w51LfSzmLvSeIJDNbtaAaPOzt6c+gx5m9uFt
	 XmvsYTII42p4aGA6lGt0TuV6AD+GS2RQxJyjnohILsdbjVKX0HRhCn6irrNde8Kq1T
	 e0m5WTCETuOWA==
Message-ID: <sashiko-outbox-230630@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: at91sam9: Use devm_clk_get_enabled() in
 at91_rtc_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Elfring" <Markus.Elfring@web.de>, linux-rtc@vger.kernel.org
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <d16d0991-d1d7-4828-8e05-8d8826cbb222@web.de>
References: <d16d0991-d1d7-4828-8e05-8d8826cbb222@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 07:23:38 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 24 Nov 2026 08:01:48 +0100
>=20
> * Reuse existing functionality from devm_clk_get_enabled() instead of
>   keeping duplicate source code.
>=20
> * Delete a clk_disable_unprepare() call on an error handling path
>   and in the implementation of the function =E2=80=9Cat91_rtc_remove=E2=
=80=9D.
>=20
> * Omit the label =E2=80=9Cerr_clk=E2=80=9D.
>=20
> This issue was detected by using the Coccinelle software.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/d16d0991-d1d7-4828-=
8e05-8d8826cbb222@web.de?part=3D1
