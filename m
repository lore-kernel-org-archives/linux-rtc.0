Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC353932C2;
	Fri, 21 Aug 2026 21:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787347016; cv=none; b=koeYtsjVmdUKz3m4mfknzba89fQDE7p36AdxJckg73i6JYkI2KAcHiJdV3BplREVNOg3V9XzakEWR/dN2LZ9AI/7AD1MDvoCxVoIRRGeRQrXERURiAhutGvJV9lDM/K9YegWzlUpT08anIBLusMB2ksi2RVyqtsoX/KTccHdHj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787347016; c=relaxed/simple;
	bh=DGiOPh1NC5NgEpvVQpTLnDta16R3XF0HJHffOJWoRKM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YEnxrZ2qCDQkFvrXyXO3yJcJbiH7XzGhkgyW+HsHl+OoubuD3GhIVGg1rlSMCNw1+oLEInQJNf9waRTAl1QHuUaySce4yJba/+RXFYLHTX9CMGJonSpOniDEOGp4MMlCEMWPLSQ4kv7YAT8psh/rhmp2b2lP5liv8exkdDXL/N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6jaD1V5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6jaD1V5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3131F00A3D;
	Fri, 21 Aug 2026 21:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787347013;
	bh=DGiOPh1NC5NgEpvVQpTLnDta16R3XF0HJHffOJWoRKM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G6jaD1V5KU8nSquOe4eUu2vxaWb1YCpcsjfy6YFgp5sqX1TBlAR4PRIDF0R4TwtZd
	 XGbUgugoFbNILBCo4GxIGOYPs68wZwXc2LtlQZUKnaVX5Jq8B7O7sCyvFuaibuDHse
	 YaEkaVKaRJPVJo1Htz14H3Y2TP5eOj4wGOz9XJrPiE4bAFo7nix/Y7rQ61K7IaHrmY
	 C4/bWuU82Gx4Nsw8We6nyV2GZOY/P3GF+C2w+bP5YdyGzxZPUdYDtj9sPuUXycP/CE
	 aZpKaAUxdVygjilvbM+ROopiYGnTRJrPganNZD9SdFJpl/gXiar3T1ozFSOdAWJ7At
	 aHoAM1XHpjRnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/17] rtc: rzn1: Dynamically calculate
 synchronization delay based on clock rate
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, linux-rtc@vger.kernel.org, robh@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org
In-Reply-To: <20260821211032.13554-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821211032.13554-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821211032.13554-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 21:16:52 +0000
Message-Id: <20260821211653.1D3131F00A3D@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821211032.1355=
4-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D11

