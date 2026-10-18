Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB5033E345
	for <linux-rtc@vger.kernel.org>; Sun, 18 Oct 2026 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792334349; cv=none; b=Enpsp9Kx8lKtOmjGaOi2e6x8XKoeLixWyEWb7nMXOK1h5+PLtFiHpuVay4PI2KFKZlg9lg2hykrdy4PfN/yHnauui+B8MP2Na8vf+gXVIED2IZmP+dK5Kft+kK+8d3fNpp/HuN3JozsKkp8KKhT/9O1JnMoOBAPoaKXJevHB5B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792334349; c=relaxed/simple;
	bh=NlJRzXjITm8BfgiJHxsJuXdqKocXtqMnTLXu8iv5mv4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=u+So6i+s8BM9fijYJ7zNSw+ty4jZzmns8/Qf+mF2bzPwaKUoYYKb7H5G63d67FHgx7t1JDcoJaIWsvfrCy6WVgM0KCt4RBBwttWTtOtPyykEYeDm3L410tbsDtRzKSlQy9tEZnC8Deh7w9Z+i1Tkx1TFpeqHFHXXINJHr/sSt8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPkWiJvh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPkWiJvh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B0C1F000C5;
	Sun, 18 Oct 2026 14:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792334348;
	bh=NlJRzXjITm8BfgiJHxsJuXdqKocXtqMnTLXu8iv5mv4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RPkWiJvhusj8S0xCbBQJHcNYBV/MwZboGU9bdiZjR8mtAcqqUi1qZvmVaVWCrNKbL
	 C0H0oOz1JcaGV563YgRKuYHxAKMVfrbYdjEEDkG1AwgA/G3dsYF4WWW7yzrdx9wYl0
	 LLIGOnA/dRDUa1LelivPe1ChlAXDkzwTU9p/lwp+ZpxO1OnjlOJ0FzHQqtuWNBYc/K
	 TgV83KWzG+8g22zTwvU40a4cIefs1//twfPjgBlDPYnMi6az/YyvQMMAubFDb1UC5e
	 FXYNwNoEg4MmIPOpKbLbzLGCnBd+hciIvN76Ki9zOsfEzcfyJTSwG1Cgpm4A8Hqe+s
	 5rOJDBdBt6NUw==
Message-ID: <sashiko-outbox-176207@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 2/3] dt-bindings: rtc: Add property for Raspberry Pi
 5 RTC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sander Speetjens" <sander.speetjens@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261018143712.1040152-3-sander.speetjens@gmail.com>
References: <20261018143712.1040152-1-sander.speetjens@gmail.com>
 <20261018143712.1040152-3-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 14:39:07 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018143712.1040=
152-1-sander.speetjens@gmail.com?part=3D2

