Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440629;
	b=dPW0S5nRcmOQ+4nfsi3HTLGA0q6i3M0Xle4lWXri4QYZNFAMSHnQc11dF3EG9d5YPfRs
	 2W8JVVOuNs6bOMasrECFYojcmDrlgFvBqGjKVtazAO7Qh4n1T+Hsp953SZ1YVqzhSnEc/
	 nAUvWzS7a1xF1Pmjym7rIM6Yr3TtVRfJv3C53B2Hm32vTAFhMeb6fjz0ZWG1e5KcpZE8F
	 UJINAn8NycR8oRybe1sGtpVrc/VL+jhw/By6fREXZSTRAKpxHIIa74GinMNSoEMKGQxw9
	 jvTXerHWnujSEQT35ZzlMnDjYjSz6WGk/GxjTral+pl9E4lnxJOk4PHVNf/tNnTGbPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440629;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Last-TLS-Session-Version;
	bh=BVwu0zGEH0/TN5lnCQrb8LUaYg21LYYId0LnB698nU8=;
	b=LHFgZbzJpu58/7y5g6QcQ2U8bshTWeveXmT9MS6PKwXjCvu2r5LKz4AgMgbFZlrqRJKP
	 fY4/B33nVsAbyVmKM+w9WA3emT41but1l3QSWHRnloethMOV2oCFz9iqNQAm3/EgCJ7JQ
	 /qDbEyHE0ZqyuDh/r13cDxNSMMSXhmD6MVxZjKA/7JAxFvoTNV4OE0MgkSUsDpPm1GqOf
	 PShl/a5Tl3OGmOV6SlQPqQbOK6Zth9wbDuxn60OCb4+C34MMhJSy86huerpw8W0sYXFCy
	 7hGs/2BMmkcmErC+ZvY33zxuTumNahxkb3oNtWwCdCwldc/qdGbCow5RRsBDOqJrdiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=EXMRCviC;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287D5606A31A;
	Mon, 19 Oct 2026 20:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 287D5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=EXMRCviC
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8C1DB1A124D;
	Mon, 19 Oct 2026 20:10:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4B20160582;
	Mon, 19 Oct 2026 20:10:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5F72C10328C22;
	Mon, 19 Oct 2026 22:10:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792440624; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=BVwu0zGEH0/TN5lnCQrb8LUaYg21LYYId0LnB698nU8=;
	b=EXMRCviCklnOjnqoZRCVUMZXw5pVoRsryS6ybXaQiO9uSmEUhsW6+j3LG2OPiuUnGVDyn/
	HwTKQUtsqdGjGrj0VPFehQ9dWp4/jpTYnWoqPH6g9FlXhrtpYRhMSqvekHGXq8imvaNYzw
	CuCgauxmavb2G9sCg8NmdT4TCN07HxM6cFO7maDY4/Z6HNrmLNaBfVKwslOcIMNWoh3pPi
	Je+gLyBTyFj5h6KrNX8Afxr8Ay1gEbB9nbDhIhsMb8Pk0WSI8pngmV23vs0vfWNxNm3Z4l
	UQrAqES0kjpIIby8A8mKCEi68br1S3m+ePXDdZ/0c3cXkQ3IqVB6l1YrGd53wQ==
Date: Mon, 19 Oct 2026 22:10:21 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org, Gregory Price <gourry@gourry.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, rui.zhang@intel.com
Subject: Re: [RESEND PATCH 0/2] rtc: cmos: Fix ACPI RTC alarm handling
Message-ID: <179244056610.104236.1471257559903305892.b4-ty@b4>
References: <20261015173029.3091872-1-gourry@gourry.net>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015173029.3091872-1-gourry@gourry.net>
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 15 Oct 2026 13:30:27 -0400, Gregory Price wrote:
> Resend of the series first posted on September 9.
> https://lore.kernel.org/linux-rtc/20260909225132.1392883-1-gourry@gourry.net/
> 
> RTC update interrupt emulation can stop delivering events when rtc-cmos
> uses the ACPI RTC fixed event. On an affected system, a test that waits
> for five one-second update events completed only 40 of 50 runs. The ACPI
> ff_rt_clk counter stopped at 218, exactly matching the number of events
> delivered to userspace, with the event status set but delivery disabled.
> 
> [...]

Applied, thanks!

[1/2] rtc: cmos: Disable ACPI RTC event before handling it
      https://git.kernel.org/abelloni/c/3f67038df8b5
[2/2] rtc: cmos: Honor explicit use_acpi_alarm parameter value
      https://git.kernel.org/abelloni/c/3c7acb209e1d

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
