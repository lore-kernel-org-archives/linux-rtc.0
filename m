Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956A0374E7A
	for <linux-rtc@vger.kernel.org>; Sat,  3 Oct 2026 01:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991196; cv=none; b=T9xoRlQHUg4w+TQokbqAQ0NqASXkttZ5u5SNCV9Hz5aYB1rDST0SV25WDO/FDdR2zgYWY8BIomV/K+qJ4IeHbVwxZCI2y2MIQArtaR2kFcrUDC9BbGRsEB7nSs06VtCbWOJKTZ7ru6US9H1RTphI21erXyAwtYXzaY04zAqiQE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991196; c=relaxed/simple;
	bh=CzxXGT5Zoz6N7PwFChwRUhJW3DoHqFKgk6kUQeSnecY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ujLffTIabNXX22ObNQ5J5g9BOKlr7/ilFNM+IVu6LHGHX4VSRJ7sey4zqgC6NO0Fjbwjtn1Qpf5yQiX+X1SzzOlEliQ1kUIZSvO9VTQpb6mUngECdL+17v3xm3kfxYkTRNPxcLEkD65CZUOUYV5jEY5jAc+Fev1LPrZt1wmYGFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCcds2Yk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCcds2Yk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1439E1F00899;
	Sat,  3 Oct 2026 01:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991195;
	bh=D+bJHg8MOHhWMH3T1TotrK6tDiYcrkPXf+FOCZbL6Oo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YCcds2YkeAejLrPpZzcvn85NCee8UlZmZncMc3RvFLVQDD//DPx8BrVsNhMt9Fm9w
	 UhAbnaqXAhKi3qZer/Y2v6HWVz8h/M5aTLVs19OBzA35Pprcrvag5W8OyevPgsb+nN
	 6vsALnATi46vG1QhNf9mqCWJMnJUJTqBwJJSTQAr/dQBZxTWqHe5Ag6OcBPa9EPfaH
	 FMUZmP8PL/HvX0o7n9+M3pf916bko7eJMTYbmoRt+hG97k6LxpkfANmWLc3KcEMDzI
	 XbjCflC8eKpXTGTMNsr9aXYNwyMt3twb844UmK58ZqveZpgBFg4YcKbaR1YGkbO9/l
	 8MGWak3akhmuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 25/38] rtc: m48t35: support the SGI IP35 timekeeper's
 1968 year base
Reply-To: sashiko-reviews@lists.linux.dev
To: "Imre Kaloz" <kaloz@kernel.org>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <7c2b71a1627e49209a8c3311f4283eb92325852c.1790857966.git.kaloz@kernel.org>
References: <cover.1790857966.git.kaloz@kernel.org>
 <7c2b71a1627e49209a8c3311f4283eb92325852c.1790857966.git.kaloz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:14 +0000
Message-Id: <20261003013315.1439E1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] rtc: m48t35: null pointer dereference in m48t35_probe() via driver=
_override
--

commit 697b757d9c2a3da93baaf70e4fd5d745beae964e
Author: Imre Kaloz <kaloz@kernel.org>

rtc: m48t35: support the SGI IP35 timekeeper's 1968 year base

This commit updates the M48T35 RTC driver to support the 1968 year base for=
=20
SGI IP35-family machines. It assigns a base epoch using the platform device=
 ID
table and bounds the year to the appropriate century.

> diff --git a/drivers/rtc/rtc-m48t35.c b/drivers/rtc/rtc-m48t35.c
> index 92f19bf997b2f..69c313b4b6e84 100644
> --- a/drivers/rtc/rtc-m48t35.c
> +++ b/drivers/rtc/rtc-m48t35.c

[ ... ]

> @@ -164,6 +154,7 @@ static int m48t35_probe(struct platform_device *pdev)
>  				     pdev->name))
>  		return -EBUSY;
> =20
> +	priv->epoch =3D platform_get_device_id(pdev)->driver_data;

[Severity: High]
Does this code handle devices bound via sysfs driver_override?

If the driver is manually bound to a device using the sysfs driver_override
interface, the platform bus platform_match() function returns success witho=
ut
calling platform_match_id(). This leaves pdev->id_entry as null.

Since platform_get_device_id(pdev) returns pdev->id_entry, wouldn't
dereferencing its result directly cause a null pointer dereference regressi=
on?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790857966.gi=
t.kaloz@kernel.org?part=3D25
