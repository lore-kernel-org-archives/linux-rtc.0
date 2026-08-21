Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99DA414DF6;
	Fri, 21 Aug 2026 21:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787346828; cv=none; b=iNgb6KUMmwiFD4TnHQM5poMM6GNX6cUWpWlzLHov3zmtTDRyr3FUMAbl7ayrTe+fGQezZHC22TLwXtMtauT0X+FvCKP0S/3vxDb+W3ZLhaTLOuUdt1hbCagPuk7aFYb0IohWIv2bANKt0TAIRKPIyWQWT8hIHNGmutxHaK8usUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787346828; c=relaxed/simple;
	bh=I1G1b0KDinXmXBcR95V00R5Osrx4F0noCkXhI0XjZ2k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qOybWRjsVdW4AfURnHdyx6DOLcQ0jEO/exbfNYtO7Qf4k8PpFUTvnIuTQ49C5hd2KJ3J5ozQ7xahzbQA2M6aZJv+mZPakAzYgu8dAhrqS+Wcyh11YrJYP9/5jZo/cRfOUCPli0NR9ASlNFzoKwNPmU7R4/TBzMR7kj3X5CqwS6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dj5+UCQr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dj5+UCQr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F061F000E9;
	Fri, 21 Aug 2026 21:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787346826;
	bh=I1G1b0KDinXmXBcR95V00R5Osrx4F0noCkXhI0XjZ2k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dj5+UCQrIADGhGZMr8qR9BIxEHsGlE+ThO4JUSYzsCeApcuSZnm8AXik5wjPJzYps
	 YqTzd3KKZsbxf27Vqw8IMON9Mpl/qaQxvBfrXhUvm/Zyv+URFZWezlWfaQJI5Pv75v
	 fe6Ep8xu5XC4HoW4cMGQOeLbp4N62YUwKUIdHZwR6BRx+GVVXMf9DptNpNFHnT6RD1
	 o5f36cpbhuwqtuk+8v8CCXOtgUFQhAKJZgjPkrVrdOxcI1qxmYZj2PZ94+IpZknbSt
	 N28HgtO8QPc+86t+DUZWujxgsGFKfuRsY4EmgVfnNK9XW2Jp1tKHsrnziDsmx4Pjyo
	 pKN85uMIQFO+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/17] rtc: rzn1: Fix malformed MODULE_AUTHOR string
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: conor+dt@kernel.org, robh@kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, wsa+renesas@sang-engineering.com, devicetree@vger.kernel.org
In-Reply-To: <20260821211032.13554-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821211032.13554-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821211032.13554-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 21:13:45 +0000
Message-Id: <20260821211346.37F061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Fix a malformed MODULE_AUTHOR macro in the rtc-rzn1 driver where a missing
> closing angle bracket on the second author entry creates an invalid forma=
t.
> Correct it to the standard "Name <email>" format.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821211032.1355=
4-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D7

