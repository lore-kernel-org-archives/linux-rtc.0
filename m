Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C2E35B654
	for <linux-rtc@vger.kernel.org>; Fri, 30 Jan 2026 22:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769813982; cv=none; b=TCVjIU32eDRYoHcDB6xiQ/Y3AGnuVDWVNBURdHMphPs7YJnTNTto4DjL25zPEOBlOqXLv8Xc6jnvhLcjiUHEtzo50iOEpOOOCDfLyNgldGfFOglisqb3T+h5m4RTzBuUgshLPcOjG+sC2uxGrbmhUR9//yEpZPodJ/CGiTBXX3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769813982; c=relaxed/simple;
	bh=v9LLJ4DIaY/FzoznUbaHd0DqPdthUwLsbvOXTY3BP/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HazVFzu9zLye8LVIAVqK4j7czKt+hCjAWBttGPybudMGIoh9d2NcAC9ZM+9gMMfexPwRV9w+2LZhFOZmPkf7JZtng2YFiRKAJDbAkEgtS2JV0/PBU1N6TihjQhPDprNxVcFlQvKxue3QGZ8YFhOIIs6lpYXjnOkkvljOl7zA6V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZQA1vcdn; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZQA1vcdn"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 4DA30C22F6C;
	Fri, 30 Jan 2026 22:59:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AF3476075A;
	Fri, 30 Jan 2026 22:59:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 58507119A88EC;
	Fri, 30 Jan 2026 23:59:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769813978; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=hP+m169YdHkMBzGPknU7zjeOfw/2sZzFjzxQI+0qmzc=;
	b=ZQA1vcdnbzBZ4+z90jQxUbkci+1XJ4Gd/WA8JBcVURJ6itW1OIUakC3rs0E2Witk9JFtyG
	JB+SWpZpTQ2bRpFLZ2u2gqTH9hgIcES2qwbFQmBeJt2Co1A310wZw0aTBQQGYJMw1d3KZj
	yT1eQdNQVNC0je62LlOnSnoJJu7Z0xf2BzhMtvkfttCJPcd6EGZ0wtkERX1d+LeBUKZCsd
	FXqJFYZynuKe8RACit5OejqeNudLhuN6PQECIEfDUi+6f75RBC9tShgPF20cR3BN7r1a9+
	r34pAe2yD3P8L4GVWISvLHUiAJQP9Hfw1LcpfF7U82xAIBbstyX2+YRn2XNycg==
Date: Fri, 30 Jan 2026 23:59:35 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Michal Simek <michal.simek@amd.com>,
	Tomas Melin <tomas.melin@vaisala.com>
Cc: linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Harini T <harini.t@amd.com>
Subject: Re: [PATCH v4 0/5] rtc: zynqmp: fixes for read and set offset
Message-ID: <176981393513.2222240.16272626152840820332.b4-ty@bootlin.com>
References: <20260122-zynqmp-rtc-updates-v4-0-d4edb966b499@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122-zynqmp-rtc-updates-v4-0-d4edb966b499@vaisala.com>
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 22 Jan 2026 13:53:44 +0000, Tomas Melin wrote:
> Add improvements for read and set offset functions.
> The basic functionality is still the same, but offset correction values
> are now updated to match with expected.
> 
> The RTC calibration value operates with full ticks,
> and fractional ticks which are a 1/16 of a full tick.
> The 16 lowest bits in the calibration registers are for the full ticks
> and value matches the external oscillator in Hz. Through that,
> the maximum and minimum offset values can be calculated dynamically,
> as they depend on the input frequency used.
> 
> [...]

Applied, thanks!

[1/5] rtc: zynqmp: correct frequency value
      https://git.kernel.org/abelloni/c/2724fb4d429c
[2/5] rtc: zynqmp: check calibration max value
      https://git.kernel.org/abelloni/c/83b9e5eb0437
[3/5] rtc: zynqmp: rework read_offset
      https://git.kernel.org/abelloni/c/0f9989443fae
[4/5] rtc: zynqmp: rework set_offset
      https://git.kernel.org/abelloni/c/9f5af70268d6
[5/5] rtc: zynqmp: use dynamic max and min offset ranges
      https://git.kernel.org/abelloni/c/2254383176fc

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
