Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793282935;
	b=0jA/HJgKR5AogfJP0awuFib2FFEFdB7RW5qmYgTyS3aBZ3vH3pBqSxZJOH3YRx3+FCY+
	 qpMHughNydp6FJNzH+mpTzn1JcyEaW5TEndVU/Xz7u1rh8qj488J7t30P04qhuVQX0UIE
	 kveduZLPOa1wAjveLcP4e2AKBy+T87DW3jR8idp0mn1luGZxiWf/ROFLGsJ2qUzJ0cQ8J
	 TgFcYHoyfKbAZJjry08wvPqkT+dlY4bRWxli7oVFPtgqmPD9SVjTnkFhdLB2K1fWb1jWw
	 RYOE3bPOejUoefu1s44Vhlw8hHIt2P+NWYzjXpeAKXKgVn662sYzEUcZ5k33clnya8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793282935;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Last-TLS-Session-Version;
	bh=a71sdmRTLE3iv2iC80MwZtRlRPpjHv/3hi6caAkk68M=;
	b=xQdLftxvVpNyVY6CR9motDb+QaDqMkNlC0blUUPW6oIUNs0QyIRwqQlda4wPp7yEaaDX
	 SzwU5qwyn70Zjx5lA9LJZSlZgMEO7l2lHk18546s7jB5ZL49fzUG3dcFi5w/dguR1GFn0
	 eIBXRUwRHg1mFJqdevyXZmw/FyaDIxoam1SBPJ59FW1VetC4fzNnWriMiguXhbR0BuyHQ
	 kcRP+I6mwykl+Z+bAUXElHDxxG99oXj+5uBFbZPmTsigQvGxCnulvXPgzQFDPG7bYa4Ha
	 VUuEzrBkLkXYxPlqGXcYWBgwBZOlcPh89lh0+ClHRZEWUuCD3cY39PKodRBqEVCihUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=q14Kf03S;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81DC606A332
	for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 14:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C81DC606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=q14Kf03S
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 408501A1376
	for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 14:08:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 150756076B;
	Thu, 29 Oct 2026 14:08:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A165B103290EE;
	Thu, 29 Oct 2026 15:08:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793282931; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=a71sdmRTLE3iv2iC80MwZtRlRPpjHv/3hi6caAkk68M=;
	b=q14Kf03SEAK4kzARtUiV+vw8Yft/zCwNDpakCdoXOfBnxwAyNFrjma06LOAt/mPrrUZ1tn
	0ZgbbZhrj4GyFtWjWuVO9aynH0p4oVMWaarTCN9c8knPWsk1eG8xF/MdyWTVEuFpfM4Mq0
	/RvH4e/MKswB7vILUL3i6bqqBI3MtyZAL4SHh3clAc0cAA0wfBDavGsBUfGLHoLqEuKPSz
	mFsKdzEd/UMtczRie1kxTib4abiJ7VkcNpibeX6ccv5kURXxTNw+bg52G++z+4D9H97KNb
	DcYQ7RuJH4+AYVHGhiIa19en9O1G4PaZPNycx7BEMii9Cuu1716NHtLl6PbSEA==
Date: Thu, 29 Oct 2026 15:08:49 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Imre Kaloz <kaloz@kernel.org>
Cc: Joshua Kinard <linux@kumba.dev>, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] rtc: ds1685: power-off fixes
Message-ID: <179328288495.935369.10348342357277030630.b4-ty@b4>
References: <20261013120208.11268-1-kaloz@kernel.org>
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
In-Reply-To: <20261013120208.11268-1-kaloz@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 13 Oct 2026 14:02:05 +0200, Imre Kaloz wrote:
> Three fixes for ds1685_rtc_poweroff(), on SGI O2 and Octane machines.
> 
> Patch 1 arms the wake-up alarm only if an alarm is set, so that stale
> alarm registers no longer power the machine back on.
> 
> Patch 2 replaces the sleep before the PAB write with a busy wait, as
> power-off handlers must not sleep.
> 
> [...]

Applied, thanks!

[1/3] rtc: ds1685: arm the wake-up alarm at power-off only if an alarm is set
      https://git.kernel.org/abelloni/c/d01026cc6e8f
[2/3] rtc: ds1685: do not sleep in the power-off handler
      https://git.kernel.org/abelloni/c/fce04362eeb6
[3/3] rtc: ds1685: keep setting PAB until power is removed
      https://git.kernel.org/abelloni/c/27ff8c706ba4

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
