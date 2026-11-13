Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794611791;
	b=t9fzJHe5O5oUQpDdYgvoiBJHmi5riPRso89DT50tgb4FZrRE79AsIIgXBW5UEmPPjsPF
	 9t/kt1606tkBxt5VNe2h4W08Av/5zxaeStNGtRNuYaQPZgOmF99dC4KETZYK6v6YzX5Uq
	 tM24GDOruG/ejODmBXjxjYUMCUai6NR4mU817d9/WyWxj83QC6HJgVfNSLukLqIjci3sa
	 OtpZ7UGoF3JjIoIZzqDsKx2XhiEIlg4icU0qk2zI6TjMeuuGiHiLyKqYO2Z+X4UxkPuZ2
	 YCQTdczknZ4l0J7faLm0PXJqhMwpli0KyRKSDYaZTK0GsfJ85dxH5WhVygv8DSGWbrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794611791;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fdV2vedNVYLnRBLTcirImciNM3ZhVxnr4vMeoMeFFx8=;
	b=1nWh5QwbAZeQvzN5OlZOZ7fngoW7dSRT7ff/BKt8hq5FF6uDDVIlE3HaSq1OfGxxllKn
	 R7RcaY456m1B2ghG+4wHZF4Am59q4SEun7DUzrNwF6QxpCn1u4woOAGe3WoZsQNFhm1UF
	 FMvZnUKdiN3L0p3kmxr4NTZKFgqE2Dz+kquEKxf7tp4fNS7ZNtPTTWl7rtZf0WyclFrIi
	 60IV0cpJaKqqYuIR3f8N1ykNiX6q7pr2qMgs3TXKwposwLk6Je7zr+lKu9JMTmZR8LXAI
	 8pU9jYiRNCAayXiTqO+ZqP81/E0yuRa8CHrjocbUWa3aofHupIf+ykTt1AtOgoapj+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dI5XN4HC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704EC606A336
	for <linux-rtc@vger.kernel.org>; Fri, 13 Nov 2026 23:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dI5XN4HC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C479A1F000C4;
	Fri, 13 Nov 2026 23:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794611791;
	bh=fdV2vedNVYLnRBLTcirImciNM3ZhVxnr4vMeoMeFFx8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dI5XN4HCLzzBPhvhvcpivYzkHW0FNALkIdyNNWUDyCzcBvM3l/vMv9V1Fklp877BG
	 eGaIj0ZDWZOw885jN5qX5K0VgMJk1O4BssMfljZtPwPuuv4SRz2WGjqQ2nneVChKi/
	 ytU4dqgbKUUSdu3PaJ/PgYbLTst/B242/MLEkJ8JBbcx77DfiK0mqtdduDsubTselQ
	 yDQsoI9YLmSp7oejaSEF2cGKlJhIdOhAatGjNd65FmeMzZ87GlrSXTELki4VFmKLgx
	 eDQkRTIj0KUfPYMxuiOV8iRrDwPGUeiLvE7mhCQU3s6EVffmnApWhmSfEV7ZpKvrdI
	 CB4+6lZS0Rm2w==
Message-ID: <sashiko-outbox-213857@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: nvidia-vrs10: Disable IRQ wake when resume fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hungyu Lin" <dennylin0707@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261113231327.22109-1-dennylin0707@gmail.com>
References: <20261113231327.22109-1-dennylin0707@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 23:16:30 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> nvvrs_rtc_suspend() enables IRQ wake, but nvvrs_rtc_resume() returns
> early if the I2C access to clear FORCE_ACT fails. This leaves a wake
> reference held across later suspend and resume cycles.
>=20
> Disable IRQ wake on the error path before returning the I2C error.
>=20
> Fixes: 9d6d6b06933c ("rtc: nvvrs: add NVIDIA VRS RTC device driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113231327.2210=
9-1-dennylin0707@gmail.com?part=3D1

