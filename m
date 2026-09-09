Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410F43A6B9C
	for <linux-rtc@vger.kernel.org>; Wed,  9 Sep 2026 23:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788995027; cv=none; b=UJQZ0zjgRcDSp7notAYXUsPoytOhfw4LXoVnu8E58B9fzDYYvlYP/gsMF/lqkNsh+jpOxUDdu//B9zqmdZai6S6HDxS1zABIPGBU8fdxAA03uL90JMbmx20eXtU4ZFAs4mpXrEP65CnM4WoiLZIOAd+eB4T3Vfei2YH7FpGTMMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788995027; c=relaxed/simple;
	bh=AFPGmPMUkBn37q99fLVqYyYlawynrhLkzMF6RzQ/RD8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O4pDKEwDe7i8Bctn1G6V/njdErB2id5DD+Nfz8D3gW7JSNAQ/5Zdhn+cYMW/jHVRru86PMZbQKfVWERg4oIfHXurvD54Bsbf4YCVbkMNTiGSsnuLEmjS2b9vyyp2pkFleJFgU9YHjeCv4OpGY+o2BqkGeAnXYAA0CtWAUgKJEao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XULOp4+T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XULOp4+T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA191F000FF;
	Wed,  9 Sep 2026 23:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788995019;
	bh=V69YOyxpolcW2GX5d9ddqiv1lryghp1h/Qgwd8nO+L4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XULOp4+Tswucven2Isz1UI5vPE7KD9fSJ+d3PKRdOni+qD5AY6uz+x6qrDhca6jQ2
	 Po2E0oDhKf/r3c6bjpK3jUrBi8hqP+LxIHeunFFqBoZkOFWItQCmvDP/UNk2V6h6zt
	 O62dX8XwOHCXKccAIto3AhIQ5+icG2awqSSfaVrVX5vFGIgYxMbiPEBwuIR8BVNApq
	 ljO8NFV9Wu48VsGbjosnyyHgquIMbVii8Timfm0vat1bFZ3OguIbh43sy5lTpn1mq8
	 HZc5zvi4d8Sb8Z5/YnavLaGju8QA5L7k55ovaFlk6Qy2AQgs4snlu8K7AXUkzCio0H
	 UFLzNyQhwEhYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] rtc: cmos: Disable ACPI RTC event before handling
 it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gregory Price" <gourry@gourry.net>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-rtc@vger.kernel.org
In-Reply-To: <20260909225132.1392883-2-gourry@gourry.net>
References: <20260909225132.1392883-1-gourry@gourry.net>
 <20260909225132.1392883-2-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 23:03:38 +0000
Message-Id: <20260909230339.2EA191F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] RTC wakeup events are permanently lost if the ACPI SCI handler exe=
cutes before the device resume callback and the BIOS has cleared the RTC co=
ntrol registers.
--

commit 8ca107b659080f6c7d65133bba3bda531b0c4968
Author: Gregory Price <gourry@gourry.net>

rtc: cmos: Disable ACPI RTC event before handling it

This commit resolves an issue where rtc-cmos alarm events are missed due to=
 a
race condition with the ACPI SCI handler. It clears and disables the ACPI R=
TC
event before scheduling the irqwork so the worker can safely enable the next
event without interference.

> diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
> index fa04ece151b8b..fe514b1aa3433 100644
> --- a/drivers/rtc/rtc-cmos.c
> +++ b/drivers/rtc/rtc-cmos.c
> @@ -758,7 +758,9 @@ static u32 rtc_handler(void *context)
>  	unsigned char rtc_intr;
>  	unsigned long flags;
> =20
> -
> +	/* Quiesce this event before rtc->irqwork can arm the next one. */
> +	acpi_clear_event(ACPI_EVENT_RTC);
> +	acpi_disable_event(ACPI_EVENT_RTC, 0);

[Severity: High]
This isn't a bug introduced by this patch, but this unconditional clearing =
of
the ACPI event status appears to permanently lose RTC wakeup events under
certain conditions.

If the system suspends with the RTC alarm enabled (cmos_rtc.suspend_ctrl has
RTC_AIE set) and use_acpi_alarm is false, the BIOS can clear the RTC_CONTROL
register during the suspend/resume cycle.

When the system wakes, the ACPI SCI handler rtc_handler() runs before
cmos_resume(). Because rtc_handler() clears the ACPI event status
unconditionally, it reads the cleared register and fails to call
rtc_update_irq():

rtc_handler() {
    ...
    if (cmos_rtc.suspend_ctrl)
        rtc_control =3D CMOS_READ(RTC_CONTROL);
    if (rtc_control & RTC_AIE) {
        ...
        rtc_update_irq(...);
    }
}

Later, cmos_resume() runs and attempts to recover the lost event by calling
cmos_check_acpi_rtc_status(). However, since rtc_handler() already cleared =
the
ACPI event status, acpi_get_event_status() returns no event, and the IRQ is
permanently lost.

Will this indefinitely stall userspace processes waiting for the RTC alarm
via poll() on /dev/rtc?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909225132.1392=
883-1-gourry@gourry.net?part=3D1
