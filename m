Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7AB2459D1;
	Mon,  6 Jul 2026 18:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783360846; cv=none; b=GvWGIIXkDTBW9kDMJ3nfVtUX72Sk3pFJMkb9lC3+Mi+cG7tlvzK03hEq2pFobrTbKAe6SMQIo/fre7QXMPeOtQe8ytcV4l7VTV+8MXJSIGzhjRETLEupwBb/E769DsQeGaiZ7SVaDy5Lk/8UwiPMNcP3oTo/7DOHJVXn93jmeBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783360846; c=relaxed/simple;
	bh=NGqsrgq8qSfnIU6TQqPz/Vf0eayhZ0sRZQfyFvIhFJg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GmcIle9T34MHLWcdt+NfSzzs6/lcoP08j2B0CgH/uKcSi4QWJaTeU+rSHDNQT3+riDjTYJRB/asEg0m9+8SOB+aXLXbuBYQ3K7LsuKp6BRcYurP+uRqQ1UcC8ZtNkeuPoQVz2ImVCfj/3WJxXpslllKiPRcyFHT/jARrek//zGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQ0PQ0T2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQ0PQ0T2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFE41F000E9;
	Mon,  6 Jul 2026 18:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783360844;
	bh=NYtQEPwGd217M7NuJ+d7MF5Ev+LUw1T3TueXJilKaVc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oQ0PQ0T20boETqUQ6R9GHbTWb/We4DX5Oen3Fm/Im58r8zgg+H8NBHBapVFArWXQ7
	 dHXEoEVtxMuMAt6NqfRROayfXiBO4XlEVurdTtwvh0xHpVMxI6QcwPLIyLAW7Tw4TI
	 +02MSXYdHugn86hzlwTdOSdx8fZopRKuEUkeFBM0qmq91M8Bc9157qc12hlc5g3HJz
	 mv8G27qEjIenfetJ7EmWndy9ZGh3AJendLAjoJq98GCATrMsUr2eUIs/b10GjRF5JY
	 mHbbX4JzhRtnXu8Ij7tcna9ZfCZPmaYTXDM9DxTmKoGVzz69RhwO62BbkZ70TJv19N
	 E+0ATcnYSeJIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/12] rtc: rzn1: fix weekday underflow when alarm
 crosses month boundary
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, linux-rtc@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260706175138.12587-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260706175138.12587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706175138.12587-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 18:00:43 +0000
Message-Id: <20260706180044.5CFE41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> In rzn1_rtc_set_alarm(), the driver attempts to calculate the weekday
> for an alarm by computing the day delta between the alarm time and the
> current time:
>=20
>     days_ahead =3D tm->tm_mday - tm_now.tm_mday;
>     wday =3D (tm_now.tm_wday + days_ahead) % 7;
>=20
> However, if an alarm is scheduled for the beginning of the next month
> while the current time is at the end of the month (e.g., current day is
> 31, alarm day is 1), `tm->tm_mday - tm_now.tm_mday` results in a negative
> value (-30). Since `days_ahead` is an unsigned int, this underflows to a
> large positive number, leading to an incorrect `wday` being written to
> the RZN1_RTC_ALW register. As a result, the alarm fails to fire.
>=20
> Fix this by utilizing the already computed `alarm` time64_t timestamp.
> Convert it back into an rtc_time struct via rtc_time64_to_tm(), which
> automatically handles month boundaries and correctly populates the
> `tm_wday` field.
>=20
> Fixes: b5ad1bf00d2c4 ("rtc: rzn1: Add alarm support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706175138.1258=
7-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D3

