Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BC0348C5C;
	Wed,  1 Jul 2026 14:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782917027; cv=none; b=EVoMv8HNfxktzPhPzYLAjKz/0Fi3l965/Z/mH9dA+8RWT6VQBp0wUP+/m2y3V42NIrweuWOdBn/iSjxMVqxhYkYlmeBKN1wZiL/bQTC5rH6sUorg79K8wZ4lgXr+ejNAGuPMccQw8KlcJX5TDpAPsYOuwcKWRjuA13Xx4S7xsxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782917027; c=relaxed/simple;
	bh=LeJO1I2w+tO8gS3W+rM7aMHAk6VON7xcB3FVYSsduzY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rJ/aWcaN8MKGAYJrUfPNALTVkzLDKNFJbiwxDjyOvP6N3dPNxRfHcUVDjo14N+gwEPX64FkF6T6ogj3IK2D7VWUsvHkjQ53vhcFVzny9TADysFS51QZoUZT81si7Y6i225WhiGoHA1hY+lOxRhKIZ4yQ1zpZREUBmeeEpmFaRO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOfJdvQy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOfJdvQy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3511F000E9;
	Wed,  1 Jul 2026 14:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782917026;
	bh=LeJO1I2w+tO8gS3W+rM7aMHAk6VON7xcB3FVYSsduzY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EOfJdvQyexKruMOWl/BJ8O07Lfucgb3h5WBWoCwyktnE+IMWLv4390hlND4dFAWoN
	 nquz8394RvW9jE77K9jyaYlqShn0MIf6waCBVpk4z1sLDe/zjudjvWaP+JhvZvSJIU
	 7sZXW8QBBjvIZkmXcW9fEAW29DF9eojlKeEOJLJrkMMpxRLS5n0KbqK1PIJaggmnei
	 Z044aO8SIwDtCNuupRokwfK0SLJFPXSAC4X8CsZBlR/ont8rsrDPLkx4kUgixqTgkZ
	 BU4RjSpuy9a6OOQ5jRyjHda5myUXouKqTRIs8tj/9L1G8J/LRm/LzrnQ40tl7ZMOyo
	 6xmH5nFxEYwTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/10] rtc: rzn1: Use temporary variable for struct
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260701142953.2014895-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260701142953.2014895-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260701142953.2014895-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 14:43:45 +0000
Message-Id: <20260701144346.4B3511F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Use a temporary variable for the struct device pointers to avoid
> dereferencing.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701142953.2014=
895-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D7

