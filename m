Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D3C47124F;
	Wed, 30 Sep 2026 15:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781978; cv=none; b=cHjA1dSil9ZtR/aKl0yzOYQ1FE8qK3CjlvxowfXuHY0tFKeip0Ccy0RWlukIO3p5z0GWu2jdilW+S1YWOXgNe9eOS7kbF4/iIiEPsxTjyi0KvkbLWxqrilJFkq3nXkGqyulyZ35q9DiKzwrPgOO5EVQmuY2Y9aYCeRPxsuUkizs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781978; c=relaxed/simple;
	bh=aH7hNLyNAgOaDEnz+9Dk2AKvGY+UeRikvcAUB7dHIqQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m104YocUTAK+x1yNR+k3MgVIhLWa3xeEsYyp5+LpTCQ3/Pk7mwmQNPjkdX0deHlhb5W868GwCWT/ZEd1cslyGwC9bAD9t3IezwKRlUgsVdPmOZx0LOMnnDV3s4dlYvt1FZn4TQdx5yWZsKo4OkrmTF2wbJ1N+VB0EJ36Zdx0FK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=i1fc2PhY; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="i1fc2PhY"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 93E9F4E410D5;
	Wed, 30 Sep 2026 15:26:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6058660749;
	Wed, 30 Sep 2026 15:26:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CB9DE103281E9;
	Wed, 30 Sep 2026 17:25:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790781958;
	h=from:subject:date:message-id:to:mime-version:content-type:in-reply-to:
	 references; bh=aTK5MFAHqEWeZmsczuNSyKGhptfevUah8Adp9z/InjU=;
	b=i1fc2PhYrMbBWLUgteVIhipEJWOI2xq1N/FOVThHV0jze3ReCRote8Z0iaQY1cCUhxEXPG
	Lo4whEfO3myAB7bCXVpAJ1UBPiN3kO4n5wLzsu88arQ+DDbke0SIcdhZX5jNGyUZgair6g
	Jhc1P+7OyQy3vuG512BX2ghgWxD0ATC9aETXMJxeajVv2BHlacvIWFSwyAjn/j3kOZUb4+
	SLkNU8ad26YpxaK4KeM+kPds2cVa+ftDg9aFBXnpeK3IhTRlV68q+oSkBhRY+Za13wh0s6
	HmFDgA/qaTTvC2+GtgcRf3+bY7BkGNQFD9XGBHayphJ9b2UwVIluZUu05L8VeQ==
Date: Wed, 30 Sep 2026 17:25:57 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH v3] rtc: bd70528: properly enable wakeup
Message-ID: <179078194801.464639.4261167399732268928.b4-ty@b4>
References: <20260922-rtc-bd-v3-1-7f2580c55d58@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922-rtc-bd-v3-1-7f2580c55d58@kemnade.info>
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 22 Sep 2026 15:20:15 +0200, Andreas Kemnade wrote:
> Wakeup on RTC alarm now only accidentially works when wakeup for the power
> button connected to the same PMIC is also enabled. Fix that by properly
> specifying the wakeup irq.

Applied, thanks!

[1/1] rtc: bd70528: properly enable wakeup
      https://git.kernel.org/abelloni/c/cb8a6249236f

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
