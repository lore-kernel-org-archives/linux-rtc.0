Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126EA41F5DB;
	Wed,  5 Aug 2026 20:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785962525; cv=none; b=BV1TurkPFZ6OFbXRO61oBywKX0AAR9lIzFvss6i47X03WeyAZKpqZqPDRmDSRFfD3pB9R9nayoITLVmHFLruZcN/sU+zhkKr9Trihp+Xj8QsHlIvz/JZWkuPv0/26dmbNHRtc4fxBN9Kxab0TFpXdqEIGClgkMsuAfYVeE7D3UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785962525; c=relaxed/simple;
	bh=3DVDCh8zb4IWI50+OfXFv6zcAGJDHhHNOzVWlGJLQbg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nFj8et5bJlJIM4B5qlwlgc45CF0hFiQuQmSScoRy4nluipF56K7oRHT5EiZ/yc1L9c3Yxnkd9CPgPcllQ7OmnkCh8Qnazanzc88sa9E2/UoefRgmpZ5UB7e/u/+gkTBuQapoWjmsNO5AhUuiDrbWPbqKMRecWgUnrxoxIUH70w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qw7wKkKL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qw7wKkKL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A151F000E9;
	Wed,  5 Aug 2026 20:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785962523;
	bh=3DVDCh8zb4IWI50+OfXFv6zcAGJDHhHNOzVWlGJLQbg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qw7wKkKLZdCRP6Mk1kjUUVyFAe5rSJYyN2OlgnPtgyRPGEQcPG4PTeKOAdF/531it
	 nDaOCK4HpQkqzuUnTzVHACCay+FDdArYXwLQt7j9ZUHdFbSgZtIj2nE0o44E0+Xo2J
	 h3a2mE336wGRbnCCn6kmDRPiTHWxfgNMduVTbjlHQFD47l3K9mvEvc4O0EDhEp2KTW
	 yFl1E4IrdyDHSvqyUp9D5HpyGF/zQUNg0D0kbXrGhAkmElS+Sw2yre5Ms5qoYzt1Md
	 leQEP4HaQ/Igi4un3KnIKStB6L9u1zAf2UFnQ/XbiK9Ug6/22A0K4H7Xdq4PJrHym9
	 6Y+nkWe89hFAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] rtc: s35390a: Fix alarm not disabling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260805-rtc_s35390a_int1-v3-3-e836faba3e25@posteo.de>
References: <20260805-rtc_s35390a_int1-v3-0-e836faba3e25@posteo.de>
 <20260805-rtc_s35390a_int1-v3-3-e836faba3e25@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 20:42:01 +0000
Message-Id: <20260805204202.B1A151F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Implement alarm_irq_enable callback.
>=20
> Fixes: 542dd33a4925 ("drivers/rtc/rtc-s35390a.c: add wakealarm support fo=
r rtc-s35390A rtc chip")
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-rtc_s35390=
a_int1-v3-0-e836faba3e25@posteo.de?part=3D3

