Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793028619;
	b=koJtwXxoS+J6dQBekwrp8nnffrA7cGiS3yssVk73JMnkKBW2HoFJRcZDbZ/yqOnUN5m9
	 So6WPOeTc10z1izbbxajgmiqafttJnQneFSTFSXOEO4K0fDcUxg5iprH6zSYOFLGpTVYd
	 4r2NgrwoMurv1pVovS7OdssFUNAZjOS2RsPolGP+Lk0F2bhJgQBaP/gyHEJjrNoVdmvEW
	 oqiEKD50Ata4Sjdl/q6Yd5Opb84gr95Ur2wEplcoZYlmQoQIVVbPeFxhdYP+qFwWLSSB3
	 hqfO+Wk4URMUFuyW54Va8Ilwqkb+IXmOFsU4KoFllRumEjwzsqWYRNV6reyY0PPzFfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793028619;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QlauuidMjNW5m/36Zk27L2JRzCR3z4JUiEhQE2ZsCjI=;
	b=cq2jzT0mM+msKOfKCXmi0kVga7LUv1vFIkvWvVpaeiMriTpVYot/qgPH9JTn0wDoTawA
	 CElkwpCJ3sj6q/hTKwLv5AKCYcUj20ADc1HSht0fn+W1Y1nZJmB+V6XtT/f47xqAqSKRH
	 ECbpMXuyLXr3LAlbYOwiIpxXS9EVP8cLS98RJCPm0yHEB2/PUMXBkAFpHmxR1FGUIdp6l
	 PEXL1J0cGvRw5b8ewP+metHuxBsbuLnZiD56cdPxFnubZnp5e3sYE/4kCo6ZGOe4pmlfw
	 9zHrLubZnDGC1BG3XFGWJk33pyG/UfKmQD2Dx67Ho4u3p3sCW2hG6u6Jo/J1aVyklzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CZ4dhLB6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297BC606A31F
	for <linux-rtc@vger.kernel.org>; Mon, 26 Oct 2026 15:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CZ4dhLB6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA1A1F01828;
	Mon, 26 Oct 2026 15:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793028618;
	bh=QlauuidMjNW5m/36Zk27L2JRzCR3z4JUiEhQE2ZsCjI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CZ4dhLB6YAiK57FoiVVsLfjXtvKwt9FEBCy8CdVQlpMOvmjyOm7ZABrK4ZljHn/QK
	 74mXojD7yVCNWkytEMmmzZ9bEaC3pqfqjYMy6/0B1iah1CyfWok+Jqhe3/bd+wmTRX
	 DpFaBu23k069t5+Vv3XjIBhStel9G2HMVuCaBAEym10RyPGPKfQrHpPThEOj7PJ6Qc
	 VEGsXQDqkzTThLlo0R/z8zTSuVy+XaBwgMYrTfU4v8CgzDl7XVs2Cg0GYkZxPE/klZ
	 WogH4lozM91ISpDiFTZxTG4OJFlLY30/df1P87Idk1tLjUg6ApbpzoVHG1qMv6AuPL
	 U+wX7qiA4d6wQ==
Message-ID: <sashiko-outbox-185440@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] ACPI: TAD: introduce acpi_has_rtc()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hamza Mahfooz" <hamzamahfooz@linux.microsoft.com>, linux-rtc@vger.kernel.org
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261026152103.3109313-1-hamzamahfooz@linux.microsoft.com>
References: <20261026152103.3109313-1-hamzamahfooz@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 15:30:17 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026152103.3109=
313-1-hamzamahfooz@linux.microsoft.com?part=3D1

