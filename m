Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334DD15C14F;
	Sun, 23 Aug 2026 22:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787523574; cv=none; b=tIDmsfvVKElDsfCaNsm20yCmJxnEY39xWQoWSy1z+FaTU917TwN6iPWZveXcA8MYRUSfIpkYzyBTHfN95fZ8dMqIicI4g8SMHqE5cY8M2UKVYIPUAJaOuuwm5ayKLGsIqKNF1Wo+0RZfmrnyezYxtnXIwvugftnzEQdSU1zW3ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787523574; c=relaxed/simple;
	bh=yPoHIrZSTwZ4n6rrbWbrnm8gdSj5PtRJZTSC/o8fw9A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=adO3Dd4+sXbWWOD2Hiaab02bahZbpa5Xax9o8kUelrW8hRk+EwHlDLZDnRjNaL4ZKSjh4zk2SZU6ltHuKKy2GheRMmlaMI3+6A69HdIV+7nkNknGQjWwjef9ZeNS4xjt2n2m4QGyavIj9OR4wTz1nJfKcqH1iX3UxYZuMhR8zjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMuHHSa3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMuHHSa3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A2E1F000E9;
	Sun, 23 Aug 2026 22:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787523572;
	bh=yPoHIrZSTwZ4n6rrbWbrnm8gdSj5PtRJZTSC/o8fw9A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jMuHHSa3pa6ptiru2pTEGdiaSVHioBxD92Dszc+nb2+yKSEG2ZTIJlUsGVebOcJFQ
	 FVKklSEU63Rxadx8TGy0SKIJUgqNn95WgHwnph0V8e5wjYGoJc86w0Lhh7VMRm7y5V
	 3VSyGxMkjLBd7HiVTjDgaSKZjTbFk0DUc2zx52DY+uVLodGtN6y6DI5Qbh5JRNtLeW
	 XCHSj8Mmrq4jx3gDN3hCLHjGayadlVEnkF6SJWbu9CNw8uVDBL/Z22wpdF68Af+UO7
	 9iC+TcBW0RAPhNoOP4YkeilIElxM/jZ2LOzyCG7H3Y6ksGvzZsxV3pcyjeqT5Cfx7J
	 Zjkf1rAREKFvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/6] rtc: s35390a: Fix alarm not disabling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-rtc@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260824-rtc_s35390a_int1-v6-3-df96569e3412@posteo.de>
References: <20260824-rtc_s35390a_int1-v6-0-df96569e3412@posteo.de>
 <20260824-rtc_s35390a_int1-v6-3-df96569e3412@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 22:19:32 +0000
Message-Id: <20260823221932.71A2E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Implement alarm_irq_enable callback.
>=20
> Fixes: 542dd33a4925 ("drivers/rtc/rtc-s35390a.c: add wakealarm support fo=
r rtc-s35390A rtc chip")
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-rtc_s35390=
a_int1-v6-0-df96569e3412@posteo.de?part=3D3

