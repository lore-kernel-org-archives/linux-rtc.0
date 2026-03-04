Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1075F1A9B46
	for <linux-rtc@vger.kernel.org>; Wed,  4 Mar 2026 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772628151; cv=none; b=cWsrTYN18zWgxK5Ig/miyjcEae6UshkV1kV9Da7S9HtyLsYc+ZQV6poe86npu8Q6ZrHaPb1yv+7Vryi7QIytWsRtfFaHoCL0G0tJKMLJTm4+zt9iYL1zO45dmsLR+//8YOIirCZhqEUl+a3h+CPbHdMrU44Zf4LCf+isI9WP69M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772628151; c=relaxed/simple;
	bh=qGzZfAit+MSoZwftoZQ85Sg5ltGAW1OtPiex2YPo14E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dLcab0zIOWoiqkKDrnSJ163h5UNMLhqJTK4D9WPqjljRMzzx3LP1itNeAQdqqOPCHmgc69dKgUwAslYiNhjEBgjA5BqHl/5z9KbYDJnK8pw0JonJwFas4LVbKG9bLqpMWkmRkGg1916kvw+GnqrmcPTpNr/qIkz4eBpOg4l+I+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyCTvWXz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyCTvWXz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2718C2BCAF
	for <linux-rtc@vger.kernel.org>; Wed,  4 Mar 2026 12:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772628150;
	bh=qGzZfAit+MSoZwftoZQ85Sg5ltGAW1OtPiex2YPo14E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tyCTvWXzkvTWmkBtJM042Bdk/jeEAxgzQ0LoJgINdC95oAGM7qCZT5xWtzPhmnwt8
	 vZZA+9rc/TPHZubNL7t7OjFRtB+qByRlwTpgDywNdKuY3lw4nfImOVjpBV9bBoSY/F
	 O1Sq/hPkWPlS6Ug7SbOg/rDc9QYIyK9oBm0ioBPAYOI33gmw5YSPnXFG+TsCE5hrwS
	 lzlhDyyMxuImXwn0oaaFoFTE1OFQIqo3bKaDQKULdGlmcm4r8ppA9Y7yVD9OnfBoRf
	 0g9EE2JoXskU77ToCeO/bq35N0GxZxHRm+bWaQko0ZhXQO7zinwEhaAqW63hQa9t2W
	 jZJu+E0GsZCbw==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-40974bf7781so1321803fac.0
        for <linux-rtc@vger.kernel.org>; Wed, 04 Mar 2026 04:42:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUOUmd+yIIdP2PHgKBO9gklUFWCn1BPP0ZkLBzC26N7OgzHjCFBHFpQDzmow3oofwlOKHnRg4zy/IQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKkGFiBpwiBUxEYSICgDLEtkhZIxqgqW2HbD59k9i93b07CVBk
	e4CE5RKPF3Tpg6ioea2BKA9BR8ghVsfxPK6AMBi5uQZoXg8yDB0QpfcJMSQ0jZ+Dsa25UBkr7yw
	G8GvDog58n8RSIzv+MEpfu9pyoBZ8+uA=
X-Received: by 2002:a05:6870:7020:b0:3d3:1fc3:c0c6 with SMTP id
 586e51a60fabf-41691d7a8e9mr3409458fac.1.1772628149894; Wed, 04 Mar 2026
 04:42:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5983325.DvuYhMxLoT@rafael.j.wysocki> <13969123.uLZWGnKmhe@rafael.j.wysocki>
 <20260303060752.GA2749263@ax162> <5087839.31r3eYUQgx@rafael.j.wysocki>
 <20260303175237.GB1114907@ax162> <CAJZ5v0jgLU_87cESzySAQhP31L83u-sd2xAHFiJmeqrw0NdOhg@mail.gmail.com>
 <20260303211725.GA2374171@ax162>
In-Reply-To: <20260303211725.GA2374171@ax162>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 4 Mar 2026 13:42:18 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gzEp9UG74G76ohFa0gp2ii+hxUiU_kPGyWdbmSXLmQKg@mail.gmail.com>
X-Gm-Features: AaiRm51LgxcGpx2YLr8Zqh_VMeB5JV1oFN0UmgabxBy1Q-PsWcjzfqpOarh5azk
Message-ID: <CAJZ5v0gzEp9UG74G76ohFa0gp2ii+hxUiU_kPGyWdbmSXLmQKg@mail.gmail.com>
Subject: Re: [PATCH v1 4/8] ACPI: x86/rtc-cmos: Use platform device for driver binding
To: Nathan Chancellor <nathan@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, x86 Maintainers <x86@kernel.org>, linux-rtc@vger.kernel.org, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 10:17=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> On Tue, Mar 03, 2026 at 07:47:54PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Mar 3, 2026 at 6:52=E2=80=AFPM Nathan Chancellor <nathan@kernel=
.org> wrote:
> > >
> > > On Tue, Mar 03, 2026 at 01:51:37PM +0100, Rafael J. Wysocki wrote:
> > > > On Tuesday, March 3, 2026 7:07:52 AM CET Nathan Chancellor wrote:
> > > > > After this change in -next as commit 2a78e4210444 ("ACPI: x86/rtc=
-cmos:
> > > > > Use platform device for driver binding"), I am seeing
> > > > >
> > > > >   rtc_cmos PNP0B00:00: error -ENXIO: IRQ index 0 not found
> > > > >
> > > > > on a few of my test machines. Is this expected?
> > > >
> > > > Not really, thanks for reporting!
> > > >
> > > > Please send me a dmesg boot log from one of the affected systems.
> > >
> > > Attached.
> > >
> > > > The patch below should make the message go away.
> > >
> > > Can confirm, thanks! If it is helpful:
> > >
> > > Tested-by: Nathan Chancellor <nathan@kernel.org>
> >
> > Thank you!
> >
> > Can you please also send me a dmesg boot log from the same system with
> > this patch applied?
>
> Attached. Let me know if you need anything else.

All is fine now AFAICS, thanks!
