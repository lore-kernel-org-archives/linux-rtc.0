Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A685E442B06;
	Wed, 19 Aug 2026 10:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136446; cv=none; b=czqOvv4Bc/02OxxNoG9PEuxojE33zJ5wQxmxELtVkDhTunH/Qk2fLngAwl/9/m5MWyXQp2tqzqSyCK/2N9CC8jOIam6q2O/hOSZvZ1Tm03vEWSz2PgrmIqsBeJXg0tQjf8U4KJcVnSJ8VoveTMWvNGQeLsEDxqXQWP4n2Idtbz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136446; c=relaxed/simple;
	bh=gHUX87I1NcwfL2/eHmmpV5xncLHdrmxcqmJGfJkZ+lg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gx7JXYpxguisFPmF+rtYf+bQPh/oVEv2o7ZffQ8YTE+UxBZIHj96f1wOWmdNCjEpvQpcqaFdsImyKqQTmmtTnPye/N5kt2mNMLYr5QlU/cdHIgrqKFxdSsLS0uiD4q0u01SNqT5EyOXEHMwam4dglLdvdXZdvNR8KYsu1t4ovMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkSUdUmJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkSUdUmJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04EA1F000E9;
	Wed, 19 Aug 2026 10:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787136445;
	bh=gHUX87I1NcwfL2/eHmmpV5xncLHdrmxcqmJGfJkZ+lg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QkSUdUmJLYvji2lOVkrKmSOm00VwjLpy1Owj5svHppaP6PNQcc2HC4djQyYGejkI7
	 TEUGKCQ0wtF7eXlDsXfSyUWh9IApzJfT1OfWzVd2qaTBQWvniQrvmA474StoKnOCUx
	 J1yL96a2LdwI1b1B2vbAAeNvmL3KnicatIRFbv0kuUXraaQUyFM2WHfO/17QLxLQxI
	 Qd67b4K+tAhMx3rZ9JAYYout7+B4NOVbLpVfs7X/6bEDVAWb0KhBDp5MeI3tCztvTX
	 MV3WII7+8XAGuIYY4cwqA63jqtJMNpibNBM1IEsKocWTO4IZ6QgfGYCUIeWstEmtud
	 1xEhAfspHXtVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/15] rtc: rzn1: Add OF match data to gate SUBU
 register access
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: conor+dt@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, wsa+renesas@sang-engineering.com, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260819103926.2136712-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 10:47:24 +0000
Message-Id: <20260819104724.E04EA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> The RZ/N1 RTC driver selects SCMP mode only when an optional xtal clock
> is provided at a valid rate other than 32768 Hz. Without an xtal clock,
> or when it runs at 32768 Hz, the driver uses SUBU mode.
>=20
> However, the RTCA0SUBU register used by SUBU mode is not present on all
> SoCs that integrate a similar variant of the RTC block. Allowing SUBU
> mode on those variants would expose RTC offset operations that access a
> non-existent register.
>=20
> Add OF match data to describe whether the RTC supports the SUBU register.
> Reject probe with -EOPNOTSUPP when SUBU mode would be selected on a
> variant without SUBU support.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819103926.2136=
712-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D13

