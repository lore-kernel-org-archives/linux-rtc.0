Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8156741F5D8;
	Wed, 16 Sep 2026 21:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789592878; cv=none; b=NcreG16srvcJ74UPBpcwmp4WYCKbUKGz4dncnUdbSbxi8A0uzAuv21CxhmOZninJc3MzWdmxTmUoqA0WIuhuC+XQELWidEzvl4yq2oL3sA6uCdZWubaqAOT/eSfcjiAczFlTdRwek5Gv8oZjbRtpx/r8wr/xqpQjHR84+fGJ7xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789592878; c=relaxed/simple;
	bh=uojig818TnZJWCvwyqnIcY5VGqjD6FDqt7RU7scE0Ss=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NkKeR1UUfATm9pGoz64pCA/46ZjtXgSi93LUsVhvI2xiUmAwQEMqeJAY77D5y2T+hhTD/7tnamFyQkE2y11ito862bq72uIlree60Lf63Nlcgr5mcVru7KGDKwM0tdR+Agq+jsRS1B87mSgpY5mJaFv6s6iBxhWhBcOsbfXAi08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nriy4WH2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nriy4WH2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4631F000FF;
	Wed, 16 Sep 2026 21:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789592865;
	bh=uojig818TnZJWCvwyqnIcY5VGqjD6FDqt7RU7scE0Ss=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nriy4WH2ICwoQtO7zhH37ZqUo9iZlGUQRlw7gF5DSI7jhAR0VITuos8jJM2NHmksT
	 0/aMFU3cwhqq7Ke+VYrTtnT7RAfrtpVUw8WOZ4t/rNmK7WegnMFYvUbOJxhyeymcgC
	 oQKkHFk3Bs0dBKERDTgjnxquLfr3+coPnER9GYALUPEZo0tTBrrtqdfL69EYZUiCni
	 +AVAKE3lPgOVJhXJC6HxobMw2jAt87eLchQ6lqx4pVj43bk95XT/0jccU6XPCIIORL
	 /3W8N84WoPiyF4OsvWJc92IH8+lD6J7PJhHsl4ElJ6ghTp3jzfHegCOnY8aAgoS2Tk
	 K36hSpO/lGElw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 8/9] rtc: abx80x: create abx80x_i2c_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antoni Pokusinski" <apokusinski01@gmail.com>
Cc: robh@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org
In-Reply-To: <20260916205138.16771-9-apokusinski01@gmail.com>
References: <20260916205138.16771-1-apokusinski01@gmail.com>
 <20260916205138.16771-9-apokusinski01@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 21:07:44 +0000
Message-Id: <20260916210745.2B4631F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Move the I2C-specific code from abx80x_probe() to the newly created
> function. This is a preparation for introducing the support for
> ABX81X RTCs which use SPI interface.
>=20
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916205138.1677=
1-1-apokusinski01@gmail.com?part=3D8

