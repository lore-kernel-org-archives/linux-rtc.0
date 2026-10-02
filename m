Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59DC471414;
	Fri,  2 Oct 2026 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932407; cv=none; b=kdJILlBbK8ilbhDE2IMTIMrrjKs9POs6IKYe8ogyDar/vaRxQMWRuODiqCYxr+L9sf4c7xZU8h/y+tOESGMCzrXBK6iBBt4R9qS0yhUWCnGjrPduGvXR0R5nZsO7h8VjOswC4fibvVYbTcDhrKeBsjgyzEPtneEZBoToEzlGv9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932407; c=relaxed/simple;
	bh=QRpAZYqVqlg5Htz3AeUWUDDDU3riACvPyTtW+I8GyTQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YTTSVeJk3Yyh3DFldqe1Xm2Z9LgU48xgwt2hxq9YtisBjsqQaK3WyEjkYUmGmz8tYo35zjCjfd8cHd4uGAAhWAH0tOfsvd1qzu1RA23Z+xYwchell4430YOuNuBZ5wBzYpJ4sR8kSk/vinr6CzCYhh6wFYettJdljVcNNyfxHh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIKSbjma; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIKSbjma"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783831F000FF;
	Fri,  2 Oct 2026 09:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932405;
	bh=QRpAZYqVqlg5Htz3AeUWUDDDU3riACvPyTtW+I8GyTQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GIKSbjmaVf1rtLZ4wVt1Os0HpieZgM+vfjo8d0tcHCnyxdcRByCbeTNUu6SW/Z2td
	 MpDHZt6xGbXk/ewCCX+AstKM5QGYfW8/H3h22RgagURCKzn2dLjOgwkp5/9Bz3wYrX
	 0T4UV06derFgG7QYDEj8/kfkaFTGiF9L55QbJpSREgVdanVQ0Kz7YLs2NBCHHp7BL1
	 AEwetJXGz4T3KH7NFO6+1ZNNFKFsXGIsDM0iAM1Bu017kPo3h6jGA3PCHn5AUVGER6
	 HuwIG/9y7+d71l13BUhLozFt88NaoMay+TKRbuq0fbf0L92GkIFREETibf0itcSKh3
	 piFcLhNek0R1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/3] rtc: Add Raspberry Pi 5 RTC driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sander Speetjens" <sander.speetjens@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20261001193703.734323-4-sander.speetjens@gmail.com>
References: <20261001193703.734323-1-sander.speetjens@gmail.com>
 <20261001193703.734323-4-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:25 +0000
Message-Id: <20261002091325.783831F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Upstreaming the downstream Raspberry Pi 5 RTC driver.
> This driver supports the custom DA9091,
> which is accessed through the firmware mailbox.
>=20
> Signed-off-by: Jonathan Bell <jonathan@raspberrypi.com>
> Signed-off-by: Dom Cobley <popcornmix@gmail.com>
> Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001193703.7343=
23-1-sander.speetjens@gmail.com?part=3D3

