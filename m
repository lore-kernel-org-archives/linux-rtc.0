Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793269479;
	b=QrTzFsOBn/M8KwE0d2McGSi9bhU+D2lT64WzA/roP9OVI85owN5eTbjoAnhOxSZDs1/k
	 uykemTSZhzRM7QZYpGP+zGf1/OiSGho10q/IS436zQljIOh4xg9+i78SqH+YwxDl2x751
	 tLx7qOj5V2rqev6g3U5AFg+F2zwyKeno815obuM6abyggKnb+GMm5TOiN8T/puJxzwXf6
	 L1hjOEzh0+bZykQNBd75HyK2LkifW88YUWrXP/OHIos4gi71mcfCDCM6mbMVOPqNOton+
	 pmb/D/W+AJG9IAEGkHXcDyif2dBynmWuGKgfuz3wZwdMqTw6VxEr0B6ALNuGfHVfyuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793269479;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Last-TLS-Session-Version;
	bh=PRGCV9cZ4VthOUaNo51WkRzJnsZvTbLhbXjN4sI6wPc=;
	b=1YPTibas2ToFLqz30/uaPvw1Vls8eySTrymgPeM1kSO3SQQjr7xAUeur5JR5P6OB2GWj
	 FzIo9Y3ngC7gKwsXXDv3S9arDhvFqWNv/orOeyeZjyDwUcEnl+zamsWW1KYCjw/+gij97
	 xXISb533lYd9CmmCLJVRiibtpHz/A8scYTHF3aGR0bnwtET+H0uei/NMs+LW/6HZVyHaV
	 rOvRHhpQG9T4m7Q2a8s1W+nkIRJftyW0FMasM6PMmmjZE/FcVr8P8xJ0Wn9HGCghykxq5
	 mmrNMUn/jarROnqG0FvsBp4EQ5ToAhMSt8DSyWxP2VaYeAxrGdwgXoMPVLCn9h06bSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=uzQ2084k;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E54F606A31F
	for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 10:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E54F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=uzQ2084k
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id CBE0C1A1390
	for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 10:24:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9CE4B60360;
	Thu, 29 Oct 2026 10:24:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EA873103290ED;
	Thu, 29 Oct 2026 11:24:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793269475; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=PRGCV9cZ4VthOUaNo51WkRzJnsZvTbLhbXjN4sI6wPc=;
	b=uzQ2084kCbRviD1yaE++rtmTpeeSVrFpFtGgZ44sVgqlc/NSZTAduSD2P8eTJVLYSpuR3W
	dl43Tv4/VBfZPBmlz/Fr9EiTg9etCbpRFwPhvgAnyRXdZSsO8hhkXf52VLAwDfjUoVtg/F
	laKAnHBqXupmsHqtakj1Q9yW3B9yUdzQ2+WMRCmO+ZjFuKgXJJdU5XOaXSyhhLAy8R8bUB
	WVULSzjCM37uY38g7v9M+fKlUoGFsnp1LVme26DZ2g0ncjfWOuG9LivnJadfoDim9I0YiV
	dImIPOz+4L0Q9TearVPLef7HKXSxYnJn1iM0b/bkMb41lRYM+sudGFR/hkUytw==
Date: Thu, 29 Oct 2026 11:24:34 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org,
	"A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] rtc: pcf85063: Update interrupt support
Message-ID: <179326945279.872181.7368976629277935202.b4-ty@b4>
References: <20260828164445.3907839-1-alexander.sverdlin@siemens.com>
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
In-Reply-To: <20260828164445.3907839-1-alexander.sverdlin@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3

On Fri, 28 Aug 2026 18:44:38 +0200, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> Add hardware-backed UIE (1 Hz update interrupt) support to the pcf85063
> driver. The PCF85063A/RV8263 have no dedicated update-interrupt source,
> so chrony and similar tools that rely on RTC_UIE_ON fall back to the
> kernel's software polling emulation. This series repurposes the chip's
> countdown timer (TCF = 1 Hz, T = 1) to generate a periodic interrupt on
> the INT pin, serving UIE entirely in hardware.
> 
> [...]

Applied, thanks!

[1/4] rtc: pcf85063: use devm_of_clk_add_hw_provider() for clkout
      https://git.kernel.org/abelloni/c/a451b6bb922e
[2/4] rtc: pcf85063: do not clear AIE in the interrupt handler
      https://git.kernel.org/abelloni/c/75ba9f3a6a0b
[3/4] rtc: pcf85063: preserve the alarm flag in clkout register updates
      https://git.kernel.org/abelloni/c/09f5d9b8caaf
[4/4] rtc: pcf85063: add 1 Hz update interrupt (UIE) support
      https://git.kernel.org/abelloni/c/45efb584a1c0

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
