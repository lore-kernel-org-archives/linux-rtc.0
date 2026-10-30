Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357585;
	b=4i9Q94bl+HDzQNf0yoAyN1s4H5qaVSHDRjJeyfTjqsmQbFV/zEwGBRdXY8ORrAIJcMqM
	 4XvOouJGaCiZotgQKkDQu0yo0hIP2wBXaC8BMboScGQ9I/gI9q2bExgwm1Iqvr0GqvwW/
	 ctOmE0v7lExhUPSHQMWtbbU98r8BPj0FnVL2ViVEI+2leXcX4W9L5n/Bnl/3+nfbuHQS3
	 bDT20WJBkkqGpX2UmVQ4Dhz8mZsFtPCC//0PkaXgKtLtHjewDXL6kceVOjYpiym+Xzk21
	 TxOWmx7+mavSTl82CKQ3DrzPGIm1LvrcxlGGHbPl5Xq+xB6/yGesJhA0QUaEFwFiGYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357585;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pA8OdA1PSLEmSwTRN+iSoJS8knp+VpuBfaT5Q+mpLQQ=;
	b=s48SgmP3VMI6JKhWC4E804/9TvkIVPRrbeRr5LP4tCl42JjcxUoXWYNxI7IUiKf09h3h
	 KbfFtywyHgauE6DpkB/ZdltKoPcVs/33udjWQCKJ55qSh2z9Onxc/QXVeV+rOWmY8ZDYy
	 BYkwp922HwSnbqW1iMrfAgtQu03vY79ZnBl6S9XXKiqi/9hAea+vI1D6rQGXaVFxPwFcg
	 ZR/60kPVJtoLqLFQMbS4t1ium7O3UjEPT7JqGPxnLUR1WRph9+QBn/zNAL96AMNFDhfOx
	 2v28SNyAJBdZiRclYnvjUjjzpJz5pu+DvLvDsh7QG/TtEj0P+2bhwUiTYRLPVwmC3Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b1YgKRdj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437B660706A3
	for <linux-rtc@vger.kernel.org>; Fri, 30 Oct 2026 10:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b1YgKRdj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F241F0093A;
	Fri, 30 Oct 2026 10:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793357584;
	bh=pA8OdA1PSLEmSwTRN+iSoJS8knp+VpuBfaT5Q+mpLQQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b1YgKRdjBChglBd7jCuaZYNJ+ZfXTVcWQ0AnaQISuV4IcO4cdWnU7WjVhaJLkvzar
	 3Vc6nQE0a2gD0INOssGZYzMzxbcQ5fPd9licf1fa4xRWUdWxllJpReVvk5Nf+G2e4Z
	 1Jz/w58SDVPfF6Gx3vGozmfv/NQtGgCzsP/86dEgTTamZM1p7T9NOq9IeYcgSDZ2OV
	 jmKG5hvzq5sDf/e/A7RLvW76jovnfII4iqUc7A/juAYoLnyTzwICIl2ix67Q97LrCv
	 JV5E3kPEdhmZMxlnK7dQRJdSbKld73Y6ZPwHAbJOC7J0iREomLekWqH+hv+KTy8kPu
	 WmWXff7IBpsbw==
Message-ID: <sashiko-outbox-190888@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: rv3029: use sysfs_emit() instead of sprintf()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Akshat Rawat" <akshatrawat095@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261030105118.426-1-akshatrawat095@gmail.com>
References: <20261030105118.426-1-akshatrawat095@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 10:53:04 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> Use sysfs_emit() instead of sprintf() in sysfs show callbacks
> (rv3029_hwmon_show_temp and rv3029_hwmon_show_update_interval) to
> comply with the recommended sysfs attribute formatting guidelines in
> Documentation/filesystems/sysfs.rst.
>=20
> Signed-off-by: Akshat Rawat <akshatrawat095@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030105118.426-=
1-akshatrawat095@gmail.com?part=3D1

