Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0C648643C;
	Mon,  5 Oct 2026 13:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208198; cv=none; b=kXlqgEXtp44lCe6nZ7yp2Ywy89DvJA155vMGpPmLeFY2Zxkc2pbC9xaFAqiJNUxGvLJDr3AJQ9+/AEe68kOCdTBKBeN5HdP+89INhnZlABgjIueDA9TIKdW5+5LENpSMdmaKztNZS3HkWCe9pYf2aUDXBf4nve5AH4F7R0pdgoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208198; c=relaxed/simple;
	bh=z8mXgqPbfnrHMfG4x/CaUWbgGlKztCRm8rTge2kpu24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwQ/VePAf2rPmoXF1yX411Yz8bIscPDgLbjz2c3cLDl6kohXwln47VAaexmMWjJjqKiHygA+F0wgtLIVb4bcivi2rMZIgEnyLMgEP6T6jNVEvYIZ7Iz8SNRM0CsHbPopHpjQjnoCIS8L4b2z3C2QA4Op7tQj8DCRg4u/0HYnCKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OUgTN+wb; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OUgTN+wb"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 922364E4117C;
	Mon,  5 Oct 2026 13:49:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 60413601A5;
	Mon,  5 Oct 2026 13:49:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E4DC010330663;
	Mon,  5 Oct 2026 15:49:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791208188; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=8vA+I9C9/mU7kAI15YDstDuXZm6iy0kIk5yK3NXlhgw=;
	b=OUgTN+wbXTbIxIDJm7T8feK2nR+kOoXoQGzSHWiTQc0lYbJ+hDsF7ZmEfH7FG96s7xsHjN
	w6zAzq4cP5/BmkSCqh/sFLuMkFOFiq7+QNJwbHrOVl4Up3V8h2n3V7pjQU7YkTlSZ55Qxi
	rrVpXR6psvEUeXs7O84DX/62DJL1yvw6YrE0cXjVzKxJsN/mBTTTTNsxRP3EYHGVefJ5WU
	HEM5cj4dtKzgKSA9eW/pf85pXUZeRoiULwVHFvZTa5uORabLYpKgXFW+KYiW4lZQIjcI90
	k4oZ+hMZU15Hs1V2glYhwXBr/E17z0146beA+GCMdB1bF2hElNpk0pYh31UREw==
Date: Mon, 5 Oct 2026 15:49:45 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: class: Make the time32 hctosys limit configurable
Message-ID: <202610051349454ed35b56@mail.local>
References: <20260914212537.1452-1-kmehltretter@gmail.com>
 <7c020979-cf03-4ece-a7d4-b1475d1400c3@app.fastmail.com>
 <aqnHDxRIBncNH6qr@gmail.com>
 <59ba6707-c5d5-4fd8-9200-f910e61d9232@app.fastmail.com>
 <aq3R5QnCpu_fOq8g@gmail.com>
 <5515c266-f9cd-405f-b7a8-1ec45d9d902a@app.fastmail.com>
 <202609222137059e745547@mail.local>
 <d7825e87-93f2-4444-bf3b-45a4127de7a9@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7825e87-93f2-4444-bf3b-45a4127de7a9@app.fastmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On 24/09/2026 17:07:30+0200, Arnd Bergmann wrote:
> On Tue, Sep 22, 2026, at 23:37, Alexandre Belloni wrote:
> > On 19/09/2026 11:16:29+0200, Arnd Bergmann wrote:
> >> On Sat, Sep 19, 2026, at 02:10, Karl Mehltretter wrote:
> >>
> >> config RTC_HCTOSYS_TIME32_LIMIT
> >> 	bool "Reject RTC dates after the 2038 cutoff"
> >> 	depends on RTC_HCTOSYS && !64BIT && COMPAT_32BIT_TIME
> >> 	default y
> >> 
> >> to completely disallow it. I think we should wait for Alexandre
> >> to comment here, as it's his subsystem in the end and I'm sure
> >> he has an opinion on the matter.
> >> 
> >
> > I gave it some thought for the past month as this is an issue that is
> > regularly brought up.
> >
> > The first thing is that this is an issue that disappears as soon as
> > RTC_HCTOSYS is not used. RTC_HCTOSYS has plenty of issue and one of
> > those is that is doesn't actually work well with NTP. There is a fix for
> > this and it would slow down every boot by a second or two.
> 
> Sure, simply disallowing RTC_HCTOSYS on any build that contains support
> for time32 userspace would also avoid this.
> 
> > The main issue is that systemd decided to mandate RTC_HCTOSYS when
> > raising up the issue, the answer is that it is unacceptable to have logs
> > that are not properly dated until userspace sets the system time. But
> > letting userspace set the system time simply solves the issue as it will
> > always set a time that it can handle, even if not correct.
> 
> Not sure what exactly you are suggesting here. Do you mean we should
> try again to address this in systemd in order to no longer need
> the RTC_HCTOSYS hack?
> 

Well I guess we'll get the same answer that this is too late in the boot
process.

My proposed solution is to have a way to tell the kernel what size of
time_t userspace actually supports as there is no way to automatically
detect it. That's why I was thinking a kernel cmdline parameter would
fit. This would allow us to be 100% correct.

Else, I'm fine with your last proposal. I guess this would leave us with
two unhandled cases:
 - 64bit systems with 32 bit userspace that you said we don't want to
   support
 - 32bit systems with 64bit time_t userspace that would not work
   properly with the default configuration.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
