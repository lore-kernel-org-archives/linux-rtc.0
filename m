Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A84F4D4887
	for <linux-rtc@vger.kernel.org>; Tue, 22 Sep 2026 21:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790113042; cv=none; b=osuD8jEqFZnI5qDyX8+3y21Ofe14JIAHRHXJ1zTaQUwt9VrjTqlagJjkUYN1WkVr51cu/yTlenT4h/+dXHk2cwVy/+5hn8FXNIBbmGegmUrfQ7yEL1PoB4rMDau39TdXnHl4UsZ11uZuthhIJ+NBibTd+fOoEibKspmrctu8dvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790113042; c=relaxed/simple;
	bh=yPDXC5vowmo+pZ3224jTCpA65SZnVwbEO4hqx3G2yn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEa0+ar60aG/kXpx7YaksK7xaHdMY2g/IHPiNKfZyRzaViCQHvxlxhEyEMrCRFnBXYZnrQo9z//515zPeoEmi2OBRMVU0faAfMyMeVBVtQG5dtIFaN1lny6In91pc8jd8eIvK2HKnfPro9Ta/ZCPeHul1YnPOUZzNorsjVPJ184=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mD4TqCgI; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mD4TqCgI"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E4D444E41030;
	Tue, 22 Sep 2026 21:37:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A96DB60580;
	Tue, 22 Sep 2026 21:37:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5A634103293A1;
	Tue, 22 Sep 2026 23:37:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790113027; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ftJzvj2kwXjjQxPRrvzoTsUveGerAV94CItEpFzP2OU=;
	b=mD4TqCgIrZig9eaJCUFIOzaP0wnXcvIFMTxxfaNY1Rd+I2Kxoo2gsIlltrF395Se3AwfAO
	fbtLQmivoaAj2Uyq9Qc3ur73gZHEgYwN3Wh9urr1CbtTC8UAXb9cswE7HHAU23qVD7dkAC
	cqBWHT1FxQJVQi48N4ySXTh8pExQWCaYhyNgORHYu1Bvozu260ilKLIuri0nisUw13p45+
	lXmXbTnG0409ApWjxzyBJBM2+tFReAKbnD3oX8y1uG8I0YUAmNSBqKsloW7Diq98Oq2dnQ
	dfUBIoaodw2Y3PdKbWtAt0F9bjsVqP6xrCg0U8oe7VduCLhmvofPzBUVQaSylw==
Date: Tue, 22 Sep 2026 23:37:05 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: class: Make the time32 hctosys limit configurable
Message-ID: <202609222137059e745547@mail.local>
References: <20260914212537.1452-1-kmehltretter@gmail.com>
 <7c020979-cf03-4ece-a7d4-b1475d1400c3@app.fastmail.com>
 <aqnHDxRIBncNH6qr@gmail.com>
 <59ba6707-c5d5-4fd8-9200-f910e61d9232@app.fastmail.com>
 <aq3R5QnCpu_fOq8g@gmail.com>
 <5515c266-f9cd-405f-b7a8-1ec45d9d902a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5515c266-f9cd-405f-b7a8-1ec45d9d902a@app.fastmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On 19/09/2026 11:16:29+0200, Arnd Bergmann wrote:
> On Sat, Sep 19, 2026, at 02:10, Karl Mehltretter wrote:
> > On Wed, Sep 16, 2026 at 08:56:02AM +0100, Arnd Bergmann wrote:
> >> > existing safeguard automatically and prevent restoring it without
> >> > re-enabling the legacy ABI.
> >> 
> >> I'm not following your logic here, what is the safeguard?
> >
> > I meant the existing RTC cutoff. In my glibc test, accepting the
> > 2040 RTC date changes time32 clock_gettime() from success to
> > EOVERFLOW.
> 
> I see. I would just not call that a safeguard, it's more of a
> time bomb ;-)
> 
> Note that the cutoff was never meant to help systems actually
> run beyond 2038, but instead is only needed on very rare systems
> with a broken RTC implementation that have a random reset
> value if the RTC is enabled in devicetree but the backup battery
> is absent or depleted.

Well, this is how the issue has been discovered but this is a real y2038
issue.

