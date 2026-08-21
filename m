Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1436639D6F6;
	Fri, 21 Aug 2026 21:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787347574; cv=none; b=OlajoqafMzYuOorcyN/pDJ2F+pr/bPTEICVqFWKcKs0oD5JDCgCKTVehLUJSX3A0d3W/3j5XOJNoDmaXAS6RVfIyRkBvSBQDxkgVwXGEq0Aw+XoLl0aRdcrepNJkjwLQc8nD0dsS4NLALduzDsYARGvY4D1Z0v45P8IlVea9Ksk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787347574; c=relaxed/simple;
	bh=Ee9J/7cFhF81s3kbTe7MDL2MKbtf02YY7MAabn3HYkM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KQ6s3Ui6YtwnfT4W18CfUSDCBc7kwTVKKPArcuz8/QyY8DUwz8T4CQWpKwYa/nHPZluYm7mwCag0Yl8Lj6+LFoLpsW/fTEO0qQeBONqYlQDgUUakcoxBDY38psChXzZIAvfKUzIqz32OdFbtdSkSh1OBQpff5nftxMa8HpZhFSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fikZpgl+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fikZpgl+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E0C1F00A3E;
	Fri, 21 Aug 2026 21:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787347572;
	bh=S7JY09EKdXKR51agN5l9JZEijLlYhtMyr0zcyX2v09M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fikZpgl+vCtWx+EPlqQwqjxfm0IqpcngUS3/8akRCW1cKaVXCeWmy9N3Zx7K8pxYX
	 Am/IUvFxBrcHhbukJ9AMZ1S6EY4JzUwUpRGGmH1JwysorX6+/L+sXKl91MDJORHa1e
	 7UzFOapv444+KjNFZxZf5ga0UDRQQeb8r630doPkKlTLMBcAfH27X3VrpUloyZtgni
	 JdAQ39gCi0dDPOcsIgDacTdYs/fQ9wL/h0gBshhinqNuj4NroBtSQ6cdRGIvk/bGBH
	 F8yaNIe5zLfHwMgrTC+JSOBk6jhxp2riW2OGhqbVoQBJeZTQ2vPRBA1yyze5W8Iwkt
	 nMxJjCh1lgkdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/17] rtc: rzn1: Disable alarm interrupt before
 reprogramming alarm registers
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: wsa+renesas@sang-engineering.com, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260821211032.13554-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260821211032.13554-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260821211032.13554-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 21:26:11 +0000
Message-Id: <20260821212612.10E0C1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Data race and TOCTOU in IRQ handler leading to spurious interrupts=
 and incomplete synchronization
- [High] Hardware state lockup on timeout in rzn1_rtc_set_time()
- [High] Alarm logic erroneously uses 1-second interrupt for past alarms wi=
th the same minute
- [Medium] Race window in rzn1_rtc_read_time() fallback logic can produce i=
nconsistent timestamps
--

--- Patch [6]: [PATCH v6 06/17] rtc: rzn1: Disable alarm interrupt before r=
eprogramming alarm registers ---
commit 0be1a07839b0e52a936e0315319b64b90371633b
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: rtc: rzn1: Disable alarm interrupt before reprogramming alarm regi=
sters

This commit updates rzn1_rtc_set_alarm() to disable alarm interrupts before
reprogramming the alarm registers (ALM, ALH, ALW). This prevents a scenario
where an existing alarm interrupt fires while the registers contain a mixtu=
re
of old and new values.

> diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
> index f3268655fd373..42e57bf0b4aaa 100644
> --- a/drivers/rtc/rtc-rzn1.c
> +++ b/drivers/rtc/rtc-rzn1.c
> @@ -281,6 +281,11 @@ static int rzn1_rtc_set_alarm(struct device *dev, st=
ruct rtc_wkalrm *alrm)
>  	if (alarm > farest)
>  		return -ERANGE;
> =20
> +	/* Disable alarm interrupts before reprogramming the alarm. */
> +	ret =3D rzn1_rtc_alarm_irq_enable(dev, 0);

[Severity: High]
This is a pre-existing issue, but does disabling the IRQ here fully prevent
the race without a call to synchronize_irq()?

If a previous alarm interrupt fires right as rzn1_rtc_set_alarm() is called,
CPU0 could enter rzn1_rtc_alarm_irq(), read tm_sec locklessly, and wait for
the spinlock.

CPU1 could then call rzn1_rtc_alarm_irq_enable(dev, 0), holding and releasi=
ng
the lock.

CPU0 could then acquire the lock and unconditionally write its locklessly
computed set_irq_bits to CTL1, re-enabling the interrupt:

drivers/rtc/rtc-rzn1.c:rzn1_rtc_alarm_irq() {
	if (rtc->tm_alarm.tm_sec =3D=3D 0)
		rtc_update_irq(rtc->rtcdev, 1, RTC_AF | RTC_IRQF);
	else
		/* Switch to 1s interrupts */
		set_irq_bits =3D RZN1_RTC_CTL1_1SE;

	guard(spinlock)(&rtc->ctl1_access_lock);
	...
	ctl1 &=3D ~RZN1_RTC_CTL1_ALME;
	ctl1 |=3D set_irq_bits;
	writel(ctl1, rtc->base + RZN1_RTC_CTL1);
}

Could this allow the handler to override the synchronization intended by
this patch?

> +	if (ret)
> +		return ret;
> +
>  	writel(bin2bcd(tm->tm_min), rtc->base + RZN1_RTC_ALM);

[ ... ]


[Severity: High]
This isn't a bug introduced by this patch, but does the error path in
rzn1_rtc_set_time() leave the hardware in a locked-up state?

drivers/rtc/rtc-rzn1.c:rzn1_rtc_set_time() {
	...
		ret =3D readl_poll_timeout(rtc->base + RZN1_RTC_CTL2, val,
					 val & RZN1_RTC_CTL2_WST, 0, 100);
		if (ret)
			return ret;
	...
}

If the system is under heavy load causing a preemption delay longer than
the 100us timeout, the function returns -ETIMEDOUT immediately without
clearing RZN1_RTC_CTL2_WAIT.

Could this stop the RTC hardware from ticking entirely across the system?


[Severity: Medium]
This is a pre-existing issue, but does the fallback logic in
rzn1_rtc_read_time() leave a race window for preemption to corrupt the
timestamp?

drivers/rtc/rtc-rzn1.c:rzn1_rtc_read_time() {
	...
	rzn1_rtc_get_time_snapshot(rtc, tm);
	secs =3D readl(rtc->base + RZN1_RTC_SECC);
	if (tm->tm_sec !=3D bcd2bin(secs))
		rzn1_rtc_get_time_snapshot(rtc, tm);

	return 0;
}

If the thread is preempted precisely between the TIMEC and CALC reads in the
second snapshot, could this return an inconsistent timestamp to userspace
since there is no loop to verify the second snapshot?


[Severity: High]
This is a pre-existing issue, but does the alarm logic erroneously fall back
to the 1-second interrupt for past alarms?

drivers/rtc/rtc-rzn1.c:rzn1_rtc_alarm_irq_enable() {
	...
			if (rtc_tm_sub(tm, &tm_now) > 59 || tm->tm_min !=3D tm_now.tm_min)
				ctl1 |=3D RZN1_RTC_CTL1_ALME;
			else
				ctl1 |=3D RZN1_RTC_CTL1_1SE;
	...
}

If an alarm is set for a time in the past where tm_min matches but
rtc_tm_sub() is negative, does this logic incorrectly apply the 1-second
interrupt and cause late or spurious wakeups?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821211032.1355=
4-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D6
