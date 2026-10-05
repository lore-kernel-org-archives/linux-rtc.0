Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A1D547047
	for <linux-rtc@vger.kernel.org>; Mon,  5 Oct 2026 00:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791158686; cv=none; b=JYQSa+ZoSF0lgICdkqQwmgf1lt8yMbeVeGS5O3KYttKw44BKvxwnV2BzJk1aRXEVUEdzhwbR5lEKEB2+PLfz5c+LPaCNytzsXkBwlumJlz4hwhkJoczrMurlGdzT9+l7VgX7Z9W/dqfY6E9eDrY1uWBMPjGqXn/rPgRpVwP/RzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791158686; c=relaxed/simple;
	bh=k10V2d7b9b01ZjgmPgShRLz6BTL5hfvdShMoju1Bj2I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LqTsuRoD1CBWqFY5rNhJD8gksud6AcCI6HRbYR6QwhAxhagDevqOGRZL1ykHY+RFZX/9qJKlL2QHC82k/CR+9BHz3zpFBP32kFG5u6baBDTIeBJ9kDbxGp7ByRDLNbvikfe4SqNMyMTbUZKQgngH7QHkGUVDoiP84E/WNpTg1OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Igtu+7Gy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Igtu+7Gy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E614B1F000FF;
	Mon,  5 Oct 2026 00:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791158685;
	bh=k10V2d7b9b01ZjgmPgShRLz6BTL5hfvdShMoju1Bj2I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Igtu+7Gy/jyXRhJGoZdps+6/c/I6DnPKhR03MrgJRtAKzmbd8q1xrET0vJFvGBYBO
	 zy9rNxJhNuKdLMAOWOjF7mjcHgkE2nNouQat/NBeA/CJIbdvRS6ioV+8wSCb6mg0S2
	 92O0HUjJV4FXvmQiWoHRt/tHJ8rri6f1YBRp2nHt6X6Ll7tVkbP8nQQDQ+1D89GE0J
	 uSF/SpDAdhIiQoZC2JvKXnqLIzm7JEaY3NEtpAF/E8GsuRxaOsDjL0KGFkiyBG0NdE
	 sAbBnizi0HcmCnPy96l9fQENCpfm9xnPJt6PQQdNcJwtu4gzKEizVg5FSFEnrqmNaX
	 VQVitG7fk3+dw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: pcf8563: pass the driver data to the alarm
 interrupt handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Igor Velkov" <iav@iav.lv>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261004-pcf8563-irq-data-v1-1-f176763ddf2f@iav.lv>
References: <20261004-pcf8563-irq-data-v1-1-f176763ddf2f@iav.lv>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 00:04:44 +0000
Message-Id: <20261005000444.E614B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Igor Velkov <iav@iav.lv>
>=20
> pcf8563_irq() takes its dev_id as struct pcf8563, but probe still
> registers the interrupt with the i2c client. The handler then takes the
> regmap pointer from the wrong structure: the first alarm oopses, the
> level-low INT is never acknowledged, and the interrupt gets disabled as
> spurious.
>=20
> Only an RTC that has an interrupt (client->irq > 0) reaches this path.
>=20
> Fixes: 00f1bb9b8486 ("rtc: pcf8563: Switch to regmap")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Igor Velkov <iav@iav.lv>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004-pcf8563-ir=
q-data-v1-1-f176763ddf2f@iav.lv?part=3D1