> 
> >> With a fixed C library, COMPAT_32BIT_TIME=n should act as a safeguard
> >> to ensure that no interfaces can be used that limit time to y2038
> >> and break unexpectedly in the future. The RTC_HCTOSYS interface
> >
> > Should we try adding an option to build glibc and other libcs without
> > time32 interfaces? Looking at musl's source, its time32 clock_gettime()
> > wrapper also calls the time64 implementation and checks whether the
> > result fits [1].
> 
> I think that would be great, we can certainly try again, at least
> with glibc, where at the time the concern was more about the timing
> of behavior changes.
> 
> There are two separate questions here:
> 
> a) Having a libc build only against the time64 interfaces. As far
>    as I understand, glibc has used linux-3.2 headers as the
>    baseline for kernel compatibility for a long time but one can
>    choose a later version. Building with 5.10+ as the minimum
>    should already avoid the time32 syscalls, but that could at
>    some point be made the minimum header version for 32-bit targets
>    or everything.
>    musl does not specify a minimum kernel version at all and tries
>    to go back as far as possible, so the fallback code is likely
>    to stay indefinitely. Rich also does not like the idea of setting
>    CONFIG_COMPAT_32BIT_TIME=n (ever), and an unpatched musl
>    build will fail in that configuration.
>    
> b) providing 32-bit interfaces to applications: both libraries
>    already provide these as wrappers around the 64-bit internal
>    functions, which is part of the problem here but does mean that
>    it should be possible to just leave those out. On musl this
>    should be very easy (just skip building the compat/time32/
>    directory), on glibc I expect this to be much harder as it
>    interferes with their idea of having __TIMESIZE=64 vs
>    __TIMESIZE=32 as a hardcoded per-architecture setting.
> 
> >> actually make it work. Since we have COMPAT_32BIT_TIME as a global
> >> option already, it makes a lot of sense to actually use it here
> >> as well.
> >
> > Could we use COMPAT_32BIT_TIME for the default, but still allow the
> > limit to be enabled? I could split the update into two patches:
> >
> > 1. Add RTC_HCTOSYS_TIME32_LIMIT with default y, as posted. This keeps
> >    the existing RTC date acceptance by default.
> >
> > 2. Change the default, keeping the dependency unchanged:
> >
> >        depends on RTC_HCTOSYS && !64BIT
> >        default COMPAT_32BIT_TIME
> >
> > With RTC_HCTOSYS=y on a 32-bit kernel, the default would allow
> > post-2038 RTC dates when COMPAT_32BIT_TIME=n. Integrators could still
> > enable the limit without re-enabling legacy syscalls.
> >
> > I suggest nominating the first patch for stable. Would default
> > COMPAT_32BIT_TIME also be suitable for stable?
> 
> I think the 'default COMPAT_32BIT_TIME' would absolutely make
> sense for stable, since that can only really be set by users that
> have a fully 64-bit userspace already and the limit will
> cause problems for them.
> I would still go one step further and make this
> 
> config RTC_HCTOSYS_TIME32_LIMIT
> 	bool "Reject RTC dates after the 2038 cutoff"
> 	depends on RTC_HCTOSYS && !64BIT && COMPAT_32BIT_TIME
> 	default y
> 
> to completely disallow it. I think we should wait for Alexandre
> to comment here, as it's his subsystem in the end and I'm sure
> he has an opinion on the matter.
> 

I gave it some thought for the past month as this is an issue that is
regularly brought up.

The first thing is that this is an issue that disappears as soon as
RTC_HCTOSYS is not used. RTC_HCTOSYS has plenty of issue and one of
those is that is doesn't actually work well with NTP. There is a fix for
this and it would slow down every boot by a second or two.

The main issue is that systemd decided to mandate RTC_HCTOSYS when
raising up the issue, the answer is that it is unacceptable to have logs
that are not properly dated until userspace sets the system time. But
letting userspace set the system time simply solves the issue as it will
always set a time that it can handle, even if not correct.

So, my backup plan was to unconditionally enable the limit so we also
handle the 32bit userspace on 64bit systems and have a new kernel
parameter that would opt-out of the limit. I guess we could have a
warning and point to some documentation if the parameter is missing. We
can avoid the warning when the parameter is present and explicitly opts
in.

Thoughts?

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
