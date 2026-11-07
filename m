Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068219;
	b=VkKX8kFEBZl+jQu52RsIWOJ8ChxKV/mckU9dRghsgqnkQ4RzLzDoS+IdHl4gjvZclu4n
	 p4W9OwJk6zyoH8gNFhxIIe7xKbHoE0AEp4HI91Hu8qGRverCNtBbkLLawI5xs8iocJdkl
	 nZ7+7dlpZvH7ZdROgvYJEtUb7kxF6sOI/emqJx9bsBzNF4O2lU70U6SEUDQMtkoZWwwg9
	 aVFJf4aVQ6auBNNTchBvuhnveCHGbvZ5Tr1tGQ3/q33kQfyU2ko2KG0yRYa4kdmV5FKV6
	 m31+RN5Zwh/l/c4ys9xNx/h87JLyevcmPMgcwLvTtsuhac9r21gIzxcYYdZBd49F15g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068219;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Wlj51i5JKDl5YoPkGzrVO8F+qsqaa6uMRvy5xHVVFSA=;
	b=nUG+JwH0O2mU2/LXCojj4nZLpW/WOrYa6rgRXs3FP26UOb0LlqDGyUH6OeoDwXX9imZX
	 fyN9yNqXDBZehdK9C7cFMi9jIKVpNa/OhxrPZelFJmYxFdTItm3kgHO6U2lE1ATM7S1PH
	 BDPuywIM1FiszGCUxgO1n1YvZEfc7Ww+6Arl67+pSyiXn7L3Gm2UJZ9Gk8plUaZCw1oTR
	 PhVrhXXpwGyyWiYgJsuGaRpWjZLuu5qspzb1vNqe0DEMNwiJY+TflfUG61xZ8FIu7Rx96
	 Q0K7rudu9QBLkzL4eWx2+Zfu+rQ+tNGMcek9nppvOmKAXfDaoNafs04j/oPGovwqPwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DecBXu+Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D7C606EEB1
	for <linux-rtc@vger.kernel.org>; Sat,  7 Nov 2026 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DecBXu+Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766731F008A1;
	Sat,  7 Nov 2026 16:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794068218;
	bh=Wlj51i5JKDl5YoPkGzrVO8F+qsqaa6uMRvy5xHVVFSA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DecBXu+Zp2gG8TZ22I/L9ACr4cy22WG5IpoI4Gdg452ArFTh4CS3QPJxXlzpLY/r8
	 AoT8KC+mPMLrjZFW/TZUskpEn9L6dgxqrLgb1UrwW0JK1kSGYauSvf2XvJWadyBnii
	 TQG31+KAZ4QNPVQBHdzM3FDzRLEUi3F/g/a6OQXVun+k8wk0ZOragBmaW2MD/C2MlB
	 Ml3a0aNP4XO+xFeQap031vAP0cNNLQR8GmOnV8XWmU/JBRmfHh+JahjfavccxpEw3b
	 pxbbLnwbZiz7JNp5qR/zQrJSj4tGE9mR6UJu7XuS8T8bM+7cRAs177UgkoS86TUJ0l
	 HpLFoEk2qCBoQ==
Message-ID: <sashiko-outbox-203041@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: as3722: check return value of platform_get_irq()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Akshat Rawat" <akshatrawat095@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261107160839.422-1-akshatrawat095@gmail.com>
References: <20261107160839.422-1-akshatrawat095@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 16:16:58 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> In as3722_rtc_probe(), the return value of platform_get_irq() is
> assigned to as3722_rtc->alarm_irq without error checking.
>=20
> If platform_get_irq() fails (such as returning -EPROBE_DEFER when the
> parent interrupt controller is not yet ready), the driver logs an
> invalid IRQ number in dev_info() and calls devm_request_threaded_irq()
> with a negative value. This causes devm_request_threaded_irq() to fail
> with -EINVAL and abort probe permanently, breaking deferred probing.
>=20
> Check the return value of platform_get_irq() and return immediately on
> failure to properly propagate errors.
>=20
> Fixes: b45062619840 ("drivers/rtc/rtc-as3722: add RTC driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Akshat Rawat <akshatrawat095@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107160839.422-=
1-akshatrawat095@gmail.com?part=3D1

