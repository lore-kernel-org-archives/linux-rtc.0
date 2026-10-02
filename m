Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E27447F3D5;
	Fri,  2 Oct 2026 10:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936976; cv=none; b=u3VZjOyDb9bPbXJKv3MnUY039euvwE44UD4X6zeB5A/J7Si7Jj2rv8c9f5Rv7Qbhv29jdnNey/06ni5YJULFD6c+Oj1mSljocOIVdnJBS+bj0aG4VYG81O1exgeyozQ33puNC0Wi7GE/q9Kst68r+LsZVQxUgjUq4My6at0EXQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936976; c=relaxed/simple;
	bh=/ljkSsxQ/AdpYXEBLJ0Kxn22hVin7iWVLVb+wEhtEWg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L7+qTT/JOUha7UhXuns1tyxmxTKBp61v0TzAX2AodhgPliYX9Uf1Xr2V/bciUGvu2bJtSNEEYZSIfbG8NTZZDqXKCWnmJ3qgZpp6cltvaj06pgyG/ax/J3ATPAKrkAE8VnhpmBKSfBi8q6HWeaigfLunkYwCQ6TvCraYbp/L+mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJu0C1yT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJu0C1yT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964671F00893;
	Fri,  2 Oct 2026 10:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790936974;
	bh=/ljkSsxQ/AdpYXEBLJ0Kxn22hVin7iWVLVb+wEhtEWg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JJu0C1yTG9ya73euep2Ay8t/vgsPsbzLhSu9rJMF9LT50hcemP9UJnkZE8z7tiwwz
	 xBQSrIVaN+FgW2nKhTaxhfWXq8FCBciU1+vxOonL/O75giGp7ewRyfQ3uSnwd5BMt1
	 3eHrsnx8K2uKi00OudUqy59mKcBzqYmpZgtPX5CJe1t8qJqRAjohm/aPN4kpExVb+x
	 noyQD080S9+9gRI1K5NYqmJ/eqNy7QMFSLiQTUoAStkvZmWpkESnZU39sCFjGtDA42
	 5oU0r0iX2g8cWpWRC/A3TApvxS97DT9gBTKRueCjpHFkXnfz2oQk45c3MtSpYtnbRA
	 643Sqh7F9fnvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/3] dt-bindings: rtc: Add property for Raspberry Pi
 5 RTC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sander Speetjens" <sander.speetjens@gmail.com>
Cc: conor+dt@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org
In-Reply-To: <20261002102419.830595-3-sander.speetjens@gmail.com>
References: <20261002102419.830595-1-sander.speetjens@gmail.com>
 <20261002102419.830595-3-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 10:29:34 +0000
Message-Id: <20261002102934.964671F00893@smtp.kernel.org>
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

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002102419.8305=
95-1-sander.speetjens@gmail.com?part=3D2

