Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECE9345ED7;
	Wed, 19 Aug 2026 10:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136227; cv=none; b=jItdCu16HvEVkabqzYxxe4Y41yFk/CRMjM96wI5oJA6sqtLd62DXzLzZ32PMJ8ardTMVtS+NQC/qsl/598K251MXwU4WlsAMqAKK5duEAoVa4eftekz6McohayMl7jv4O/sjzKBvWAPQjTgZxLe4MAE3JEMGfl8KVUAqlWjhAms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136227; c=relaxed/simple;
	bh=7T8bDtszauB2b6bnMDx9aqUyz0vKrYjpL3OxAxgk754=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DKoRoJV2CyAt9mKLRY4t8a+LUjKifqXcvh9eoTN7fv9yu2VcV0Rsfc8NvIBvmRInX1r/SWbVB88mbHHzhlncoa1qR7m2Tb+VM1E5FeSVYV0MKhuY/+dyUB/Oc7CzOoCooVPB9ZD5rC2Bxr9X247gBImbnc7UP7HQcBrhJuwoiFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJ2X0CMn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJ2X0CMn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4775B1F00A3A;
	Wed, 19 Aug 2026 10:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787136226;
	bh=7T8bDtszauB2b6bnMDx9aqUyz0vKrYjpL3OxAxgk754=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oJ2X0CMn1HEGdlI0CviMgJVDxj9xU0ljZyogstFnTtkE7VA7EREtmR/6m5GBJTt7M
	 30wAbataPJ6Mg4QjCq8iq3oSlsA2yNtsCFDI2Eo+Pt3kuvknwh81CL9Izgrg6+PVvv
	 LYY58c/L//627omEwR3NVBy6QJ2TuwlRb3DKoiDYGDOcqLoRk+M6LLUE/jsHa90KN4
	 0Uvq/WAobx4Bf3hlgzmNz3NBWjgYfU629yIJFRtLVQLXD3IiEMD3iaz4GQI+LtWuEK
	 OsuyzrzRe9+fo/230JmHV2JQpTltTa4cGOIDX+e16ZSIs4HOIYoo3QH8GJdoDu8qcs
	 Ior3tvNLZeRAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/15] rtc: rzn1: Fix malformed MODULE_AUTHOR string
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, wsa+renesas@sang-engineering.com, linux-rtc@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260819103926.2136712-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 10:43:45 +0000
Message-Id: <20260819104346.4775B1F00A3A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819103926.2136=
712-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D4

