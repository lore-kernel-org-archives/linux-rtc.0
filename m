Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792565491;
	b=oasb+aq4sSdgQMahbRa7O/9TRaXgYWDC/afBHUZEcaLZBp2n+NmwL6EyM3mSqYJ2MUIR
	 DuGRrEUpi+rdvweSt/QNmdJu0TKpZ1F0kKQQLloyzIhQIYKCptZV1MXo6Q5/329JiHVLs
	 ti30W0YqoIXcrzCIDJDHnzncmYzNeQXcNswHR7LVBW7JhOjP1gAyRSA85Paarr0ovWX9g
	 ZTz89dp0QB94tZKp7z9Uo3Ms9RrIUE+ck7aPnyMK0ar1gAXWQB7uAJac/xBUkvL2sarQ/
	 oSE37JDatwIhlJaLAbDuaRTDCM+fnaxpRVHUsoBCV7nfd74DG2Or+f/qZnQ22CAYiPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792565491;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ImvLXKzJwx2vO76faC40IRBOnncpzbrn7E6eJ1I/5fI=;
	b=ZA8nr9WGfrXSQYu1aCa1nAkfrxNwwyuvCTvLpJCpN0rgCa7O/wXXLHneaM8P6x9jsEXo
	 YrpQsht2zdwOHQYbvjvE3Ae7/wKOccBqVZyraYetLKUfbAUIof4PAwAkkux/Lyrzh3b3w
	 pVOdmgJnYseYuuVBJ1k4NnguKE7aGar49n5SihKRqdvnlsmWIRZaSuqYswdSYFijEAXYU
	 HFO0yWfmFhoHZPSQN/rEMy+KJ0S4d8XlSZhl0y7BOREzHQZS43CF9PxC3cgc5yh61w6AZ
	 kPdYHWRH48eN0ND6i9hOcG/eiVHSbCl78nTRAop9B8FWuwQQCLEoUgcuG2hCs9EBI1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=elZUQ30Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194B8606A319
	for <linux-rtc@vger.kernel.org>; Wed, 21 Oct 2026 06:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=elZUQ30Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3061F000C9;
	Wed, 21 Oct 2026 06:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792565490;
	bh=ImvLXKzJwx2vO76faC40IRBOnncpzbrn7E6eJ1I/5fI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=elZUQ30Zez10eqJEiEmJUuPO5rnALizBKdXnGK+bedz+DYhfIpzd4u7MNaUA+rbRH
	 M3vxMehlIndYc7sbOEi2WnZXD5o+bWPF4PC9HQwWAvqmjs1XTABLznAtyyhicJLE0d
	 nwlbW8IQvh9tcE8htH3/31MB5CJB/AueRmm3ELvxulwGR8/VX8cIlEqietubxQm8of
	 vKQRTTbAgjJe+XdWiIWa3NT56pLVvRWCc6zdma+y5q+TOQ8lPFksy5lbIhl/OfxSSs
	 VLY5dFogYCyHjJhNMOwT7wNQG3yg8FWWc305fhiEKuJQdsXeJ5DX9afYbBORrmPVX/
	 3Gqx2XjS8fAiQ==
Message-ID: <sashiko-outbox-179847@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] rtc: pcf2127: arm the alarm IRQ as a wake IRQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aristo Chen" <aristo.chen@canonical.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261021064432.551943-1-aristo.chen@canonical.com>
References: <20261021064432.551943-1-aristo.chen@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 06:51:30 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> When an alarm IRQ is available, the driver calls device_init_wakeup(),
> so the RTC shows up as wakeup capable and enabled, but it never marks
> the IRQ itself as a wakeup interrupt. The PM core therefore disables
> the IRQ for the whole system suspend, and the alarm cannot wake the
> system: "rtcwake -m mem" on this RTC only resumes once another wakeup
> source fires.
>=20
> On the i.MX93 11x11 FRDM board the PCF2131 alarm is routed through a
> PCAL6524 GPIO expander. Without a wakeup request on the expander pin,
> the expander's own interrupt is not armed for wakeup either, so the
> alarm never reaches the CPU. The BBNSM RTC on the same board uses
> devm_pm_set_wake_irq() and wakes the system as expected.
>=20
> Register the alarm IRQ with devm_pm_set_wake_irq() so that the PM core
> arms it whenever the device may wake the system. A failure is not
> fatal: the RTC keeps working, only wakeup from it is unavailable.
>=20
> The I2C core already sets up the wake IRQ before probe for clients
> flagged I2C_CLIENT_WAKE, which a "wakeup-source" DT property or a
> wake-capable ACPI interrupt sets. Those boards can already wake from
> the alarm, so skip the call for them: a second registration would only
> trigger a "wake irq already initialized" warning.
>=20
> Fixes: 8a914bac44be ("rtc: pcf2127: add alarm support")
> Assisted-by: LLM
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021064432.5519=
43-1-aristo.chen@canonical.com?part=3D1

