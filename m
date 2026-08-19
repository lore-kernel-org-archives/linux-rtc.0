Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB94424D64;
	Wed, 19 Aug 2026 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787136630; cv=none; b=NbJ8uXjM+F0RJmCwIO3Uq+dTTrAkUd7Bso4k/R6U7r0VdirpAcv+1/JtbVKsiP4JppZfh02U5/REPi6t6CrcBC0qZt7Ia7hSuiHvS4W/vvD4kY0pfx1gQC5JPIHJHZAhuoh1dBoHpLxMoYQDJBfjLC9if6N0BoR+pX+SoBqzEN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787136630; c=relaxed/simple;
	bh=ShZbxPsYluupIr2uCM5ezJb/zyPN3owMVRpHvGa3W94=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ikTgJOfmelz12pFYRd2q70fykp6DQrOInR++tDAN1jRWO7iJr00p4asDPTW8HyJBKQiUf000ep4d9eGR0WljNyFndAm2yMxLuxxAsuJPgnd8HQobeYd18LN+WWgK3Jt9QIvnQYQC6z+TJ4p8PqbB0ZdvaRdWPme1m8LM5BxrBW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iINbUQjZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iINbUQjZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F3A1F00A3A;
	Wed, 19 Aug 2026 10:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787136628;
	bh=tWv1ECl4PchI5hg4gnWK2tnmmTbZGUbNljMLk8kjfaA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iINbUQjZwK43uO5JXwRMmK8BhZDF9yF85zJNkRlYAD4gssX28ja8uW4/qdXpcFWPc
	 sKzlPzY63OdSGbTBoIbWi96uNmSDNLqm/5u92wQPFcNZUnEwtPDG3RhMO79h8V2Da4
	 jCfwnuNa3Zd+RvylUa2sOpd74PDLMCVUkEGvprqVnAf/G0jVcyDYt2gT+4iIEu7+az
	 dUFWkSag3lZai7/p/cOAXs6IdsV6/DFWnEfadJQ5qoQciLIIqrCwAVCsHCeXpNTU7u
	 1aKphC8/aBY4CWpaWhKwQKpE5yK/+Q1QBgzH90WscvOd/3prvXGWViUvWu+YubJEAQ
	 FPVFSlUJAs2Gw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/15] rtc: rzn1: Fix alarm range check truncation on
 32-bit systems
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, linux-rtc@vger.kernel.org, robh@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org
In-Reply-To: <20260819103926.2136712-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 10:50:28 +0000
Message-Id: <20260819105028.70F3A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Race condition in rzn1_rtc_set_alarm between hardware programming =
and the alarm interrupt handler.
--

--- Patch [6]: [PATCH v4 06/15] rtc: rzn1: Fix alarm range check truncation=
 on 32-bit systems ---
commit 87931837ad8bba978fe3d99a5140167b545c3e4d
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

rtc: rzn1: Fix alarm range check truncation on 32-bit systems

This commit changes the types of alarm and farest to time64_t to prevent
truncation on 32-bit systems. It also replaces time_after() with a direct
signed comparison.

> diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
> index d03d252fdfe1f..94d592e88a044 100644
> --- a/drivers/rtc/rtc-rzn1.c
> +++ b/drivers/rtc/rtc-rzn1.c

[ ... ]

> @@ -269,7 +269,7 @@ static int rzn1_rtc_set_alarm(struct device *dev, str=
uct rtc_wkalrm *alrm)
>  	/* We cannot set alarms more than one week ahead */
>  	farest =3D rtc_tm_to_time64(&tm_now) + rtc->rtcdev->alarm_offset_max;
>  	alarm =3D rtc_tm_to_time64(tm);
> -	if (time_after(alarm, farest))
> +	if (alarm > farest)
>  		return -ERANGE;
> =20
>  	writel(bin2bcd(tm->tm_min), rtc->base + RZN1_RTC_ALM);

[Severity: High]
This is a pre-existing issue, but can this sequence of register writes
trigger a spurious interrupt?

In drivers/rtc/rtc-rzn1.c:rzn1_rtc_set_alarm(), the driver writes to the
hardware alarm registers without first explicitly disabling the alarm
interrupt.

If the RTC core enqueues a new alarm while a previous alarm is active,
could the hardware registers temporarily match the current time during
these sequential writes and trigger an interrupt?

If an interrupt fires here, it looks like rzn1_rtc_alarm_irq() would
execute using the old, stale rtc->tm_alarm state, since it hasn't been
updated yet. Could this cause it to incorrectly switch to 1-second
interrupts or fire a spurious event?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819103926.2136=
712-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D6
