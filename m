Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFD3349CE7
	for <linux-rtc@vger.kernel.org>; Thu,  3 Sep 2026 07:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421860; cv=none; b=dWSBfZKS+o6NUvtCu5v+TR7wURPS9XiP8UetVNhDHfHy12RM1GI9ILPeAwnWh2wrRuZUUOcX3SNhTAavJtp2V0iwK5r6gTK+tif+9uqQF/ZfAXrPuzISSW0QwMUijX97oq2vxRzlpjuuGgtTs12nfkTHecO9uGaOptyktcPrSb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421860; c=relaxed/simple;
	bh=yc3I321czvJRy8lwjWz9t/eshl6N8t5hFnDSigQT02c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TvBU4LpRCiUgol8xDSYGO1bHqi5plZDIy6fxQjLfRM5mTm9gitUV4sWkFIerOlMkWAsEWem3aobzWgJzVSmXkaRiyYVy3WDUozos/JuvKXjxDCFtiXPpr1/uzFfIeIMSJdd7Bbag3dOJv8lfG1zyl0mzN6Il6Df0wj+lEAG/jAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACxAAmJc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACxAAmJc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F161F000E9;
	Thu,  3 Sep 2026 07:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788421858;
	bh=yc3I321czvJRy8lwjWz9t/eshl6N8t5hFnDSigQT02c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ACxAAmJcmbZE2KjCKRNlKNzfaCslOkPVLICl1ka+WwwSDEwL2za9LoIBCHDD41aZN
	 BKRkqrFp6svaLH6RZEM9jZNezND28vtaPCS+V8AVcJjZD0d4VK9msT8sW5grh1wSLE
	 koKIuXqhtNLPK+Gflb2lIlDZ2b4rK4oJLiV7Lyc4z1XlZY+f8GJAi13kre7ks53PxB
	 p7GLFcotQpHleX+F4c4CLQ8ikauRhgqzFcWitzU9uYkveizRtFugazfs37nPDR2/S4
	 o5MSVUAhV9ESYAXRhycv/BOECcP9nrJ6wwSTrPXnyo0SBK/dOVip51NwyZv5HjDFYo
	 avXLyt9FDPhrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] time: Avoid 64-bit by 64-bit division in
 time64_to_tm()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWggKFNjaG5laWRlciBFbGVjdHJpYyk=?= <thomas.weissschuh@linutronix.de>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260903-time-time64-to-tm-v1-1-660be972adfc@linutronix.de>
References: <20260903-time-time64-to-tm-v1-0-660be972adfc@linutronix.de>
 <20260903-time-time64-to-tm-v1-1-660be972adfc@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 07:50:57 +0000
Message-Id: <20260903075058.69F161F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> As the divisor is static and known to fit into 32 bits, a 64/32 division
> is enough. The 64/64 is unnecessary and very expensive on architectures
> without native 64/64 division instructions.
>=20
> This brings the time64_to_tm_test_date_range() runtime from 45 seconds
> down to 30 seconds in an emulated 32-bit ARM machine.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh (Schneider Electric) <thomas.weisssc=
huh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-time-time6=
4-to-tm-v1-0-660be972adfc@linutronix.de?part=3D1

