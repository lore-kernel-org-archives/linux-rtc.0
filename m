Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B930448396;
	Fri, 31 Jul 2026 18:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785524233; cv=none; b=nwDVRQk3zL0/KFhPdpejEA/m3DbPW8D0pP18LrJGCXnwEuHPZU7D/6ZPlOTOkQgKiCiNXC44FcTvseLfA+rKtIGf+gkH/OWohssdEQkq/YcXgsOtkuIEbyw54UTHIyl71862P5+6521bZxEOEtfADFHD20FX/ADDwF5eESq9H2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785524233; c=relaxed/simple;
	bh=28V2uAM3XpW9lkIlPbL8ZM5tVHKWviuwRljv0ziCUTg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mGncIUkgoxs9ZlQqCSqFIUHNnUGS0YCrVRoOXKA3apXvHUnOCfh44S+i+RRescQElYG4tn0Uu3IZSI8q1wpR7G8AN4fJ3BRS8wpH200JhNnin/BnZCB/pfyU5hgiJUhA/4+0qhhWWuUrQA9uACKc19THuAbehi9tqukZ0dmzQ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vi8WFrgH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vi8WFrgH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2103A1F00AC4;
	Fri, 31 Jul 2026 18:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785524232;
	bh=28V2uAM3XpW9lkIlPbL8ZM5tVHKWviuwRljv0ziCUTg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vi8WFrgHYqZd8Hpb1e39QYc2vX95umPaoolwQEpdSoPJrzyDCihgajyuZlYw36Ip8
	 gISIqd+Kh3IdoNk+FspJ5Qn/GzA1d2o1jy2uj1UF+eddRmuC3djUP0Z3pSHbaColEf
	 VQ/U9+wF+HZQrZ0jGZhYGLrm3xC8ZLrcg0dL08tGsU2AOlQBIyHOxX13OAwd5ANibV
	 d6RotIyvPh5ocwkoXEmW33FhFLPCajAboFtK/q6zOfpFZCd8SJRI/YNN3hcB0K2j3m
	 mV3vdsX7dXVQ/KsYhensKd/WWvzpIwyhOKzQnYDs+ZRxu+vJoxoDz5dFDb/pZTve5Y
	 fL2qPcMrv0XCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/8] dt-bindings: rtc: abx80x: document ABX81X RTCs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: linux-rtc@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org
In-Reply-To: <20260731184831.44037-2-apokusinski01@gmail.com>
References: <20260731184831.44037-1-apokusinski01@gmail.com>
 <20260731184831.44037-2-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 18:57:11 +0000
Message-Id: <20260731185712.2103A1F00AC4@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731184831.4403=
7-1-apokusinski01@gmail.com?part=3D1

