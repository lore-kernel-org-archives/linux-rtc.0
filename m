Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BB137BE71;
	Wed, 19 Aug 2026 10:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136403; cv=none; b=STSxZxV8OIQDmVnXyT+VzX4dtjxCqqmDHevOc7VaPpfT9R3GkLIfqxGpyiaQbAQVVZ8ixqvLUnnPnnRzsqm7P1xa6LIqQBtjpwaRtu7zS9suUM1zl5RmOBlOmtzaKXG++t7n/ff/J+mUI+tPwlM2X0179YidiPbmY/2h6Qb2wbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136403; c=relaxed/simple;
	bh=8ftg2szJVrguLi85WDdrcAthchLFTb6EqrrBP278Plo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jU+SZmW63ndhlglmSD37KQNfX/9At9j5BtcScRLUFq2Q4V2JG/ea/c176+Gsdkd5au8UxKy/SU3wc8FXZQcnENLxmOiHH+IwYkuHVphz6HIFGZPGTzD1ohrBi1r/jFJ8D/sMsErzo1ULwp6Y7Xr6qPbBGs+8Bq8Ep6NqBsd88rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrKbvqPA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrKbvqPA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3591F00A3D;
	Wed, 19 Aug 2026 10:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787136402;
	bh=8ftg2szJVrguLi85WDdrcAthchLFTb6EqrrBP278Plo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QrKbvqPA4oFpG7AYfjAV05MBJSV65WVw33CNIw6rQfU+PBMRDk6slwcXLelAJGNHR
	 S26f09pm/hZcBICPgqND0f0PDN3w4NM7fkhq0MO+2Uke37udaCm4wbp/d76SMvFL4g
	 YqL28OeSx055BVS7EKMtQQLb8NoxGEUvryNl8gKEJ10Ag+G/xjDJ+df+xGhSuEg/EA
	 SlTZsfmoHaX8i1cGlim249CKRNkjjOfE+rj5KC3CjMOuP+kFq0TvyquCyjwWC/Epfa
	 lFhWLGhZ37JT64TrWx9xYePsTKA3tjXEzPVwqjT3P4760qxNg5IlVNBAMI843MBijP
	 jWpZ5sIsYmC3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/15] rtc: rzn1: Consistently use dev_err_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-rtc@vger.kernel.org, conor+dt@kernel.org, wsa+renesas@sang-engineering.com, robh@kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260819103926.2136712-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 10:46:41 +0000
Message-Id: <20260819104641.BB3591F00A3D@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819103926.2136=
712-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D11

