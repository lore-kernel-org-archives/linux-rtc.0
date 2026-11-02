Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793647943;
	b=ln2XZkqE03Y6MXWYMNgAl6X8Zv7jcHrWlIeh6FFRsgINHuUyPkKydIWpBUUVvfWHQsh6
	 NXwhG4Yt7oi/cRdP9tMqOteVM/k11zoosn0iWoRO4RUHkOUIo6Ybv1MVSNqk8Yk0nvqQ8
	 9qc3LCGhGRvlj1FNL7EGBEsdWyimCW27ltORgIBrIsiAf0+12E3zVLLiGAOlPOWHW1Omo
	 iykyeqyo6z6BSPYRoeQ6oxKIuxhAMMhfJ1X2HqvpiHV/vLE0CqJP1X3tnjSICUi2qCq8z
	 noZbWT1VEGDqEwQoUyC1JNxMrOxO+fkGxUbFeCw6WCIlsAzD+W8Iaj7088SVbtVJIAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793647943;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5AEO/vUfMZOmeao2SQPuq3yKXWwdlJE+4AKmEMmdPVM=;
	b=QbLid1n1VEzivZAHw04ZO2InqrKyX+AMVJ+K7qkaXbtRdBWyz/d0tiVXtE+3UgOgdVQA
	 WRM9b6i9k0Mq82AkNM2ajU9cXLTMPxHpjtPbe+btnKTG9nFjg3cTEyVknefVziD3LbvZY
	 VBeRlspyFtjgfQI0YSfnkLdBO2qgCnvYDn7qEXraPIyGaoUY9tm91snyistyJVNzFY/gv
	 tvLzZp7AJT5oGMRADtn9YdkHhfD75igq0rpyShjtaN3VDrjvqsWrzWXLvST6u8dEIN5l1
	 oUtPtlbIpzT8vNma4eikI1K+pcNOa824R8P02fIDkXvHyLpQ89K9ZhIosUNjT0qUQeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nr09yrCm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3338F606A324;
	Mon,  2 Nov 2026 19:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nr09yrCm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE1E1F00A17;
	Mon,  2 Nov 2026 19:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793647942;
	bh=5AEO/vUfMZOmeao2SQPuq3yKXWwdlJE+4AKmEMmdPVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nr09yrCmlf+7attWmPqoeT7JbMy/eBzPNBDkqXC7jpI9SEP8MjP2/685Lr6Jf10os
	 6eRdrVnTHDg7QFlf/flgqASB+ylb13YR4KV35vB752Zh/2UUoatrP4Jiv+HmZ6UGpy
	 LzSisiZlbA5wViKySaKarc9Uo9v9YioPRflvA1LfBMujsaPGFh8TyszQnOhV2+LYNg
	 jQCDSvdPx7Iu/SRsS5vaM66lATa6M5BFCK0Yp/BO8NzFcuMpVdLIQ1kiQ+gzriHbf/
	 G8DpR6BwtJSZnwmRQX4j5SlbEEtQaRoD0OHtCO98NXD9ifA44Brs2xkpeByEZbTbbv
	 58Bkfy/KRfydQ==
Date: Mon, 2 Nov 2026 19:32:19 +0000
From: Conor Dooley <conor@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/3] dt-bindings: rtc: pcf2127: Add support for clkout
 clock
Message-ID: <20261102-eldest-cheer-efa83f11a349@spud>
References: <20261102130712.25104-1-herve.codina@bootlin.com>
 <20261102130712.25104-2-herve.codina@bootlin.com>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V/lOedDehBG/MrKB"
Content-Disposition: inline
In-Reply-To: <20261102130712.25104-2-herve.codina@bootlin.com>

--V/lOedDehBG/MrKB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--V/lOedDehBG/MrKB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaujlQwAKCRB4tDGHoIJi
0gnaAP9IJ0V8YIukkui11t1blw06MMPSoWz7ShGKPbxvL+9e/wEA8MS+ptdChFDS
eYotEJPvFu/AIXQVl3VH3UfUUulNpQA=
=Wg1L
-----END PGP SIGNATURE-----

--V/lOedDehBG/MrKB--
