Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793139400;
	b=SRRfXGdPBnlAM8q09Ax/t7ifCTCHwkQXb70IHWZFFMuYY1suEAvQJbHF0qML5frLQbkR
	 x62cx9As8OZBg5GAVrdmlvkXZszLuBASBETuBkREPvbvJWJqLEQ3gfCu6H8iZStn4riaY
	 ORcq/OBi6ABh0SX8oC0dfdF04xwiETDv7EDPFm0XcQ0xEQ6jnnAq1egDZYPpac+KvnGtz
	 +NnN/jQOe4b4lOlteahC2sskvhKOm8GAFxJQR18IyMSADSV6AykbHcdR/YDc0ywQbVgpO
	 Wj5Y/QsxTUHjxu73nqCzL26wG3hS0fmKt9Jy3QwQpvqR6abzg4fHmcmmDdMyupr9M7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793139400;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sGwHasL/cHgvBUqOb3Kkysi8QsO6SXiTCBk+sCYPDNk=;
	b=1NGmEBXOr9/O18YIkov9Wr1Rh9KrSwqX21WdTpEAxqecwK/iT6GUuSTVxmRPGPCHg7Yb
	 SspgunMlwbIcyujG4T2vwsnFcxm28T5z31il6i5tzws62wZbeB9R1Ouax0PK01Y+fKLwl
	 wN+zXa9V+paPckJJ9UMY8VCR+HW05YZlMPw8rxP11Gi35DgfAvOCvy7EXv0epRbkzmlxC
	 6f28VgzlWcpCbE9DPOSw7y5okBOAsQ8qvIoFX46KAutMAj5bcru/NhieMulhvIk4Awfvk
	 xTfwwYOsS2CjQwIch0axWhtonuUVYPG9UYzPGDAfjEe3zPdQSVvDdBUTQ1Y6hwU/nIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UGTH+fxr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B82606A31A
	for <linux-rtc@vger.kernel.org>; Tue, 27 Oct 2026 22:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UGTH+fxr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896F41F01825;
	Tue, 27 Oct 2026 22:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793139399;
	bh=sGwHasL/cHgvBUqOb3Kkysi8QsO6SXiTCBk+sCYPDNk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UGTH+fxrq4vTYsXt3nc9Od0XjyrOcjeMorTDYcWd5BjaBOZQzI/zj98Zz2Ro6utFS
	 B5ibftifvP8vzkTsTT3ck39/rpHIMnkaIlWqAVXWrUG2UpKNEjBoWcTHveyFYI8J+3
	 3KqzI7Wf0D/bR5SN5rikGiiFw6yMuZRTV6+l1l66P4n5Uer+wH7HpWL0822LpsFnxP
	 Qtng+acv6Buwh3L3TheqcSwHilLLdSYdyzvzwSdm3/ToqVUnwpYP/4IwN81lelssvs
	 sE2mcVhhBs5s5qIz7pWK82t0U3jovSn8o1H9HcSfX6pR7YpFjBONq//qz1EgrBPpEq
	 bn2AEbAvhWuWg==
Message-ID: <sashiko-outbox-187146@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] ACPI: TAD: introduce acpi_has_rtc()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hamza Mahfooz" <hamzamahfooz@linux.microsoft.com>, linux-rtc@vger.kernel.org
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261027220537.3443104-2-hamzamahfooz@linux.microsoft.com>
References: <20261027220537.3443104-1-hamzamahfooz@linux.microsoft.com>
 <20261027220537.3443104-2-hamzamahfooz@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 22:16:39 +0000
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
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org> (v3)
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027220537.3443=
104-1-hamzamahfooz@linux.microsoft.com?part=3D1

