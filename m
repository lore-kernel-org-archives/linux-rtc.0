Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001922FDC57;
	Wed, 15 Jul 2026 18:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138934; cv=none; b=JHeeR0OVGXYNnfe+XzXSgWHjELGGxuXNOyW3x+YWHQgeXYzCZ3XYrcYjmy3BYSOL30/UT18RG77EbB8Af1tjX0SRd7FI0YrBG1bGeqY7mbDsuvAfBXePBh5xeRM45sPRJo3who817h47BLJWUyE4qtf3/ROiXHtu0KdcfGj8zG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138934; c=relaxed/simple;
	bh=LkP/9mSlabI0OjN9PGpwk1y6aGJzhjkKmy8j6xfrZAo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YuL8SGj5bP2Hx4LqgaAPB3ehB+UJVC/ANxnj8H5PzoNUMLBzYOegPbJhWq+6ORVOA6LdDzipuC+BKTsUvxm3aliapntieiOLtbdL1iqWFoQLqkUDKSeNZdZb+RK3WqRQG9DcXJcISOkvyGTxsH7MfMWyEgHCukzzmMf62Wh/hXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTclVIiK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTclVIiK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6951F00A3A;
	Wed, 15 Jul 2026 18:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784138929;
	bh=qLVMs8B/gmr0UI3ooxeeE+f9lVRysNVAG6rFR/DuA8E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gTclVIiKSIHjLg72d2o7caOz1gFEtQBjmwqtTQ7X260itzA9VuR8+EpaY0jNjBtBF
	 SEcYLJTdKKXZcztUrGoSRNn26ZyVYpm/PA9gCZXRraYDZLRzPc86s6GxnlxUV38R6f
	 DABnGqEXc2QSkrebl5sXbeQXspBRqxPAJAZU3D4D3ncECj+jvNvg6qd1haLtYGO4bb
	 belVsCsgbVUK4bg89nwnZdWakI9cyH91CCrkuUvcnEccyEXEcLCgVgYNuq08hiLZNF
	 SQAjci7kVnZOjr2wLAS+QZ3WsaI0rbWtxLIb10RuRJYbB7SFzBft5Pk8LgHX+nOyaa
	 Sa2cS9aKIbieg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/8] nvmem: make all reg_write callbacks take const void
 *
Reply-To: sashiko-reviews@lists.linux.dev
To: "Link Mauve" <linkmauve@linkmauve.fr>
Cc: Frank.Li@kernel.org, ojeda@kernel.org, imx@lists.linux.dev, linux-rtc@vger.kernel.org, linux-sunxi@lists.linux.dev, lee@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, linux-amlogic@lists.infradead.org, mfd@lists.linux.dev, neil.armstrong@linaro.org
In-Reply-To: <20260715175229.24672-3-linkmauve@linkmauve.fr>
References: <20260715175229.24672-1-linkmauve@linkmauve.fr>
 <20260715175229.24672-3-linkmauve@linkmauve.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 18:08:48 +0000
Message-Id: <20260715180848.BD6951F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Syntax error in `qfprom_reg_write` signature causing compilation fa=
ilure
- [Low] Incomplete API migration causing widespread incompatible-pointer-ty=
pes build errors across other subsystems
--

--- Patch [2]: [PATCH 2/8] nvmem: make all reg_write callbacks take const v=
oid * ---
commit 7e2f42ea4c9950738972bc60aeca19f14bd93ce4
Author: Link Mauve <linkmauve@linkmauve.fr>

nvmem: make all reg_write callbacks take const void *

This patch updates the reg_write callbacks in the nvmem subsystem to take a
const void pointer instead of a mutable void pointer for the value buffer.

>     nvmem: make all reg_write callbacks take const void *
>    =20
>     The previous commit switched from a pointer to mutable data to a poin=
ter
>     to immutable data, so let=E2=80=99s fix all users of this API.

[Severity: Low]
Are there users of this API outside of the drivers/nvmem/ directory that we=
re
missed during this migration?

For example, when building drivers like drivers/rtc/rtc-cmos.c or
drivers/misc/eeprom/at24.c, will assigning their unupdated callbacks to
nvmem_config.reg_write trigger incompatible-pointer-types build errors?

> diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
> index a872c640b8c5a..bacdcb5610bae 100644
> --- a/drivers/nvmem/qfprom.c
> +++ b/drivers/nvmem/qfprom.c
[ ... ]
> @@ -253,13 +253,13 @@ static int qfprom_enable_fuse_blowing(const struct =
qfprom_priv *priv,
>   *
>   * Return: 0 or -err.
>   */
> -static int qfprom_reg_write(void *context, unsigned int reg, void *_val,
> +static int qfprom_reg_write(void *context, unsigned int reg, void void *=
_val,
>  			    size_t bytes)
>  {

[Severity: Low]
Does this cause a compilation failure?

The double void void declaration appears to be a syntax error that will bre=
ak
the build when the Qualcomm QFPROM driver is enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715175229.2467=
2-1-linkmauve@linkmauve.fr?part=3D2
