Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793624959;
	b=UpOPy47NA3mSX8RtYmS6rXhOQNKNYd22mFS0XP6n9/mBbMTrspImfQWXZm0I6lsXyaUQ
	 kFECDxDrijVzq7luYJ7ecygc2UOOoamxmvZpLfBm1MvNGr6HHm45X+WM80rnK5KI46o/B
	 cqgVawWTeeaQC27DL1FYYh0pmakrJMoEtc3B52Rn0j94ayrCobY0dOPWKQbvTJpZ43iTI
	 3dnYK5uO1xWZrBtcYe+gaVeIvJToIS75fl0T2DP1JbAAUoLSYBBTj9/xk/7IQ2Y0qfMbq
	 7m6iZkMtD5ogscpjgdBLVtTT27NcVn0lxkNfDb8ihmIXY+yZDH7oGZoueRWyejgzykw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624959;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WR9RFOY91DDPBgeYQv0LnVw1VhvKmNrNWvChe8JVSRM=;
	b=Aa+8M/ZVz02OmraGSTfM67eR+I1vEh3rKWa9I8aTGpE4WdLwKcJaFeqsuxb3Ogv50DN0
	 8tTItu+UxrzgvLrOZsgDWKqqysIMAWKDe0yvJv3JKAs1RkeyhhHFE5IjGf+35/yOe8rat
	 DWhkejyTqUtFeXVAtONFmNI733rast/+7GToD2Fagcx2qMlHPFYr3b8C3q1n5mZ8dY5VK
	 sBwNeLqKA+Rwls5C7P/wCQuw38CQwjz6hanlw8Dc3RM1p1PhhSdSDpQZa0hcUBh7V1lPO
	 MgNT+8pndvsY4yDGzsXqw9sr4Z8oQ1PQ7w607LXf+fB3/vIYPokmzb8U49vGkLAP5yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D6h8RBv6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441C9606A327
	for <linux-rtc@vger.kernel.org>; Mon,  2 Nov 2026 13:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D6h8RBv6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9674F1F00A16;
	Mon,  2 Nov 2026 13:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793624957;
	bh=WR9RFOY91DDPBgeYQv0LnVw1VhvKmNrNWvChe8JVSRM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D6h8RBv6crk/hm/MPro6cL4Jr0Tk7m1AbIGxpvNovT2vqypK0ZrbsJSgTOzR/Xfj0
	 UAy56Ud3kURsElpKUU+k7ItjWtGBFSB/DEF/OTXh8ZR+wAgwFiDmHR6OGMEaf1wsqo
	 wRwnm5rZboLPdxp39oCtDbKWF3YNRRUV/xXV4os8VBPGyX0hDJCVdauYCHR4+D0W6x
	 VF/HvaGpASKuwZQ+iNP/Il/le6ig4RESEOnftOFYChwB4MjDHecsptIORlaFrvelOq
	 bEZ4XquIg2eNDoBm4sUUO8ef2WBxPH3uZiN4B7SUx4BXrI8zUdPAy/9+BxvlPtobnX
	 Y+FUH+jaf7WNw==
Message-ID: <sashiko-outbox-193467@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: rtc: pcf2127: Add support for clkout
 clock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261102130712.25104-2-herve.codina@bootlin.com>
References: <20261102130712.25104-1-herve.codina@bootlin.com>
 <20261102130712.25104-2-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 13:09:17 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> PCF2127, PCF2129, PCF2131 and PCA2129 provide a configurable output
> clock on their CLKOUT pins.
>=20
> Add support for this clock considering those devices as clock
> providers.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102130712.2510=
4-1-herve.codina@bootlin.com?part=3D1

