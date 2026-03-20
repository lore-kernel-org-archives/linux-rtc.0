Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB9E3BAD83
	for <linux-rtc@vger.kernel.org>; Fri, 20 Mar 2026 15:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774022192; cv=none; b=S5DIiTi2KvXnWMZ7MwPHin8M7DfJKJJ2NA0XFihfIke+75EnT1yuR0PmLqBroZH/pBmAAJMO0MhAzFQPIAU62SfbJtVoOxeWggc0DVFFTcPBt7rzQmVsJ25Uo6BsH6nxCsbEP92n2Vo2ou7gyKVKbFpCLl1hIT3IszXHHUd1Rqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774022192; c=relaxed/simple;
	bh=IOffjzYj/NZvL+u6/Fq6bJ9hOtQCLHt8aWP8NB7jcKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GwN360GQ3H8clU3ovxxDUNV5TvyiiJVmln72kE2K2EB9cV0Kjll9lNw+sfhGVaQX/WemtAyHlJK6gPMmGjSHGjknNB7Bq5HdVsBfQoryHCA6ER/akS7qwwhMAu8ZZol3p1Fc17DSHYUPWK0gRqjLPVRWIEtgmsEtmqGR4nLNMzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwQyYV7O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwQyYV7O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9285CC19425
	for <linux-rtc@vger.kernel.org>; Fri, 20 Mar 2026 15:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774022192;
	bh=IOffjzYj/NZvL+u6/Fq6bJ9hOtQCLHt8aWP8NB7jcKY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qwQyYV7ObH37jHPqMPYxeFbpVODB7JkSAk5+4hjktDbeK7CHsQUCB6gDfdMgrX7gz
	 vV5ihpgsPukhy+A7GjbugAPrM8ughxelya7Sfk3gHYw8t+29jWY0Q8moT32K6ZFhaV
	 BhyTKnUv9+fDxMNRGsEDswjmX61e21vt0pRzPvlscCO8Kcw/uTqFOMZCh+Bdie9oFn
	 RQSkFUSns8f3fQrH27Nwu0wqA8IKvPUr9+9J5EhHn0urXT18dZAzG/HykjsmMPNTHf
	 OOyo3iTmNcFYi3ycNXPhethHgieX5Qahwkl3Fy4zncsXZ2KJGglNvjBw06axwWBt5w
	 yV2r/R8gsq8GA==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-466f00535cfso1242712b6e.1
        for <linux-rtc@vger.kernel.org>; Fri, 20 Mar 2026 08:56:32 -0700 (PDT)
X-Gm-Message-State: AOJu0YzrrNH6E7clrMr5J2wST9dyLira1EDbcrnDZQTHNEab1HUKud+0
	lwBxv64QgFSPPFfUK87wG1yEI3l5Q5euDKLXZzPrdiJ3Ar6h8WTgy2K5evtv0xDfgDXAtoYRwaX
	KtAZIzPjDiTfQLsw+QfML/bKThk8FTqk=
X-Received: by 2002:a05:6808:1491:b0:467:36f:181c with SMTP id
 5614622812f47-467e60044eemr1747063b6e.51.1774022191668; Fri, 20 Mar 2026
 08:56:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3964452.kQq0lBPeGt@rafael.j.wysocki>
In-Reply-To: <3964452.kQq0lBPeGt@rafael.j.wysocki>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 20 Mar 2026 16:56:20 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gx8ihgMB6Nrod1pxEeWAQRTuMcB_xqJ-yzuibr2eF3RA@mail.gmail.com>
X-Gm-Features: AaiRm53hF-ilZxrd7VP1F6m-Fwm2cCEMEOyelgSFAQ06eZe2VddWunHi89qUW5c
Message-ID: <CAJZ5v0gx8ihgMB6Nrod1pxEeWAQRTuMcB_xqJ-yzuibr2eF3RA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] rtc: cmos: Do not require IRQ if ACPI alarm is used
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-rtc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 14, 2026 at 1:13=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> Hi All,
>
> This series of patches allows the CMOS RTC alarm to be used on x86
> systems that don't include a functional HPET and may not configure
> an IRQ for the CMOS RTC, but have a functional ACPI RTC fixed event.
>
> The first patch allows the ACPI RTC fixed event to be used on systems
> without functional HPET because there is no fundamental dependency
> between HPET and the ACPI RTC fixed event being hooked up to the CMOS
> RTC.
>
> The second patch changes the driver to stop requiring an IRQ to be
> configured for the alarm functionality if the ACPI RTC fixed event
> is use for signaling events because it require a separate IRQ to
> be requested (the ACPI SCI is used for event signaling in that case).

If anyone has any objections or concerns regarding these patches,
please let me know.

In the absence of any, I'll queue them up for 7.1 on top of the
previous CMOS RTC driver changes.

Thanks!
