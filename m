Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2B23B7B6E;
	Mon,  6 Jul 2026 17:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783360554; cv=none; b=tX5V9RvqpDBQVQ9k30nP0Y5QyJ1gvtRNmpMxXBDvPmE76AZrtjliDLOC88vdDIEiGAR0qDJQWJ6kIVWl2s/Gt06MNTHk1lruXNPbjQPEDR6YE+DaiSflY/NG5iBO8i0e9OHTd2Q+hRuwbUe65CAUX6kWKdSfpw61IlzRw9tOneY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783360554; c=relaxed/simple;
	bh=i8sYLarjLURvO3XkpAALJzAFmlUkduVrHHulfmo010w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q/mNZS13KOL1lPuPThuIv2RiEGcS8hwlc4VVeC+IMStv6LxZdlm7azC0jeMHz4xkJ7Ra0h1koCnyjrQZjSjPCji5rPjeiRNIvGjZuWO9X6/cqf/qacvql9rW6t9bgcnvi7DlaYBmxdBrz7G9/r1x4XAPx5N8wDMlV78Xej5uol0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaCEjJxa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaCEjJxa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B1F1F000E9;
	Mon,  6 Jul 2026 17:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783360553;
	bh=i8sYLarjLURvO3XkpAALJzAFmlUkduVrHHulfmo010w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OaCEjJxa6/7m4rmGwhdcUWl7/9Vxxrq9W/C8lbtNvQ3OwA4ZQebLzKHbGDqesP5zr
	 jS4tN5uks+DpBJ5mmgASE0DdLQBHcbgw5hYL8AeHRG9WvsRKBviqoHUXwql3veYZgE
	 EKBTUp+gVMZ8ObWLiGXLMxY4pexIzG/l2pcAU4wuouEurNSNrUhGwxGgIC8NWsH6m8
	 msh/O+e4aeMdiJay1o0lvciY8Mw0fi97MEDtBc9GSDs1uPuE50u7rX2210V6BHwpID
	 zsWUFvJX2rbCbDwDdGItfnBBy0f18nqSVxyYr7pV2hxce+fAGe0dUonsDgfD2vJ8+s
	 ZPjj7F0lqRROg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/12] rtc: rzn1: Consistently use dev_err_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: wsa+renesas@sang-engineering.com, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260706175138.12587-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260706175138.12587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706175138.12587-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 17:55:52 +0000
Message-Id: <20260706175553.32B1F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Use dev_err_probe() in the IRQ request error path to make error handling
> consistent with the rest of rzn1_rtc_probe().
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706175138.1258=
7-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D10

