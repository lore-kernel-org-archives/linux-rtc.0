Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C19442B06;
	Wed, 19 Aug 2026 10:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136430; cv=none; b=EyA9cXFbbvjq0AcbbirX69GQpe+xV1HTZMzG9EZLYzgdKldkuIc7Dujmq69Vn2voAPnoU2pJOslgDT5Vfkns1g8N0w2tErIkIG5gQqQQOBXjqlsuuj9voi06npbw5zyw+HyUvGNaz7Ar9xjigSX7Q4hdCdQuaTnqh1vi6x7p79Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136430; c=relaxed/simple;
	bh=T0WDUHyc9ztuKNXiu8lDwUqjOFjcL3VEoAjp2djGjWQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R8fNOGqLZ7VBFWpF/CcP7S4HILJgfcWhkZMfW5OMoE71tWVUASuJhhDsWVbNwfmim6QNGBJMEKHddwaVYQ9UaGHUiRfyn++0evbV1iF/uJCIdvOpHGGvJS/HP+H7K0k3/Qy0K+w+8UAbN62dV6Rpeyhtq3xl/qkvl6DPOoGy2Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIb6K7z8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIb6K7z8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0476D1F00A3A;
	Wed, 19 Aug 2026 10:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787136429;
	bh=T0WDUHyc9ztuKNXiu8lDwUqjOFjcL3VEoAjp2djGjWQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kIb6K7z8ed4Nc0bC3A/HXSZJfzOvv931x/DmWu6XXDrPJ+hWlQWdEmEzJbl4s123s
	 TiZLwwBO2omo761aDnDHzVr/j3RDjQu3BRwOgKoHK/rZZGLgatFKiFKUiQQ+wZmnky
	 HRW2bf2hVJqHJ1crAw4Oxg0qRhG16qvboj6fw/W8yNxeGmLl0Ob1buDgQlzqMEbB61
	 FHcUxqLQ2iYI4H1KXRSaAoc3Mf3gAgv9DX0CkXpf5Ph1n/WSamsMpo4/fLai8K3b04
	 SxF2nENXQO5gIRKXdPlGlWJmaOKYbhuWahjv5f9O1SMujoG6BdI9EL5aY1rgVUe4mI
	 rx1hGRxA9nSfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/15] rtc: rzn1: Dynamically calculate
 synchronization delay based on clock rate
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: wsa+renesas@sang-engineering.com, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260819103926.2136712-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 10:47:08 +0000
Message-Id: <20260819104709.0476D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Replace the hardcoded hardware synchronization delays with a calculated
> time window derived from the operating sub-clock frequency.
>=20
> The driver currently hardcodes microsecond ranges assuming a fixed
> sub-clock frequency of 32.768 kHz. Newer SoC variants, such as the
> RZ/T2H, drive this hardware block using a much faster clock rate
> (~195.3 kHz). Hardcoding these wait windows forces faster blocks to
> over-sleep, introducing unnecessary delays during clock initialization
> and register configuration.
>=20
> Calculate the duration of the required clock cycles in microseconds based
> on the runtime clock rate, and store this value in the driver private
> structure to adjust the usleep_range() and readl_poll_timeout() boundaries
> dynamically.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819103926.2136=
712-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D9

