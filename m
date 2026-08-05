Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB045427FA6;
	Wed,  5 Aug 2026 20:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785963363; cv=none; b=uy+4rb7mrPrVdFCZqgHspESNiObcGfMp5jbnbAupz5hmM6wHSYOShp/XGoFlXW2/tBnU0N1cUTLXquEp4RY+LwEDNj/Uev9NV12PYPOqTAhfhxQ6amY1k2dIf32uz4lbL9zLR+CNt+ZGNiVC0L+Jej/Nf8xegiyzk0pyAg5O+4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785963363; c=relaxed/simple;
	bh=R5K5LXxmTD7cvzPzoP5szaYUnefUA1pEtGyOUB9RNJY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LRqQAjSfxSvBdWaBK2OsvM6iHoH9DHw/cCL078INYuhte6eHbzow4F1+9qn5rne3rzjN+MSpPjOdxK0BD6WohhxB+SlVgk/pNBzxG00/7elSXaK9lNvFUoYszrchC+uga/d3MnWalzv6jG0+5GFwa+Dlk15R4HUIGEFQJwqiZYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+IDFMo8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+IDFMo8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B821F000E9;
	Wed,  5 Aug 2026 20:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785963360;
	bh=R5K5LXxmTD7cvzPzoP5szaYUnefUA1pEtGyOUB9RNJY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g+IDFMo8bWozXzgqvuo267YH76VIIwR20GS7oExDwxDfFpoKjHTXpsoypdjk9eYg4
	 fSCP6TcYQlJZurTT98QFD0Le2Us9MPNtbJfRnyGftdkK2O2SE9SPcE2+5Wed4CYzmY
	 rixFUjYzixJtnkpNRHSRRiPZ0d4I6SUSA6t2mCvkU95h0BGdwyly1fG8v9vZ+5yA2F
	 zf0TAwcsp98TqmcLtM6Ly/R8dffaCBmFYXR6Jdo8vn/LSyHN2IJ2xAqaTvwGghbG9E
	 aMPD2KfakWj0UQRYsoZawyYPqVP6m7PQJMyNLB0waD6PezXwkbqz5V8nNegGZ8fxEw
	 BGTuc8W/K1c7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/5] rtc: s35390a: Add synology quirk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: robh@kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260805-rtc_s35390a_int1-v3-5-e836faba3e25@posteo.de>
References: <20260805-rtc_s35390a_int1-v3-0-e836faba3e25@posteo.de>
 <20260805-rtc_s35390a_int1-v3-5-e836faba3e25@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 20:55:59 +0000
Message-Id: <20260805205559.76B821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Synology NAS devices use interrupt signal 1 for wakeup alarms. On ACPI
> it is not possible to configure pinctrl.
>=20
> Use interrupt signal 1 for wakeup if no pinmux function has been
> configured in devicetree and dmi sys vendor matches "Synology Inc.".
>=20
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-rtc_s35390=
a_int1-v3-0-e836faba3e25@posteo.de?part=3D5

