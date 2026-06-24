Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483A53E5A3D
	for <linux-rtc@vger.kernel.org>; Wed, 24 Jun 2026 21:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782335826; cv=none; b=FFV4ToPVtUEcEIN+T5yt5MfKFOfRUL4oOkgcomCXA60Gt2oDMXtxPLSMu+/6uurwCnb1Hk4emUekJG847U+iFAIqjysxl51cRKwcPoUjMW1itj7Fjz642xMZQguzxwYHqZVJ5xnHSMbPDqGiKQuNdETYEIsAEaCrJ0VqXZv9wO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782335826; c=relaxed/simple;
	bh=gTgL8+lmpcwLCGQRY9Bku6JzWWsgcvLlNHfjosu22PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0+vz/a7GrJMNY3c7TRj8QzOKyoCPpIEsYenrFRoQxhB6P+C0xbdxuUH3pg3Tvh7UL/bYys68Efxzy4YRDhYTlcpVYCeXuS3XlvpAeF4F9XYwEJ8kdi/+vSsPqCBmbJKgakBQO6N4tKZpTxPVGwAiJgIA60iveLZHRSTcPyWzfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kD5+byKx; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kD5+byKx"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E6F5D4E40832
	for <linux-rtc@vger.kernel.org>; Wed, 24 Jun 2026 21:17:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BAD1160231;
	Wed, 24 Jun 2026 21:17:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EB0A5106C8468;
	Wed, 24 Jun 2026 23:17:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782335823; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=6vl3xq+hXClGs1ERJsV1Z0QGdFCXYrK24EabUIuY8Ss=;
	b=kD5+byKx13lq1eJh9xcMXnU68KU2EqXOto0velsYWex0h80JPKoB8+KFa4XjATBlpeAWhQ
	o9weE5HaJA0SuJL6RrLL0JIdJM4EzrwH6OSe52rqrxmfL+2ckBpu3LtP1YBhNiKsBsNKgv
	dPi8BG3r9RLnc0KbyxDcB7IzwZb/dtSoNi2cxiyinqSFCOfayd0ut0Ak5WYpUTHorP/guh
	oAqpjbvfyfcJzxllgKhoerxd4OjsvJsxlcx1Ex3rLNyMqKroSDmAUqWglvT+VjXitxDxd8
	Nldk4J3hPgXSy2kqvqzMPYJAezTAet3iS+/8UUmwhc721M7clP2tTULv76gmyg==
Date: Wed, 24 Jun 2026 23:17:00 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Xue Lei <Xue.Lei@windriver.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
	xue.lei@windriver.com
Subject: Re: [PATCH] rtc: mv: add suspend/resume support for wakeup
Message-ID: <178233558824.1517260.7162256035683405937.b4-ty@b4>
References: <20260611023350.1370881-1-Xue.Lei@windriver.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611023350.1370881-1-Xue.Lei@windriver.com>
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 11 Jun 2026 10:33:50 +0800, Xue Lei wrote:
> Add PM suspend/resume callbacks to enable/disable IRQ wake for the
> RTC alarm interrupt. This allows the RTC alarm to wake the system
> from STR (e.g. via rtcwake -m mem -s N).
> 
> Without this, the RTC IRQ is masked during suspend by the MPIC's
> IRQCHIP_MASK_ON_SUSPEND behavior, preventing alarm-based wakeup.
> 
> [...]

Applied, thanks!

[1/1] rtc: mv: add suspend/resume support for wakeup
      https://git.kernel.org/abelloni/c/851d961ff248

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
