Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BAE474246;
	Fri, 21 Aug 2026 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321029; cv=none; b=nD0xYmeGGzgwQq2DMImxqwsHsHc90j/93cT7lBETablNeLAjOIgUpw2WiUy+bY4WZbOo9SFFehZw3MnNKTG2VAWHddtJWd/qCZUZ6ZUt/grniy6fmenzO8Q+ixVjbXW0sqIdvbirSF92YhV0WtbT+NLok5viehM63GA4+hZp3Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321029; c=relaxed/simple;
	bh=RUvvArpc86LpjBQWFjZdT0PPkGymYZkU1lGbpQhK3Qs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jG+jv6xpiJGbbfNBx0Nqqsxnf7n8rdWrwB+0MCUmC3hsf3aZnfsbMUpNfKn1a4l+DnNUY4mOMI84uTqEFTwpuePI/rc24k9CY9dJ+Qb3TxQvM0kuDpIfyQ7i/xhMdjJ2K4IrKoqGeSXG7qZbqaOUmYNkS0xL4LiQ84Vcs50ACvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOVKYRtU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOVKYRtU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9241F00A3E;
	Fri, 21 Aug 2026 14:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787321028;
	bh=RUvvArpc86LpjBQWFjZdT0PPkGymYZkU1lGbpQhK3Qs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NOVKYRtU2NKsGeUQ4bkhJszeB5JGziuDt4KQ8n6q8gWI19Fp8s39maaVzMNs8xgE9
	 077j+gSkxMyCIIz3r2pVJNfho/iEnaFJFfgBliFk6udYK770ObOOhqqc3FO8ioHLV+
	 50L4pOngSIC2wvIc0t8QFFCMlIcgZieZWNu5AVWZWx4Zax+l+cbw3O+0PySjyhZl47
	 o7aazrzIVnY/k/MWntFSMC5BD5tsYuTyOh7jvHJMDjKFJW+HncCYX6auMSIPCy9hS1
	 0TWYp6gdoD9iMVu4pKA9ynv6iinC4vV9TK0D0J9Eu4x1jOZcCHXIF1gs7r5xFCC3bl
	 TE9E5ETSNB4YA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/17] rtc: rzn1: Consistently use dev_err_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: devicetree@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, wsa+renesas@sang-engineering.com, robh@kernel.org, conor+dt@kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260821135608.275233-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821135608.275233-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 14:03:47 +0000
Message-Id: <20260821140347.DC9241F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Use dev_err_probe() in the IRQ request error path to make error handling
> consistent with the rest of rzn1_rtc_probe().
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821135608.2752=
33-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D13

