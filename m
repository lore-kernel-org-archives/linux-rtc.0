Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F7F17B425
	for <linux-rtc@vger.kernel.org>; Fri, 28 Aug 2026 03:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787887943; cv=none; b=ivS7OXBezynZh2Q6f6Ux0WFubrmAlY1CniarGk4kogIP5/VxYqsoViGVX39+pyxEzhdCdZ0zphxocltj7jKRGhaZZmagATipDeaJnc7qJ1FbkqGtTabeFkRWjV5uIcqoxPR6nO5KsFwVMEDnBo1bcmkA0OGBNJZ5fNXPYSGKt14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787887943; c=relaxed/simple;
	bh=7vdwpYw6o3DlgrRgR3tS0bv2nuUAan//+5V9VjEjXJw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PwjlLE/uU/p/AAOBa7Z+zK0gYLFxhryqJ9+ipmqETr1bIFw4U3hQO2bEjjeM1iureP8IULW5EPm/DW/q1xpWBhgs/JaBpnssAUJ1Jq5faXOD2vZ6L7iZXHYO2hsqn8TmCL5Vjy20QtWfzIjbKDuWOf3NrtZ1ADaQS1NWh2rKxNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJRTKiv0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJRTKiv0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B281D1F00A3A;
	Fri, 28 Aug 2026 03:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787887941;
	bh=1I0kgUfGomPF+SJg5vu4IaXNXdVjD0VNLVBxbYZ4i/w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eJRTKiv0McJuPqbuMJ+2ZC6Drhobrr/5Ko20IuMQ5LdJA7HX8m2olgYVl/arEL4o6
	 6mKKXhQeKm10jZIyvR0+i7kpPtMqNPdPqd3gwmiweZKZ8W7nutxQWjILF5oFWn4CO8
	 7olXJahL6Uv6EjGKvVE+RRO5xp0FQuehxv3IiLhRoBIZuj3uhgz76GJNmln9rOrPFR
	 EKmJhdbZzo+GoN9d4NtsLswSZ+YptMXjLwbGKz3ggJjWARn5g9pQcqL9EzmE2YsJDO
	 /MLhc0yzYqc6tnsWqBhh+s7u9Q9AvRQis3u8/j9qjPG4oLQMiWRuafmA0VzDEBAyRz
	 ETrE+wmMEkUYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: efi: restore alarm support with runtime capability
 probe
Reply-To: sashiko-reviews@lists.linux.dev
To: Johnny.Fan <johnny.fan@cixtech.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260828031519.2749354-1-johnny.fan@cixtech.com>
References: <20260828031519.2749354-1-johnny.fan@cixtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 03:32:21 +0000
Message-Id: <20260828033221.B281D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Uninitialized kernel stack memory (struct padding) is leaked to EF=
I firmware in efi_set_alarm and efi_set_time.
- [High] efi_read_alarm processes uninitialized stack memory and returns sp=
urious errors when the alarm is disabled.
- [High] wkalrm->enabled is passed to firmware without being normalized to =
a strict boolean, risking unpredictable firmware behavior.
- [Low] Incorrect format specifier for signed timezone value in procfs outp=
ut.

Pre-existing issues:
- [High] Lack of year bounds checking allows an extremely large tm_year to =
be truncated, programming the RTC with an unintended valid year.
--

commit f48bd3a58905ce7e489d515621c84d688e125eec
Author: Johnny.Fan <Johnny.Fan@cixtech.com>

rtc: efi: restore alarm support with runtime capability probe

This commit restores EFI RTC alarm support by probing for the capability
during initialization via GetWakeupTime(). It avoids breaking systems
without a working wakeup capability by clearing RTC_FEATURE_ALARM if the
probe fails, ensuring the alarm functions correctly for platforms that
rely on EFI for shared RTC access.

> diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
> index b4f44999ef0f4..708cba43435e0 100644
> --- a/drivers/rtc/rtc-efi.c
> +++ b/drivers/rtc/rtc-efi.c
> @@ -112,6 +112,34 @@ convert_from_efi_time(efi_time_t *eft, struct rtc_ti=
me *wtime)
>  	return true;
>  }
> =20
> +static int efi_read_alarm(struct device *dev, struct rtc_wkalrm *wkalrm)
> +{
> +	efi_time_t eft;
> +	efi_status_t status;
> +
> +	status =3D efi.get_wakeup_time((efi_bool_t *)&wkalrm->enabled,
> +				     (efi_bool_t *)&wkalrm->pending, &eft);
> +	if (status !=3D EFI_SUCCESS)
> +		return -EINVAL;
> +
> +	if (!convert_from_efi_time(&eft, &wkalrm->time))
> +		return -EIO;

[Severity: High]
Does this code handle disabled alarms correctly?=20

According to the UEFI specification, if the alarm is not enabled, the
contents of the Time parameter returned by GetWakeupTime are undefined. Sin=
ce
eft is allocated on the stack uninitialized, it may contain random stack
garbage if the firmware leaves the buffer unmodified.=20

Calling convert_from_efi_time() with this stack garbage will fail its strict
bounds checks (like eft->second >=3D 60) and invariably return -EIO instead=
 of
returning the disabled alarm state.

> +
> +	return rtc_valid_tm(&wkalrm->time);
> +}
> +
> +static int efi_set_alarm(struct device *dev, struct rtc_wkalrm *wkalrm)
> +{
> +	efi_time_t eft;
> +	efi_status_t status;
> +
> +	convert_to_efi_time(&wkalrm->time, &eft);
> +
> +	status =3D efi.set_wakeup_time((efi_bool_t)wkalrm->enabled, &eft);

[Severity: High]
Does this code leak uninitialized stack memory to the EFI firmware?

convert_to_efi_time() initializes specific fields but fails to zero out the
explicit pad1 and pad2 fields in efi_time_t. The UEFI specification mandates
that Pad1 and Pad2 must be zero, and passing stack garbage in these fields =
can
cause the firmware to reject valid parameters with EFI_INVALID_PARAMETER.

[Severity: High]
Does this code safely pass the enabled flag to the firmware?=20

The wkalrm->enabled field is directly populated from userspace as an
unsigned char (e.g., 255) and cast to efi_bool_t without normalization. The
UEFI specification explicitly defines BOOLEAN as containing exactly 0 for F=
ALSE
or 1 for TRUE.=20

Passing un-normalized values can cause unpredictable behavior in buggy UEFI
firmware implementations.

> +
> +	return status =3D=3D EFI_SUCCESS ? 0 : -EINVAL;
> +}

[ ... ]

> @@ -168,6 +204,25 @@ static int efi_procfs(struct device *dev, struct seq=
_file *seq)
>  		/* XXX fixme: convert to string? */
>  		seq_printf(seq, "Timezone\t: %u\n", eft.timezone);
> =20
> +	if (test_bit(RTC_FEATURE_ALARM, rtc->features)) {
> +		seq_printf(seq,
> +			   "Alarm Time\t: %u:%u:%u.%09u\n"
> +			   "Alarm Date\t: %u-%u-%u\n"
> +			   "Alarm Daylight\t: %u\n"
> +			   "Enabled\t\t: %s\n"
> +			   "Pending\t\t: %s\n",
> +			   alm.hour, alm.minute, alm.second, alm.nanosecond,
> +			   alm.year, alm.month, alm.day,
> +			   alm.daylight,
> +			   enabled =3D=3D 1 ? "yes" : "no",
> +			   pending =3D=3D 1 ? "yes" : "no");
> +
> +		if (alm.timezone =3D=3D EFI_UNSPECIFIED_TIMEZONE)
> +			seq_puts(seq, "Alarm Timezone\t: unspecified\n");
> +		else
> +			seq_printf(seq, "Alarm Timezone\t: %u\n", alm.timezone);

[Severity: Low]
Does this use the correct format specifier for alm.timezone?=20

alm.timezone is an s16 variable, so using the %u format specifier will cause
a negative timezone value (e.g., -300) to be formatted as a large positive
unsigned integer in the procfs output.

> +	}
> +

[ ... ]

> @@ -203,7 +261,23 @@ static int __init efi_rtc_probe(struct platform_devi=
ce *dev)
>  	platform_set_drvdata(dev, rtc);
> =20
>  	rtc->ops =3D &efi_rtc_ops;
> -	clear_bit(RTC_FEATURE_ALARM, rtc->features);
> +	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->features);

[Severity: High]
This isn't a bug introduced by this patch, but does this probe function nee=
d to
initialize rtc->range_max?

Without setting rtc->range_max =3D 9999 - 1900, the RTC core's internal bou=
nds
checking is disabled. If userspace provides a maliciously large year, the
calculation wtime->tm_year + 1900 in convert_to_efi_time() overflows the 16=
-bit
unsigned integer eft->year, silently truncating it into a valid range and
programming the hardware RTC with an unintended year.=20

This issue affects efi_set_time and propagates to the new efi_set_alarm
functionality.

> +
> +	/*
> +	 * The EFI_RT_SUPPORTED_WAKEUP_SERVICES bit defaults to enabled
> +	 * and only gets cleared when the RT_PROP table explicitly says
> +	 * wakeup is unsupported. Many platforms lack an RT_PROP table

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828031519.2749=
354-1-johnny.fan@cixtech.com?part=3D1
