Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB830436377;
	Wed, 19 Aug 2026 10:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136429; cv=none; b=X5rTEdljjyre6aWThpeiCczx1wb07mWymVwd7JRTzWH2d7OSiXjBWJ/OoLPXTrUSytH31yMnSwJPx5whNnyrXUzpsk523azrho1SBIKuV4y4rX+oarskWtXSaN9x6sQqnK/KCwx11avyHLXnc3Ry/EfIBmbKl7O5QyqJm/WJ/5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136429; c=relaxed/simple;
	bh=qVQjn9T82r5k/SlG/UR1HY9JRYFIMcPS8PQ8qfVXp1U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M4xPnVGpO0MOjcZVSlVzrFrLw9FD+zzyD6/RAoGGchkjEpFAHmpTuukt8hhpYjVcnELIyBSFkjZLbJ/Zbaznj7pUw3BRhxLxxFzpNDCqEatoWeEuqaiBRAHR86+cNWtTX4tGSexBqWJQptSHVqm2Y6B/uQdaW0ODT6FZzFowRZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgtBLegQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgtBLegQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67A41F000E9;
	Wed, 19 Aug 2026 10:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787136428;
	bh=qVQjn9T82r5k/SlG/UR1HY9JRYFIMcPS8PQ8qfVXp1U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mgtBLegQrzWJf/SZxugZp7emGIoTfT98FPwkewfHOqWyrcIRErG8HIzEKvuD4LeM1
	 YmictExIzGcC42p8SHKIcQkjMAmJzJRWMrYwjCGCY7G1kgERuWYdgE/l7zZpzXP7fC
	 tv8tjxgZgOzT9S0swFBbS9dzRB9Q9nvezJGI+GNUJdUDNa0eA6g8FAY50O8Avac5ut
	 7hLYpCYbGNvFiRsBxmft/LilLqiKO6l0aHVy9balQ9XAHe3DW/D98Kb2suhWGsUyEq
	 KU4briXGjbF/MaJaKXLNYDdSU56S8MpVRO7HNPx9acIU4nAyMhHcFAk4jK7NBu5dU6
	 NNykp/CGww2Wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/15] rtc: rzn1: Drop trailing comma from OF match
 table sentinel
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: robh@kernel.org, wsa+renesas@sang-engineering.com, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260819103926.2136712-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 10:47:07 +0000
Message-Id: <20260819104707.B67A41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Drop the trailing comma from the final empty entry in the RZN1 RTC OF
> match table and mark it explicitly as the sentinel.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819103926.2136=
712-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D14

