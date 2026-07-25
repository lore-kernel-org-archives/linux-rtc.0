Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC5D2D94B5;
	Sat, 25 Jul 2026 15:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784992263; cv=none; b=XF0W9GgOiakpw1ObPQvy/SbVdvTURt6HWQowyoYjNioU8pDUEQvpL84inzdXsVjtDD2aOCRGtNfYp02PE2A4dKDh7518/WXLdRYTwnVFXqD71n5sFmaj5u1xjA4pYeAC1QqB9iDrA26RmGCsWdreMXnK26R1zjUcxtrBKuUl0cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784992263; c=relaxed/simple;
	bh=Nt496GRPAjm08tMDYm2TPTHvwfe3uZw/aiKIhIcVMJ8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=edSG7Qu0meWll8RybReGueisvlr9/ZxpAx/1SibFSiqfkrwfMdqn3jEppMnWlHuv2nXlInVDMunarQY9sDySw9iySHp1Ri92NJHBX1NXI1IBxmHlWYipvdu6Vjiv73h07wGvA9JRfC2SfzWcJBeXfMTXI/MZYCrWYzI93jzp2fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Js9b8pdZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Js9b8pdZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5112A1F000E9;
	Sat, 25 Jul 2026 15:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784992261;
	bh=Nt496GRPAjm08tMDYm2TPTHvwfe3uZw/aiKIhIcVMJ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Js9b8pdZN+vYQFwlHbeCjaWPBTdHrkj3Qgylfcmj6wvogqTuo5pI7Qrp05zWAuFMh
	 Zmjlks/QblIwPMrsFMw0VXfGSgS6jQ3Uf6JIEPtCHdlGuuzCFSbFcKeHpr6TA7/j1H
	 ltQtlxsHOKCRAxxPwVF2OjPrpzmn99O5QTuYtu+4mHAFOYzIYn2QA39hJRGJDFYY8F
	 TA0bDsPWXVGsVTfEed3IPeVQWGGAirFLLPHovhjf9lUEIVw7N32UhjBvl6mE12JImG
	 1o/qNGwaQtqrd6KzYUm55aoIO2raABCEum3ZU0Jb0AjdnvfD2Q+JH/jujhPq5qZlad
	 3FYD+J6QTWbMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/8] dt-bindings: rtc: abx80x: document ABX81X RTCs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: robh@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org
In-Reply-To: <20260725145718.14733-2-apokusinski01@gmail.com>
References: <20260725145718.14733-1-apokusinski01@gmail.com>
 <20260725145718.14733-2-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 15:11:00 +0000
Message-Id: <20260725151101.5112A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Abracon AB0815 and AB1815 are RTC modules with SPI interface.
>=20
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725145718.1473=
3-1-apokusinski01@gmail.com?part=3D1

