Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729413B14DE;
	Fri, 21 Aug 2026 14:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321241; cv=none; b=RYQ3SCPjkw7Mn7fUacywi4lBiT7exSoDY+dUCbLLugakkO9YJNGq9vn8+7Q+VEy2ycBfQSKlXQmoza2lJcMoDbM1tODhqaiC06B8jc/SZwdkVNuDNWMl8h79tb9LZBgSU0yvZh/bKWpIqNTNOC8vfDn6SE9kxwNtGDPZHmD75dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321241; c=relaxed/simple;
	bh=/a3vOpQ+FYB0VRRsfB5KVK5M9idYesqVhzJ5JGOhOGs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=omZF+oZiscXjQfIUMqTC5oLoBfqlC9m9XsB0zbkcPm4M3RDcsDo3XM24GALN8p+wvKjDN25C2VfAMwF6a/YLKCrpsKRzFsIDRvQZw0Ib0I+eUpxJJZ0nrAfNqqfnnpfT8RK4AmIWJNefZM7t6zHwd1O4Z9myZz/tDu7x0E0mfgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoSi4unW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoSi4unW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBEDC1F000E9;
	Fri, 21 Aug 2026 14:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787321240;
	bh=eARIYZJHCKusRDXQcBA45ZIvEa2g3+hFJrU6yrXgbyI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZoSi4unWZ/4kL8PjACIk+57IyO8ON+hhlh25UeoawySIgyDYOeNEBycD3tApbnTV1
	 B7cZ57MAHilIBHIYXLj8yDxgLxZ0OJMHwITw6/YJZ+tZ0h5atDEp8xYAyKRJ6SUihr
	 5uM6fiQF5oz2OEZMcIaJnki98/lXHC45svSFz0SLNQaRfc23l2fkqhN//usZEYFqLP
	 7TDscrilrNQul0PYnE2zxk8k0ZQzaiWYRfbQ0JcdPx4R0VctqkwCnY3duJfLWV6wPC
	 cW4CyEL2h57Clt7fnF8OqtmPJXA1YF1XyG0ix8qoBxn1/O5gvg4PkF6vbnO+zrtEXK
	 0SHY5OtigK+LQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 16/17] rtc: rzn1: Drop trailing comma from OF match
 table sentinel
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: robh@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, linux-rtc@vger.kernel.org
In-Reply-To: <20260821135608.275233-17-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821135608.275233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821135608.275233-17-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 14:07:19 +0000
Message-Id: <20260821140719.EBEDC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The commit message claims to 'mark it explicitly as the sentinel', =
but no explicit marker (such as a `/* sentinel */` comment) is added to the=
 code.
--

--- Patch [16]: [PATCH v5 16/17] rtc: rzn1: Drop trailing comma from OF mat=
ch table sentinel ---
commit 6102085fc7a0622a82be53791f34e44f2573ec8b
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

rtc: rzn1: Drop trailing comma from OF match table sentinel

This commit drops the trailing comma from the final empty entry in the RZN1
RTC OF match table.

> diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
> index 35770bff129ff..75713e7b045b0 100644
> --- a/drivers/rtc/rtc-rzn1.c
> +++ b/drivers/rtc/rtc-rzn1.c
> @@ -528,7 +528,7 @@ static const struct rzn1_rtc_data rzn1_rtc_rzn1_data =
=3D {
> =20
>  static const struct of_device_id rzn1_rtc_of_match[] =3D {
>  	{ .compatible	=3D "renesas,rzn1-rtc", .data =3D &rzn1_rtc_rzn1_data },
> -	{},
> +	{}

[Severity: Low]
This isn't a bug, but the commit message claims to mark it explicitly as the
sentinel. Should there be a /* sentinel */ comment added here to match the
description in the commit message?

>  };
>  MODULE_DEVICE_TABLE(of, rzn1_rtc_of_match);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821135608.2752=
33-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D16
