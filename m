Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0058B3822B1
	for <linux-rtc@vger.kernel.org>; Thu, 15 Oct 2026 17:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792085790; cv=none; b=LbNuscP1+lU5t0DUKM0MwUNa57f060rbzAxtHBz2yh6/Zb26Su/lapNkgxEbex0X1i4UXC+1wmIhuOK5o4hnIKwBvuz75t30vOrj+46OTQj12fpNZpCjknKAf5wrinLwBGCvhNtHLan7VZeEXaJic7PdYoiCs5OJ7neG48CxKKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792085790; c=relaxed/simple;
	bh=3jsCnk+zhCAmipxcTNTutPyRNzm4Rz2nOrOrLS1oe0k=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=j8e2fIVGDIBXNAkVphzS8kte3/lbokgXWXw08QR9hrpAVGwQWZsEG1PborEcBnF39tFpjbMxP3uek7sShcS35i3ooHMQdfY7ddVWZ6UJNv3Ox8Q2jMNmtJAlsgwrZD3/u2TaNEMlvotBeOTF/4Os3tMMMgnqJrlvaw1X908wg6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqOr3Rtn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqOr3Rtn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385571F000C6;
	Thu, 15 Oct 2026 17:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792085777;
	bh=6cA0/h+EeqsNlnrZbijGnpTC9m+uMARU0WTmlLiW39U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PqOr3RtnUW3QMTZHtmXM22XOTqs9proqifS+JjZsjE1xas5ippF+0uxl1EcphofoW
	 KTIfegN/J23leIBJMo58Xu8cfruzrX7NUvbkhWhqWMJ9VPGCpf9U6mpbQxXMZnsJi7
	 pmyKzg/xR6PI+Szw2ZmmTDi9YW1TmMWO6pEhqvSPae/9g04/uOwO0U8qVI8XKsRfCC
	 1pzdXYcYo3PEp8Qdn31EcHFS70ACrShusKCAH1jt5pOfYtHoZqJSNud+YvvOKxDNy7
	 od5L4OqzqlLOV/hT64pJ0kSr0WgE/c5i69QjuxspmrQxce925PDeyliG8QSjWlfgWr
	 RGcA7utgDrS4g==
Message-ID: <sashiko-outbox-173258@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH 2/2] rtc: cmos: Honor explicit use_acpi_alarm
 parameter value
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gregory Price" <gourry@gourry.net>, linux-rtc@vger.kernel.org
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261015173029.3091872-3-gourry@gourry.net>
References: <20261015173029.3091872-1-gourry@gourry.net>
 <20261015173029.3091872-3-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 17:36:16 +0000
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] rtc: cmos: unused-but-set variable use_acpi_alarm_explicit on non-x=
86
--

commit db7f65d5eb781cb5e973c2ace56bd5a4865e78bb
Author: Gregory Price <gourry@gourry.net>

rtc: cmos: Honor explicit use_acpi_alarm parameter value

An explicit rtc_cmos.use_acpi_alarm=3D0 command-line argument is ignored on
systems where use_acpi_alarm_quirks() enables ACPI RTC alarms. This patch u=
ses
a custom setter to record whether parsing occurred and skips automatic
selection when it did.

> diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
> index fe514b1aa3433..209aa4ec732c8 100644
> --- a/drivers/rtc/rtc-cmos.c
> +++ b/drivers/rtc/rtc-cmos.c
> @@ -57,7 +57,28 @@
>   */
> =20
>  static bool use_acpi_alarm;
> -module_param(use_acpi_alarm, bool, 0444);
> +static bool use_acpi_alarm_explicit;
> +
> +static int set_use_acpi_alarm(const char *val, const struct kernel_param=
 *kp)
> +{
> +	int ret;
> +
> +	ret =3D param_set_bool(val, kp);
> +	if (!ret)
> +		use_acpi_alarm_explicit =3D true;

[Severity: Low]
Will this trigger a -Wunused-but-set-variable compiler warning on non-x86
architectures?

The file-scoped variable use_acpi_alarm_explicit is declared and unconditio=
nally
assigned here, but it appears to only be read inside use_acpi_alarm_quirks(=
),
which is wrapped in an #ifdef CONFIG_X86 block.

On architectures like ARM64 or PowerPC, the variable is written to but never
read.

> +
> +	return ret;
> +}

[ ... ]

> @@ -822,6 +843,9 @@ static void rtc_wake_off(struct device *dev)
>  #ifdef CONFIG_X86
>  static void use_acpi_alarm_quirks(void)
>  {
> +	if (use_acpi_alarm_explicit)
> +		return;
> +
>  	if (acpi_gbl_FADT.flags & ACPI_FADT_FIXED_RTC)
>  		return;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015173029.3091=
872-1-gourry@gourry.net?part=3D2
