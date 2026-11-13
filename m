Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794609380;
	b=XpnAGNPbZzNFckGiilLqjhKYPwRUxm5quTl54uMcMMOOb95/fX+k8CXROxc3DwLkLlIL
	 LuEnwRPNrWX9IEaJvXwqRH7oA1KReLfAgpDBUyt8GanZO0E6L3YLOxvEpjsIXo0yGB7Q7
	 oabKX8nyEPNqHDFBLw1xI350lJ1SfMqnMFTBTqG4KaTJdZZo6hjzl6vKNEiQQgVTU4xVp
	 tnw6JSVS5DOKjxRT0NiRBTcYv6T4c+9Pt6hBNASVr1zGwC9yLFXPb4AMTNe+TDchZ9c8d
	 K0xmLOyVpRoPnOtcDsILfIA/2+4JCxlysmCEnl1X1qXGXhxjWaSjh7OvsRs51P5Q0vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609380;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eX33GiNsl7FWmK/6UlKadCBsGQN1cWbZdZDhkNP3VD0=;
	b=jkiLxtTdQn0V7V3vybylTdXm+lLZwNtyJ8a44tIPUWRKPCa/l1sJzdODFaY7lwkQ0t9x
	 chq/GXaF7wT3h/3nHLHbsRahI/g9k1aYp85d7czANdiwfiNnNzDmmeR354wfWqY0nuJib
	 fB4ATn6cbl0hwGxWt84xE2J3jQiacQIqy9olmEMmh+AgdAHGotk1QFS3/uXGvi0b1L3S2
	 bPrIvwS5903gwuBybmwYoutAOzS3cwz8moLYCFMZmRaPxL2mFMxXxb4/KXW4u5pHvMPRq
	 IokKnZbRfBV4I3DyCwjxKlo+vXXrsJ3U5y/TAPq0A+5FPlUkiN2hnWrXPDDQb3ngFDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FqPakHlk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DCB606A561
	for <linux-rtc@vger.kernel.org>; Fri, 13 Nov 2026 22:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FqPakHlk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F791F000C6;
	Fri, 13 Nov 2026 22:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794609380;
	bh=eX33GiNsl7FWmK/6UlKadCBsGQN1cWbZdZDhkNP3VD0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FqPakHlkO5yZcTek6v0I+UZDahvlNz6UKMBl/EKkeLJVAnx9OAm7Kh8TF77ZVf9QS
	 fvBJhCIfPT8uDiBnMoZOCFuVGRm82RFSO2RLfnm22dKDTfG0JpBdZUxW1CtMi1W8D+
	 C9hVA+M2YpzUPmnC57qhcx39ttTDqIZH8PkZLr+GhPtfTT3vynsyRkNYi/HweAWtqT
	 Xx29oT5s4tngnBxY1iv6KUPhvFZyxBOf5mfaRbYOXEHoI0yJhgaXPfkIGoTGgJYGym
	 Rk7QpNH3UsWIrbCIyFz5HNuXo6/7Lp0ljrLn3uBVSB7PwKD73c7yyVls0JamLjssfL
	 uiKSOK3rXcBlg==
Message-ID: <sashiko-outbox-213818@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/19] dt-bindings: timer: add the Allwinner V861 CLINT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261114-v861-v1-4-eb71ec3ee523@iscas.ac.cn>
References: <20261114-v861-v1-0-eb71ec3ee523@iscas.ac.cn>
 <20261114-v861-v1-4-eb71ec3ee523@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 22:36:17 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Han Gao <gaohan@iscas.ac.cn>
>=20
> The V861 uses the XuanTie C900 CLINT implementation, like the D1. Add an
> SoC-specific compatible with "thead,c900-clint" as the fallback.
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-v861-v1-0-=
eb71ec3ee523@iscas.ac.cn?part=3D4

