Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793139004;
	b=qVcbQ6aypTMWxTWsvndRG4r+RP94GuF7x/BTcH4p5JStL0lvuJVy4QVndRg/FGZuALLS
	 X4e0dAAe6NfMxUjFC4fPBGI3LNiw2EsSuZthI5yARJsHAdjK2ifMbqRHSwKhw8ZFzCuz9
	 MqkxKZYTYXvr8AO1AlmTi6FeGsggO9e6jVqQwTy69MPxOyshkQIWjU+cPmgymkFWOZtqY
	 Fz/JwH18Gd6eGHseAoJ+T4zzUvLCJEqz4aLM6M5M6f0aghjyt/UiQhiK2GBUp0Q1fyqp3
	 GZJ1yy5w7MH5VdJmkwR5tOGXy6QmCk2T8iw7xpENbXMOIBg7GarhbrSWhJE1R0u41gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793139004;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XFTQghqJVdMBxY4xaMoPjjc/z+KDCrgt/x8GNui9tgY=;
	b=k4zL/KIuTTIN9fsXvj1/mD+4A4CV7x5f4TsYRTpEYWDVpMvWpNaRZ5tiKbLCw0fh/KAS
	 j+tFSqfAe+tBGv1b6dLIf7nebMYENmzoewd+qJMCPIjOmbNfKYw4trrGaFXdzvKuk246a
	 9HvcMSCGiIFZBSkKCc7ZkFIqYVSiFnN0K1zf38UwX4Nsx8qjQf6bVf9XegIU941FXkzEA
	 +rwOwDTjBmR30o/CTcx5WJ90TDhHTBE2qsRtRVJFH1ZuNNZghD+JVYG93RtdySODDcEwo
	 h4AIO5UJmZhGPuD8CWJHOeU//AWojkrXnKf8eRdTjUtxNToQPRBIsIUEGy9EJ29uvFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IXFH0fI4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79956606A31A
	for <linux-rtc@vger.kernel.org>; Tue, 27 Oct 2026 22:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IXFH0fI4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE041F01825;
	Tue, 27 Oct 2026 22:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793139004;
	bh=XFTQghqJVdMBxY4xaMoPjjc/z+KDCrgt/x8GNui9tgY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IXFH0fI4vUVEU73ZksmOE8A/hMfzZfoZqeYZlD+KPJY/ABoZhC+rTtYevIgWFrOqF
	 A86ELqrS/4bUIqCrbcLa11peaNML4RW8wJE0t7emhpThuJZFSdaybVMT1FFPbEfIhf
	 bsuKpEN/OQZjCVHNZyreXiTWccUQbgFj+nZAT0o+k2QIZyYxyj0MWuUQCgk5Gg53xS
	 ZVey2JIrQ8EuKaNv8gZfwzaYPXn3n5tIDERkR0auD4e71icRlilwUE9QkTBC60v7Ha
	 nxVHL4xBRr5JEzWXLGI4aAWbdOLEbpIjQDSe+FshL2WzA66CytE+clgKVkTB0hV73A
	 w8neAfNpxUSVw==
Message-ID: <sashiko-outbox-187144@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] rtc: efi: defer to the ACPI TAD if it can drive
 the RTC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hamza Mahfooz" <hamzamahfooz@linux.microsoft.com>, linux-rtc@vger.kernel.org
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261027220537.3443104-3-hamzamahfooz@linux.microsoft.com>
References: <20261027220537.3443104-1-hamzamahfooz@linux.microsoft.com>
 <20261027220537.3443104-3-hamzamahfooz@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 22:10:03 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> EFI runtime services are best avoided where possible, and ACPI defines a
> standard interface to the RTC in the form of the Time and Alarm Device
> (TAD), which the acpi-tad driver has been exposing as an RTC class
> device since commit 8a1e7f4b1764 ("ACPI: TAD: Add RTC class device
> interface").
>=20
> So, make rtc-efi decline to probe, before calling GetTime(), if
> acpi_has_rtc() says that the RTC can be driven via the TAD.
>=20
> Also, to ensure that acpi_has_rtc() is always reachable from rtc-efi
> when ACPI_TAD is enabled, make RTC_DRV_EFI depend on
> ACPI_TAD || !ACPI_TAD.
>=20
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027220537.3443=
104-1-hamzamahfooz@linux.microsoft.com?part=3D2

