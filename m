Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804448;
	b=2TvnQqEYVLRGUAgcfguioTQl2VNQo8xcrJVr1hCm+EflrLIhYwvJiXlXkYOi1CIO2M59
	 d8AvyFudwRWcuJjDcX+IBbviLHsQqhrBhRWS0gADRpEVnD3GgWNv0Ym4xaa5sU/QQRIxl
	 yq7GOr/nOQuQss2nY2DH8vQXqFWYVyQrPYs3XiMsFjjhKZK5cPXoqDstqGz4x0LYvvHhs
	 KcO/P1NFZoUCMGHTuKwIjxVDERo6ZkrW1vkdnVFwanu4sP6N8M3bqqIrWcDbpus+8gSJ/
	 3CWJ+pGAkYypP/FN9zQaXr6lA7awwspKDH/ANqYmOKbS4SYWa0I15eSHrVhlgPimYpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804448;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eWNoEDiaLAO68SfSCI3CdT382Huqwo3H76ITjasd3LM=;
	b=YtfKefDJpDw3poGh3ltXfhqbhOui4iXCWoDM94XC56n2DBODcxK2ec3lRYFcmdMXuiX+
	 XGQF7/GoN6B0fYNtw22WTeoH1GX5SweBEiCvRiDhEdekSIDgWPwWCg3bnwef7yK+Rw5bu
	 87ARAnLzzDLp29t25DhQixSO2b0oE835A39ENFprxvkmfYebKQwFhjms7HXKwKuZVteC0
	 KC3UuyWpLY++QyS3q7O71PjSWujrQ0U2A+vD9HJX7fXrqx1qgADijUTna1qhZKFajkE/z
	 /43y4OIGQbM/23byIF8loO8n658MMM4Zl5ryu12F2/aNzVCB89fX7q5wx6/2F8i/PCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mN4QOE6L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0393E606A326
	for <linux-rtc@vger.kernel.org>; Wed,  4 Nov 2026 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mN4QOE6L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669061F000C1;
	Wed,  4 Nov 2026 15:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793804447;
	bh=eWNoEDiaLAO68SfSCI3CdT382Huqwo3H76ITjasd3LM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mN4QOE6Lm29kp0Eb4sidtzjIDZsE+1cubmFJTryLwGR5zGGiozBn3B9pGCXEFA3Kx
	 qGWcyL+VAvhEKLX7iQUAkhHY/e+tFuX6nH+rS8BEJ1x3h51WEtfklt0seSCR/NjIBp
	 NOFRN11FGWFLzu/tDbvaXyIMvJzN0nqxhd5p7OnFPlFLj9mV8EwRTdriAbPvSPsD2R
	 Xc4ZFuEN7o6NPqHuZ1B1aM/uLjisnpXrrxAugsMupBdHU7YgmgT60m8r+Lalifr326
	 IwrJF62WMcqdfcAmFS7at2fg9Ullbk++eZHGX12xMXYcPc+YlZC3eUdxwd+nSi98hD
	 FN2YggVAP9cHA==
Message-ID: <sashiko-outbox-197475@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: raspberrypi: do not mark the file comment as
 kernel-doc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aryan Sinha" <sinha.aryan03@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261104145844.32361-1-sinha.aryan03@gmail.com>
References: <20261104145844.32361-1-sinha.aryan03@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 15:00:46 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> The file header opens with /** but is not kernel-doc, so kernel-doc tries
> to attach it to the RTC_TIME define below and warns about it. Instead use=
 a plain comment.
>=20
> Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104145844.3236=
1-1-sinha.aryan03@gmail.com?part=3D1

