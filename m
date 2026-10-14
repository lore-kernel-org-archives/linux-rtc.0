Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26572470438
	for <linux-rtc@vger.kernel.org>; Wed, 14 Oct 2026 19:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792006860; cv=none; b=ol+4L7J7nIH3dhJVIck+eWk9rDUTK6Qb2uGGL2mvWNyZv2PFsHqzAW76DgSbU1xQGUyI4RpZm97NHiMEp7vsoeDvDu5lgkUWSFxdcS+K32ZLF2o4bj+RkW4BNW3o71zuWPQbXkWGYYrWYXt2CVvXhT8xhcxJ+AsGk16YXimrQTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792006860; c=relaxed/simple;
	bh=jplaW3YLxQho4h+U2HjNBZx9PjMm/ZSHfj9JorzktFg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=FhkDYXPpVgMR1e0fyzCovZaXLwOUU0J78Aw+4xsv5b2HZRb0hABOlzWuM3+Jb1NleQdUhnS6iEcLQOOH77QSXCaIHXzO7kIH+v95sxAOHfxwI0bnZEV/ZaeRUGtvpYya0U86S2sVqNa9pDPfZARTEFPrLuY1yN2gCULOe95BbRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gp9V3Jf7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gp9V3Jf7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615721F000C4;
	Wed, 14 Oct 2026 19:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792006858;
	bh=jplaW3YLxQho4h+U2HjNBZx9PjMm/ZSHfj9JorzktFg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gp9V3Jf7qPUUouYi4FOQWnJjwyqf+81eDmmq+RGQg5ZgLOw1uZI6XJRLfa+5VFTVe
	 CQknOLmg3YwtgSr0OpB2j5lkiuGKSOIoaVSkRgjcNRHB05Ndh5N/EFMqw46jIgMaoq
	 IRADo4HtvP5zP6AgQIOoeYJFXGe8YV3GnlbhejJeZvhrBVJZ88QnmjRrfhvFyk19us
	 a7p0QAzQ0XGjWER5eZA50KFgemN9sCde5I1p/sS20bjHLlWpqK05AUY09+K1hoimED
	 qELqxuBF1uI9aj0jUgZPGJDed3kOQm8UQWTmaKgA455aie09YiMTTs4xXgPCwB0lln
	 7+48qYAyxKQLA==
Message-ID: <sashiko-outbox-171804@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: sun6i: fix error handling in sun6i_rtc_clk_init()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pablo Mazzini" <pmazzini@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261014193220.38055-1-pmazzini@gmail.com>
References: <20261014193220.38055-1-pmazzini@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 19:40:57 +0000
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Set sun6i_rtc only once all clocks are registered, and unwind fully on
> error.
>=20
> Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014193220.3805=
5-1-pmazzini@gmail.com?part=3D1

