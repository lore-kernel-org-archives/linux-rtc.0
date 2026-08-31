Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B3B43C043
	for <linux-rtc@vger.kernel.org>; Mon, 31 Aug 2026 17:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788198427; cv=none; b=OMNqo+9IHTqQmn0CQmH4QsgqZmcEoGPZaCGDXHHumcYfV17iOX/ooXVQe3VOMAz9jffZtEg6hMAAJxlENH6ddOlMHodtjOd1Kt6KGTwMEuU/QttCToi/lrwI+X0a4ZPnsX6Cwek7MeAwQm47Wq5catFaMiYrhEq2/Tl26zZzIao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788198427; c=relaxed/simple;
	bh=m5Evg41dtMwncqOVxcy6XAYdkbSlIgWoHaLhTSPVhnA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Lri3S/h/I78SmuO8DZZ8uB2cD59AQeg1l9evCi9oHcehWachAkiLA23aguNPWNh+Z6TaokHdgF9dFVxbhhYiowaGaON+GsBQXFms0H0tRNVhLv8eu3uLD9bFrfKNQiELSJ2p0kKVPs5BpTtJMyDEG9o7ETZK5w48bCzZYo7+s8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/3YS6Si; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/3YS6Si"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689DB1F00A3D;
	Mon, 31 Aug 2026 17:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788198425;
	bh=Qx2AJo3UYBDEqP2WImZYqmU7Ucl99mDMSxipb9l/0UM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j/3YS6SiHj/WHAB5g0zw14/W58+WmBFOxggNfnoZ0nJyGMC9ewv4pXQvNNvO/3pzR
	 yZEz+2AlsJa0QVDDaHc6RCU6aMc4+UpfolEfFh2FHVL7K6UC22aCni8SvIkNqrHYIu
	 UocxiyRZoLxZsqkphLn5YmbSLnErCO8MsgU/wPvL1fSXXKf8esYxEPx1FIjeucyhz8
	 qznCg7qJRVfPpqLnbYEx6ScNmD2DCnh0sKH/Hv4cYDkipc80pFLWQ7/jrm92yApdMk
	 irFAyewLPvT4nfFBEDNlmXN3ry8gja/mj/h+vNrumcCy36LZHImKBSNOpWXKSlbXsQ
	 h7F2LT6Y0dt0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] rtc: efi: restore alarm support with runtime
 capability probe
Reply-To: sashiko-reviews@lists.linux.dev
To: Johnny.Fan <johnny.fan@cixtech.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260831140014.839222-1-johnny.fan@cixtech.com>
References: <20260828031519.2749354-1-johnny.fan@cixtech.com>
 <20260831140014.839222-1-johnny.fan@cixtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 17:47:05 +0000
Message-Id: <20260831174705.689DB1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Zero-initializing `eft` causes `efi_read_alarm()` to always fail w=
ith `-EIO` for disabled alarms, completely breaking userspace reads.
--

commit b695e617f63e29889d5f34a76788ecbfdea7f619
Author: Johnny.Fan <Johnny.Fan@cixtech.com>

rtc: efi: restore alarm support with runtime capability probe

This commit restores EFI RTC alarm functionality removed in a previous comm=
it.
It adds a capability probe at ->probe() time to check if GetWakeupTime()
actually works before exposing the alarm feature to the OS.

> diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
> index b4f44999ef0f4..a8c18ebc55996 100644
> --- a/drivers/rtc/rtc-efi.c
> +++ b/drivers/rtc/rtc-efi.c
[ ... ]
> @@ -112,6 +113,35 @@ convert_from_efi_time(efi_time_t *eft, struct rtc_ti=
me *wtime)
>  	return true;
>  }
> =20
> +static int efi_read_alarm(struct device *dev, struct rtc_wkalrm *wkalrm)
> +{
> +	efi_time_t eft;
> +	efi_status_t status;
> +
> +	memset(&eft, 0, sizeof(eft));
> +	status =3D efi.get_wakeup_time((efi_bool_t *)&wkalrm->enabled,
> +				     (efi_bool_t *)&wkalrm->pending, &eft);
> +	if (status !=3D EFI_SUCCESS)
> +		return -EINVAL;
> +
> +	if (!convert_from_efi_time(&eft, &wkalrm->time))
> +		return -EIO;

[Severity: High]
Does this zero-initialization cause efi_read_alarm() to fail unconditionally
with -EIO for disabled alarms?

When the alarm is disabled, firmware can return EFI_SUCCESS but leave the
eft structure untouched, as allowed by the UEFI spec. Because this patch ad=
ds
memset(&eft, 0, sizeof(eft)), eft.day and eft.month will remain 0.

Looking at convert_from_efi_time(), there is a preexisting validation check:

drivers/rtc/rtc-efi.c:convert_from_efi_time() {
    ...
	if (!eft->day || eft->day > 31)
		return false;
    ...
}

This check strictly rejects 0 as a valid day, nullifying the attempt to use
an all-zero structure to bypass validation. As a result, reading a disabled
RTC alarm will fail with -EIO rather than correctly reporting the disabled
state, breaking userspace tools like hwclock or sysfs reads that expect to
read the alarm status without a hard I/O error.

> +
> +	return rtc_valid_tm(&wkalrm->time);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831140014.8392=
22-1-johnny.fan@cixtech.com?part=3D1
