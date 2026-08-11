Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E708039DBF4;
	Tue, 11 Aug 2026 19:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786477732; cv=none; b=ucs8a6od096TROO/OG8woKu5JltiDQT979zbwBoKv9ih1sWhulxuRbagM0tZ6DBA8UQwElYZHWNPUBbvdARCVCpSK3huQLzIQL8b8j/jzQPh5bT8e/L/dAW0TGt6KTEJ8pcVlQrQWxbKTPRIs2aefon4ZgK3lBplVeC57riM32g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786477732; c=relaxed/simple;
	bh=D+Bj2U4okipfW4jBCaawotLFBjep6p2J3k64X2IdHc8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SdvoOZ5pkBNSjLUd7l1/MGeHGDy4b5tn1fXo3NhpJM2GeMnT1Om9xkzUeSfTnWy1bxTK7xTYLOM56J13kGJpatBYX3HK4ZaeZnXA6s06RlncZToj6mJ2MTqJgclvR0dVPOdCb/6j4uxjk0zEzzxBn4meMtx7RsHOVbIlybJz+K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbkUE5NU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbkUE5NU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1FE1F000E9;
	Tue, 11 Aug 2026 19:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786477731;
	bh=D+Bj2U4okipfW4jBCaawotLFBjep6p2J3k64X2IdHc8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LbkUE5NUTr/SSJ2bZoMseN3cQBQ5AN4nO+1mZhTdE2FsvJsOaIGHpzrIg9OWu2FzE
	 P7wkbf58Ljiu0C6LsG9ofuAwkxNkRBLyO9kclWB46fRR8IRqthhURlE4B+/bqobkwA
	 d/DFlHNX23uQ2oeUk9G1R7XHO7l5VLjTbae5f4LlVdLg7fMe6jJ8boys/ciejLHKJ6
	 66iE4roGJSTlO7bgO6E2RJUC32+KtStJ8JPGMDUm7sPHGb1zc4MYGtRfwb/R0OMjD7
	 A3qVgMvVWxITG6814gIC4/SapRjQuw0AgLTJuEAWowLkGeHU/zGXcu/UrdhWtobQi0
	 WbEabPAYvm4pw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/9] dt-bindings: rtc: abx80x: document ABX81X RTCs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260811194034.28937-2-apokusinski01@gmail.com>
References: <20260811194034.28937-1-apokusinski01@gmail.com>
 <20260811194034.28937-2-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 19:48:50 +0000
Message-Id: <20260811194851.3D1FE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Abracon AB0815 and AB1815 are RTC modules with SPI interface.
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811194034.2893=
7-1-apokusinski01@gmail.com?part=3D1

