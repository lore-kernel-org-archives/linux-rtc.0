Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DEF495AF3
	for <linux-rtc@vger.kernel.org>; Sun, 18 Oct 2026 15:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792336343; cv=none; b=b6oRfDK0Z6N6EGk5YMCimQ/nLlb08fKPSFnspqFLTjA+0Vd2qk1IgJCo0x9YoLOyhvEIq0Q/Tx3DQRg8r2qTooCDe/wNbS1vgpR7ox1EvTH3zcWh5l/BuT6QrzB4KNGHV4jChYHL15bj/ZYs01MaHv5OxvgzUZL+LeoUH03zdfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792336343; c=relaxed/simple;
	bh=1Ro+ht1Lv2M4L2l9WMVOdAF2txZbwrkw+NLB+LyDXe8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=TAM/Y/avo6FEZnzmde8uYoKXM4Q+6oBcGLa1zaHBL+gzCl/etgaF2EJZpE44tXvGhJ83p2qCZ9aCiokZGCXdPLHhAPcRPHwN0US/Ze29Si5HNqC3b85HgPMm7EyoHzO/P+g+G1Sb8P/yoZPNZYw7lcupc41pg/7Dq0XfK6h6FpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZuZAREc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZuZAREc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650011F000C4;
	Sun, 18 Oct 2026 15:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792336341;
	bh=1Ro+ht1Lv2M4L2l9WMVOdAF2txZbwrkw+NLB+LyDXe8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aZuZAREc7PulSl1giluVXoHjPCNruroW2RC5m6AW5Izt/auOHLAN8MV/+E90CN8yj
	 BogdvujKk2ZzXZYFDm2MHEcHWNsrL7ZSpe3i40Lr9vn3URwmjpI+Os0GK/ubQLipri
	 F6UK8d/Tirqkaarfjc9u8jr2dqCTrjC+z4Deijrzx4bLRbUHymkk3zg0DbENhdtyv7
	 1fQqgCR7AFAu8m/TMBu9VpMmS0IL8g5BEVHBqjCtWtaAUPxojrtMrdqN4l2Pde2C7I
	 2khIG+ukGTb7pEsA0yrUrdAxBmmAxKSzn58cWBBPmUhjbNwZzuTHMA+PCiwJQKiYAs
	 zr4/dDOgAHpaQ==
Message-ID: <sashiko-outbox-176230@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 2/3] dt-bindings: rtc: Add property for Raspberry Pi
 5 RTC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sander Speetjens" <sander.speetjens@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261018151056.1051330-3-sander.speetjens@gmail.com>
References: <20261018151056.1051330-1-sander.speetjens@gmail.com>
 <20261018151056.1051330-3-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 15:12:20 +0000
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> The Raspberry Pi 5 has a built-in RTC that can be battery-backed
> via the VBAT pin. When a rechargeable coin cell is used, the
> hardware requires a trickle-charge voltage to keep the battery
> topped up.
>=20
> Expose the trickle-voltage-millivolt DT property so the driver can
> program the correct charge voltage for board specific configurations with
> the attached battery.
>=20
> The property is added to the existing raspberrypi,bcm2835-firmware
> binding (rather than creating a new RTC node) because the RTC is
> accessed exclusively through the firmware mailbox interface.
> We only $ref the individual property from rtc.yaml and do not
> reference the full schema, because the firmware node name does not
> match the $nodename pattern required by rtc.yaml.
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018151056.1051=
330-1-sander.speetjens@gmail.com?part=3D2

