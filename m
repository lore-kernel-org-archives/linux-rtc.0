Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EBA3E0C7A;
	Wed, 30 Sep 2026 08:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790757868; cv=none; b=ekkH/NhYURnIVtz2ZUHT4560kU1kra94/uzk2XgPTLTshMa1d7lgXUqRRcwq44QWdEm3ikvtfi0DDbheH8h9l/4/GG4t4RIpsELSJSEE0SuJQEUkgdACwe0b2bUNqz4qFsHwfCZue0/8UmF1zzJ66b88Odkq3rM/1NM/EXPax4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790757868; c=relaxed/simple;
	bh=vXSrn0YpEMwFHIcG2t495THUX+0aoxPjovW0gU2kz28=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vc1Kdk/U0ht9LsbkcKZ6Zo5T0lGYKuhb/X4XWldChXT528QnENMfr62cry2AyAmWBzrAf2ybLGWW4QxT3+nak+29lm6U8lhUXqv5PrMyX6z6UH5VzL/yxjWYSgByI+MY6AllGj0Xb5UIAy8AzcwZIYiZ8dd8pB1x6BdMV/W/W5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fX40Yz9L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fX40Yz9L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6A91F00893;
	Wed, 30 Sep 2026 08:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790757862;
	bh=vXSrn0YpEMwFHIcG2t495THUX+0aoxPjovW0gU2kz28=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fX40Yz9LChuMYSFcfjiZNvljS4u2MIYOxFf6NZycFXLEH5tObGxIV5V0pZzH2hGWH
	 EJ3lTjp32H7eOaEllY21jYr7k6qZGc58reDQaZa0Z7AVCIryUtB0dN7OAOyD/lOlMa
	 KzR5V5iFTNgYqNMwUw+RUFoIY4phEl7UEk73k1hykFdTI+Ua8FTYt02hKeUINBW60K
	 xYXezYw2wfLf7Gpta0wYcUWH4XcigyBa1WoEMAGc3quc3CsdG/UL773vFKuDy+7tYT
	 8m0e3MD1wxkhQawSDqBN7dvOH3zvZaV6uAiiQZCpStSrS7fI0ortAPnJSUyZ2sEH8B
	 VByNCB7HCvErQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/2] dt-bindings: rtc: Add property for Raspberry Pi
 5 RTC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sander Speetjens" <sander.speetjens@gmail.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260930083922.484885-2-sander.speetjens@gmail.com>
References: <20260930083922.484885-1-sander.speetjens@gmail.com>
 <20260930083922.484885-2-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 08:44:21 +0000
Message-Id: <20260930084422.5F6A91F00893@smtp.kernel.org>
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
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930083922.4848=
85-1-sander.speetjens@gmail.com?part=3D1

