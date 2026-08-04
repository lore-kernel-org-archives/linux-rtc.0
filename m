Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011F54398EB;
	Tue,  4 Aug 2026 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863622; cv=none; b=u0szdgk8t7fcKQnCQ5a5Ln0X6wI/+25Mm5nBr9Dtb6h5dhVtIMYK19nc3he7oMcizcZmphd0AVTt1Oa3j2Ht83ytNcG7+73Z99RD0sE3Xot/m5rpwLp/cN+8swsseNTIXI/fw6dIk6ysoS7al3Q4TBm10ZBhWVDhOT3JyOuzAAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863622; c=relaxed/simple;
	bh=zGB/8iWuFrH9jTMIXzqegG5TZjHBa3w4RyQ2t9GM/Hg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=icKbUmUSxHdlGr2IL6m3TirbBLQtnGMr7XklgZ/MpkVu0RUWTZBTiYXeYLXRTOM5G1LwPTfpK8j5i1QnCDb0iLucFLZxFtE6+DbUzJwY9a+2HJXj1k1e7upjkKVeyEMH5l2A2TDaqziSzNcgya3enOHqMV4Ap6gHMTVb6585Src=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3XAq0Lk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3XAq0Lk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19E61F000E9;
	Tue,  4 Aug 2026 17:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785863608;
	bh=zGB/8iWuFrH9jTMIXzqegG5TZjHBa3w4RyQ2t9GM/Hg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I3XAq0LkggjVV2pjzsTodhPfPch0R0ooszmn/4VLfzbsN7IixvWsdXqvRRYWPvO/s
	 OXd1Gmkx2au36Rj6XKSeVy24w0e7NebO//aJ55UWH3cU1zfsLPCo36lvVszbu+GXvQ
	 t+HqNHRIyybDDtyrbvVM+G0Iba9R6z2hobaGk8PYZTq06FYOvudgdQvkZZQm8ncBZB
	 0ryCTL/q9j/6yBQXvcz5jtoZimv2xfYlXLlResSnhlGyJhc05g16AxUr+YUDH90gh3
	 rPgDo3yeEZKk2bBvNRDJ56vtZpd1hDRjtOzengu/ngeZnwh7q0mlhvUZKGbJjCKCH+
	 DhFKlZuhN4xsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] ARM: dts: ti: am57xx-idk-common: Remove unused
 ext-clk-src property
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bhargav Joshi" <j.bhargav.u@gmail.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260804-ti-omap-rtc-v3-1-ba3bbd8af570@gmail.com>
References: <20260804-ti-omap-rtc-v3-0-ba3bbd8af570@gmail.com>
 <20260804-ti-omap-rtc-v3-1-ba3bbd8af570@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 17:13:26 +0000
Message-Id: <20260804171327.C19E61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> The 'ext-clk-src' property is a legacy, undocumented boolean property
> that is entirely unhandled by the rtc-omap driver. The driver instead
> determines the clock source natively by checking the presence of the
> "ext-clk" clock via devm_clk_get().
>=20
> Remove this unnecessary property.
>=20
> Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804-ti-omap-rt=
c-v3-0-ba3bbd8af570@gmail.com?part=3D1

