Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50973E0C46
	for <linux-rtc@vger.kernel.org>; Mon, 31 Aug 2026 11:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788177420; cv=none; b=VO8Fpq192HWeSLllkXakTMB85ATN4DvjCH/AOetZSvjj0kdOpQsdTQj+2PjF2WD8J0D+4CEVYUEt3a82g9WNePst0ULNsVEh7IDtjYuxjBeFRaPoWo9N3TVDWQ0WqDdSn7mrHXfy0ttqhFLIgaNUu4I1j+two8vVgiEIYSDfdBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788177420; c=relaxed/simple;
	bh=yRf0z1o37PELva9RAd3zedxXP2XuXxtABfyCBy+6xLE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XJ7nNKETf563pKo9KcF7ZNRcF84qw9XotemoLD8sQIObzp+kIdXzD594nRNvCXfNQh4lACUL8sBzMkSeQ1n+BRnFHAJxDdoMCCKSXO18OAcdyePTYgoU6Py8mxEFzvpEOemj3Wdi8fCEW2xo2vtPGaRkKIDY+t2+2krM11LQRDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4O6sqBK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4O6sqBK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD7B1F000E9;
	Mon, 31 Aug 2026 11:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788177419;
	bh=xiP9TWYqLK3FyEsv+R8V1ynMdOCKyhq7D3eP8hBL6vE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z4O6sqBK0gN+rETPmqf0vvNyRlczlMhaxl7ZUv9gBq5YgF8dDrXi4C1kaBeltP2yh
	 Ca8jnkoihhOfL9P6DYKNPP1LXeICfpQEWpJ9KYPJp2xDuuWojaay1HHhPbI/sPsncn
	 1N7uTSUAS+jS9ipR7OD0zy/tdWI4xE7iNC4vviq3GjobnufL8Qa8knP7Lnk8amCpDr
	 gToi6+OnfdW6R0xZf1Tbw5ik3v1ZM6FPdd06HwSabfvgn4M93qz8Ffsq3TU2blseIe
	 Z+O6M9GJJcmKmaRB3tme7X/hgM9Gx7gtqfOO4vr4mzywt0PQhnlNIM7DNu7+sGiIeR
	 KjrJAepzgKEpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] rtc: efi: restore alarm support with runtime
 capability probe
Reply-To: sashiko-reviews@lists.linux.dev
To: Johnny.Fan <johnny.fan@cixtech.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260831113858.759210-1-johnny.fan@cixtech.com>
References: <20260828031519.2749354-1-johnny.fan@cixtech.com>
 <20260831113858.759210-1-johnny.fan@cixtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 11:56:58 +0000
Message-Id: <20260831115659.2AD7B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Zero-initializing `eft` in `efi_read_alarm()` guarantees an `-EIO`=
 failure when reading disabled alarms, breaking user-space reads.
--

commit f9829a03fcbfff469b82ea3dd308ff1029bfea0e
Author: Johnny.Fan <Johnny.Fan@cixtech.com>
rtc: efi: restore alarm support with runtime capability probe

This commit restores the EFI RTC alarm functionality and procfs output that
was previously removed. It introduces a runtime probe of the wakeup
capability to avoid exposing a broken alarm if the service is unsupported.

> diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
> index b4f44999ef0f4..5276870b410e0 100644
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
Does this return -EIO for disabled alarms?

When a user queries the RTC alarm via the standard ioctl interface,
efi_read_alarm() zero-initializes eft before calling efi.get_wakeup_time().

Per the UEFI specification, if the alarm is disabled, the time output is
undefined and the firmware may leave eft unmodified.

Because eft is all zeroes, its day field is 0. The convert_from_efi_time()
function strictly validates the time, rejecting day =3D=3D 0, and returns f=
alse:

drivers/rtc/rtc-efi.c:convert_from_efi_time() {
    ...
    if (!eft->day || eft->day > 31)
        return false;
    ...
}

Will this cause efi_read_alarm() to return -EIO to the subsystem, propagati=
ng
the error to userspace instead of correctly reporting the alarm as disabled,
and potentially breaking expected functionality for standard userspace tools
like rtcwake and hwclock?

> +
> +	return rtc_valid_tm(&wkalrm->time);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831113858.7592=
10-1-johnny.fan@cixtech.com?part=3D1
