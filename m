Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F55B223336;
	Thu, 24 Sep 2026 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790256497; cv=none; b=k9FppjXJXIv1mjUKrttaYIsMY0BtxoVdaHMVYxiBkdYAoHFkhqCwdMCIUhq7NYPAphts93OtAyhiDW9GdzeOkCnX6kwOgMcaQMZFkoeRCsT6m1Ahw6TvH1mxcQf4CdlobtkSOSzHQpoBRx7d0IY5NbEXEwPEVeXoWQI6meeBUOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790256497; c=relaxed/simple;
	bh=38t3Tf1pj9NkI4URXEzhkGQ9TNnh0uC6LOLVwg/XDrQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q4Qee901pbEn5EbXyt3CNoUELVz0oAYqSn9JK84f4QE0dl+oEdtj+pTTWqYgjaMqRCfIJpZVTfROYXrRzOoPSwJ5faratKyjyW5DWAl42Yl9hRkA/SXzqx4RUI77JktgM4R3zrvZ2DxYH0Q5bimA3cWGBW/IYrwzy3gOXMHy0q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQTUIOVA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQTUIOVA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67C41F000FF;
	Thu, 24 Sep 2026 13:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790256488;
	bh=38t3Tf1pj9NkI4URXEzhkGQ9TNnh0uC6LOLVwg/XDrQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BQTUIOVAFSAGwgXJU4gfQ4OOR720MZyoGMekgcGF7YPKQi8zVYZyoDZrFGXp31q5s
	 i7+AmUondv96KgY9mVeSNss8qH9xURXf/KZjLB8wSyg8qa3B1nwkSvhW7z1oFZpwLZ
	 3QUuvBCM6rdFJ3jrdMyMheWl1sWS5WDZwTZ7MlWd8/3snjCByGmDqAS44ksc/0zmMM
	 Aru4hY2vIFr1rYRDL+CojAngCnPaHcyyzOMMndsv4hM7DljP0ylZyYkIMmtBueZu09
	 v+tilYez7R1wglUfsBbbHmNBUCvfACDy3brvI0laq/XgRcwstltcMNOGOeJvhW2zrB
	 DNaKi8mOM5sPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: rtc: Add property for Raspberry Pi
 5 RTC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sander Speetjens" <sander.speetjens@gmail.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260924132217.1281752-2-sander.speetjens@gmail.com>
References: <20260924132217.1281752-1-sander.speetjens@gmail.com>
 <20260924132217.1281752-2-sander.speetjens@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 13:28:07 +0000
Message-Id: <20260924132807.E67C41F000FF@smtp.kernel.org>
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
> Signed-off-by: Sander Speetjens <sander.speetjens@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924132217.1281=
752-1-sander.speetjens@gmail.com?part=3D1

