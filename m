Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6022E736F;
	Wed,  1 Jul 2026 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916340; cv=none; b=eVHvGVbbl4Zo+g22HC+PMJl6Fb4uXJXVoZCXu/xgifvQgGcmoTNB3wYQ1dkp64v5kKoUUFZKzEDjvv5m7HZMx1EhUahEmqHJ0dHqQnItugLv9XnohQ/MZIyIMrBKFHTLmuBMvc/ozexOj1gok3I362UgKbqOMGWVmOlTjY6ttPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916340; c=relaxed/simple;
	bh=VowqlL0DJjoWqTg0KD+LrSEe8g7aGsNNd0e3WoMI04g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fZkuH47eD1fXEpsPIBLGCB+eq7rs2hpW4AsSqNyu6KvRWqfxO05aorQmYlfa+AYrbvjgVJ0pMYioYgotRIKc8w2uqQK5co3bC7h4OPmnhsRfUZcONhtEfVhH+MQCjyFnMCO0bXPbXH/O956mcHJ4HQ5ZMuyLVhRnybIGnPHrLZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMMDa++I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMMDa++I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209AF1F000E9;
	Wed,  1 Jul 2026 14:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782916339;
	bh=VowqlL0DJjoWqTg0KD+LrSEe8g7aGsNNd0e3WoMI04g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OMMDa++IKc27aEh2z+blUe5RxFS22wQ36W/ptiq/Tt/SrPDu0VW5VCYo50E9VP8NB
	 l2Bc7qJFSJ7Udi4H44scwO33J0N3cO6UKO19OJFlItyOqU/rO2RAZ75IDmXJ//29Qf
	 iMpGuu1lRPQ4krdeHbDVY284Vq/JkmEVq2kpwXt5SEauC0YNk8/f4ANvOShQmsB8Ls
	 Ciy1UVz9ORM8sSnfBUKi3Qup+6jVWpluF03t+Ki3xEk0PGL8V2jzbQJL55Y6o1f/fF
	 cd3om51Jz5KlZGTspkWK+KOdNOxd3nQ5pwM0sf0ZIZ+h6NgXu8bE7BEpkWyp4TvHDl
	 jPev7Hs1FmGPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/10] rtc: rzn1: Fix malformed MODULE_AUTHOR string
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: wsa+renesas@sang-engineering.com, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260701142953.2014895-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260701142953.2014895-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260701142953.2014895-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 14:32:18 +0000
Message-Id: <20260701143219.209AF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Fix a malformed MODULE_AUTHOR macro in the rtc-rzn1 driver where a missing
> closing angle bracket on the second author entry creates an invalid forma=
t.
> Correct it to the standard "Name <email>" format.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701142953.2014=
895-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D3

