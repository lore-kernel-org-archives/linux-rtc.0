Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793282920;
	b=w5l2p3ID9iASJTJFOgYFWHpdA97gXtHSTvEr/y4uzF7tbvd75h3z0qR6Yj1BfMEM2ET9
	 szup+Ehiro87TvpgIn/EfvpCK/t/1MgosmNLtEK0nGpqTBtk5jj7EUrRvnz6G5uOZ7LRN
	 skJNagQjwHP4mHt8BkaWuIupnV/u7sXCxPHn0imnUG3G0BGl3tZ6JuEa8Sm6MhpzSWQY2
	 SaK1hrxASkwuk4ynvt6IJx1qmTxA2GwGx5nCWAMaf7WJmqfXDvxD/X8RdeUmFrCT7irjz
	 myBCYtiHKw96iOdEkBaqbc3V1DKCmxgkZVQWdQbLZDEB+Vx4/Xxr8bMpZkzJc0bXyAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793282920;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Last-TLS-Session-Version;
	bh=0ULFcL4e+6n3G3BYTpyQ0Jax9vpvQWSN/L5pCMjIYSk=;
	b=fDwkxFttxGF6DviSZBiA+sJNpFqJihdCPH0KiouXg2fVOVs/TNtaCksEczSaYSCmwaQr
	 s4El/Y10Qiw8KHYkuuDzXS6TrWGIeTEIuRTaW5yjddphd+2Cj7jViuPTDJ5Mv44fqIc4n
	 jjbNdgA+6JK8GhXgrYS9DUtYRsooT+szsBh9sWn2QWdahDDjmPva218xsDx9iYa6ZQciv
	 MClKKNmi9HVZdM9fHDqkqPHVnQTn+dIE3ptuocQRzdnoO70WKQc65JXHdhPnEk8bTRhbE
	 2KvHT7TsKf+9GbSQWIXq9lh8Lo2l3IpZFna3myT7ebzP4IfXVXaRX49fn+D3o4tmUwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=s4+F7OlG;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B60E606A330
	for <linux-rtc@vger.kernel.org>; Thu, 29 Oct 2026 14:08:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B60E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=s4+F7OlG
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6A7341A1376;
	Thu, 29 Oct 2026 14:08:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 374DF60360;
	Thu, 29 Oct 2026 14:08:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 58CCB10328365;
	Thu, 29 Oct 2026 15:08:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793282911; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=0ULFcL4e+6n3G3BYTpyQ0Jax9vpvQWSN/L5pCMjIYSk=;
	b=s4+F7OlGQdsZG+NGuTyHk4OP3xyyVPb+Kobp+25ay0GxP+/LWoKmslXDRLsgRvcGCm7IjR
	b3PdwmhAipHqKhG4SdWPVxDbG5tmr6xW61x+iS5ry5AUUADq2odGB5bmGLDuk2PbOPgc0Q
	I5cjpG9PibYotzZeNSpWtnA2cLqVxB/q5dk+SIEVoG75v8W3x7InEiUtXFtqUKO2livQNm
	FMn1yhPARNcQL2uisFi3PMBh2/1nnjU9cP9AG8UTWqmZ8clabvWkrkVyIsdgYgVZH/T9Bw
	7pJEEJ6ZbwAqG/gSKdAtfDePhcNXnJnQpKgRqJkTPb5YsEh1hpLrVKJ9L459cg==
Date: Thu, 29 Oct 2026 15:08:30 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Akshat Rawat <akshatrawat095@gmail.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: rv3028: use sysfs_emit() instead of sprintf()
Message-ID: <179328288491.935369.6481765729463819875.b4-ty@b4>
References: <20261022081242.421-1-akshatrawat095@gmail.com>
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
In-Reply-To: <20261022081242.421-1-akshatrawat095@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 22 Oct 2026 08:12:42 +0000, Akshat Rawat wrote:
> Use sysfs_emit() instead of sprintf() in sysfs show callbacks
> (timestamp0_show and timestamp0_count_show) to conform to the
> recommended sysfs attribute formatting guidelines in
> Documentation/filesystems/sysfs.rst.

Applied, thanks!

[1/1] rtc: rv3028: use sysfs_emit() instead of sprintf()
      https://git.kernel.org/abelloni/c/55bb5877494d

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
