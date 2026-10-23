Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792791130;
	b=ipdq1CDex7vdAstNI5JaT2ZdQ7pgB/DZf5y0GmmLyW8DmNjfU4sY2cBI+FF9J4JjRdMd
	 8gO+LAPGlweergmJP8PwJKP5LX4w/QHAcGgXieqD7/VYmw4IjfgYsnu5jjPY/7dEMbUw0
	 p/Ppg+Xta7Yxhru3bICDO/yzljh0ZgFSyC5/S3O4kRiLmGvjI8JcTpQ4HJtgkZmiy+kbe
	 RpUeSHNpv5GK9rRRn6FWenDPFgpLuldr9mvufcpXESExi4rN9l/T8ZY1eO5uZ+i2NCXtx
	 tz1uv1Q+pO6jcMBWxU7IpHgnvcFDmagDhYDTrVE5eN/49/LBW0CiM1L2kv7NgowabtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792791130;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sIDTIjBH0yKempnz4+GHGCRHHKh/0sKc6A8hE/FtTLU=;
	b=EKGoAgqHoosqwrtlHLUxp4LbTaY5DBOTYLSa9tt8vXl6mS1lc79W1gbq1vQWtkyc0/tS
	 SO8UGbvLd7Ucq2E01kyVVZkwW1qCWniRLGkNiANzjqtWQN0/cTlJEtI8GXAwtYKdiVBwT
	 u31A9hzhSY+qERiQkapmKS6zzcsYEK0t56g99Hm8A8i/qugYpBglYRQarGEWAFyyEe8HC
	 zebtCr7rkzN5P5SIfmSTBVKI6Glj8KEiaBvenK0Fo1+6QJUUivtvqMmUEpmwU2uyRtolL
	 preQPwffdcheWcR3hpk1qREBg+PXmeqsv51JTnIHMhAIn6WIwfezI3HfycYgliuVTiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PTjL9PI/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020BF606A322
	for <linux-rtc@vger.kernel.org>; Fri, 23 Oct 2026 21:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PTjL9PI/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BA41F01828;
	Fri, 23 Oct 2026 21:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792791129;
	bh=sIDTIjBH0yKempnz4+GHGCRHHKh/0sKc6A8hE/FtTLU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PTjL9PI/oszF2zWC6XNpsmbotzNfteRdXf/d66IIuqFkqnW0f0vyLfW597Y/NnEiV
	 1x8Dt/yje7MSgb0LSUD0ac6se88eanr16QW/6ZkR3hdlSsnJk7oM0eXIyBZRQzXMcB
	 YK9NTME1F7Qh/KkQMF47VcVs/sIYxVvwfSbLTtxZZNU9DRtFVO0W2LdnIdaqEukdbj
	 XwEBjqJDMKh8qKEl2M9dVkZTlqPYRnae7eV7ZergIJbTI0/X5YiGbkzSesp1OPd/Ck
	 GMB+t6AJpWeSWtCJD/uaCtHHB4GAGV99wB5buuNp2dpxl6U9zUn0vt3tK9EeoBRJ7x
	 HmjhXn3/X9Ihw==
Message-ID: <sashiko-outbox-183262@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] ACPI: TAD: introduce acpi_has_rtc()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hamza Mahfooz" <hamzamahfooz@linux.microsoft.com>, linux-rtc@vger.kernel.org
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261023212218.2568858-1-hamzamahfooz@linux.microsoft.com>
References: <20261023212218.2568858-1-hamzamahfooz@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 21:32:08 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> The same RTC may also be accessible by other means, like the EFI
> GetTime() and SetTime() runtime services used by rtc-efi, which are best
> avoided if there is a native ACPI interface to the RTC.
>=20
> To allow other RTC drivers to stand down in that case, add an exported
> helper, acpi_has_rtc(), that returns true if there is a TAD the driver
> will register an RTC class device for.
>=20
> The helper looks for a platform device matching the driver's ID table
> whose _GCP indicates real time support, like acpi_tad_probe() checks,
> instead of checking whether the driver has bound to such a device, so
> that callers need not depend on the order in which drivers are probed.
>=20
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023212218.2568=
858-1-hamzamahfooz@linux.microsoft.com?part=3D1

