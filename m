Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239271;
	b=MnMaVvcZVvu3lyp2obTOCC0Pq+B9iNGjmLdTutmsNwvL9KIo5lAJjtgAq1LbNaE8eZOg
	 8kiW1uCjGPZ9kdURaj/KGOsPS3yWkopcKBhPME5c+BTLetzL6yk4vserOC6bd81S6j7mI
	 UE3S/HPwhMJgVr99kmtwgfhsjeuu6SfMR+MW4ti0vvgEAXMY3OdRs7JcQQMQzjJTK8z5X
	 3Q/2yWJJtS+r9mnS2jEiy29jS1XF2h9prEILkMy6zm3h2Mv44quqiYNkK8TnKqQtQky+A
	 59Z9u583xMLg2adTI/9TcdE/E/Z07+R3zy6h0tDJo5qVLLWOVpw8JKQ3yD9mb9g3MxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239271;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=f7VpGHbgWMJe778W+sI5zdfsDpgU2egbiFW78G4ML9c=;
	b=JkpOeCokCmTM/7HgMw6PtttinRQnV/loorxC4oA5B3YCPQbRdDW3iDliAMcuaTaVXBe6
	 AqQa/D0SmPcHTDbuCnMoSx0bKtUWVIa4Pyt87vSDxldMNYJbUc0s5O2GJR0kt+dHcAF0c
	 DYoVe1ShWIeTIjRp3xD2XUMJTuzY5lYeZ5EnEHnqaRlpNlnkIPoR44vLGbJ6/YcFjT5wR
	 InnOtO1tr48S+Y69h7bRjRSnekTs4ca5K2FBbBRXmvEs5sUxmlKFhq6lfKYSrNM/+JwCc
	 KetG3M5c2lDkpKfHeXVDnA6SEjxrijUzeql4DCqXg/MXN2guWWdr9/pX6Q8Swuj99Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YDij5ffE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F608606A321
	for <linux-rtc@vger.kernel.org>; Mon,  9 Nov 2026 15:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YDij5ffE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C61B1F0089F;
	Mon,  9 Nov 2026 15:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239270;
	bh=f7VpGHbgWMJe778W+sI5zdfsDpgU2egbiFW78G4ML9c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YDij5ffEuh6Qp80K8s9yspXXDiBXxxmxvbtRxJ2GtgCyKFJUtX2Lu0Ui0GCYwBjGx
	 6s+ofzqfyC1rKcstVwTI2qMBPQnI8gDNEcv6M9bAU1kBZq7xQDZeP/9DRxz8/L3tKB
	 Vl6syfViUDLvDT0QYqChUACQ8M+dCOn4QPDAuwDhd88UbPM9/jR8rTYzxWtQtBM9N9
	 myKJ+3J0kfCzKsouwwBi9us1bWVnPqc1CrhFqZk2H0vzfVQyf1MbS0M+WA7jgSj5dI
	 Pt4Z8aTe1jfdDz1Vn9ZMSTI9mw6/AX4IYyHtgHBmQHnwUfr/2gUwxhEKNpIoVvXSub
	 Lidde6vN0IYYQ==
Message-ID: <sashiko-outbox-205181@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: rtc: Add StarFive JH7110 RTC
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?T3dlbiBPJ0hlaGly?= <oo.hehir@gmail.com>, linux-rtc@vger.kernel.org
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261109154501.63762-2-oo.hehir@gmail.com>
References: <20261109154501.63762-1-oo.hehir@gmail.com>
 <20261109154501.63762-2-oo.hehir@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 15:47:50 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> Describe the RTC in the always-on domain of the StarFive JH7110 SoC.
>=20
> Signed-off-by: Owen O'Hehir <oo.hehir@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109154501.6376=
2-1-oo.hehir@gmail.com?part=3D1

