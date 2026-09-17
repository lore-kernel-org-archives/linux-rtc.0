Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD7A4B7A30;
	Thu, 17 Sep 2026 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789671673; cv=none; b=oSHOOIjMni707R8ZAhObcEWfdqzKow/WHpW9bi6vOZaz4AAT8XYrRVFYXcQbTAAg75/wIVe+rDHOC9I4CYQtF1lzdWAj6YbhForZeLxpglXYwT8OiohBPeiA2z5rCvXqil3Kn5eLpK3oVkwModF0pM9eQR2Qp/F1c58lu9hcvLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789671673; c=relaxed/simple;
	bh=nWzAnJgMQWpEM8xfcBSdu92iqR8c8uycNlGHmyBRRLA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VtN0UeNPyIy7dYtFo/ktR4U5bmP/8u4l8cK+LLoVapKQKt1W3WYBSBCvRt7ZIjFzwDY0LRrvYXHoMw6UhdpIQ0KARcf3M+Phwxz2jmGQrKTueYDMJsDn8/3M0hukOgeE3k/jB1P01XaeIoJ1ZshHY0lzSSxTo4v7q4VEgyv+mdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bw/ldvg3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bw/ldvg3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9E81F00899;
	Thu, 17 Sep 2026 19:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789671643;
	bh=nWzAnJgMQWpEM8xfcBSdu92iqR8c8uycNlGHmyBRRLA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bw/ldvg3Fw4iNHOaTzojZ91uKyV7+cxCx5g56qH7TEusrbGODNX0el2uNaTsJdCWy
	 ivtA6ekNlKRnEcCz6EEFaltbrUtpTQ6P5p8+8PFUu/dW2MnosoYhA1VU0DDT3THjRf
	 xIysaUMcp40wuqYt1zeEcyubKa1XVA4W26z+lyWXFKoP+N5XH9GoXHKwt0UN1bFh83
	 2exgF6/hfSFpNSYuYasVEzU0ntyYqI5Dye1rmcHdEt3HiZwkd+13GBh6q2ulE1ROMZ
	 KuPj0e1cdb6Gjt+dtQGBBxA6kDcZnc3JaHSx96fLCp5b8WDB2frglhSuNoOFekn8re
	 Y+jFsSSoPFtSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/4] dt-bindings: rtc: rzn1: add SoC names next to
 their IDs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wolfram Sang" <wsa+renesas@sang-engineering.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, wsa+renesas@sang-engineering.com, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260917185903.61253-8-wsa+renesas@sang-engineering.com>
References: <20260917185903.61253-6-wsa+renesas@sang-engineering.com>
 <20260917185903.61253-8-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 19:00:42 +0000
Message-Id: <20260917190043.1A9E81F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> This helps maintaining because the numbers are easy to confuse.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917185903.6125=
3-6-wsa+renesas@sang-engineering.com?part=3D2

