Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4254C10CD
	for <linux-rtc@vger.kernel.org>; Sun, 18 Oct 2026 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792335742; cv=none; b=qB0XsDt2xqdH3zPAcpFJV8igCgZHhuEYpkRjpZDnkVEraymxjXGzxBP1OjrcK30qIQDFTWaZnONUE7XfgHROsfLqUwZKvtP1IBwEuEqZc1HMcBw3uASWAMjhNZ5Lo93DVHGeJsv7JfQ1DsWukocEf2taRbtb/zSvIBL81x+wG4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792335742; c=relaxed/simple;
	bh=eQ/f5goviYxj78w81zf/r1FbwWKZGSKktNV/hvOKci0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=KBNiaHg02+p7Rx7brWWge6IwDCBSd52mfd66HF+5F9B9QKV2aJYawW000DOe0X1uvG1v6ExMgE6pcujN8nqCMBBTN8WcQqGgX4/z/NkrGT4e1XivTjvJ5QbQz3HuCuzHCer3YqsktgbkQoVzdR67tCDNT6e3LHYfCiYf/zH/RHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6U9+FGU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6U9+FGU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791431F000C4;
	Sun, 18 Oct 2026 15:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792335739;
	bh=eQ/f5goviYxj78w81zf/r1FbwWKZGSKktNV/hvOKci0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z6U9+FGU71sVMF7TR/QyvXosqclxLxhZOwPeUk4EaalKwxZKtN9EuZLLwUAruMtRA
	 9EuO730H2Zvl466nmkNiuDxG5MJnzyT4eBEl9NRJtTBdS8BhasGiTXKeYtM2kLYL6g
	 M/8baZ80ktItfMY1odfQ9MIoiLS1FBJyR7hnFAlNaQy3aMaSersId1RI9rDXWXjOvj
	 +9emi825OxtLk2yEN5Zf7xZzDqZ4kDYvuvAHP4VREPxNZkBBv5iaT8NibUywfzM2Cg
	 G09hLk7jpfOO3IqbvJT0DdrpW7BZhYHLF+zEUZtQsDe2g+lPuWCn5oJaCGTkTKTC5L
	 8NbTOIMm63yOA==
Message-ID: <sashiko-outbox-176225@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 2/3] dt-bindings: rtc: Add property for Raspberry Pi
 5 RTC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sander Speetjens" <sander.speetjens@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261018150028.1047172-3-sander.speetjens@gmail.com>
References: <20261018150028.1047172-1-sander.speetjens@gmail.com>
 <20261018150028.1047172-3-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 15:02:19 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018150028.1047=
172-1-sander.speetjens@gmail.com?part=3D2

