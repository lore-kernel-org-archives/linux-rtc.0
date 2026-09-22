Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF72947C11F
	for <linux-rtc@vger.kernel.org>; Tue, 22 Sep 2026 13:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083545; cv=none; b=e1ARupdUtGpz0RhR52VpWawksPy5ofFYeDqYUfHF9k8tkFy9Txuu21j0B3F6VJ5VmRbS2dullwLxUgujZEHUyVQeSjLWgUIVFYVlQYHT8lHC/Zwvj3zIbPz+zTISmO0QTRPPJ8V2gWHbwXH9V2luTCph5dBxNZpjjiMpLCxgPLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083545; c=relaxed/simple;
	bh=MSHRq0R7F45AWNhceGefOg0/Q67pgoQS8tq/s0R8VRA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fgaZH19djaSSgqmXTw0gWcGMENY4TJsbnEBceKWn34MZx4EwjWQdzmuEIYqWDKPnYrFkVMN7DHVrz7k/g9MCqQrFj8ta7/BscfjTLRkOj9zb6DX2SRkF9Ax29x3PhEohx0tdB2WtA402knK2o3IzgIVDiW1Kgg/UV6k6z8nNfNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxtaNYW/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxtaNYW/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264171F000FF;
	Tue, 22 Sep 2026 13:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790083542;
	bh=MSHRq0R7F45AWNhceGefOg0/Q67pgoQS8tq/s0R8VRA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KxtaNYW/utvfj76Ca+a4BNAY757Y84JfDnX2SDH1XM1KT7tOrS8+Lu6GBr5DbeIth
	 xzRgqh54PVQaBiAkvq5L7tV6ixPzHONSGcnhz1qQ9addSj7cqlO23abLD83UcLNFzZ
	 1kIoLnlwppuImnBwwewedTrUcOP3Z6AKApFq2E9RH+e4Y3vvDK29IhqvEbASacf4Xr
	 y4U0JUm2jhG5ctOEoiFr59x4ADdQSTwRz03QFMR0hWXacrUP5+sn+r2+QXzVWmtsRg
	 bobYmNZWstZw1Hvl2/5CpLfPV4/RpQlGa5RWcpiydO/tOJlBeqOX8Pf9R8gug+29R/
	 j9q76wvIXTkug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] rtc: bd70528: properly enable wakeup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Kemnade" <andreas@kemnade.info>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260922-rtc-bd-v3-1-7f2580c55d58@kemnade.info>
References: <20260922-rtc-bd-v3-1-7f2580c55d58@kemnade.info>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 13:25:41 +0000
Message-Id: <20260922132542.264171F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Wakeup on RTC alarm now only accidentially works when wakeup for the power
> button connected to the same PMIC is also enabled. Fix that by properly
> specifying the wakeup irq.
>=20
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Fixes: 32a4a4ebf768 ("rtc: bd70528: Initial support for ROHM bd70528 RTC")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-rtc-bd-v3-=
1-7f2580c55d58@kemnade.info?part=3D1

