Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444997;
	b=RrTzCz46hkShvNLczlnwmXySoDinVtS0oumESFl7yINHwJ3UePv46DeWJSKIloEwX07j
	 WvYn4T9LtDA96Q0Gl5hXt33lEYNQr5LX6MOYW8bWD5fSczclqQNrOiPmebQhzzs6opnjD
	 ATerANhzcsFVdnCW+opAnvnYgFavpPFZNIFS8XgWtKmsSwhlGPDixnC0CYH2k5z9s6TNX
	 MkT3HcG7fcFw6YRyHW8FgqYRKVkGMu9BuK+wqJ5LORgH8xayTKGAzwL80DX4aP2Iai/FN
	 QjX8NcLHXkuSDZTl0R6YYcH/veKRNtCjRodo0Lgow2qPpUHHRS5DmDn0wna6oH8CEMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444997;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=klrSlEMt02s04AP2IHR/Im8BGs2laJ600YkO4kFkFdk=;
	b=j0EO/DqZ99JwZzaB82AMT1dIFgaeqD7OL4Yu9iY3zFtGH9QYOZ/l0mf3ilJIbYKya5+F
	 /p3iTp73YYbn4eHR97aKBfG/LgXEgUKZRwYz4c+ne+9ZNnxQ6MiiDLXKDnZc+RrNcOx2g
	 aMgbk2s2DdA3Xb5jgyooo/rRiT08csC/zEhrjsuLj/eH5WJU3WcNpG5CIRAz9djh1HNxr
	 NR193i+FPH7SrQUs7qgCmv133X7TILRGpgtwjXpDLmn/quhq4ZWDgfQ0+6R+RJ+5vgNs/
	 RfX2QKvSa1OEBY0aKsRUuEH9J3oYonZTvVulA1azfAHGbjGLSbQSIvu7u47coFuBhHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XtD/ff1w";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA471606A31A
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XtD/ff1w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D271F000CF;
	Mon, 19 Oct 2026 21:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792444997;
	bh=klrSlEMt02s04AP2IHR/Im8BGs2laJ600YkO4kFkFdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XtD/ff1wRfM5bbWb+s66ecqyCMm7hNS84G5aQXANzrO5C89WLYbe1fKj3BHmEFCo4
	 BY0Z/bW0WrSL67hIeIYh5rgjNPzA5TAJo6Da07cunX/4maJzBW/YW8Fi7u812dEDEV
	 dVyMNLnqW21WefqBQyqf+2IlUJ02ECkF33WOTvbbG3XiP07rlibqv1mZ2YyG1SMFqJ
	 2E0VlgXn7SDGb/uCLOXmmv5qUFdwzKeWyuEhVB3F2Xqu+WmDAxB0R6LozsmjCIl+ix
	 JzWzN/PEtczuuaF2ORUOJe6YrKkjGUx+IDhKUPPJpnNeztJwvPc3rvl29OC4JmVFbl
	 JqnUTHIEiztVg==
Message-ID: <sashiko-outbox-178250@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/19] rtc: asm9260: use guard
Reply-To: sashiko-reviews@lists.linux.dev
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org
In-Reply-To: <20261019211827.126262-3-alexandre.belloni@bootlin.com>
References: <20261019211827.126262-1-alexandre.belloni@bootlin.com>
 <20261019211827.126262-3-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 21:23:16 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
>=20
> Use guard() to simplify error handling
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019211827.1262=
62-1-alexandre.belloni@bootlin.com?part=3D3

