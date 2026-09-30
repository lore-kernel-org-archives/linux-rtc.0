Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9436355819;
	Wed, 30 Sep 2026 15:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790782440; cv=none; b=b9pBB0VarM6xisgBvoYMu46J5r1maUnFPAyTHlY3dDLNgqOjo9x8kDoSc5zdtKexuVrz9b7rYOylFJwCCvqH4tZFQbRIg8UqGAz/S1u12K0gLkMf2jaTG/txSQLIQ3tduCT9c4FZ4adYkhAKzOTb3Tb6hCPcC4RjI1HUi+cqa4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790782440; c=relaxed/simple;
	bh=vIy2xc1GoTbnbtaZ/Xv4JN+S9g935RDPzbfUjpEv6h8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o9u3W7INmQvXVrE3MrZxWraC47SocqcDo2qaTR61xvyn0SzfF+46ANS4JZ2LAlUEeB6Gsv60dVA1cYa4sPI5aq3I5ipamE7dXWAuUGFICtAwZvuoOIGL80DaiGlXZEqOfxGaaPZulXhhpgQ3Bqbd/Ra/kSsPXgYE9XayMqel/NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1yJuD0/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1yJuD0/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84F01F000FF;
	Wed, 30 Sep 2026 15:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790782433;
	bh=vIy2xc1GoTbnbtaZ/Xv4JN+S9g935RDPzbfUjpEv6h8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B1yJuD0/ZIKcHV5PW7LUg4BcYFsycGyKqU1TDfOxjPOuxD1vaMxCollNGsXpYZJD1
	 lgKBMb0YVJMOe9ApB37XvdsEUKGHIiXKRoshJXUvF9qo3MSvokIXOg/pqNDyQ+y1Vu
	 gP3FikYgpMSgG4j5Iht1Gk4QyyAMKk0YAA2iNUk1/ixKBjy2ZeicJR31r/B3vxvtU4
	 m9SjE5udtkXlxehTSxv7aTj6v77xaN57U9V6zDmHVSMQHZ6nrZAoJyxaUSj/yUZf3E
	 kkfoc/bznMHHgR19358OX4iHwWv22xVDp2X9WyVGQmTw10X29Y1H2pyd3O1MwKEfAg
	 pyrWX2xTSi/Pw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/6] rtc: s35390a: Add missing newline to dev_err
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260930-rtc_s35390a_int1-v10-2-e7b1cbc50a7b@posteo.de>
References: <20260930-rtc_s35390a_int1-v10-0-e7b1cbc50a7b@posteo.de>
 <20260930-rtc_s35390a_int1-v10-2-e7b1cbc50a7b@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 15:33:52 +0000
Message-Id: <20260930153352.E84F01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Fixes: 3bd32722c827d ("rtc: s35390a: improve irq handling")
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-rtc_s35390=
a_int1-v10-0-e7b1cbc50a7b@posteo.de?part=3D2

