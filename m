Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795465016;
	b=qJ9Z9K/Btd8wkNEIk57ZiAlJ1m01DhzKWwjZEUAxDKoH4KJF6l8fOv34GfuzIvD2Y77v
	 1rHdLEEAfj9gLa2IeO/NMrTTf6H5xg44RBKJLSJSmNn1PULYI9b4qaO2G1xNGv3scd97a
	 dZ8dyvuu0H4Po1mc8LmXLJUoDFuQZeuzv8YLyU+tLqSC6S9l8pgHYoodLXsrLMm3t6V16
	 zZ/6n8sR9XxBS3RvBHMLX2p1hUG92943NaPEvdoToJTATRVsYbvNbti9sQ/hK0tF3d5+r
	 8dUVYKNC7Ns1uZTJ/2YYwU+SoQX/+tpF9ejX27EpKLHDyCwlFqKpXWIpAVuc+xhqpbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795465016;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=y5QY9Tsn+G1qyilzKFdD1s/dSyKQmLGAUhfkzch5qNw=;
	b=m8jE233t4D9pyX38/bjtXBuY+C4wDzwWz1xoF4ukmgGPe6t7vrLQWkIg7G2/OIIk6UL0
	 9SNWTm6I8v2jUngWwGFMHOcZ9Z5fc4bq4keFFSdPbnXXkR/iC7ZkFqmGVdz9aB5hQNUml
	 SBi6g2u72KY8ASKYsSgtbfFbSTKwdSbLyp5Hgo7dzEc2ygZqHIN26RZu6pvPcATjtig/G
	 oHHGGIqS3DiYf0ng1J6h9q3RftdMlqNJsUB7K14mjebAjXnwF/A0DcylJiyf3nIW7O/kh
	 F4oBVNJ+brTPgyexeUhlen5l8gMuJmd5PPM3jqLwJaxUW1wtjP6X93JDJxBf6U9fJww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TYlKUlR3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E127606A31E
	for <linux-rtc@vger.kernel.org>; Mon, 23 Nov 2026 20:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TYlKUlR3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3D31F000CF;
	Mon, 23 Nov 2026 20:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795465015;
	bh=y5QY9Tsn+G1qyilzKFdD1s/dSyKQmLGAUhfkzch5qNw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TYlKUlR3Wxv9SeMD9IAmtH+v0eY2aK5Lla8JSxPvemJufKD/vfdk/F8RcAJepLuvi
	 g//8crY6aBagar8Urt9NFa0Gs5dj5oME77nsnlgt9wJUgUic8exgla2K1GEverporX
	 b9ZRj78Qi0bOabJSuiRANuNDI5Try2JSIJ0acVq9wOBf8MPKcElXL8MyO/5O3WVrRU
	 QVte6XH8xryGLk5md631OZ+TK0A1tMX3sZm3ckntOYSuv/ozGSdir2M+Mw4WIp0Lkm
	 H8bcLenYG1lEqKZbMhnjWUBPIt2Dm9grE6wnQYppZsR0kpjxkCkWMoTVDiplKyJsYs
	 gSVmGQUSzFZLA==
Message-ID: <sashiko-outbox-229984@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 00/10] rtc: assorted bug fixes across RTC drivers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261123200012.502284-1-lee@kernel.org>
References: <20261123200012.502284-1-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 20:16:55 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 10-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123200012.5022=
84-1-lee@kernel.org
