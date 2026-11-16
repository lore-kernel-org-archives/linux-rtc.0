Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855500;
	b=VEpWFlHJl4fqNZwVUaM9aZ2zNB3X71hCVP746HB2MfDyqdVkeLEfmnV2t9LvrJ//DRtK
	 +ECcaOGm3AIliwD9zI482ATy1IkXgzZd4bu8uN/8B1n8Ih4c2IP4khfsPG7Lz135Eskmk
	 aVmzMnGNPE3HWEDWu48W5m/AoSnj09TYjKD7mNwaBitAbenXT0nDDqrjdhg9pFtpoOio7
	 dquukqTXWYdXj0Q5lZ8WmevDZRSAzKdb22oM4bKclApSCAVLRs0RXS4MDXvTMqO5VKNZt
	 juQNmLYJbmlkIN2fHPhbYk0O0m2goZhykW3pr7g97QkIq6GdJ2Aj8rbuxSYVV8W+ESw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855500;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KZcp7830tfXgUweBJsST6qZnS+mTu2SQdypKjpTqh/s=;
	b=lnuMytIhpOgANNM30xEybCBOTqcj+EuJm6fiNG0d5l+eBx9j5kJorvBJvn5KUAc2GbaH
	 GVFuGPp8aYLv7u4Xhmz9WRL2mZXTNNntbXFn5VdwizL54V3H6vYYJxLI90USKIutbOc6G
	 XlsELSVjF/dzBjNBBNHJVdNoCG6DEK+Z/LrDmzlynkM7VrGca9j7BzJym6CreoplvTQp4
	 Q3wgP8F7mq/0AqlBPTPZEnlzUmIu1KZTWNlkvSGEHjOVZ7CUdMcyF/iRfdGjUair4n9Rz
	 CfZVbPgc/lqsQBECS3CipqxdgwTSrsdFPzu5Y8P8bItL/ulYLqnId9P7EjR49ECuHug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jy2MdkzJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98520606A332;
	Mon, 16 Nov 2026 18:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jy2MdkzJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDA61F000C4;
	Mon, 16 Nov 2026 18:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794855500;
	bh=KZcp7830tfXgUweBJsST6qZnS+mTu2SQdypKjpTqh/s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jy2MdkzJSGp0DfmuH1ZFjKeFW6QIyCvUBolC8kwJoTGN4G68U8hHfu/vSb36G+90G
	 K+/Qb+R1Wp7sAcH/F2opwQNDzyzKO9kYVZmQvPW4RqPE2H3ZRsbu+rZwIL16LoaaQt
	 BlEufKDnaRHMeF5muoDLBaAgtfAuvDCvRLmA/4t4NE3cMWfspf9tknvR/V0f3isy+f
	 eLbF7TkMqyVvpDS9D7O0ata9GJmU8PRK2jtUglqoRsGdxq9hSK7ovZE8WhiUvoavQL
	 HvLysxK3ouXgn018Q65diiAOtv3x9y+FoJxpmsbUeokxR7ZvypY/5WEr4xx4aI8Ixx
	 ZJgbd9er/P+Ww==
Message-ID: <sashiko-outbox-217519@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] rtc: mt6397: provide the 32 kHz output as a
 clock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ryan Brue" <ryanbrue.dev@gmail.com>
Cc: mfd@lists.linux.dev, linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, lee@kernel.org
In-Reply-To: <20261116-rbrue-suez-upstreaming-mt6397-rtc-32k-v3-2-179145eb7e89@gmail.com>
References: <20261116-rbrue-suez-upstreaming-mt6397-rtc-32k-v3-0-179145eb7e89@gmail.com>
 <20261116-rbrue-suez-upstreaming-mt6397-rtc-32k-v3-2-179145eb7e89@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 18:58:19 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> The RTC's 32 kHz output is gated by RTC_CON.F32KOB, which the vendor
> kernel clears before it powers the Wi-Fi/Bluetooth combo chip. Mainline
> never touches it, so on a board whose bootloader leaves it set, such a
> chip has no sleep clock and does not come up.
>=20
> Register the output as a clock when the RTC node has #clock-cells, so
> the chip's power sequence can enable it.
>=20
> Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-rbrue-suez=
-upstreaming-mt6397-rtc-32k-v3-0-179145eb7e89@gmail.com?part=3D2

