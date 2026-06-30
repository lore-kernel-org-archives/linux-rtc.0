Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333E7282F1E;
	Tue, 30 Jun 2026 19:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782847496; cv=none; b=h6afvrmE58PWCsNoJmBmxS9ebvZ1dzQTjgAts8xNXycb6N2xzePTz2XhfWNGZW+bVM/gEm4C2oymJSupV00Y4Mz4QQs+i3a8x0nYY7Khx9OefU60FGuHsW6ciLo9EsdYDN7X/hvPZppgFy9flGbOvHzOiriG337qiBBOLUacIZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782847496; c=relaxed/simple;
	bh=hqAUe8yBH7exQn2XAdv+Lc/Y8o9ItkY1mG8eIahUBo8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ui9+x1hitm/oPT8QAPGye3vug18LMbI1Q9splSX5SyumkhUP1KHLj+v5x7C7BG0/XAi49vwzBpW/wBvTlUa16cnfo37xxVthZ31ydf/PCqTbc7734kmfmQHkDgJcC2fjJwBsCyLNrYIoSiln5zsD4RYStGda96sVVRrMrBxKWzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEaZMxvI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEaZMxvI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB211F000E9;
	Tue, 30 Jun 2026 19:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782847494;
	bh=hqAUe8yBH7exQn2XAdv+Lc/Y8o9ItkY1mG8eIahUBo8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oEaZMxvIOa8T5d65gn7rcQtafWN0w171Ww8LgiHTPHvOKYwwWp7FdsZi7MThZDYRK
	 YmFyxQ3tk5Psa+vXSJehD/WD6+IPLCnjPwSr+bI3yubnYSJdRWJccqCPR9FaQDE9uE
	 8cu0Wg3sW7bJ+P2bG6/p+jHl+hvlVGONjq3WwGlu7OMjBA8nJBauaegfIme7nCH1Pz
	 TJzzVAWbXM04CeycOn0/RdZgPiq8L+hcNmCExA72G+XpBFPadh6kVQgEhPDLp/qCiV
	 MUK/7+P/Z3lQK0vX/ABrJdAq4pzR3blzHdruKhAbAmx6uL/SyP5z8Fs8AbFqzRcaqW
	 sUahdnWmp8iKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] rtc: s35390a: Add missing newline to dev_err
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, conor+dt@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260630-rtc_s35390a_int1-v1-2-1b2239e16be2@posteo.de>
References: <20260630-rtc_s35390a_int1-v1-0-1b2239e16be2@posteo.de>
 <20260630-rtc_s35390a_int1-v1-2-1b2239e16be2@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 19:24:53 +0000
Message-Id: <20260630192454.0FB211F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Fixes: 3bd32722c827d ("rtc: s35390a: improve irq handling")
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630-rtc_s35390=
a_int1-v1-0-1b2239e16be2@posteo.de?part=3D2

